alter session set plsql_code_type = native;

create or replace package ETL_PROCESS_LETTERS_PKG as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure COPY_LETTERS_TO_TEMP;

  procedure PROCESS_LETTERS_UPD1;

  PROCEDURE COPY_PL_UPD_WIP2WIPT;

end;
/
create or replace package body ETL_PROCESS_LETTERS_PKG as

PROCEDURE COPY_LETTERS_TO_TEMP AS

 CURSOR letters_cur(c_exclude_letters in varchar2) IS
   SELECT cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case, letter_definition_id 
 FROM corp_etl_proc_letters
 WHERE 1=1   
   --and letter_request_id >= 22867600
   and complete_dt IS NULL   
   --Exclude processing below letter types on specific days of the week (as configured in the corp_etl_list_lkup table).
   and letter_type  not in (SELECT regexp_substr(c_exclude_letters,'[^,]+', 1, level) items
                            FROM dual
                            CONNECT BY regexp_substr(c_exclude_letters, '[^,]+', 1, level) is not null
                            );

   TYPE t_letter_tab IS TABLE OF letters_cur%ROWTYPE INDEX BY PLS_INTEGER;
    letter_tab   t_letter_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_err_code   VARCHAR2(30);
    v_err_msg    VARCHAR2(240);
    v_last_Excl_day_from_sysdate DATE:= null; --stores the last exclusion day (Saturday for now) from sysdate.
    v_prev_run_JobStat_Excl_day DATE:= null; --stores the last exclusion day (Saturday for now) based on Job stats for TXEB PL process.
    V_LETTER_TYPE_EXCL_DAY CORP_ETL_LIST_LKUP.Value%type := null;
    v_last_runday_from_sysdate date:= null;
    V_LAST_RUN_JOBSTAT_EXCL_DAY date:= null;
    V_LETTER_TYPES_TO_EXCLUDE CORP_ETL_LIST_LKUP.OUT_VAR%type := null;
    v_exclude_letters CORP_ETL_LIST_LKUP.OUT_VAR%type := null;

BEGIN
   v_step := 'Truncate temp tables';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_WIP_T';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_WIP_BPM';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_OLTP_T';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_OLTP';

  /*
  Variable v_last_runday_from_sysdate will have the previous run date depending on the global control.

  Ex: Initially, we set saturday as the day when specific letters should be run processed, all other days we should NOT process them.
  In the future if we have to add Tuesday of the week to the run schedule along with Saturday, then this variable will have the previous
  run date i.e, a tuesday or saturday.

  --If sysdate is a saturday then, last saturday should be considered as sysdate, if not, fetch previous saturday.
  */

   V_LETTER_TYPE_EXCL_DAY := null;
   SELECT VALUE,
          NEXT_DAY(trunc(sysdate),to_number(VALUE))-7
     INTO V_LETTER_TYPE_EXCL_DAY,
          v_last_runday_from_sysdate
     FROM CORP_ETL_LIST_LKUP
    WHERE LIST_TYPE = 'LETTER_TYPE_EXCLUSION'
      AND name = 'LETTER_TYPE_EXCLUDE_DAYS';

   --v_last_run_JobStat_Excl_day stores last day run on an exclusion day.
    v_last_run_JobStat_Excl_day := null;
    select max(trunc(job_start_date))
    into v_last_run_JobStat_Excl_day
    from corp_etl_job_statistics
    where 1=1
     and job_name = 'Process_Letters_runall'
     and trim(to_char(job_start_date,'D')) = V_LETTER_TYPE_EXCL_DAY
     and job_status_cd = 'COMPLETED';

   V_LETTER_TYPES_TO_EXCLUDE := null;
   SELECT OUT_VAR
     INTO V_LETTER_TYPES_TO_EXCLUDE
     FROM CORP_ETL_LIST_LKUP
    WHERE LIST_TYPE = 'LETTER_TYPE_EXCLUSION'
      AND name = 'LETTER_TYPES_TO_EXCLUDE';

  if v_last_runday_from_sysdate = v_last_run_JobStat_Excl_day and to_char(sysdate,'D') <> V_LETTER_TYPE_EXCL_DAY
  then
      v_exclude_letters := V_LETTER_TYPES_TO_EXCLUDE;
  else
      v_exclude_letters := 'A';
  end if;

   OPEN letters_cur(v_exclude_letters);
   LOOP
     FETCH letters_cur BULK COLLECT INTO letter_tab LIMIT v_bulk_limit;
     EXIT WHEN letter_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. letter_tab.COUNT LOOP
       BEGIN
        v_step := 'Error inserting into WIP_T';
        INSERT INTO corp_etl_proc_letters_wip_t	(
          cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case,letter_definition_id)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,
          letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date,
          letter_tab(indx).new_letter_request_id,letter_tab(indx).error_count,letter_tab(indx).last_errored_date,
          letter_tab(indx).last_error_fixed_by,letter_tab(indx).reject_flag,
          letter_tab(indx).assd_resolve_resp,letter_tab(indx).ased_resolve_resp,letter_tab(indx).asf_resolve_resp,
          letter_tab(indx).created_by_id,letter_tab(indx).last_updated_by_id,letter_tab(indx).cancel_by_id, letter_tab(indx).epm_mail_dt_for_case,letter_tab(indx).letter_definition_id
          );

        v_step := 'Error inserting into WIP_BPM';
        INSERT INTO corp_etl_proc_letters_wip_bpm	(
          cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case,letter_definition_id)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,
          letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date,
          letter_tab(indx).new_letter_request_id,letter_tab(indx).error_count,letter_tab(indx).last_errored_date,
          letter_tab(indx).last_error_fixed_by,letter_tab(indx).reject_flag,
          letter_tab(indx).assd_resolve_resp,letter_tab(indx).ased_resolve_resp,letter_tab(indx).asf_resolve_resp,
          letter_tab(indx).created_by_id,letter_tab(indx).last_updated_by_id,letter_tab(indx).cancel_by_id, letter_tab(indx).epm_mail_dt_for_case, letter_tab(indx).letter_definition_id
          );

         v_step := 'Error inserting into OLTP';
         INSERT INTO corp_etl_proc_letters_oltp	(
          cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case,letter_definition_id)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,
          letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date,
          letter_tab(indx).new_letter_request_id,letter_tab(indx).error_count,letter_tab(indx).last_errored_date,
          letter_tab(indx).last_error_fixed_by,letter_tab(indx).reject_flag,
          letter_tab(indx).assd_resolve_resp,letter_tab(indx).ased_resolve_resp,letter_tab(indx).asf_resolve_resp,
          letter_tab(indx).created_by_id,letter_tab(indx).last_updated_by_id,letter_tab(indx).cancel_by_id, letter_tab(indx).epm_mail_dt_for_case,letter_tab(indx).letter_definition_id 
          );

         v_step := 'Error inserting into OLTP_T';
         INSERT INTO corp_etl_proc_letters_oltp_t	(
          cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case,letter_definition_id)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,
          letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date,
          letter_tab(indx).new_letter_request_id,letter_tab(indx).error_count,letter_tab(indx).last_errored_date,
          letter_tab(indx).last_error_fixed_by,letter_tab(indx).reject_flag,
          letter_tab(indx).assd_resolve_resp,letter_tab(indx).ased_resolve_resp,letter_tab(indx).asf_resolve_resp,
          letter_tab(indx).created_by_id,letter_tab(indx).last_updated_by_id,letter_tab(indx).cancel_by_id, letter_tab(indx).epm_mail_dt_for_case,letter_tab(indx).letter_definition_id 
          );
          
       EXCEPTION
         WHEN OTHERS THEN
           v_err_code := SQLCODE;
           v_err_msg := SUBSTR(SQLERRM, 1, 200);
            insert into corp_etl_error_log values(
                SEQ_CEEL_ID.nextval,--CEEL_ID
                sysdate,--ERR_DATE
                'CRITICAL',--ERR_LEVEL
                'LETTERS',--PROCESS_NAME
                'COPY_LETTERS_TO_TEMP',--JOB_NAME
                '1',--NR_OF_ERROR
                v_step||' '||v_err_msg,--ERROR_DESC
                null,--ERROR_FIELD
                v_err_code,--ERROR_CODES
                sysdate,--CREATE_TS
                sysdate,--UPDATE_TS
                'CORP_ETL_PROC_LETTERS_OLTP',--DRIVER_TABLE_NAME
                letter_tab(indx).letter_request_id);--DRIVER_KEY_NUMBER
       END;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE letters_cur;
END;


PROCEDURE PROCESS_LETTERS_UPD1 AS

CURSOR plupd1_cur IS
SELECT *
   FROM (
SELECT
oltp.CEPN_ID
,oltp.LETTER_REQUEST_ID
,'Y'		IN_YES
--,'N'	IN_NO
,CASE WHEN NVL(REQUEST_DT,'1-JAN-1111') <>  NVL(O_REQUEST_DT,'1-JAN-1111')
     THEN REQUEST_DT
     ELSE O_REQUEST_DT
END AS UPD1_10
,CASE WHEN NVL(LETTER_TYPE,'X') <>  NVL(O_LETTER_TYPE,'X')
     THEN LETTER_TYPE
     ELSE O_LETTER_TYPE
END AS UPD1_20
,CASE WHEN NVL(PROGRAM,'X') <>  NVL(O_PROGRAM,'X')
     THEN PROGRAM
     ELSE O_PROGRAM
END AS UPD1_30
,CASE WHEN NVL(CASE_ID,0) <>  NVL(O_CASE_ID,0)
     THEN CASE_ID
     ELSE O_CASE_ID
END AS UPD1_40
,CASE WHEN NVL(COUNTY_CODE,'X') <>  NVL(O_COUNTY_CODE,'X')
     THEN COUNTY_CODE
     ELSE O_COUNTY_CODE
END AS UPD1_50
,CASE WHEN NVL(ZIP_CODE,0) <>  NVL(O_ZIP_CODE,0)
     THEN ZIP_CODE
     ELSE O_ZIP_CODE
END AS UPD1_60
,CASE WHEN NVL(LANGUAGE,'X') <>  NVL(O_LANGUAGE,'X')
     THEN LANGUAGE
     ELSE O_LANGUAGE
END AS UPD1_70
,CASE WHEN NVL(REPRINT,'X') <>  NVL(O_REPRINT,'X')
     THEN REPRINT
     ELSE O_REPRINT
END AS UPD1_80
,CASE WHEN NVL(REQUEST_DRIVER_TYPE,'X') <>  NVL(O_REQUEST_DRIVER_TYPE,'X')
     THEN REQUEST_DRIVER_TYPE
     ELSE O_REQUEST_DRIVER_TYPE
END AS UPD1_90
,CASE WHEN NVL(REQUEST_DRIVER_TABLE,'X') <>  NVL(O_REQUEST_DRIVER_TABLE,'X')
     THEN REQUEST_DRIVER_TABLE
     ELSE O_REQUEST_DRIVER_TABLE
END AS UPD1_100
,CASE WHEN NVL(STATUS,'X') <>  NVL(O_STATUS,'X')
     THEN STATUS
     ELSE O_STATUS
END AS UPD1_110
,CASE WHEN NVL(STATUS_DT,'1-JAN-1111') <>  NVL(O_STATUS_DT,'1-JAN-1111')
     THEN STATUS_DT
     ELSE O_STATUS_DT
END AS UPD1_111
,CASE WHEN NVL(SENT_DT,'1-JAN-1111') <>  NVL(O_SENT_DT,'1-JAN-1111')
     THEN SENT_DT
     ELSE O_SENT_DT
END AS UPD1_130
,CASE WHEN NVL(PRINT_DT,'1-JAN-1111') <>  NVL(O_PRINT_DT,'1-JAN-1111')
     THEN PRINT_DT
     ELSE O_PRINT_DT
END AS UPD1_140
,CASE WHEN NVL(MAILED_DT,'1-JAN-1111') <>  NVL(O_MAILED_DT,'1-JAN-1111')
     THEN MAILED_DT
     ELSE O_MAILED_DT
END AS UPD1_150
,CASE WHEN NVL(RETURN_DT,'1-JAN-1111') <>  NVL(O_RETURN_DT,'1-JAN-1111')
     THEN RETURN_DT
     ELSE O_RETURN_DT
END AS UPD1_160
,CASE WHEN NVL(RETURN_REASON,'X') <>  NVL(O_RETURN_REASON,'X')
     THEN RETURN_REASON
     ELSE O_RETURN_REASON
END AS UPD1_170
,CASE WHEN NVL(REJECT_REASON,'X') <>  NVL(O_REJECT_REASON,'X')
     THEN REJECT_REASON
     ELSE O_REJECT_REASON
END AS UPD1_180
,CASE WHEN NVL(ERROR_REASON,'X') <>  NVL(O_ERROR_REASON,'X')
     THEN ERROR_REASON
     ELSE O_ERROR_REASON
END AS UPD1_190
,CASE WHEN NVL(TRANSMIT_FILE_NAME,'X') <>  NVL(O_TRANSMIT_FILE_NAME,'X')
     THEN TRANSMIT_FILE_NAME
     ELSE O_TRANSMIT_FILE_NAME
END AS UPD1_200
,CASE WHEN NVL(TRANSMIT_FILE_DT,'1-JAN-1111') <>  NVL(O_TRANSMIT_FILE_DT,'1-JAN-1111')
     THEN TRANSMIT_FILE_DT
     ELSE O_TRANSMIT_FILE_DT
END AS UPD1_205
,CASE WHEN NVL(LETTER_RESP_FILE_NAME,'X') <>  NVL(O_LETTER_RESP_FILE_NAME,'X')
     THEN LETTER_RESP_FILE_NAME
     ELSE O_LETTER_RESP_FILE_NAME
END AS UPD1_210
,CASE WHEN NVL(LETTER_RESP_FILE_DT,'1-JAN-1111') <>  NVL(O_LETTER_RESP_FILE_DT,'1-JAN-1111')
     THEN LETTER_RESP_FILE_DT
     ELSE O_LETTER_RESP_FILE_DT
END AS UPD1_215
,CASE WHEN NVL(Last_Updated_By_ID,'X') <>  NVL(O_Last_Updated_By_ID,'X')
     THEN Last_Updated_By_ID
     ELSE O_Last_Updated_By_ID
END AS UPD1_230
,CASE WHEN NVL(LAST_UPDATE_DT,'1-JAN-1111') <>  NVL(O_LAST_UPDATE_DT,'1-JAN-1111')
     THEN LAST_UPDATE_DT
     ELSE O_LAST_UPDATE_DT
END AS UPD1_240
,CASE WHEN NVL(NEW_LETTER_REQUEST_ID,0) <>  NVL(O_NEW_LETTER_REQUEST_ID,0)
     THEN NEW_LETTER_REQUEST_ID
     ELSE O_NEW_LETTER_REQUEST_ID
END AS UPD1_250
,CASE WHEN NVL(ERROR_COUNT,0) <>  NVL(O_ERROR_COUNT,0)
     THEN ERROR_COUNT
     ELSE O_ERROR_COUNT
END AS UPD1_260
,CASE WHEN NVL(LAST_ERRORED_DATE,'1-JAN-1111') <>  NVL(O_LAST_ERRORED_DATE,'1-JAN-1111')
     THEN LAST_ERRORED_DATE
     ELSE O_LAST_ERRORED_DATE
END AS UPD1_270
,CASE WHEN NVL(LAST_ERROR_FIXED_BY,'X') <>  NVL(O_LAST_ERROR_FIXED_BY,'X')
     THEN LAST_ERROR_FIXED_BY
     ELSE O_LAST_ERROR_FIXED_BY
END AS UPD1_271
,CASE WHEN NVL(REJECT_FLAG,'X') <>  NVL(O_REJECT_FLAG,'X')
     THEN REJECT_FLAG
     ELSE O_REJECT_FLAG
END AS UPD1_280
,CASE WHEN NVL(EPM_MAIL_DT_FOR_CASE,'1-JAN-1111') <>  NVL(O_EPM_MAIL_DT_FOR_CASE,'1-JAN-1111')
     THEN EPM_MAIL_DT_FOR_CASE
     ELSE O_EPM_MAIL_DT_FOR_CASE
END AS UPD1_290
,CASE WHEN NVL(LETTER_DEFINITION_ID,0) <>  NVL(O_LETTER_DEFINITION_ID,0)
     THEN LETTER_DEFINITION_ID
     ELSE O_LETTER_DEFINITION_ID
END AS UPD1_300
,CASE WHEN NVL(REQUEST_DT,'1-JAN-1111') <>  NVL(O_REQUEST_DT,'1-JAN-1111')
OR  NVL(LETTER_TYPE,'X') <>  NVL(O_LETTER_TYPE,'X')
OR  NVL(PROGRAM,'X') <>  NVL(O_PROGRAM,'X')
OR  NVL(CASE_ID,0) <>  NVL(O_CASE_ID,0)
OR  NVL(COUNTY_CODE,'X') <>  NVL(O_COUNTY_CODE,'X')
OR  NVL(ZIP_CODE,0) <>  NVL(O_ZIP_CODE,0)
OR  NVL(LANGUAGE,'X') <>  NVL(O_LANGUAGE,'X')
OR  NVL(REPRINT,'X') <>  NVL(O_REPRINT,'X')
OR  NVL(REQUEST_DRIVER_TYPE,'X') <>  NVL(O_REQUEST_DRIVER_TYPE,'X')
OR  NVL(REQUEST_DRIVER_TABLE,'X') <>  NVL(O_REQUEST_DRIVER_TABLE,'X')
OR  NVL(STATUS,'X') <>  NVL(O_STATUS,'X')
OR  NVL(STATUS_DT,'1-JAN-1111') <>  NVL(O_STATUS_DT,'1-JAN-1111')
OR  NVL(SENT_DT,'1-JAN-1111') <>  NVL(O_SENT_DT,'1-JAN-1111')
OR  NVL(PRINT_DT,'1-JAN-1111') <>  NVL(O_PRINT_DT,'1-JAN-1111')
OR  NVL(MAILED_DT,'1-JAN-1111') <>  NVL(O_MAILED_DT,'1-JAN-1111')
OR  NVL(RETURN_DT,'1-JAN-1111') <>  NVL(O_RETURN_DT,'1-JAN-1111')
OR  NVL(RETURN_REASON,'X') <>  NVL(O_RETURN_REASON,'X')
OR  NVL(REJECT_REASON,'X') <>  NVL(O_REJECT_REASON,'X')
OR  NVL(ERROR_REASON,'X') <>  NVL(O_ERROR_REASON,'X')
OR  NVL(TRANSMIT_FILE_NAME,'X') <>  NVL(O_TRANSMIT_FILE_NAME,'X')
OR  NVL(TRANSMIT_FILE_DT,'1-JAN-1111') <>  NVL(O_TRANSMIT_FILE_DT,'1-JAN-1111')
OR  NVL(LETTER_RESP_FILE_NAME,'X') <>  NVL(O_LETTER_RESP_FILE_NAME,'X')
OR  NVL(LETTER_RESP_FILE_DT,'1-JAN-1111') <>  NVL(O_LETTER_RESP_FILE_DT,'1-JAN-1111')
OR  NVL(Last_Updated_By_ID,'X') <>  NVL(O_Last_Updated_By_ID,'X')
OR  NVL(LAST_UPDATE_DT,'1-JAN-1111') <>  NVL(O_LAST_UPDATE_DT,'1-JAN-1111')
OR  NVL(NEW_LETTER_REQUEST_ID,0) <>  NVL(O_NEW_LETTER_REQUEST_ID,0)
OR  NVL(ERROR_COUNT,0) <>  NVL(O_ERROR_COUNT,0)
OR  NVL(LAST_ERRORED_DATE,'1-JAN-1111') <>  NVL(O_LAST_ERRORED_DATE,'1-JAN-1111')
OR  NVL(LAST_ERROR_FIXED_BY,'X') <>  NVL(O_LAST_ERROR_FIXED_BY,'X')
OR  NVL(REJECT_FLAG,'X') <>  NVL(O_REJECT_FLAG,'X')
OR  NVL(EPM_MAIL_DT_FOR_CASE,'1-JAN-1111') <>  NVL(O_EPM_MAIL_DT_FOR_CASE,'1-JAN-1111')
OR  NVL(LETTER_DEFINITION_ID,0) <>  NVL(O_LETTER_DEFINITION_ID,0)
 THEN 'Y'
 ELSE 'N'
 END AS UPDATED
FROM CORP_ETL_PROC_LETTERS_OLTP OLTP
JOIN
(SELECT
CEPN_ID O_CEPN_ID
,LETTER_REQUEST_ID O_LETTER_REQUEST_ID
,REQUEST_DT O_REQUEST_DT
,LETTER_TYPE O_LETTER_TYPE
,PROGRAM O_PROGRAM
,CASE_ID O_CASE_ID
,COUNTY_CODE O_COUNTY_CODE
,ZIP_CODE O_ZIP_CODE
,LANGUAGE O_LANGUAGE
,REPRINT O_REPRINT
,REQUEST_DRIVER_TYPE O_REQUEST_DRIVER_TYPE
,REQUEST_DRIVER_TABLE O_REQUEST_DRIVER_TABLE
,STATUS O_STATUS
,STATUS_DT O_STATUS_DT
,SENT_DT O_SENT_DT
,PRINT_DT O_PRINT_DT
,MAILED_DT O_MAILED_DT
,RETURN_DT O_RETURN_DT
,RETURN_REASON O_RETURN_REASON
,REJECT_REASON O_REJECT_REASON
,ERROR_REASON O_ERROR_REASON
,TRANSMIT_FILE_NAME O_TRANSMIT_FILE_NAME
,TRANSMIT_FILE_DT O_TRANSMIT_FILE_DT
,LETTER_RESP_FILE_NAME O_LETTER_RESP_FILE_NAME
,LETTER_RESP_FILE_DT O_LETTER_RESP_FILE_DT
,LAST_UPDATED_BY_ID O_LAST_UPDATED_BY_ID
,LAST_UPDATE_DT O_LAST_UPDATE_DT
,NEW_LETTER_REQUEST_ID O_NEW_LETTER_REQUEST_ID
,ERROR_COUNT O_ERROR_COUNT
,LAST_ERRORED_DATE O_LAST_ERRORED_DATE
,LAST_ERROR_FIXED_BY O_LAST_ERROR_FIXED_BY
,REJECT_FLAG O_REJECT_FLAG
,EPM_MAIL_DT_FOR_CASE O_EPM_MAIL_DT_FOR_CASE
,LETTER_DEFINITION_ID O_LETTER_DEFINITION_ID
FROM CORP_ETL_PROC_LETTERS_WIP_T
WHERE COMPLETE_DT IS NULL
)BPM
ON OLTP.CEPN_ID= BPM.O_CEPN_ID)
WHERE UPDATED = 'Y';

 TYPE plupd1_tab IS TABLE OF plupd1_cur%ROWTYPE INDEX BY PLS_INTEGER;
    upd1_tab plupd1_tab;
    v_bulk_limit NUMBER := 5000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;

BEGIN

   OPEN plupd1_cur;
   LOOP
     FETCH plupd1_cur BULK COLLECT INTO upd1_tab LIMIT v_bulk_limit;
     EXIT WHEN upd1_tab.COUNT = 0; -- Exit when missing rows

     BEGIN
       FORALL indx IN 1..upd1_tab.COUNT SAVE EXCEPTIONS
       UPDATE CORP_ETL_PROC_LETTERS_WIP_BPM
       set  REQUEST_DT	=	upd1_tab(indx).UPD1_10
            ,	LETTER_TYPE	=	upd1_tab(indx).UPD1_20
            ,	PROGRAM	=	upd1_tab(indx).UPD1_30
            ,	CASE_ID	=	upd1_tab(indx).UPD1_40
            ,	COUNTY_CODE	=	upd1_tab(indx).UPD1_50
            ,	ZIP_CODE	=	upd1_tab(indx).UPD1_60
            ,	LANGUAGE	=	upd1_tab(indx).UPD1_70
            ,	REPRINT	=	upd1_tab(indx).UPD1_80
            ,	REQUEST_DRIVER_TYPE	=	upd1_tab(indx).UPD1_90
            ,	REQUEST_DRIVER_TABLE	=	upd1_tab(indx).UPD1_100
            ,	STATUS	=	upd1_tab(indx).UPD1_110
            , STATUS_DT =	upd1_tab(indx).UPD1_111
            ,	SENT_DT	=	upd1_tab(indx).UPD1_130
            ,	PRINT_DT	=	upd1_tab(indx).UPD1_140
            ,	MAILED_DT	=	upd1_tab(indx).UPD1_150
            ,	RETURN_DT	=	upd1_tab(indx).UPD1_160
            ,	RETURN_REASON	=	upd1_tab(indx).UPD1_170
            ,	REJECT_REASON	=	upd1_tab(indx).UPD1_180
            ,	ERROR_REASON	=	upd1_tab(indx).UPD1_190
            ,	TRANSMIT_FILE_NAME	=	upd1_tab(indx).UPD1_200
            ,	TRANSMIT_FILE_DT	=	upd1_tab(indx).UPD1_205
            ,	LETTER_RESP_FILE_NAME	=	upd1_tab(indx).UPD1_210
            ,	LETTER_RESP_FILE_DT	=	upd1_tab(indx).UPD1_215
            ,	Last_Updated_By_ID	=	upd1_tab(indx).UPD1_230
            ,	LAST_UPDATE_DT	=	upd1_tab(indx).UPD1_240
            ,	NEW_LETTER_REQUEST_ID	=	upd1_tab(indx).UPD1_250
            , ERROR_COUNT 	=	upd1_tab(indx).UPD1_260
            , LAST_ERRORED_DATE 	=	upd1_tab(indx).UPD1_270
            , LAST_ERROR_FIXED_BY 	=	upd1_tab(indx).UPD1_271
            , REJECT_FLAG 	=	upd1_tab(indx).UPD1_280
            , EPM_MAIL_DT_FOR_CASE 	=	upd1_tab(indx).UPD1_290
            , LETTER_DEFINITION_ID = upd1_tab(indx).UPD1_300
            , UPDATED =	upd1_tab(indx).UPDATED
        WHERE LETTER_REQUEST_ID = upd1_tab(indx).LETTER_REQUEST_ID;

     EXCEPTION
           WHEN OTHERS THEN
             IF SQLCODE = -24381 THEN
               FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
                v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                --v_err_msg := SUBSTR(SQLERRM, 1, 200);
                INSERT INTO corp_etl_error_log
                VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                        sysdate,--ERR_DATE
                        'CRITICAL',--ERR_LEVEL
                        'PROCESS LETTERS',--PROCESS_NAME
                        'ProcessLetters_update1',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step, --||' '||v_err_msg,--ERROR_DESC
                        null, --ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_PROC_LETTERS_WIP_BPM',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
               END LOOP;
             END IF;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE plupd1_cur;
END PROCESS_LETTERS_UPD1;


PROCEDURE COPY_PL_UPD_WIP2WIPT AS

 CURSOR cur IS
  SELECT * FROM CORP_ETL_PROC_LETTERS_WIP_BPM;

   TYPE t_letter_tab IS TABLE OF cur%ROWTYPE INDEX BY PLS_INTEGER;
    letter_tab t_letter_tab;
    v_bulk_limit NUMBER := 5000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN
   v_step := 'Truncate wip_t tables';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_WIP_T';


   OPEN cur;
   LOOP
     FETCH cur BULK COLLECT INTO letter_tab LIMIT v_bulk_limit;
     EXIT WHEN letter_tab.COUNT = 0; -- Exit when missing rows

    -- FOR indx IN 1 .. letter_tab.COUNT LOOP
   BEGIN
      v_step := 'Error inserting into WIP_T';
      FORALL indx IN 1 .. letter_tab.COUNT SAVE EXCEPTIONS
        INSERT INTO corp_etl_proc_letters_wip_t	(
          cepn_id,letter_request_id,create_dt,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          newborn_flag,task_id,cancel_dt,
          cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,
          asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date,
          new_letter_request_id,error_count,last_errored_date,last_error_fixed_by,reject_flag,
          assd_resolve_resp,ased_resolve_resp,asf_resolve_resp,
          created_by_id,last_updated_by_id,cancel_by_id,epm_mail_dt_for_case,letter_definition_id)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,
          letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date,
          letter_tab(indx).new_letter_request_id,letter_tab(indx).error_count,letter_tab(indx).last_errored_date,
          letter_tab(indx).last_error_fixed_by,letter_tab(indx).reject_flag,
          letter_tab(indx).assd_resolve_resp,letter_tab(indx).ased_resolve_resp,letter_tab(indx).asf_resolve_resp,
          letter_tab(indx).created_by_id,letter_tab(indx).last_updated_by_id,letter_tab(indx).cancel_by_id, letter_tab(indx).epm_mail_dt_for_case,letter_tab(indx).letter_definition_id
          );


EXCEPTION
          WHEN OTHERS THEN
             IF SQLCODE = -24381 THEN
                 FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                     v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
                     v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                     insert into corp_etl_error_log values(
                        SEQ_CEEL_ID.nextval,--CEEL_ID
                        sysdate,--ERR_DATE
                        'CRITICAL',--ERR_LEVEL
                        'PROCESS LETTERS',--PROCESS_NAME
                        'ProcessLetters_update_wip2wipt',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_PROC_LETTERS_WIP_BPM',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;
 END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cur;
END COPY_PL_UPD_WIP2WIPT;

END ETL_PROCESS_LETTERS_PKG;
/

alter session set plsql_code_type = interpreted;
