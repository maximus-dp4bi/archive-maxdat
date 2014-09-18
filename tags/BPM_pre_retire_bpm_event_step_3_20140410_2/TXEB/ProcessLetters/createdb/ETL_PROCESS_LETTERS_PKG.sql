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

 CURSOR letters_cur IS
   SELECT cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date
 FROM corp_etl_proc_letters
   WHERE complete_dt IS NULL;
   
   TYPE t_letter_tab IS TABLE OF letters_cur%ROWTYPE INDEX BY PLS_INTEGER;
    letter_tab t_letter_tab;
    v_bulk_limit NUMBER := 5000;    
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
BEGIN
   v_step := 'Truncate temp tables';   
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_WIP_T';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_WIP_BPM';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_OLTP_T';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_LETTERS_OLTP';
   
   OPEN letters_cur;
   LOOP
     FETCH letters_cur BULK COLLECT INTO letter_tab LIMIT v_bulk_limit;
     EXIT WHEN letter_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. letter_tab.COUNT LOOP    
       BEGIN
        v_step := 'Error inserting into WIP_T';
        INSERT INTO corp_etl_proc_letters_wip_t	(
          cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date	)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,letter_tab(indx).create_by,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).last_update_by_name,letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_by,letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,letter_tab(indx).assd_create_route_work,
          letter_tab(indx).ased_create_route_work,letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).asf_create_route_work,letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date);	   
        
        v_step := 'Error inserting into WIP_BPM';
        INSERT INTO corp_etl_proc_letters_wip_bpm	(
          cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date	)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,letter_tab(indx).create_by,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).last_update_by_name,letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_by,letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,letter_tab(indx).assd_create_route_work,
          letter_tab(indx).ased_create_route_work,letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).asf_create_route_work,letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date);	      

         v_step := 'Error inserting into OLTP';
         INSERT INTO corp_etl_proc_letters_oltp	(
          cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date	)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,letter_tab(indx).create_by,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).last_update_by_name,letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_by,letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,letter_tab(indx).assd_create_route_work,
          letter_tab(indx).ased_create_route_work,letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).asf_create_route_work,letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date);	      

         v_step := 'Error inserting into OLTP_T';
         INSERT INTO corp_etl_proc_letters_oltp_t	(
          cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date	)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,letter_tab(indx).create_by,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).last_update_by_name,letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_by,letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,letter_tab(indx).assd_create_route_work,
          letter_tab(indx).ased_create_route_work,letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).asf_create_route_work,letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date);	      
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
BPM.CEPN_ID,
LETTER_REQUEST_ID,
'Y'		IN_YES,
--,'N'	IN_NO
CASE WHEN NVL(REQUEST_DT,'1-JAN-1111') <>  NVL(O_REQUEST_DT,'1-JAN-1111')
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
,CASE WHEN NVL(TASK_ID,0) <>  NVL(O_TASK_ID,0)
     THEN TASK_ID
     ELSE O_TASK_ID
END AS UPD1_220
,CASE WHEN NVL(LAST_UPDATE_BY_NAME,'X') <>  NVL(O_LAST_UPDATE_BY_NAME,'X')
     THEN LAST_UPDATE_BY_NAME
     ELSE O_LAST_UPDATE_BY_NAME
END AS UPD1_230
,CASE WHEN NVL(LAST_UPDATE_DT,'1-JAN-1111') <>  NVL(O_LAST_UPDATE_DT,'1-JAN-1111')
     THEN LAST_UPDATE_DT
     ELSE O_LAST_UPDATE_DT
END AS UPD1_240,

CASE WHEN NVL(REQUEST_DT,'1-JAN-1111') <>  NVL(O_REQUEST_DT,'1-JAN-1111')   
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
OR  NVL(TASK_ID,0) <>  NVL(O_TASK_ID,0)     
OR  NVL(LAST_UPDATE_BY_NAME,'X') <>  NVL(O_LAST_UPDATE_BY_NAME,'X')     
OR  NVL(LAST_UPDATE_DT,'1-JAN-1111') <>  NVL(O_LAST_UPDATE_DT,'1-JAN-1111')   
 THEN 'Y'
 ELSE 'N'
 END AS UPDATED
FROM CORP_ETL_PROC_LETTERS_OLTP OLTP
JOIN 
(SELECT 
CEPN_ID CEPN_ID
,LETTER_REQUEST_ID O_LETTER_REQUEST_ID
,CREATE_DT O_CREATE_DT
,CREATE_BY O_CREATE_BY
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
,LAST_UPDATE_DT O_LAST_UPDATE_DT
,LAST_UPDATE_BY_NAME O_LAST_UPDATE_BY_NAME
,NEWBORN_FLAG O_NEWBORN_FLAG
,TASK_ID O_TASK_ID
,CANCEL_DT O_CANCEL_DT
,CANCEL_BY O_CANCEL_BY
,COMPLETE_DT O_COMPLETE_DT
,INSTANCE_STATUS O_INSTANCE_STATUS
,ASSD_PROCESS_LETTER_REQ O_ASSD_PROCESS_LETTER_REQ
,ASED_PROCESS_LETTER_REQ O_ASED_PROCESS_LETTER_REQ
,ASSD_TRANSMIT O_ASSD_TRANSMIT
,ASED_TRANSMIT O_ASED_TRANSMIT
,ASSD_RECEIVE_CONFIRMATION O_ASSD_RECEIVE_CONFIRMATION
,ASED_RECEIVE_CONFIRMATION O_ASED_RECEIVE_CONFIRMATION
,ASSD_CREATE_ROUTE_WORK O_ASSD_CREATE_ROUTE_WORK
,ASED_CREATE_ROUTE_WORK O_ASED_CREATE_ROUTE_WORK
,ASF_PROCESS_LETTER_REQ O_ASF_PROCESS_LETTER_REQ
,ASF_TRANSMIT O_ASF_TRANSMIT 
,ASF_RECEIVE_CONFIRMATION O_ASF_RECEIVE_CONFIRMATION
,ASF_CREATE_ROUTE_WORK  O_ASF_CREATE_ROUTE_WORK
,GWF_VALID O_GWF_VALID 
,GWF_OUTCOME O_GWF_OUTCOME
,GWF_WORK_REQUIRED O_GWF_WORK_REQUIRED
,STG_EXTRACT_DATE O_STG_EXTRACT_DATE
,STG_LAST_UPDATE_DATE  O_STG_LAST_UPDATE_DATE
,STAGE_DONE_DATE O_STAGE_DONE_DATE
,UPDATED O_UPDATED
FROM CORP_ETL_PROC_LETTERS_WIP_T
WHERE COMPLETE_DT IS NULL
)BPM
ON OLTP.CEPN_ID= BPM.CEPN_ID)
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
            ,STATUS_DT =	upd1_tab(indx).UPD1_111
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
            ,	TASK_ID	=	upd1_tab(indx).UPD1_220
            ,	LAST_UPDATE_BY_NAME	=	upd1_tab(indx).UPD1_230
            ,	LAST_UPDATE_DT	=	upd1_tab(indx).UPD1_240
            ,UPDATED =	upd1_tab(indx).UPDATED
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
          cepn_id,letter_request_id,create_dt,create_by,
          request_dt,letter_type,program,case_id,
          county_code,zip_code,language,reprint,
          request_driver_type,request_driver_table,status,status_dt,
          sent_dt,print_dt,mailed_dt,return_dt,
          return_reason,reject_reason,error_reason,transmit_file_name,
          transmit_file_dt,letter_resp_file_name,letter_resp_file_dt,last_update_dt,
          last_update_by_name,newborn_flag,task_id,cancel_dt,
          cancel_by,cancel_reason,cancel_method,complete_dt,
          instance_status,assd_process_letter_req,ased_process_letter_req,assd_transmit,
          ased_transmit,assd_receive_confirmation,ased_receive_confirmation,assd_create_route_work,
          ased_create_route_work,asf_process_letter_req,asf_transmit,asf_receive_confirmation,
          asf_create_route_work,gwf_valid,gwf_outcome,gwf_work_required,
          stg_extract_date,stg_last_update_date,stage_done_date	)
         VALUES (letter_tab(indx).cepn_id,letter_tab(indx).letter_request_id,letter_tab(indx).create_dt,letter_tab(indx).create_by,
          letter_tab(indx).request_dt,letter_tab(indx).letter_type,letter_tab(indx).program,letter_tab(indx).case_id,
          letter_tab(indx).county_code,letter_tab(indx).zip_code,letter_tab(indx).language,letter_tab(indx).reprint,
          letter_tab(indx).request_driver_type,letter_tab(indx).request_driver_table,letter_tab(indx).status,letter_tab(indx).status_dt,
          letter_tab(indx).sent_dt,letter_tab(indx).print_dt,letter_tab(indx).mailed_dt,letter_tab(indx).return_dt,
          letter_tab(indx).return_reason,letter_tab(indx).reject_reason,letter_tab(indx).error_reason,letter_tab(indx).transmit_file_name,
          letter_tab(indx).transmit_file_dt,letter_tab(indx).letter_resp_file_name,letter_tab(indx).letter_resp_file_dt,letter_tab(indx).last_update_dt,
          letter_tab(indx).last_update_by_name,letter_tab(indx).newborn_flag,letter_tab(indx).task_id,letter_tab(indx).cancel_dt,
          letter_tab(indx).cancel_by,letter_tab(indx).cancel_reason,letter_tab(indx).cancel_method,letter_tab(indx).complete_dt,
          letter_tab(indx).instance_status,letter_tab(indx).assd_process_letter_req,letter_tab(indx).ased_process_letter_req,letter_tab(indx).assd_transmit,
          letter_tab(indx).ased_transmit,letter_tab(indx).assd_receive_confirmation,letter_tab(indx).ased_receive_confirmation,letter_tab(indx).assd_create_route_work,
          letter_tab(indx).ased_create_route_work,letter_tab(indx).asf_process_letter_req,letter_tab(indx).asf_transmit,letter_tab(indx).asf_receive_confirmation,
          letter_tab(indx).asf_create_route_work,letter_tab(indx).gwf_valid,letter_tab(indx).gwf_outcome,letter_tab(indx).gwf_work_required,
          letter_tab(indx).stg_extract_date,letter_tab(indx).stg_last_update_date,letter_tab(indx).stage_done_date);	   
         
          
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
