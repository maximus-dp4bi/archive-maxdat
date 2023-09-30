alter session set plsql_code_type = native;

create or replace package ETL_MANAGE_ENROLLMENT_PKG as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure MEA_FETCH_NEW_INSTANCES;
  procedure MEA_COPY_BPM_TO_TEMP;
  procedure MEA_FETCH_FEE;
  procedure MEA_AA_DUE_DT;
  procedure MEA_FETCH_EMI_LETTER;
  procedure MEA_FETCH_HPC_LETTER;
  procedure MEA_FETCH_ENRL_PKTS;
  procedure MEA_FETCH_FIRST_FOLLOWUPS;
  procedure MEA_FETCH_SECOND_FOLLOWUPS;
  procedure MEA_CANCEL_DT_NO_LONGER_ELIG;    
  procedure MEA_CANCEL_DT_NEW_ENROLL;
  procedure MEA_UPD_PLAN_SELECTION;
  procedure MEA_SELECTION_AUTO_PROC;
  procedure MEA_UPD_ENROLL_STATUS;          
  procedure MEA_AGE_CALCULATION;
  procedure MEA_UPD_1;    
  procedure MEA_UPD_2;
  procedure MEA_UPD_3;
  procedure MEA_UPD_4;
  procedure MEA_UPD_5;
  procedure MEA_UPD_6;
  procedure MEA_UPD_7;
  procedure MEA_UPD_8;
  procedure MEA_UPD_9;
  procedure MEA_UPD_10;
  procedure MEA_UPD_11;
  procedure MEA_UPD_12;
  procedure MEA_UPD_13;
--  procedure MEA_UPD_14;
  procedure MEA_UPD_15;
  procedure MEA_UPD_16;
--  procedure MEA_UPD_17;
  procedure MEA_UPD_18;
  procedure MEA_UPD_19;
    
  procedure MEA_WIP_TO_BPM;
    
  

end;
/

create or replace package body ETL_MANAGE_ENROLLMENT_PKG as

PROCEDURE MEA_FETCH_NEW_INSTANCES AS
/*
This procedure fetches the new instances.
*/
 CURSOR MEA_cur IS
  select 
       A.client_enroll_status_id as client_enroll_status_id,
       A.client_id as client_id,
       A.plan_type as plan_type,
       A.program_type as program_type,
       A.ENROLLMENT_STATUS_CODE as ENROLLMENT_STATUS_CODE,
       A.ENROLLMENT_STATUS_DT as ENROLLMENT_STATUS_DT, 
       A.create_dt as create_dt,
       A.client_cin as client_cin,
       A.case_id as case_id,
       A.ADDR_ZIP as ZIP_CODE,
       A.ADDR_County as COUNTY_CODE,
       A.Service_area as Service_area,
       A.newborn_flag as newborn_flg,
       (
        select distinct
               first_value(c1.subprogram_type) over (partition by c1.client_id, c1.PLAN_TYPE_CD, c1.program_cd order by c1.start_date desc, c1.end_date desc, c1.client_elig_status_id desc)
         from client_elig_status_stg c1
        where 1=1
          and A.client_id = c1.client_id
          and A.plan_type = c1.plan_type_cd
          and A.program_type = c1.program_cd
          and c1.elig_status_cd in ('M','V','P')
         )  as subprogram_type,    
       (SELECT followup_type_code
          FROM RULE_LKUP_MNG_ENRL_FOLLOWUP R
         WHERE R.FOLLOWUP_NAME = 'FIRST'
         AND R.FOLLOWUP_REQ = 'Y'
         AND R.PLAN_TYPE = A.plan_type
         AND R.PROGRAM_TYPE = A.program_type
        ) as first_followup_type_code,
        (SELECT followup_type_code
          FROM RULE_LKUP_MNG_ENRL_FOLLOWUP R
         WHERE R.FOLLOWUP_NAME = 'SECOND'
         AND R.FOLLOWUP_REQ = 'Y'
         AND R.PLAN_TYPE = A.plan_type
         AND R.PROGRAM_TYPE = A.program_type
        ) as second_followup_type_code,
       (SELECT followup_type_code
          FROM RULE_LKUP_MNG_ENRL_FOLLOWUP R
         WHERE R.FOLLOWUP_NAME = 'THIRD'
         AND R.FOLLOWUP_REQ = 'Y'
         AND R.PLAN_TYPE = A.plan_type
         AND R.PROGRAM_TYPE = A.program_type
        ) as third_followup_type_code,
       (SELECT followup_type_code
          FROM RULE_LKUP_MNG_ENRL_FOLLOWUP R
         WHERE R.FOLLOWUP_NAME = 'FOURTH'
         AND R.FOLLOWUP_REQ = 'Y'
         AND R.PLAN_TYPE = A.plan_type
         AND R.PROGRAM_TYPE = A.program_type
        ) as fourth_followup_type_code,
        'Y' as in_yes
from (
select 
       enr.client_enroll_status_id as client_enroll_status_id, 
       enr.client_id as client_id, 
       enr.plan_type_cd as plan_type,
       enr.program_cd as program_type,
       enr.enroll_status_cd as ENROLLMENT_STATUS_CODE,
       enr.start_date as ENROLLMENT_STATUS_DT,
       enr.create_ts as create_dt,
       csi.client_cin as client_cin,
       csi.case_id as case_id,
       csi.ADDR_ZIP as ADDR_ZIP,
       csi.ADDR_County as ADDR_County,
       csi.Service_area as Service_area,
       (case when (trunc(enr.create_ts) - csi.dob) <= 365 then 'Y' else 'N' end) as newborn_flag
from client_enroll_status_stg  enr,
     client_supplementary_info_stg csi           
where 1=1
and enr.create_ts        >= 
                            (select coalesce(max(job_start_date), to_date('2014/02/01','yyyy/mm/dd'))
                               from corp_etl_job_statistics
                              where job_status_cd = 'COMPLETED'
                                and job_name = 'ProcessManageEnroll_RUNALL')           
and enr.client_enroll_status_id > 
                           (select to_number(value)
                              from corp_etl_control
                             where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID')
and enr.enroll_status_cd = 'A'
and enr.client_id = csi.client_id(+)
and enr.program_cd = csi.program_cd(+)
and not exists (select 1 
                  from corp_etl_manage_enroll CEME
                 where CEME.client_enroll_status_id = enr.client_enroll_status_id)
) A
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
  
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Inserting New Instances into MEA BPM Stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        INSERT INTO corp_etl_manage_enroll	(
CLIENT_ENROLL_STATUS_ID,
CLIENT_ID,
PLAN_TYPE,
PROGRAM_TYPE,
SUBPROGRAM_TYPE,
ENROLLMENT_STATUS_CODE,
ENROLLMENT_STATUS_DT,
CREATE_DT,
GWF_ENRL_PACK_REQ,
ASSD_SEND_ENROLL_PACKET,
CASE_ID,
CLIENT_CIN,
NEWBORN_FLG,
SERVICE_AREA,
COUNTY_CODE,
ZIP_CODE,
FIRST_FOLLOWUP_TYPE_CODE,
SECOND_FOLLOWUP_TYPE_CODE,
THIRD_FOLLOWUP_TYPE_CODE,
FOURTH_FOLLOWUP_TYPE_CODE
)
         VALUES (
MEA_cur_tab(indx).CLIENT_ENROLL_STATUS_ID,
MEA_cur_tab(indx).CLIENT_ID,
MEA_cur_tab(indx).PLAN_TYPE,
MEA_cur_tab(indx).PROGRAM_TYPE,
MEA_cur_tab(indx).SUBPROGRAM_TYPE,
MEA_cur_tab(indx).ENROLLMENT_STATUS_CODE,
MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,
MEA_cur_tab(indx).CREATE_DT,
MEA_cur_tab(indx).IN_YES,
MEA_cur_tab(indx).CREATE_DT,
MEA_cur_tab(indx).CASE_ID,
MEA_cur_tab(indx).CLIENT_CIN,
MEA_cur_tab(indx).NEWBORN_FLG,
MEA_cur_tab(indx).SERVICE_AREA,
MEA_cur_tab(indx).COUNTY_CODE,
MEA_cur_tab(indx).ZIP_CODE,
MEA_cur_tab(indx).FIRST_FOLLOWUP_TYPE_CODE,
MEA_cur_tab(indx).SECOND_FOLLOWUP_TYPE_CODE,
MEA_cur_tab(indx).THIRD_FOLLOWUP_TYPE_CODE,
MEA_cur_tab(indx).FOURTH_FOLLOWUP_TYPE_CODE
);
commit;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_NEW_INSTANCES',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_NEW_INSTANCES;

PROCEDURE MEA_COPY_BPM_TO_TEMP AS

 CURSOR MEA_cur IS
   SELECT
CEME_ID,CLIENT_ENROLL_STATUS_ID,CLIENT_ID,CREATE_DT,CASE_ID,CLIENT_CIN,NEWBORN_FLG,SERVICE_AREA,COUNTY_CODE,ZIP_CODE,
ENROLLMENT_STATUS_CODE,ENROLLMENT_STATUS_DT,AA_DUE_DT,ENRL_PACK_ID,ENRL_PACK_REQUEST_DT,ENROLL_FEE_AMNT_DUE,ENROLL_FEE_AMNT_PAID,
ENROLL_FEE_PAID_DT,FEE_PAID_FLG,CHIP_HPC_ID,CHIP_HPC_MAILED_DT,CHIP_EMI_ID,CHIP_EMI_MAILED_DT,PLAN_TYPE,PROGRAM_TYPE,SUBPROGRAM_TYPE,
SLCT_AUTO_PROC,SLCT_METHOD,SLCT_CREATE_BY_NAME,SLCT_CREATE_DT,SLCT_LAST_UPDATE_BY_NAME,SLCT_LAST_UPDATE_DT,ASSD_SELECTION_RECD,
ASED_SELECTION_RECD,ASSD_SEND_ENROLL_PACKET,ASED_SEND_ENROLL_PACKET,FIRST_FOLLOWUP_ID,FIRST_FOLLOWUP_TYPE_CODE,ASSD_FIRST_FOLLOWUP,
ASED_FIRST_FOLLOWUP,SECOND_FOLLOWUP_ID,SECOND_FOLLOWUP_TYPE_CODE,ASSD_SECOND_FOLLOWUP,ASED_SECOND_FOLLOWUP,THIRD_FOLLOWUP_ID,
THIRD_FOLLOWUP_TYPE_CODE,ASSD_THIRD_FOLLOWUP,ASED_THIRD_FOLLOWUP,FOURTH_FOLLOWUP_ID,FOURTH_FOLLOWUP_TYPE_CODE,ASSD_FOURTH_FOLLOWUP,
ASED_FOURTH_FOLLOWUP,ASSD_AUTO_ASSIGN,ASED_AUTO_ASSIGN,ASSD_WAIT_FOR_FEE,ASED_WAIT_FOR_FEE,ASF_CANCEL_ENRL_ACTIVITY,ASF_SEND_ENROLL_PACKET,
ASF_SELECTION_RECD,ASF_FIRST_FOLLOWUP,ASF_SECOND_FOLLOWUP,ASF_THIRD_FOLLOWUP,ASF_FOURTH_FOLLOWUP,ASF_AUTO_ASSIGN,ASF_WAIT_FOR_FEE,GWF_ENRL_PACK_REQ,
GWF_FIRST_FOLLOWUP_REQ,GWF_SECOND_FOLLOWUP_REQ,GWF_THIRD_FOLLOWUP_REQ,GWF_FOURTH_FOLLOWUP_REQ,GWF_REQUIRED_FEE_PAID,GENERIC_FIELD_1,
GENERIC_FIELD_2,GENERIC_FIELD_3,GENERIC_FIELD_4,GENERIC_FIELD_5,INSTANCE_STATUS,COMPLETE_DT,CANCEL_DT,CANCEL_REASON,CANCEL_METHOD,
CANCEL_BY,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,STAGE_DONE_DATE
 FROM corp_etl_manage_enroll
   WHERE COMPLETE_DT IS NULL;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN
   v_step := 'Truncate temp tables';
   EXECUTE IMMEDIATE 'truncate table corp_etl_manage_enroll_oltp';
   EXECUTE IMMEDIATE 'truncate table corp_etl_manage_enroll_wip';

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Inserting New Instances into MEA OLTP Stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        INSERT INTO corp_etl_manage_enroll_oltp	(
CEME_ID,CLIENT_ENROLL_STATUS_ID,CLIENT_ID,CREATE_DT,CASE_ID,CLIENT_CIN,NEWBORN_FLG,SERVICE_AREA,COUNTY_CODE,ZIP_CODE,
ENROLLMENT_STATUS_CODE,ENROLLMENT_STATUS_DT,AA_DUE_DT,ENRL_PACK_ID,ENRL_PACK_REQUEST_DT,ENROLL_FEE_AMNT_DUE,ENROLL_FEE_AMNT_PAID,
ENROLL_FEE_PAID_DT,FEE_PAID_FLG,CHIP_HPC_ID,CHIP_HPC_MAILED_DT,CHIP_EMI_ID,CHIP_EMI_MAILED_DT,PLAN_TYPE,PROGRAM_TYPE,SUBPROGRAM_TYPE,
SLCT_AUTO_PROC,SLCT_METHOD,SLCT_CREATE_BY_NAME,SLCT_CREATE_DT,SLCT_LAST_UPDATE_BY_NAME,SLCT_LAST_UPDATE_DT,ASSD_SELECTION_RECD,
ASED_SELECTION_RECD,ASSD_SEND_ENROLL_PACKET,ASED_SEND_ENROLL_PACKET,FIRST_FOLLOWUP_ID,FIRST_FOLLOWUP_TYPE_CODE,ASSD_FIRST_FOLLOWUP,
ASED_FIRST_FOLLOWUP,SECOND_FOLLOWUP_ID,SECOND_FOLLOWUP_TYPE_CODE,ASSD_SECOND_FOLLOWUP,ASED_SECOND_FOLLOWUP,THIRD_FOLLOWUP_ID,
THIRD_FOLLOWUP_TYPE_CODE,ASSD_THIRD_FOLLOWUP,ASED_THIRD_FOLLOWUP,FOURTH_FOLLOWUP_ID,FOURTH_FOLLOWUP_TYPE_CODE,ASSD_FOURTH_FOLLOWUP,
ASED_FOURTH_FOLLOWUP,ASSD_AUTO_ASSIGN,ASED_AUTO_ASSIGN,ASSD_WAIT_FOR_FEE,ASED_WAIT_FOR_FEE,ASF_CANCEL_ENRL_ACTIVITY,ASF_SEND_ENROLL_PACKET,
ASF_SELECTION_RECD,ASF_FIRST_FOLLOWUP,ASF_SECOND_FOLLOWUP,ASF_THIRD_FOLLOWUP,ASF_FOURTH_FOLLOWUP,ASF_AUTO_ASSIGN,ASF_WAIT_FOR_FEE,GWF_ENRL_PACK_REQ,
GWF_FIRST_FOLLOWUP_REQ,GWF_SECOND_FOLLOWUP_REQ,GWF_THIRD_FOLLOWUP_REQ,GWF_FOURTH_FOLLOWUP_REQ,GWF_REQUIRED_FEE_PAID,GENERIC_FIELD_1,
GENERIC_FIELD_2,GENERIC_FIELD_3,GENERIC_FIELD_4,GENERIC_FIELD_5,INSTANCE_STATUS,COMPLETE_DT,CANCEL_DT,CANCEL_REASON,CANCEL_METHOD,
CANCEL_BY,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,STAGE_DONE_DATE
)
         VALUES (
MEA_cur_tab(indx).CEME_ID,MEA_cur_tab(indx).CLIENT_ENROLL_STATUS_ID,MEA_cur_tab(indx).CLIENT_ID,MEA_cur_tab(indx).CREATE_DT,MEA_cur_tab(indx).CASE_ID,MEA_cur_tab(indx).CLIENT_CIN,MEA_cur_tab(indx).NEWBORN_FLG,MEA_cur_tab(indx).SERVICE_AREA,MEA_cur_tab(indx).COUNTY_CODE,MEA_cur_tab(indx).ZIP_CODE,MEA_cur_tab(indx).
ENROLLMENT_STATUS_CODE,MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,MEA_cur_tab(indx).AA_DUE_DT,MEA_cur_tab(indx).ENRL_PACK_ID,MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE,MEA_cur_tab(indx).ENROLL_FEE_AMNT_PAID,MEA_cur_tab(indx).
ENROLL_FEE_PAID_DT,MEA_cur_tab(indx).FEE_PAID_FLG,MEA_cur_tab(indx).CHIP_HPC_ID,MEA_cur_tab(indx).CHIP_HPC_MAILED_DT,MEA_cur_tab(indx).CHIP_EMI_ID,MEA_cur_tab(indx).CHIP_EMI_MAILED_DT,MEA_cur_tab(indx).PLAN_TYPE,MEA_cur_tab(indx).PROGRAM_TYPE,MEA_cur_tab(indx).SUBPROGRAM_TYPE,MEA_cur_tab(indx).
SLCT_AUTO_PROC,MEA_cur_tab(indx).SLCT_METHOD,MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,MEA_cur_tab(indx).SLCT_CREATE_DT,MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,MEA_cur_tab(indx).ASSD_SELECTION_RECD,MEA_cur_tab(indx).
ASED_SELECTION_RECD,MEA_cur_tab(indx).ASSD_SEND_ENROLL_PACKET,MEA_cur_tab(indx).ASED_SEND_ENROLL_PACKET,MEA_cur_tab(indx).FIRST_FOLLOWUP_ID,MEA_cur_tab(indx).FIRST_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_FIRST_FOLLOWUP,MEA_cur_tab(indx).
ASED_FIRST_FOLLOWUP,MEA_cur_tab(indx).SECOND_FOLLOWUP_ID,MEA_cur_tab(indx).SECOND_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_SECOND_FOLLOWUP,MEA_cur_tab(indx).ASED_SECOND_FOLLOWUP,MEA_cur_tab(indx).THIRD_FOLLOWUP_ID,MEA_cur_tab(indx).
THIRD_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_THIRD_FOLLOWUP,MEA_cur_tab(indx).ASED_THIRD_FOLLOWUP,MEA_cur_tab(indx).FOURTH_FOLLOWUP_ID,MEA_cur_tab(indx).FOURTH_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_FOURTH_FOLLOWUP,MEA_cur_tab(indx).
ASED_FOURTH_FOLLOWUP,MEA_cur_tab(indx).ASSD_AUTO_ASSIGN,MEA_cur_tab(indx).ASED_AUTO_ASSIGN,MEA_cur_tab(indx).ASSD_WAIT_FOR_FEE,MEA_cur_tab(indx).ASED_WAIT_FOR_FEE,MEA_cur_tab(indx).ASF_CANCEL_ENRL_ACTIVITY,MEA_cur_tab(indx).ASF_SEND_ENROLL_PACKET,MEA_cur_tab(indx).
ASF_SELECTION_RECD,MEA_cur_tab(indx).ASF_FIRST_FOLLOWUP,MEA_cur_tab(indx).ASF_SECOND_FOLLOWUP,MEA_cur_tab(indx).ASF_THIRD_FOLLOWUP,MEA_cur_tab(indx).ASF_FOURTH_FOLLOWUP,MEA_cur_tab(indx).ASF_AUTO_ASSIGN,MEA_cur_tab(indx).ASF_WAIT_FOR_FEE,MEA_cur_tab(indx).GWF_ENRL_PACK_REQ,MEA_cur_tab(indx).
GWF_FIRST_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_SECOND_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_THIRD_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_FOURTH_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_REQUIRED_FEE_PAID,MEA_cur_tab(indx).GENERIC_FIELD_1,MEA_cur_tab(indx).
GENERIC_FIELD_2,MEA_cur_tab(indx).GENERIC_FIELD_3,MEA_cur_tab(indx).GENERIC_FIELD_4,MEA_cur_tab(indx).GENERIC_FIELD_5,MEA_cur_tab(indx).INSTANCE_STATUS,MEA_cur_tab(indx).COMPLETE_DT,MEA_cur_tab(indx).CANCEL_DT,MEA_cur_tab(indx).CANCEL_REASON,MEA_cur_tab(indx).CANCEL_METHOD,MEA_cur_tab(indx).
CANCEL_BY,MEA_cur_tab(indx).STG_EXTRACT_DATE,MEA_cur_tab(indx).STG_LAST_UPDATE_DATE,MEA_cur_tab(indx).STAGE_DONE_DATE
);
commit;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'COPY_MEA_BPM_TO_TEMP',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;
  

OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Inserting New Instances into MEA WIP Stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        INSERT INTO corp_etl_manage_enroll_wip	(
CEME_ID,CLIENT_ENROLL_STATUS_ID,CLIENT_ID,CREATE_DT,CASE_ID,CLIENT_CIN,NEWBORN_FLG,SERVICE_AREA,COUNTY_CODE,ZIP_CODE,
ENROLLMENT_STATUS_CODE,ENROLLMENT_STATUS_DT,AA_DUE_DT,ENRL_PACK_ID,ENRL_PACK_REQUEST_DT,ENROLL_FEE_AMNT_DUE,ENROLL_FEE_AMNT_PAID,
ENROLL_FEE_PAID_DT,FEE_PAID_FLG,CHIP_HPC_ID,CHIP_HPC_MAILED_DT,CHIP_EMI_ID,CHIP_EMI_MAILED_DT,PLAN_TYPE,PROGRAM_TYPE,SUBPROGRAM_TYPE,
SLCT_AUTO_PROC,SLCT_METHOD,SLCT_CREATE_BY_NAME,SLCT_CREATE_DT,SLCT_LAST_UPDATE_BY_NAME,SLCT_LAST_UPDATE_DT,ASSD_SELECTION_RECD,
ASED_SELECTION_RECD,ASSD_SEND_ENROLL_PACKET,ASED_SEND_ENROLL_PACKET,FIRST_FOLLOWUP_ID,FIRST_FOLLOWUP_TYPE_CODE,ASSD_FIRST_FOLLOWUP,
ASED_FIRST_FOLLOWUP,SECOND_FOLLOWUP_ID,SECOND_FOLLOWUP_TYPE_CODE,ASSD_SECOND_FOLLOWUP,ASED_SECOND_FOLLOWUP,THIRD_FOLLOWUP_ID,
THIRD_FOLLOWUP_TYPE_CODE,ASSD_THIRD_FOLLOWUP,ASED_THIRD_FOLLOWUP,FOURTH_FOLLOWUP_ID,FOURTH_FOLLOWUP_TYPE_CODE,ASSD_FOURTH_FOLLOWUP,
ASED_FOURTH_FOLLOWUP,ASSD_AUTO_ASSIGN,ASED_AUTO_ASSIGN,ASSD_WAIT_FOR_FEE,ASED_WAIT_FOR_FEE,ASF_CANCEL_ENRL_ACTIVITY,ASF_SEND_ENROLL_PACKET,
ASF_SELECTION_RECD,ASF_FIRST_FOLLOWUP,ASF_SECOND_FOLLOWUP,ASF_THIRD_FOLLOWUP,ASF_FOURTH_FOLLOWUP,ASF_AUTO_ASSIGN,ASF_WAIT_FOR_FEE,GWF_ENRL_PACK_REQ,
GWF_FIRST_FOLLOWUP_REQ,GWF_SECOND_FOLLOWUP_REQ,GWF_THIRD_FOLLOWUP_REQ,GWF_FOURTH_FOLLOWUP_REQ,GWF_REQUIRED_FEE_PAID,GENERIC_FIELD_1,
GENERIC_FIELD_2,GENERIC_FIELD_3,GENERIC_FIELD_4,GENERIC_FIELD_5,INSTANCE_STATUS,COMPLETE_DT,CANCEL_DT,CANCEL_REASON,CANCEL_METHOD,
CANCEL_BY,STG_EXTRACT_DATE,STG_LAST_UPDATE_DATE,STAGE_DONE_DATE
)
         VALUES (
MEA_cur_tab(indx).CEME_ID,MEA_cur_tab(indx).CLIENT_ENROLL_STATUS_ID,MEA_cur_tab(indx).CLIENT_ID,MEA_cur_tab(indx).CREATE_DT,MEA_cur_tab(indx).CASE_ID,MEA_cur_tab(indx).CLIENT_CIN,MEA_cur_tab(indx).NEWBORN_FLG,MEA_cur_tab(indx).SERVICE_AREA,MEA_cur_tab(indx).COUNTY_CODE,MEA_cur_tab(indx).ZIP_CODE,MEA_cur_tab(indx).
ENROLLMENT_STATUS_CODE,MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,MEA_cur_tab(indx).AA_DUE_DT,MEA_cur_tab(indx).ENRL_PACK_ID,MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE,MEA_cur_tab(indx).ENROLL_FEE_AMNT_PAID,MEA_cur_tab(indx).
ENROLL_FEE_PAID_DT,MEA_cur_tab(indx).FEE_PAID_FLG,MEA_cur_tab(indx).CHIP_HPC_ID,MEA_cur_tab(indx).CHIP_HPC_MAILED_DT,MEA_cur_tab(indx).CHIP_EMI_ID,MEA_cur_tab(indx).CHIP_EMI_MAILED_DT,MEA_cur_tab(indx).PLAN_TYPE,MEA_cur_tab(indx).PROGRAM_TYPE,MEA_cur_tab(indx).SUBPROGRAM_TYPE,MEA_cur_tab(indx).
SLCT_AUTO_PROC,MEA_cur_tab(indx).SLCT_METHOD,MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,MEA_cur_tab(indx).SLCT_CREATE_DT,MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,MEA_cur_tab(indx).ASSD_SELECTION_RECD,MEA_cur_tab(indx).
ASED_SELECTION_RECD,MEA_cur_tab(indx).ASSD_SEND_ENROLL_PACKET,MEA_cur_tab(indx).ASED_SEND_ENROLL_PACKET,MEA_cur_tab(indx).FIRST_FOLLOWUP_ID,MEA_cur_tab(indx).FIRST_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_FIRST_FOLLOWUP,MEA_cur_tab(indx).
ASED_FIRST_FOLLOWUP,MEA_cur_tab(indx).SECOND_FOLLOWUP_ID,MEA_cur_tab(indx).SECOND_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_SECOND_FOLLOWUP,MEA_cur_tab(indx).ASED_SECOND_FOLLOWUP,MEA_cur_tab(indx).THIRD_FOLLOWUP_ID,MEA_cur_tab(indx).
THIRD_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_THIRD_FOLLOWUP,MEA_cur_tab(indx).ASED_THIRD_FOLLOWUP,MEA_cur_tab(indx).FOURTH_FOLLOWUP_ID,MEA_cur_tab(indx).FOURTH_FOLLOWUP_TYPE_CODE,MEA_cur_tab(indx).ASSD_FOURTH_FOLLOWUP,MEA_cur_tab(indx).
ASED_FOURTH_FOLLOWUP,MEA_cur_tab(indx).ASSD_AUTO_ASSIGN,MEA_cur_tab(indx).ASED_AUTO_ASSIGN,MEA_cur_tab(indx).ASSD_WAIT_FOR_FEE,MEA_cur_tab(indx).ASED_WAIT_FOR_FEE,MEA_cur_tab(indx).ASF_CANCEL_ENRL_ACTIVITY,MEA_cur_tab(indx).ASF_SEND_ENROLL_PACKET,MEA_cur_tab(indx).
ASF_SELECTION_RECD,MEA_cur_tab(indx).ASF_FIRST_FOLLOWUP,MEA_cur_tab(indx).ASF_SECOND_FOLLOWUP,MEA_cur_tab(indx).ASF_THIRD_FOLLOWUP,MEA_cur_tab(indx).ASF_FOURTH_FOLLOWUP,MEA_cur_tab(indx).ASF_AUTO_ASSIGN,MEA_cur_tab(indx).ASF_WAIT_FOR_FEE,MEA_cur_tab(indx).GWF_ENRL_PACK_REQ,MEA_cur_tab(indx).
GWF_FIRST_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_SECOND_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_THIRD_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_FOURTH_FOLLOWUP_REQ,MEA_cur_tab(indx).GWF_REQUIRED_FEE_PAID,MEA_cur_tab(indx).GENERIC_FIELD_1,MEA_cur_tab(indx).
GENERIC_FIELD_2,MEA_cur_tab(indx).GENERIC_FIELD_3,MEA_cur_tab(indx).GENERIC_FIELD_4,MEA_cur_tab(indx).GENERIC_FIELD_5,MEA_cur_tab(indx).INSTANCE_STATUS,MEA_cur_tab(indx).COMPLETE_DT,MEA_cur_tab(indx).CANCEL_DT,MEA_cur_tab(indx).CANCEL_REASON,MEA_cur_tab(indx).CANCEL_METHOD,MEA_cur_tab(indx).
CANCEL_BY,MEA_cur_tab(indx).STG_EXTRACT_DATE,MEA_cur_tab(indx).STG_LAST_UPDATE_DATE,MEA_cur_tab(indx).STAGE_DONE_DATE
);
commit;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_COPY_BPM_TO_TEMP',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;  

END MEA_COPY_BPM_TO_TEMP;

PROCEDURE MEA_FETCH_FEE AS
/*
Enrollment Fee related attributes are to be updated only for the instances that changed since the last ETL run.
This check will work on the newly inserted instances and also all the active instances.
*/
 CURSOR MEA_cur IS
 select Z.* 
from 
(
select 
       etl.ceme_id,
       etl.client_id, 
       etl.client_enroll_status_id,
       etl.ENROLL_FEE_AMNT_DUE,
       etl.fee_paid_flg,
       etl.ENROLL_FEE_PAID_DT,
       c1.enrollment_fee as ENROLL_FEE_AMNT_DUE_2, 
       c1.fee_paid_flag  as FEE_PAID_FLG_2, 
       c1.date_fee_paid  as ENROLL_FEE_PAID_DT_2         
from corp_etl_manage_enroll_oltp  etl
left outer join cost_share_details_stg  c1
          on etl.case_id = c1.case_id                                        
where 1=1           
 --and etl.aa_due_dt is null                      
  and c1.cs_details_id = (select distinct first_value(c2.cs_details_id) over (partition by c2.case_id order by c2.enrollment_start_date desc, c2.enrollment_end_date desc, c2.cs_details_id desc)
                           from cost_share_details_stg c2
                           where c2.case_id = etl.case_id
                          )
  and c1.update_ts >= (select to_date(value,'yyyy/mm/dd hh24:mi:ss')
                         from CORP_ETL_CONTROL
                    	where name = 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS')                            
) Z
where 1=1
and ( 
       coalesce(ENROLL_FEE_AMNT_DUE,9) <> coalesce(ENROLL_FEE_AMNT_DUE_2,9) or                                    
       coalesce(fee_paid_flg,'X') <> coalesce(fee_paid_flg_2,'X') or                                    
       coalesce(ENROLL_FEE_PAID_DT,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(ENROLL_FEE_PAID_DT_2,to_date('1-jan-2000','dd-mon-yyyy')) 
     ) 
  ;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Enrollment fee attributes.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set ENROLL_FEE_AMNT_DUE = MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE_2,
            fee_paid_flg = MEA_cur_tab(indx).FEE_PAID_FLG_2,
            ENROLL_FEE_PAID_DT = MEA_cur_tab(indx).ENROLL_FEE_PAID_DT_2
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_FEE',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_FEE;

PROCEDURE MEA_AA_DUE_DT AS
/*
Enrollment Fee related attributes are to be updated only for the instances that changed since the last ETL run.
This check will work on the newly inserted instances and also all the active instances.
*/
 CURSOR MEA_cur IS
    select ceme_id,  
      (CASE WHEN  etl.program_type = 'MEDICAID' THEN trunc(etl.create_dt)+15
            WHEN  etl.program_type = 'CHIP' and nvl(etl.enroll_fee_amnt_due,0) = 0
                                              then (select distinct first_value(Maximus_Cutoff_Date_1) over (partition by 1 order by Maximus_Cutoff_Date_1 asc)
                                                     from cutoff_calendar_stg c
                                                     where c.Maximus_Cutoff_Date_1 >= trunc(etl.create_dt)+15
                                                     ) 
            WHEN  etl.program_type = 'CHIP' and etl.enroll_fee_amnt_due > 0
                                              then (select distinct first_value(Maximus_Cutoff_Date_1) over (partition by 1 order by Maximus_Cutoff_Date_1 asc)
                                                      from cutoff_calendar_stg c
                                                     where c.Maximus_Cutoff_Date_1 >= trunc(etl.create_dt)+45
                                                     )
            end 
          ) as aa_due_dt
     from corp_etl_manage_enroll_oltp etl
    where aa_due_dt is null;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating aa_due_dt in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set aa_due_dt = MEA_cur_tab(indx).aa_due_dt
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_AA_DUE_DT',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_AA_DUE_DT;


PROCEDURE MEA_FETCH_EMI_LETTER AS
/*
Fetch EMI letter for an instance where it was not fetched before and EMI letters that were created since last ETL run.
Updating CHIP_EMI_ID - CHIP_EMI_MAILED_DT.
*/
 CURSOR MEA_cur IS
   SELECT 
       ETL.CEME_ID,
       LET_1ST_ENR.LETTER_ID,
       LET_1ST_ENR.LETTER_MAILED_DATE
from corp_etl_manage_enroll_oltp etl
join letters_stg let_1st_enr
    ON ETL.CASE_ID = LET_1ST_ENR.LETTER_CASE_ID
    AND (ETL.CHIP_EMI_ID IS NULL OR ETL.CHIP_EMI_MAILED_DT IS NULL)
    and LET_1ST_ENR.letter_update_ts >= (select to_date(value,'yyyy/mm/dd hh24:mi:ss') 
                                           from CORP_ETL_CONTROL 
                                          where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI')
WHERE 1=1 
and let_1st_enr.letter_id = (select min(l.letter_id)
                                 FROM LETTERS_STG L
                                WHERE 1=1 
                                  AND L.LETTER_CASE_ID = ETL.CASE_ID
                                  and l.letter_requested_on >= etl.create_dt 
                                  AND L.LETTER_TYPE_CD IN (SELECT OUT_VAR FROM CORP_ETL_LIST_LKUP WHERE NAME = 'ENROLL_MI')       
                                  )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating EMI Letter information in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set CHIP_EMI_ID = MEA_cur_tab(indx).LETTER_ID,
            CHIP_EMI_MAILED_DT = MEA_cur_tab(indx).LETTER_MAILED_DATE
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_EMI_LETTER',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_EMI_LETTER;


PROCEDURE MEA_FETCH_HPC_LETTER AS
/*
Fetch HPC letter for an instance where it was not fetched before and EMI letters that were created since last ETL run.
Updating CHIP_HPC_ID - CHIP_HPC_MAILED_DT.
*/
 CURSOR MEA_cur IS
   SELECT 
       ETL.CEME_ID,
       LET_1ST_ENR.LETTER_ID,
       LET_1ST_ENR.LETTER_MAILED_DATE
from corp_etl_manage_enroll_oltp etl
join letters_stg let_1st_enr
    ON ETL.CASE_ID = LET_1ST_ENR.LETTER_CASE_ID
    AND (ETL.CHIP_HPC_ID IS NULL OR CHIP_HPC_MAILED_DT IS NULL)
    and LET_1ST_ENR.letter_update_ts >= (select to_date(value,'yyyy/mm/dd hh24:mi:ss') 
                                           from CORP_ETL_CONTROL 
                                          where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC')
WHERE 1=1 
and let_1st_enr.letter_id = (select min(l.letter_id)
                                 FROM LETTERS_STG L
                                WHERE 1=1 
                                  AND L.LETTER_CASE_ID = ETL.CASE_ID
                                  and l.letter_requested_on >= etl.create_dt 
                                  AND L.LETTER_TYPE_CD IN (SELECT OUT_VAR FROM CORP_ETL_LIST_LKUP WHERE NAME = 'PLAN_CHANGE')       
                                  )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating EMI Letter information in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set CHIP_HPC_ID = MEA_cur_tab(indx).LETTER_ID,
            CHIP_HPC_MAILED_DT = MEA_cur_tab(indx).LETTER_MAILED_DATE
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_HPC_LETTER',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_HPC_LETTER;


PROCEDURE MEA_FETCH_ENRL_PKTS AS
/*
Fetch Enrollment packet for an instance where it was not fetched before.
*/
 CURSOR MEA_cur IS
  select etl.ceme_id,
       let_1st_enr.letter_id,
       let_1st_enr.letter_requested_on,
       let_1st_enr.letter_type_cd
from corp_etl_manage_enroll_oltp etl
left outer join letters_stg let_1st_enr
    on etl.case_id = let_1st_enr.letter_case_id
    and etl.enrl_pack_id is null
where let_1st_enr.letter_id = (select min(l.letter_id)
                                 from letters_stg l
                                where l.letter_case_id = etl.case_id
                                  and l.letter_requested_on >= etl.enrollment_status_dt 
                                  and l.letter_type_cd in 
                                        (
                                          SELECT ENROLL_PACKET_NAME 
                                            FROM RULE_LKUP_MNG_ENRL_PACKET  r
                                           WHERE r.PLAN_TYPE = ETL.PLAN_TYPE
                                             AND r.PROGRAM_TYPE = ETL.PROGRAM_TYPE
                                             AND r.SUBPROGRAM_TYPE = etl.SUBPROGRAM_TYPE
                                          )                      
                                  )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Enrollment Packet information in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set ENRL_PACK_ID = MEA_cur_tab(indx).LETTER_ID,
            ENRL_PACK_REQUEST_DT = MEA_cur_tab(indx).LETTER_REQUESTED_ON
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_ENRL_PKTS',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_ENRL_PKTS;

PROCEDURE MEA_FETCH_FIRST_FOLLOWUPS AS
/*
Fetch First Followups for an instance where it was not fetched before.
*/
 CURSOR MEA_cur IS
  select 
       etl.ceme_id,
       etl.ENRL_PACK_REQUEST_DT,
       let_1st_enr.letter_id,
       let_1st_enr.letter_requested_on
from corp_etl_manage_enroll_oltp etl
left outer join letters_stg let_1st_enr
    on etl.case_id = let_1st_enr.letter_case_id
    and etl.enrl_pack_id is not null --Enrollment packet was requested.
    and etl.first_followup_id is null    --First follow-up notice was not requested yet.
where let_1st_enr.letter_id = (select min(letter_id)
                                 from letters_stg l
                                where l.letter_case_id = etl.case_id
                                  and l.letter_requested_on >= etl.ENRL_PACK_REQUEST_DT 
                                  and l.letter_type_cd = etl.first_followup_type_code          
                                  )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating First Followup information in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set FIRST_FOLLOWUP_ID = MEA_cur_tab(indx).LETTER_ID,
            ASSD_FIRST_FOLLOWUP = MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,
            ASED_FIRST_FOLLOWUP = MEA_cur_tab(indx).LETTER_REQUESTED_ON
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_FIRST_FOLLOWUPS',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_FIRST_FOLLOWUPS;

PROCEDURE MEA_FETCH_SECOND_FOLLOWUPS AS
/*
Fetch Second Followups for an instance where it was not fetched before.
*/
 CURSOR MEA_cur IS
 select 
       etl.ceme_id,
       etl.ased_first_followup,
       let_1st_enr.letter_id,
       let_1st_enr.letter_requested_on
from corp_etl_manage_enroll_oltp etl
left outer join letters_stg let_1st_enr
    on etl.case_id = let_1st_enr.letter_case_id
    and etl.first_followup_id is not null
    and etl.second_followup_id is null
where let_1st_enr.letter_id = (select min(letter_id)
                                 from letters_stg l
                                where l.letter_case_id = etl.case_id
                                  and l.letter_requested_on > etl.ased_first_followup 
                                  and l.letter_type_cd = etl.second_followup_type_code                      
                                  )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Second Followup information in the oltp stage table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set SECOND_FOLLOWUP_ID = MEA_cur_tab(indx).LETTER_ID,
            ASSD_SECOND_FOLLOWUP = MEA_cur_tab(indx).ASED_FIRST_FOLLOWUP,
            ASED_SECOND_FOLLOWUP = MEA_cur_tab(indx).LETTER_REQUESTED_ON
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_FETCH_SECOND_FOLLOWUPS',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_FETCH_SECOND_FOLLOWUPS;

PROCEDURE MEA_CANCEL_DT_NO_LONGER_ELIG AS
/*
Find the earliest occurence of the 'O' status without a 'A' in between. This will be natural Instance Completion.
cancel_reason = 'No longer eligible'.
*/
 CURSOR MEA_cur IS
 select 
        etl.ceme_id,
        etl.client_id,
        etl.client_enroll_status_id,
        c1.create_ts        as cancel_dt,
       'No longer eligible' as cancel_reason,
       'Normal'             as cancel_method,
       coalesce( (select last_name ||', '||first_name from staff_stg where to_char(staff_id)  = c1.updated_by), c1.updated_by) as cancel_by
  from CLIENT_ENROLL_STATUS_STG c1,
       corp_etl_manage_enroll_oltp  etl
  where c1.enroll_status_cd in ( 'O','K','Q')
  and c1.update_ts >= (
					    select to_date(value,'yyyy/mm/dd hh24:mi:ss')
  						  from corp_etl_control
						 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT')
  and c1.client_id = etl.client_id
  and c1.client_enroll_status_id > etl.client_enroll_status_id
  and not exists (select 1 
                  from client_enroll_status_STG c2
                 where 1=1 
                   and c2.client_id = etl.client_id
                   and c2.client_enroll_status_id > etl.client_enroll_status_id --after instance was created.
                   and c2.client_enroll_status_id < c1.client_enroll_status_id --before 'O' status
                   and c2.enroll_status_cd = 'A'
                 )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Cancel date when the client is no longer eligible.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set CANCEL_BY = MEA_cur_tab(indx).cancel_by,
            CANCEL_DT = MEA_cur_tab(indx).cancel_dt,
            CANCEL_METHOD = MEA_cur_tab(indx).cancel_method,
            CANCEL_REASON = MEA_cur_tab(indx).cancel_reason
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_CANCEL_DT_NO_LONGER_ELIG',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_CANCEL_DT_NO_LONGER_ELIG;


PROCEDURE MEA_CANCEL_DT_NEW_ENROLL AS
/*
Find the earliest occurence of the 'A' status without a 'O' in between. This will be a Instance Completion because we received a new instance.
cancel_reason = 'New Enrollment Packet Required'.
*/
 CURSOR MEA_cur IS
 select 
        etl.ceme_id,
        etl.client_enroll_status_id,
        c1.create_ts        as cancel_dt,
       'New Enrollment Packet Required' as cancel_reason,
       'Normal'             as cancel_method,
       coalesce( (select last_name ||', '||first_name from staff_stg where to_char(staff_id)  = c1.updated_by), c1.updated_by) as cancel_by
  from CLIENT_ENROLL_STATUS_STG c1,
       corp_etl_manage_enroll_oltp  etl
  where c1.enroll_status_cd = 'A'
  and c1.update_ts >= (
						select to_date(value,'yyyy/mm/dd hh24:mi:ss')
  						  from corp_etl_control
					     where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT')
  and c1.client_id = etl.client_id
  and c1.client_enroll_status_id > etl.client_enroll_status_id
  and not exists (select 1 
                  from client_enroll_status_STG c2
                 where 1=1 
                   and c2.client_id = etl.client_id
                   and c2.client_enroll_status_id > etl.client_enroll_status_id --after instance was created.
                   and c2.client_enroll_status_id < c1.client_enroll_status_id --before 'O' status
                   and c2.enroll_status_cd in ( 'O','K','Q')
                 )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Cancel date when there is a New Enrollment.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set CANCEL_BY = MEA_cur_tab(indx).cancel_by,
            CANCEL_DT = MEA_cur_tab(indx).cancel_dt,
            CANCEL_METHOD = MEA_cur_tab(indx).cancel_method,
            CANCEL_REASON = MEA_cur_tab(indx).cancel_reason
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_CANCEL_DT_NEW_ENROLL',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_CANCEL_DT_NEW_ENROLL;

PROCEDURE MEA_UPD_PLAN_SELECTION AS
 CURSOR MEA_cur IS
select * from 
(
select 
      etl.ceme_id, etl.client_id, etl.case_id,
      case when s1.transaction_type_cd = 'DefaultEnroll' and s1.STATUS_CD in ('uploadedToState','acceptedByState') then 'Auto-Assigned'
            when s1.transaction_type_cd <> 'DefaultEnroll' and enum.value = 'P' then 'Phone'
            when s1.transaction_type_cd <> 'DefaultEnroll' and enum.value = 'W' then 'Online'
            when s1.transaction_type_cd <> 'DefaultEnroll' and enum.value = 'C' then 'Mail'
            else null
       end as slct_method,
       (select last_name ||', '||first_name from staff_stg where to_char(staff_id) = s1.created_by) as slct_create_by_name,
       s1.create_ts as slct_create_dt,
       (select last_name ||', '||first_name from staff_stg where to_char(staff_id) = s1.updated_by) as slct_last_update_by_name,
       s1.update_ts  as slct_last_update_dt,
       s1.plan_type_cd plan_type
from SELECTION_TXN_STG s1,
     ENUM_ENROLL_TRANS_SOURCE_STG enum,
     corp_etl_manage_enroll_oltp  etl
where 1=1
and etl.enrl_pack_id is not null
and etl.slct_method is null
and etl.client_id = s1.client_id 
and s1.update_ts > (select to_date(value,'yyyy/mm/dd hh24:mi:ss')
  					  from corp_etl_control
                     where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN')
and enum.value = s1.selection_source_cd
and s1.selection_txn_id = (select max(selection_txn_id) 
                             from SELECTION_TXN_STG s2
                            where s2.client_id = etl.client_id
                              and s2.create_ts > etl.create_dt
                              and s2.status_cd in ('uploadedToState','acceptedByState')
                              )
)
where slct_method is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Plan selection attributes.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set SLCT_CREATE_BY_NAME = MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,
            SLCT_CREATE_DT = MEA_cur_tab(indx).SLCT_CREATE_DT,
            SLCT_LAST_UPDATE_BY_NAME = MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,
            SLCT_LAST_UPDATE_DT = MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,
            SLCT_METHOD = MEA_cur_tab(indx).SLCT_METHOD,
            PLAN_TYPE =  MEA_cur_tab(indx).PLAN_TYPE
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_PLAN_SELECTION',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_PLAN_SELECTION;

PROCEDURE MEA_SELECTION_AUTO_PROC AS
 CURSOR MEA_cur IS
select ceme_id,
       'N' as in_NO
from corp_etl_manage_enroll_oltp etl
where slct_method in ('Phone','Mail','Online')
and slct_auto_proc is null
and exists (select 1
             from step_instance_stg  sis
            where 1=1
              and sis.case_id = etl.case_id
              and sis.step_definition_id in (select ref_id 
                                              from corp_etl_list_lkup
                                              where name = 'ENRL_DATA_ENTRY')
              and sis.create_ts >= etl.create_dt
              and sis.hist_status = 'COMPLETED'
              )
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Plan selection attributes.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set SLCT_AUTO_PROC = MEA_cur_tab(indx).in_NO
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_SELECTION_AUTO_PROC',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_SELECTION_AUTO_PROC;

PROCEDURE MEA_UPD_ENROLL_STATUS AS
--Update Enrollment Status for a client within the same program type.
 CURSOR MEA_cur IS
select A.stg_ceme_id,
       A.oltp_enrol_status_cd,
       A.oltp_create_ts 
from 
( 
 select
        etl.ceme_id                as stg_ceme_id,
        c1.ENROLL_STATUS_CD        as oltp_enrol_status_cd, 
	      c1.create_ts               as oltp_create_ts,
	      etl.enrollment_status_code as stg_enrol_status_cd
  from 
       CLIENT_ENROLL_STATUS_STG c1,
       corp_etl_manage_enroll_oltp   etl
  where 1=1
  and c1.update_ts >= (select to_date(value,'yyyy/mm/dd hh24:mi:ss')
                         from corp_etl_control
                        where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT')
  and c1.client_id = etl.client_id
  and c1.client_enroll_status_id =  (select max(cl_max.client_enroll_status_id)
                                      from client_enroll_status_stg cl_max
                                     where cl_max.client_id = c1.client_id
                                       and cl_max.plan_type_cd =  etl.plan_type
                                     )
) A                                     
where A.oltp_enrol_status_cd <> A.stg_enrol_status_cd
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Enrollment Status.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_oltp
        set ENROLLMENT_STATUS_CODE = MEA_cur_tab(indx).OLTP_ENROL_STATUS_CD,
            ENROLLMENT_STATUS_DT = MEA_cur_tab(indx).oltp_create_ts
        where ceme_id = MEA_cur_tab(indx).stg_ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_ENROLL_STATUS',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_OLTP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_ENROLL_STATUS;

PROCEDURE MEA_AGE_CALCULATION AS

BEGIN

  update corp_etl_manage_enroll_oltp
  set  AGE_IN_BUSINESS_DAYS = ETL_COMMON.bus_days_between(create_dt, SYSDATE),
       AGE_IN_CALENDAR_DAYS = trunc(SYSDATE) - trunc(create_dt)
where nvl(age_in_calendar_days,9999999) <> trunc(SYSDATE) - trunc(create_dt);
commit;

END MEA_AGE_CALCULATION;


PROCEDURE MEA_UPD_1 AS
--Update Volatile attributes.
 CURSOR MEA_cur IS
 SELECT
       OLTP.CEME_ID,
       oltp.AA_DUE_DT, 
       oltp.SERVICE_AREA,
       OLTP.COUNTY_CODE,
       oltp.ZIP_CODE,
       oltp.NEWBORN_FLG,
       oltp.ENROLLMENT_STATUS_CODE,
       oltp.ENROLLMENT_STATUS_DT,
       OLTP.ENROLL_FEE_AMNT_DUE,
       oltp.FEE_PAID_FLG,
       oltp.ENROLL_FEE_AMNT_PAID,
       oltp.ENROLL_FEE_PAID_DT,
       OLTP.ENRL_PACK_ID,
       oltp.ENRL_PACK_REQUEST_DT,
       oltp.CHIP_HPC_ID,
       oltp.CHIP_HPC_MAILED_DT,
       oltp.CHIP_EMI_ID,
       OLTP.CHIP_EMI_MAILED_DT,
       oltp.SLCT_METHOD,
       oltp.SLCT_CREATE_BY_NAME,
       oltp.SLCT_CREATE_DT,
       oltp.SLCT_LAST_UPDATE_BY_NAME,
       oltp.SLCT_LAST_UPDATE_DT,
       oltp.SLCT_AUTO_PROC,
       oltp.FIRST_FOLLOWUP_ID,
       oltp.SECOND_FOLLOWUP_ID,
       oltp.THIRD_FOLLOWUP_ID,
       oltp.FOURTH_FOLLOWUP_ID,
       OLTP.AGE_IN_CALENDAR_DAYS,
       oltp.age_in_business_days,
      'Y' as in_yes
  from corp_etl_manage_enroll_oltp oltp
 JOIN  CORP_ETL_MANAGE_ENROLL_WIP WIP
 ON OLTP.CEME_ID = WIP.CEME_ID   -- AND oltp.CEME_ID  = 145
 LEFT OUTER JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F1 ON OLTP.FIRST_FOLLOWUP_TYPE_CODE  = F1.FOLLOWUP_TYPE_CODE
                                                AND OLTP.PLAN_TYPE = F1.PLAN_TYPE
                                                AND OLTP.PROGRAM_TYPE = F1.PROGRAM_TYPE
 LEFT OUTER JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F2 ON OLTP.SECOND_FOLLOWUP_TYPE_CODE = F2.FOLLOWUP_TYPE_CODE
                                                AND OLTP.PLAN_TYPE = F2.PLAN_TYPE
                                                AND OLTP.PROGRAM_TYPE = F2.PROGRAM_TYPE
 LEFT OUTER JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F3 ON OLTP.THIRD_FOLLOWUP_TYPE_CODE  = F3.FOLLOWUP_TYPE_CODE
                                                 AND OLTP.PLAN_TYPE = F3.PLAN_TYPE
                                                AND OLTP.PROGRAM_TYPE = F3.PROGRAM_TYPE
 LEFT OUTER JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F4 ON OLTP.FOURTH_FOLLOWUP_TYPE_CODE = F4.FOLLOWUP_TYPE_CODE
                                                 AND OLTP.PLAN_TYPE = F4.PLAN_TYPE
                                                AND OLTP.PROGRAM_TYPE = F4.PROGRAM_TYPE
 WHERE 1=1
 --AND oltp.CEME_ID  = 145
and
       coalesce(OLTP.SERVICE_AREA,'X') <> coalesce(WIP.SERVICE_AREA,'X') OR
       coalesce(oltp.COUNTY_CODE,'X') <> coalesce(WIP.COUNTY_CODE,'X') or
       coalesce(oltp.ZIP_CODE,'X') <> coalesce(WIP.ZIP_CODE,'X') or
       coalesce(OLTP.ENROLL_FEE_AMNT_DUE,9) <> coalesce(WIP.ENROLL_FEE_AMNT_DUE,9) or
       coalesce(OLTP.FEE_PAID_FLG,'X') <> coalesce(WIP.FEE_PAID_FLG,'X') or
       coalesce(OLTP.ENROLL_FEE_PAID_DT,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.ENROLL_FEE_PAID_DT,to_date('1-jan-2000','dd-mon-yyyy')) or
       coalesce(OLTP.aa_due_dt,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.aa_due_dt,to_date('1-jan-2000','dd-mon-yyyy')) or
       coalesce(oltp.NEWBORN_FLG,'X') <> coalesce(WIP.NEWBORN_FLG,'X') or
       coalesce(oltp.ENROLLMENT_STATUS_CODE,'X') <> coalesce(WIP.ENROLLMENT_STATUS_CODE,'X') or       
       coalesce(OLTP.ENRL_PACK_ID,9) <> coalesce(WIP.ENRL_PACK_ID,9) OR
       coalesce(oltp.ENRL_PACK_REQUEST_DT,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.ENRL_PACK_REQUEST_DT,to_date('1-jan-2000','dd-mon-yyyy')) or
       coalesce(oltp.SLCT_METHOD,'X') <> coalesce(WIP.SLCT_METHOD,'X') or
       coalesce(OLTP.SLCT_LAST_UPDATE_BY_NAME,'X') <> coalesce(WIP.SLCT_LAST_UPDATE_BY_NAME,'X') OR
       coalesce(oltp.SLCT_LAST_UPDATE_DT,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.SLCT_LAST_UPDATE_DT,to_date('1-jan-2000','dd-mon-yyyy')) or
       coalesce(oltp.SLCT_AUTO_PROC,'X') <> coalesce(WIP.SLCT_AUTO_PROC,'X') or

   --    COALESCE(OLTP.AGE_IN_CALENDAR_DAYS,9999) <> COALESCE(WIP.AGE_IN_CALENDAR_DAYS,9999) OR
       (   WIP.FIRST_FOLLOWUP_ID IS NULL
            and oltp.first_followup_id IS NOT NULL
            and coalesce(F1.FOLLOWUP_TYPE_CODE,'X') = coalesce(oltp.FIRST_FOLLOWUP_TYPE_CODE,'X')
            and coalesce(F1.FOLLOWUP_NAME,'X') = 'FIRST'
            AND COALESCE(F1.FOLLOWUP_REQ,'X')  = 'Y'
            AND COALESCE(F1.PLAN_TYPE,'X')     = OLTP.PLAN_TYPE
            AND coalesce(F1.PROGRAM_TYPE,'X')  = OLTP.PROGRAM_TYPE
            AND coalesce(F1.FOLLOWUP_CAL_DAYS,9999) <= OLTP.AGE_IN_CALENDAR_DAYS
       )  OR --f_first_followup_id,
      ( WIP.SECOND_FOLLOWUP_ID IS NULL
            and oltp.SECOND_FOLLOWUP_ID IS NOT NULL
            and coalesce(F2.FOLLOWUP_TYPE_CODE,'X') = coalesce(oltp.SECOND_FOLLOWUP_TYPE_CODE,'X')
            and coalesce(F2.FOLLOWUP_NAME,'X') = 'SECOND'
            and coalesce(F2.FOLLOWUP_REQ,'X')  = 'Y'
            and coalesce(F2.Plan_Type,'X')     = OLTP.PLAN_TYPE
            and coalesce(F2.Program_Type,'X')  = OLTP.PROGRAM_TYPE
            AND coalesce(F2.FOLLOWUP_CAL_DAYS,9999) <= oltp.AGE_IN_CALENDAR_DAYS
       ) or --f_second_followup_id,
       ( WIP.THIRD_FOLLOWUP_ID IS NULL
            and oltp.THIRD_FOLLOWUP_ID IS NOT NULL
            AND coalesce(F3.FOLLOWUP_TYPE_CODE,'X') = coalesce(oltp.THIRD_FOLLOWUP_TYPE_CODE,'X')
            and coalesce(F3.FOLLOWUP_NAME,'X') = 'THIRD'
            and coalesce(F3.FOLLOWUP_REQ,'X')  = 'Y'
            and coalesce(F3.Plan_Type,'X')     = OLTP.PLAN_TYPE
            and coalesce(F3.Program_Type,'X')  = OLTP.PROGRAM_TYPE
            AND coalesce(F3.FOLLOWUP_CAL_DAYS,9999) <= oltp.AGE_IN_CALENDAR_DAYS
       ) OR --f_THIRD_followup_id,
       ( WIP.FOURTH_FOLLOWUP_ID is null
            and oltp.FOURTH_FOLLOWUP_ID is not null
            and coalesce(F4.FOLLOWUP_TYPE_CODE,'X') = coalesce(oltp.fourth_FOLLOWUP_TYPE_CODE,'X')
            and coalesce(F4.FOLLOWUP_NAME,'X') = 'FOURTH'
            and coalesce(F4.FOLLOWUP_REQ,'X')  = 'Y'
            and coalesce(F4.Plan_Type,'X')     = OLTP.PLAN_TYPE
            AND coalesce(F4.PROGRAM_TYPE,'X')  = OLTP.PROGRAM_TYPE
            AND coalesce(F4.FOLLOWUP_CAL_DAYS,9999) <= oltp.AGE_IN_CALENDAR_DAYS
       ) or --f_fourth_followup_id,

       coalesce(oltp.chip_hpc_id,9999) <> coalesce(WIP.chip_hpc_id,9999) or
       coalesce(oltp.CHIP_HPC_MAILED_DT,to_date('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.CHIP_HPC_MAILED_DT,to_date('1-jan-2000','dd-mon-yyyy')) or
       coalesce(OLTP.CHIP_EMI_ID,9999) <> coalesce(WIP.CHIP_EMI_ID,9999) OR
       coalesce(OLTP.CHIP_EMI_MAILED_DT,TO_DATE('1-jan-2000','dd-mon-yyyy')) <> coalesce(WIP.CHIP_EMI_MAILED_DT,TO_DATE('1-jan-2000','dd-mon-yyyy'))
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Updating Volatile attributes.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS

        update corp_etl_manage_enroll_wip
        set 
            AA_DUE_DT = MEA_cur_tab(indx).AA_DUE_DT,
            SERVICE_AREA = MEA_cur_tab(indx).SERVICE_AREA,
            COUNTY_CODE = MEA_cur_tab(indx).COUNTY_CODE,
            ZIP_CODE = MEA_cur_tab(indx).ZIP_CODE,
            NEWBORN_FLG = MEA_cur_tab(indx).NEWBORN_FLG,
            ENROLLMENT_STATUS_CODE = MEA_cur_tab(indx).ENROLLMENT_STATUS_CODE,
            ENROLLMENT_STATUS_DT = MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,
            ENROLL_FEE_AMNT_DUE = MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE,
            FEE_PAID_FLG = MEA_cur_tab(indx).FEE_PAID_FLG,
            ENROLL_FEE_AMNT_PAID = MEA_cur_tab(indx).ENROLL_FEE_AMNT_PAID,
            ENROLL_FEE_PAID_DT = MEA_cur_tab(indx).ENROLL_FEE_PAID_DT,
            ENRL_PACK_ID = MEA_cur_tab(indx).ENRL_PACK_ID,
            ENRL_PACK_REQUEST_DT = MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,
            CHIP_HPC_ID = MEA_cur_tab(indx).CHIP_HPC_ID,
            CHIP_HPC_MAILED_DT = MEA_cur_tab(indx).CHIP_HPC_MAILED_DT,
            CHIP_EMI_ID = MEA_cur_tab(indx).CHIP_EMI_ID,
            CHIP_EMI_MAILED_DT = MEA_cur_tab(indx).CHIP_EMI_MAILED_DT,
            SLCT_METHOD = MEA_cur_tab(indx).SLCT_METHOD,
            SLCT_CREATE_BY_NAME = MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,
            SLCT_CREATE_DT = MEA_cur_tab(indx).SLCT_CREATE_DT,
            SLCT_LAST_UPDATE_BY_NAME = MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,
            SLCT_LAST_UPDATE_DT = MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,
            SLCT_AUTO_PROC = MEA_cur_tab(indx).SLCT_AUTO_PROC,
            FIRST_FOLLOWUP_ID = MEA_cur_tab(indx).FIRST_FOLLOWUP_ID,
            SECOND_FOLLOWUP_ID = MEA_cur_tab(indx).SECOND_FOLLOWUP_ID,
            THIRD_FOLLOWUP_ID = MEA_cur_tab(indx).THIRD_FOLLOWUP_ID,
            FOURTH_FOLLOWUP_ID = MEA_cur_tab(indx).FOURTH_FOLLOWUP_ID,
         --   AGE_IN_CALENDAR_DAYS = MEA_cur_tab(indx).AGE_IN_CALENDAR_DAYS,
          --  AGE_IN_BUSINESS_DAYS = MEA_cur_tab(indx).AGE_IN_BUSINESS_DAYS,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_1',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;
 END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_1;

PROCEDURE MEA_UPD_2 AS
 CURSOR MEA_cur IS
SELECT  CEME_ID,
       'Complete' as IN_COMPLETE,
       SYSDATE AS IN_SYSDATE,
      'Y' as in_yes
FROM CORP_ETL_MANAGE_ENROLL_OLTP OLTP 
WHERE  INSTANCE_STATUS = 'Active'
AND CANCEL_DT IS NULL
and NVL(OLTP.gwf_enrl_pack_req,'X') = 'N'
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_2 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set INSTANCE_STATUS = MEA_cur_tab(indx).IN_COMPLETE,
            COMPLETE_DT = MEA_cur_tab(indx).IN_SYSDATE,
            STAGE_DONE_DATE = MEA_cur_tab(indx).IN_SYSDATE,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES            
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_2',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_2;

PROCEDURE MEA_UPD_3 AS
 CURSOR MEA_cur IS
SELECT o.CEME_ID,
       'Y' as in_yes, 
       --o.asf_send_enroll_packet,
       o.enrl_pack_request_dt
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o,
	 corp_etl_manage_enroll_wip   w
WHERE 1=1
and o.ceme_id = w.ceme_id
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and nvl(w.gwf_enrl_pack_req,'X') = 'Y'
and w.assd_send_enroll_packet is not null
and w.ased_send_enroll_packet is null
--
and o.enrl_pack_id is not null          
AND o.enrl_pack_request_dt is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_3 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_SEND_ENROLL_PACKET = MEA_cur_tab(indx).IN_YES,
            ASED_SEND_ENROLL_PACKET = MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES            
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_3',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_3;

PROCEDURE MEA_UPD_4 AS
 CURSOR MEA_cur IS
select A.ceme_id,
       A.in_yes,
       --(case when ((A.w_FIRST_FOLLOWUP_TYPE_CODE is not null and NVL(O_FIRST_FOLLOWUP_TYPE_CODE,'X') <> NVL( w_FIRST_FOLLOWUP_TYPE_CODE,'X')) or A.w_FIRST_FOLLOWUP_TYPE_CODE is null ) then 'Y' else 'N' end ) as UPD_4_needed,
       (case when A.w_FIRST_FOLLOWUP_TYPE_CODE is not null then IN_YES else IN_NO end) as W_GWF_FIRST_FOLLOWUP_REQ,
       (case when A.w_FIRST_FOLLOWUP_TYPE_CODE is not null then W_ASED_SEND_ENROLL_PACKET else W_ASSD_FIRST_FOLLOWUP end) as W_ASSD_FIRST_FOLLOWUP,
       (case when A.w_FIRST_FOLLOWUP_TYPE_CODE is null then W_ASED_SEND_ENROLL_PACKET else W_ASSD_AUTO_ASSIGN end) as W_ASSD_AUTO_ASSIGN
from ( 
SELECT w.CEME_ID,
       'Y' as in_yes, 
       'N' as in_no,
       w.ASED_SEND_ENROLL_PACKET  as w_ASED_SEND_ENROLL_PACKET,
       w.FIRST_FOLLOWUP_TYPE_CODE as w_FIRST_FOLLOWUP_TYPE_CODE,
       w.gwf_first_followup_req   as w_gwf_first_followup_req,
       w.assd_first_followup      as w_assd_first_followup,
       w.assd_auto_assign         as w_assd_auto_assign
      -- o.FIRST_FOLLOWUP_TYPE_CODE as O_FIRST_FOLLOWUP_TYPE_CODE
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
left JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F1 ON W.FIRST_FOLLOWUP_TYPE_CODE  = F1.FOLLOWUP_TYPE_CODE
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.ased_send_enroll_packet is not null       
AND w.gwf_first_followup_req is null
) A
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_4 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
      --  if UPD_4_needed ='Y' then
          update corp_etl_manage_enroll_wip
          set GWF_FIRST_FOLLOWUP_REQ = MEA_cur_tab(indx).W_GWF_FIRST_FOLLOWUP_REQ,
            ASSD_FIRST_FOLLOWUP = MEA_cur_tab(indx).W_ASSD_FIRST_FOLLOWUP,
            ASSD_AUTO_ASSIGN = MEA_cur_tab(indx).W_ASSD_AUTO_ASSIGN,            
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES            
          where ceme_id = MEA_cur_tab(indx).ceme_id
          ;
      --  end if;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_4',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_4;


PROCEDURE MEA_UPD_5 AS
 CURSOR MEA_cur IS
SELECT w.CEME_ID,
       'Y' as in_yes, 
       --w.ASED_SEND_ENROLL_PACKET as w_ASED_SEND_ENROLL_PACKET,
       o.ased_first_followup     as o_ased_first_followup,
       w.asf_first_followup      as w_asf_first_followup,
       w.ased_first_followup     as w_ased_first_followup
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.assd_selection_recd is null                     
AND w.assd_first_followup is not null
and w.ased_first_followup is null
and o.first_followup_id is not null
and o.ased_first_followup is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_5 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_FIRST_FOLLOWUP = MEA_cur_tab(indx).in_yes,
            ASED_FIRST_FOLLOWUP = MEA_cur_tab(indx).o_ased_first_followup,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_5',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_5;

PROCEDURE MEA_UPD_6 AS
 CURSOR MEA_cur IS
 select A.ceme_id,
        A.in_yes,
       (case when A.w_SECOND_FOLLOWUP_TYPE_CODE is not null then IN_YES else IN_NO end) as w_gwf_second_followup_req,
       (case when A.w_SECOND_FOLLOWUP_TYPE_CODE is not null then w_ased_first_followup else W_ASSD_SECOND_FOLLOWUP end) as W_ASSD_SECOND_FOLLOWUP,
       (case when A.w_SECOND_FOLLOWUP_TYPE_CODE is null then w_ased_first_followup else W_ASSD_AUTO_ASSIGN end) as W_ASSD_AUTO_ASSIGN
from ( 
SELECT w.CEME_ID,
       'Y' as in_yes, 
       'N' as in_no,
       w.ased_first_followup       as w_ased_first_followup,
       w.SECOND_FOLLOWUP_TYPE_CODE as w_SECOND_FOLLOWUP_TYPE_CODE,
       w.gwf_second_followup_req   as w_gwf_second_followup_req,
       w.assd_second_followup      as w_assd_second_followup,
       w.assd_auto_assign          as w_assd_auto_assign
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
left JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F2 ON W.SECOND_FOLLOWUP_TYPE_CODE  = F2.FOLLOWUP_TYPE_CODE
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.ased_first_followup is not null                
AND w.gwf_second_followup_req is null
) A
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_5 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set GWF_SECOND_FOLLOWUP_REQ = MEA_cur_tab(indx).W_GWF_SECOND_FOLLOWUP_REQ,
            ASSD_SECOND_FOLLOWUP = MEA_cur_tab(indx).W_ASSD_SECOND_FOLLOWUP,      
            ASSD_AUTO_ASSIGN = MEA_cur_tab(indx).W_ASSD_AUTO_ASSIGN,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_6',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_6;

PROCEDURE MEA_UPD_7 AS
 CURSOR MEA_cur IS
SELECT w.CEME_ID,
       'Y' as in_yes,        
       o.ased_second_followup     as o_ased_second_followup,
       w.asf_second_followup      as w_asf_second_followup,
       w.ased_second_followup     as w_ased_second_followup
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.assd_selection_recd is null                     
AND w.assd_second_followup is not null
and w.ased_second_followup is null
and w.second_followup_id is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_7 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_SECOND_FOLLOWUP = MEA_cur_tab(indx).in_yes,
            ASED_SECOND_FOLLOWUP = MEA_cur_tab(indx).o_ased_second_followup,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_7',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_7;

PROCEDURE MEA_UPD_8 AS
 CURSOR MEA_cur IS
 select A.ceme_id,
        A.in_yes,
       (case when A.w_THIRD_FOLLOWUP_TYPE_CODE is not null then IN_YES else IN_NO end) as w_gwf_third_followup_req,
       (case when A.w_THIRD_FOLLOWUP_TYPE_CODE is not null then w_ased_second_followup else w_assd_third_followup end) as w_assd_third_followup,
       (case when A.w_THIRD_FOLLOWUP_TYPE_CODE is null then w_ased_second_followup else W_ASSD_AUTO_ASSIGN end) as W_ASSD_AUTO_ASSIGN
from ( 
SELECT w.CEME_ID,
       'Y' as in_yes, 
       'N' as in_no,
       w.ased_second_followup     as w_ased_second_followup,
       w.THIRD_FOLLOWUP_TYPE_CODE as w_THIRD_FOLLOWUP_TYPE_CODE,
       w.gwf_third_followup_req   as w_gwf_third_followup_req,
       w.assd_third_followup      as w_assd_third_followup,
       w.assd_auto_assign         as w_assd_auto_assign
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
left JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F3 ON W.THIRD_FOLLOWUP_TYPE_CODE  = F3.FOLLOWUP_TYPE_CODE
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.ased_second_followup is not null                
AND w.gwf_third_followup_req is null
) A
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_8 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set GWF_THIRD_FOLLOWUP_REQ = MEA_cur_tab(indx).W_GWF_THIRD_FOLLOWUP_REQ,
            ASSD_THIRD_FOLLOWUP = MEA_cur_tab(indx).W_ASSD_THIRD_FOLLOWUP,      
            ASSD_AUTO_ASSIGN = MEA_cur_tab(indx).W_ASSD_AUTO_ASSIGN,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_8',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_8;

PROCEDURE MEA_UPD_9 AS
 CURSOR MEA_cur IS
SELECT w.CEME_ID,
       'Y' as in_yes,        
       o.ased_third_followup     as o_ased_third_followup,
       w.asf_third_followup      as w_asf_third_followup,
       w.ased_third_followup     as w_ased_third_followup
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.assd_selection_recd is null                     
AND w.assd_third_followup is not null
and w.ased_third_followup is null
and w.third_followup_id is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_9 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_THIRD_FOLLOWUP = MEA_cur_tab(indx).in_yes,
            ASED_THIRD_FOLLOWUP = MEA_cur_tab(indx).o_ased_third_followup,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_9',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_9;

PROCEDURE MEA_UPD_10 AS
 CURSOR MEA_cur IS
 select A.ceme_id,
        A.in_yes,
       (case when A.w_FOURTH_FOLLOWUP_TYPE_CODE is not null then IN_YES else IN_NO end) as w_gwf_fourth_followup_req,
       (case when A.w_FOURTH_FOLLOWUP_TYPE_CODE is not null then w_ased_third_followup else w_assd_fourth_followup end) as w_assd_fourth_followup,
       (case when A.w_FOURTH_FOLLOWUP_TYPE_CODE is null then w_ased_third_followup else W_ASSD_AUTO_ASSIGN end) as W_ASSD_AUTO_ASSIGN
from ( 
SELECT w.CEME_ID,
       'Y' as in_yes, 
       'N' as in_no,
       w.ased_third_followup as w_ased_third_followup,
       w.FOURTH_FOLLOWUP_TYPE_CODE as w_FOURTH_FOLLOWUP_TYPE_CODE,
       w.gwf_fourth_followup_req as w_gwf_fourth_followup_req,
       w.assd_fourth_followup    as w_assd_fourth_followup,
       w.assd_auto_assign        as w_assd_auto_assign
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
left JOIN RULE_LKUP_MNG_ENRL_FOLLOWUP F4 ON W.FOURTH_FOLLOWUP_TYPE_CODE  = F4.FOLLOWUP_TYPE_CODE
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.ased_third_followup is not null                
AND w.gwf_fourth_followup_req is null
) A
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_8 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set GWF_FOURTH_FOLLOWUP_REQ = MEA_cur_tab(indx).W_GWF_FOURTH_FOLLOWUP_REQ,
            ASSD_FOURTH_FOLLOWUP = MEA_cur_tab(indx).W_ASSD_FOURTH_FOLLOWUP,      
            ASSD_AUTO_ASSIGN = MEA_cur_tab(indx).W_ASSD_AUTO_ASSIGN,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_10',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_10;

PROCEDURE MEA_UPD_11 AS
 CURSOR MEA_cur IS
SELECT w.CEME_ID,
       'Y' as in_yes,        
       o.ased_fourth_followup     as o_ased_fourth_followup,
       w.asf_fourth_followup      as w_asf_fourth_followup,
       w.ased_fourth_followup     as w_ased_fourth_followup
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and w.assd_selection_recd is null                     
AND w.assd_fourth_followup is not null
and w.ased_fourth_followup is null
and w.fourth_followup_id is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_11 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_FOURTH_FOLLOWUP = MEA_cur_tab(indx).in_yes,
            ASED_FOURTH_FOLLOWUP = MEA_cur_tab(indx).O_ASED_FOURTH_FOLLOWUP,      
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_11',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_11;

PROCEDURE MEA_UPD_12 AS
 CURSOR MEA_cur IS
SELECT w.CEME_ID,
       o.ased_fourth_followup as o_ased_fourth_followup,
      'Y' as in_yes
FROM CORP_ETL_MANAGE_ENROLL_OLTP   O
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
AND W.INSTANCE_STATUS = 'Active'
AND W.CANCEL_DT IS NULL
AND O.ASED_FOURTH_FOLLOWUP IS NOT NULL
and W.assd_auto_assign is null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_12 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASSD_AUTO_ASSIGN = MEA_cur_tab(indx).O_ASED_FOURTH_FOLLOWUP,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_12',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_12;

PROCEDURE MEA_UPD_13 AS
 CURSOR MEA_cur IS
SELECT  o.CEME_ID,
        'Y' as in_yes, 
       o.slct_last_update_dt as o_slct_last_update_dt
FROM CORP_ETL_MANAGE_ENROLL_OLTP   O
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
AND W.INSTANCE_STATUS = 'Active'
AND W.CANCEL_DT IS NULL
and W.assd_selection_recd is null
AND W.assd_auto_assign is not null
and W.ased_auto_assign is null
and w.slct_method = 'Auto-Assigned'
and W.enrollment_status_code = 'G' 
and o.slct_last_update_dt is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_13 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_AUTO_ASSIGN = MEA_cur_tab(indx).in_yes,
            ASED_AUTO_ASSIGN = MEA_cur_tab(indx).o_slct_last_update_dt,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_13',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_13;

PROCEDURE MEA_UPD_15 AS
 CURSOR MEA_cur IS
SELECT  o.CEME_ID,
        'Y'                  AS in_yes, 
        'Complete'           AS in_Complete,
        SYSDATE              AS IN_SYSDATE, 
        greatest(o.enroll_fee_paid_dt,w.assd_wait_for_fee) AS o_enroll_fee_paid_dt
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
AND W.INSTANCE_STATUS = 'Active'
AND W.CANCEL_DT IS NULL
AND W.assd_wait_for_fee is not null 
AND W.ased_wait_for_fee is null
and W.enroll_fee_paid_dt is not null
AND W.fee_paid_flg = 'Y'
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_15 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_WAIT_FOR_FEE = MEA_cur_tab(indx).in_yes,
            ASED_WAIT_FOR_FEE = MEA_cur_tab(indx).O_ENROLL_FEE_PAID_DT,
            INSTANCE_STATUS = MEA_cur_tab(indx).in_Complete,
            COMPLETE_DT = MEA_cur_tab(indx).O_ENROLL_FEE_PAID_DT,
            STAGE_DONE_DATE = MEA_cur_tab(indx).IN_SYSDATE,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_15',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_15;

PROCEDURE MEA_UPD_16 AS
 CURSOR MEA_cur IS
SELECT  o.CEME_ID,
        'Y' as in_yes, 
        'Complete' as in_Complete,
        o.slct_create_dt as o_slct_create_dt,
        nvl(o.slct_last_update_dt, o.slct_create_dt) as  o_ased_selection_recd
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
AND W.INSTANCE_STATUS = 'Active'
AND W.CANCEL_DT IS NULL
AND W.assd_selection_recd is null
AND W.asf_send_enroll_packet = 'Y'
and W.slct_method in ('Phone', 'Mail', 'Fax', 'Online')    
AND W.enrollment_status_code in ('G')
AND o.slct_create_dt is not null
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_16 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
       update corp_etl_manage_enroll_wip
        set ASF_SELECTION_RECD = MEA_cur_tab(indx).in_yes,
            ASSD_SELECTION_RECD = MEA_cur_tab(indx).O_SLCT_CREATE_DT,
            ASED_SELECTION_RECD = MEA_cur_tab(indx).O_ASED_SELECTION_RECD,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_16',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_16;

PROCEDURE MEA_UPD_18 AS
 CURSOR MEA_cur IS
SELECT  o.CEME_ID,
        'Y'         as in_yes, 
        'Complete'  as in_Complete,
         SYSDATE    AS IN_SYSDATE,
        greatest(o.enroll_fee_paid_dt,w.assd_wait_for_fee) as o_enroll_fee_paid_dt
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o
join corp_etl_manage_enroll_wip   w on o.ceme_id = w.ceme_id
WHERE 1=1 
AND W.INSTANCE_STATUS = 'Active'
AND W.CANCEL_DT IS NULL
AND W.assd_wait_for_fee is not null 
AND W.ased_wait_for_fee is null
and W.enroll_fee_paid_dt is not null
AND W.fee_paid_flg = 'Y'
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_18 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_WAIT_FOR_FEE = MEA_cur_tab(indx).in_yes,
            ASED_WAIT_FOR_FEE = MEA_cur_tab(indx).O_ENROLL_FEE_PAID_DT,
            INSTANCE_STATUS = MEA_cur_tab(indx).IN_COMPLETE,
            COMPLETE_DT = MEA_cur_tab(indx).O_ENROLL_FEE_PAID_DT,
            STAGE_DONE_DATE = MEA_cur_tab(indx).IN_SYSDATE,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_18',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_18;


PROCEDURE MEA_UPD_19 AS
 CURSOR MEA_cur IS
SELECT o.CEME_ID,
       'Y'               as in_yes,
       'Complete'        as in_complete,
       SYSDATE           AS IN_SYSDATE,      
       o.cancel_dt       as o_cancel_dt,
	     o.cancel_reason   as o_cancel_reason,
       o.cancel_method   as o_cancel_method,
       o.cancel_by       as o_cancel_by,
       o.instance_status as o_instance_status,
       o.cancel_dt       as o_complete_dt
FROM CORP_ETL_MANAGE_ENROLL_OLTP   o,
	 corp_etl_manage_enroll_wip   w
WHERE 1=1
and o.ceme_id = w.ceme_id
and w.INSTANCE_STATUS = 'Active'
AND w.CANCEL_DT IS NULL
and o.CANCEL_DT IS NOT NULL
and w.PLAN_TYPE = o.PLAN_TYPE
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying UPD_19 rules.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll_wip
        set ASF_CANCEL_ENRL_ACTIVITY = MEA_cur_tab(indx).in_yes,
            CANCEL_DT = MEA_cur_tab(indx).O_CANCEL_DT,
            CANCEL_REASON = MEA_cur_tab(indx).O_CANCEL_REASON,
            CANCEL_METHOD = MEA_cur_tab(indx).O_CANCEL_METHOD,
            CANCEL_BY = MEA_cur_tab(indx).O_CANCEL_BY,
            INSTANCE_STATUS = MEA_cur_tab(indx).IN_COMPLETE,
            COMPLETE_DT = MEA_cur_tab(indx).O_COMPLETE_DT,
            STAGE_DONE_DATE = MEA_cur_tab(indx).IN_SYSDATE,
            UPDATE_FLG = MEA_cur_tab(indx).IN_YES
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_UPD_19',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_UPD_19;


PROCEDURE MEA_WIP_TO_BPM AS
 CURSOR MEA_cur IS
select ceme_id,
       SERVICE_AREA, COUNTY_CODE, ZIP_CODE, ENROLLMENT_STATUS_CODE, ENROLLMENT_STATUS_DT, AA_DUE_DT, ENRL_PACK_ID, ENRL_PACK_REQUEST_DT, ENROLL_FEE_AMNT_DUE,
       ENROLL_FEE_AMNT_PAID, ENROLL_FEE_PAID_DT, fee_paid_flg, SLCT_METHOD, SLCT_CREATE_BY_NAME, SLCT_CREATE_DT, SLCT_LAST_UPDATE_BY_NAME, SLCT_LAST_UPDATE_DT,
       SLCT_AUTO_PROC, ASSD_SELECTION_RECD, ASED_SELECTION_RECD, ASSD_SEND_ENROLL_PACKET, ASED_SEND_ENROLL_PACKET, FIRST_FOLLOWUP_ID, FIRST_FOLLOWUP_TYPE_CODE,
       ASSD_FIRST_FOLLOWUP, ASED_FIRST_FOLLOWUP, SECOND_FOLLOWUP_ID, SECOND_FOLLOWUP_TYPE_CODE, ASSD_SECOND_FOLLOWUP, ASED_SECOND_FOLLOWUP, THIRD_FOLLOWUP_ID,
       THIRD_FOLLOWUP_TYPE_CODE, ASSD_THIRD_FOLLOWUP, ASED_THIRD_FOLLOWUP, FOURTH_FOLLOWUP_ID, FOURTH_FOLLOWUP_TYPE_CODE, ASSD_FOURTH_FOLLOWUP,
       ASED_FOURTH_FOLLOWUP,  ASSD_AUTO_ASSIGN,  ASED_AUTO_ASSIGN, ASSD_WAIT_FOR_FEE,  ASED_WAIT_FOR_FEE, ASF_CANCEL_ENRL_ACTIVITY, ASF_SEND_ENROLL_PACKET,
       ASF_SELECTION_RECD, ASF_FIRST_FOLLOWUP, ASF_SECOND_FOLLOWUP, ASF_THIRD_FOLLOWUP, ASF_FOURTH_FOLLOWUP, ASF_AUTO_ASSIGN, ASF_WAIT_FOR_FEE,
       GWF_ENRL_PACK_REQ, GWF_FIRST_FOLLOWUP_REQ, GWF_SECOND_FOLLOWUP_REQ, GWF_THIRD_FOLLOWUP_REQ, GWF_FOURTH_FOLLOWUP_REQ, GWF_REQUIRED_FEE_PAID,
       INSTANCE_STATUS, COMPLETE_DT, CANCEL_DT, CANCEL_REASON, CANCEL_METHOD, CANCEL_BY, STAGE_DONE_DATE
  from corp_etl_manage_enroll_wip
where update_flg = 'Y'
;

  TYPE t_MEA_cur_tab IS TABLE OF MEA_cur%ROWTYPE INDEX BY PLS_INTEGER;
	MEA_cur_tab t_MEA_cur_tab;
    v_bulk_limit NUMBER := 500;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
BEGIN

  OPEN MEA_cur;
   LOOP
     FETCH MEA_cur BULK COLLECT INTO MEA_cur_tab LIMIT v_bulk_limit;
     EXIT WHEN MEA_cur_tab.COUNT = 0; -- Exit when missing rows

     begin
     v_step := 'Applying all the update rules to the WIP table.';
     FORALL indx IN 1 .. MEA_cur_tab.COUNT SAVE EXCEPTIONS
        
        update corp_etl_manage_enroll
        set 
       SERVICE_AREA=			 MEA_cur_tab(indx).SERVICE_AREA,
       COUNTY_CODE=			 MEA_cur_tab(indx).COUNTY_CODE,
       ZIP_CODE=			 MEA_cur_tab(indx).ZIP_CODE,
       ENROLLMENT_STATUS_CODE=		 MEA_cur_tab(indx).ENROLLMENT_STATUS_CODE,
       ENROLLMENT_STATUS_DT=		 MEA_cur_tab(indx).ENROLLMENT_STATUS_DT,
       AA_DUE_DT=			 MEA_cur_tab(indx).AA_DUE_DT,
       ENRL_PACK_ID=			 MEA_cur_tab(indx).ENRL_PACK_ID,
       ENRL_PACK_REQUEST_DT=		 MEA_cur_tab(indx).ENRL_PACK_REQUEST_DT,
       ENROLL_FEE_AMNT_DUE=		 MEA_cur_tab(indx).ENROLL_FEE_AMNT_DUE,
       ENROLL_FEE_AMNT_PAID=		 MEA_cur_tab(indx).ENROLL_FEE_AMNT_PAID,
       ENROLL_FEE_PAID_DT=		 MEA_cur_tab(indx).ENROLL_FEE_PAID_DT,
       fee_paid_flg=			 MEA_cur_tab(indx).fee_paid_flg,
       SLCT_METHOD=			 MEA_cur_tab(indx).SLCT_METHOD,
       SLCT_CREATE_BY_NAME=		 MEA_cur_tab(indx).SLCT_CREATE_BY_NAME,
       SLCT_CREATE_DT=			 MEA_cur_tab(indx).SLCT_CREATE_DT,
       SLCT_LAST_UPDATE_BY_NAME=	 MEA_cur_tab(indx).SLCT_LAST_UPDATE_BY_NAME,
       SLCT_LAST_UPDATE_DT=		 MEA_cur_tab(indx).SLCT_LAST_UPDATE_DT,
       SLCT_AUTO_PROC=			 MEA_cur_tab(indx).SLCT_AUTO_PROC,
       ASSD_SELECTION_RECD=		 MEA_cur_tab(indx).ASSD_SELECTION_RECD,
       ASED_SELECTION_RECD=		 MEA_cur_tab(indx).ASED_SELECTION_RECD,
       ASSD_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASSD_SEND_ENROLL_PACKET,
       ASED_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASED_SEND_ENROLL_PACKET,
       FIRST_FOLLOWUP_ID=		 MEA_cur_tab(indx).FIRST_FOLLOWUP_ID,
       FIRST_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).FIRST_FOLLOWUP_TYPE_CODE,
       ASSD_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_FIRST_FOLLOWUP,
       ASED_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASED_FIRST_FOLLOWUP,
       SECOND_FOLLOWUP_ID=		 MEA_cur_tab(indx).SECOND_FOLLOWUP_ID,
       SECOND_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).SECOND_FOLLOWUP_TYPE_CODE,
       ASSD_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_SECOND_FOLLOWUP,
       ASED_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASED_SECOND_FOLLOWUP,
       THIRD_FOLLOWUP_ID=		 MEA_cur_tab(indx).THIRD_FOLLOWUP_ID,
       THIRD_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).THIRD_FOLLOWUP_TYPE_CODE,
       ASSD_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_THIRD_FOLLOWUP,
       ASED_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASED_THIRD_FOLLOWUP,
       FOURTH_FOLLOWUP_ID=		 MEA_cur_tab(indx).FOURTH_FOLLOWUP_ID,
       FOURTH_FOLLOWUP_TYPE_CODE=	 MEA_cur_tab(indx).FOURTH_FOLLOWUP_TYPE_CODE,
       ASSD_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASSD_FOURTH_FOLLOWUP,
       ASED_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASED_FOURTH_FOLLOWUP,
       ASSD_AUTO_ASSIGN=		 MEA_cur_tab(indx).ASSD_AUTO_ASSIGN,
       ASED_AUTO_ASSIGN=		 MEA_cur_tab(indx).ASED_AUTO_ASSIGN,
       ASSD_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASSD_WAIT_FOR_FEE,
       ASED_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASED_WAIT_FOR_FEE,
       ASF_CANCEL_ENRL_ACTIVITY=	 MEA_cur_tab(indx).ASF_CANCEL_ENRL_ACTIVITY,
       ASF_SEND_ENROLL_PACKET=		 MEA_cur_tab(indx).ASF_SEND_ENROLL_PACKET,
       ASF_SELECTION_RECD=		 MEA_cur_tab(indx).ASF_SELECTION_RECD,
       ASF_FIRST_FOLLOWUP=		 MEA_cur_tab(indx).ASF_FIRST_FOLLOWUP,
       ASF_SECOND_FOLLOWUP=		 MEA_cur_tab(indx).ASF_SECOND_FOLLOWUP,
       ASF_THIRD_FOLLOWUP=		 MEA_cur_tab(indx).ASF_THIRD_FOLLOWUP,
       ASF_FOURTH_FOLLOWUP=		 MEA_cur_tab(indx).ASF_FOURTH_FOLLOWUP,
       ASF_AUTO_ASSIGN=			 MEA_cur_tab(indx).ASF_AUTO_ASSIGN,
       ASF_WAIT_FOR_FEE=		 MEA_cur_tab(indx).ASF_WAIT_FOR_FEE,
       GWF_ENRL_PACK_REQ=		 MEA_cur_tab(indx).GWF_ENRL_PACK_REQ,
       GWF_FIRST_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_FIRST_FOLLOWUP_REQ,
       GWF_SECOND_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_SECOND_FOLLOWUP_REQ,
       GWF_THIRD_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_THIRD_FOLLOWUP_REQ,
       GWF_FOURTH_FOLLOWUP_REQ=		 MEA_cur_tab(indx).GWF_FOURTH_FOLLOWUP_REQ,
       GWF_REQUIRED_FEE_PAID=		 MEA_cur_tab(indx).GWF_REQUIRED_FEE_PAID,
       INSTANCE_STATUS=			 MEA_cur_tab(indx).INSTANCE_STATUS,
       COMPLETE_DT=			 MEA_cur_tab(indx).COMPLETE_DT,
       CANCEL_DT=			 MEA_cur_tab(indx).CANCEL_DT,
       CANCEL_REASON=			 MEA_cur_tab(indx).CANCEL_REASON,
       CANCEL_METHOD=			 MEA_cur_tab(indx).CANCEL_METHOD,
       CANCEL_BY=			 MEA_cur_tab(indx).CANCEL_BY,
       STAGE_DONE_DATE=			 MEA_cur_tab(indx).STAGE_DONE_DATE
        where ceme_id = MEA_cur_tab(indx).ceme_id
        ;

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
                        'MANAGE_ENROLLMENT',--PROCESS_NAME
                        'MEA_WIP_TO_BPM',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' '||v_err_msg,--ERROR_DESC
                        null,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_ENROLL_WIP',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
                   end loop;
               end if;    
 END;       
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE MEA_cur;

END MEA_WIP_TO_BPM;

END ETL_MANAGE_ENROLLMENT_PKG;
/

  
alter session set plsql_code_type = interpreted;