alter session set plsql_code_type = native;

create or replace package LAEB_CRM_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/LAEB/createdb_etl_version/EMRS/EMRS_LAEB_ELIG_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 25551 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-11-10 18:55:32 -0800 (Sat, 10 Nov 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE CALL_RECORD_INS;
  PROCEDURE CALL_RECORD_UPD;
  
  PROCEDURE CALL_RECORD_LINK_INS;
  PROCEDURE CALL_RECORD_LINK_UPD;
  
  PROCEDURE INCIDENT_HEADER_INS;
  PROCEDURE INCIDENT_HEADER_UPD;
  
  PROCEDURE EVENT_INS;
  PROCEDURE EVENT_UPD;
    
end;
/

CREATE OR REPLACE PACKAGE BODY LAEB_CRM_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE CALL_RECORD_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_CallRecord WHERE ora_err_tag$ = 'CALL_RECORD_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CALL_RECORD_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_CALL_RECORD 
          ( call_record_id,
            call_type_cd,
            caller_type_cd,
            call_tracking_number,
            worker_id,
            worker_username,
            language_cd,
            call_start_ts,
            call_end_ts,
            caller_phone,
            ext_telephony_ref,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            note_ref_id,
            caller_first_name, 
            caller_last_name,  
            call_start_ndt,
            call_record_field1,
            call_record_field2,
            call_record_field3,
            call_record_field4,
            call_record_field5,
            parent_call_record_id,
            call_record_generic_field1,
            call_record_generic_field2,
            call_record_generic_field3,
            call_record_generic_field4,
            call_record_generic_field5,
            call_record_generic_field6,
            call_record_generic_field7,
            call_record_generic_field8,
            call_record_generic_field9,
            call_record_generic_field10,
            medchat_topic,
            medchat_status,
            medchat_id)
    SELECT
           call_record_id,
            call_type_cd,
            caller_type_cd,
            call_tracking_number,
            worker_id,
            worker_username,
            language_cd,
            call_start_ts,
            call_end_ts,
            caller_phone,
            ext_telephony_ref,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            note_ref_id,
            caller_first_name, 
            caller_last_name,  
            call_start_ndt,
            call_record_field1,
            call_record_field2,
            call_record_field3,
            call_record_field4,
            call_record_field5,
            parent_call_record_id,
            call_record_generic_field1,
            call_record_generic_field2,
            call_record_generic_field3,
            call_record_generic_field4,
            call_record_generic_field5,
            call_record_generic_field6,
            call_record_generic_field7,
            call_record_generic_field8,
            call_record_generic_field9,
            call_record_generic_field10,
            medchat_topic,
            medchat_status,
            medchat_id         
    FROM s_call_record_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_call_record ce WHERE e.call_record_id = ce.call_record_id)
     LOG Errors INTO Errlog_CallRecord ('CALL_RECORD_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CALL_RECORD', CALL_RECORD_ID
      FROM Errlog_CallRecord
     WHERE Ora_Err_Tag$ = 'CALL_RECORD_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_INS', 1, v_desc, v_code, 'D_CALL_RECORD');

      COMMIT;
END CALL_RECORD_INS;

PROCEDURE CALL_RECORD_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_CallRecord WHERE ora_err_tag$ = 'CALL_RECORD_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CALL_RECORD_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_CALL_RECORD e
   USING (SELECT tmp.*
          FROM (SELECT
                  call_record_id,
                  call_type_cd,
                  caller_type_cd,
                  call_tracking_number,
                  worker_id,
                  worker_username,
                  language_cd,
                  call_start_ts,
                  call_end_ts,
                  caller_phone,
                  ext_telephony_ref,
                  created_by,
                  create_ts,
                  updated_by,
                  update_ts,
                  note_ref_id,
                  caller_first_name, 
                  caller_last_name,  
                  call_start_ndt,
                  call_record_field1,
                  call_record_field2,
                  call_record_field3,
                  call_record_field4,
                  call_record_field5,
                  parent_call_record_id,
                  call_record_generic_field1,
                  call_record_generic_field2,
                  call_record_generic_field3,
                  call_record_generic_field4,
                  call_record_generic_field5,
                  call_record_generic_field6,
                  call_record_generic_field7,
                  call_record_generic_field8,
                  call_record_generic_field9,
                  call_record_generic_field10,
                  medchat_topic,
                  medchat_status,
                  medchat_id
                FROM s_call_record_stg e                
              ) tmp
          JOIN d_call_record t ON tmp.call_record_id = t.call_record_id
          WHERE COALESCE(t.call_type_cd,'*') != COALESCE(tmp.call_type_cd,'*')          
            OR COALESCE(t.caller_type_cd,'*') != COALESCE(tmp.caller_type_cd,'*')
            OR COALESCE(t.call_tracking_number,'*') != COALESCE(tmp.call_tracking_number,'*')
            OR COALESCE(t.worker_id,'*') != COALESCE(tmp.worker_id,'*')
            OR COALESCE(t.worker_username,'*') != COALESCE(tmp.worker_username,'*')
            OR COALESCE(t.language_cd,'*') != COALESCE(tmp.language_cd,'*')
            OR COALESCE(t.call_start_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.call_start_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.call_end_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.call_end_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.caller_phone,'*') != COALESCE(tmp.caller_phone,'*')
            OR COALESCE(t.ext_telephony_ref,'*') != COALESCE(tmp.ext_telephony_ref,'*')
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.note_ref_id,0) != COALESCE(tmp.note_ref_id,0)            
            OR COALESCE(t.caller_first_name,'*') != COALESCE(tmp.caller_first_name,'*')
            OR COALESCE(t.caller_last_name,'*') != COALESCE(tmp.caller_last_name,'*')
            OR COALESCE(t.call_start_ndt,0) != COALESCE(tmp.call_start_ndt,0)            
            OR COALESCE(t.call_record_field1,'*') != COALESCE(tmp.call_record_field1,'*') 
            OR COALESCE(t.call_record_field2,'*') != COALESCE(tmp.call_record_field2,'*') 
            OR COALESCE(t.call_record_field3,'*') != COALESCE(tmp.call_record_field3,'*') 
            OR COALESCE(t.call_record_field4,'*') != COALESCE(tmp.call_record_field4,'*') 
            OR COALESCE(t.call_record_field5,'*') != COALESCE(tmp.call_record_field5,'*') 
            OR COALESCE(t.parent_call_record_id,0) != COALESCE(tmp.parent_call_record_id,0)            
            OR COALESCE(t.call_record_generic_field1, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.call_record_generic_field1, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.call_record_generic_field2, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.call_record_generic_field2, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.call_record_generic_field3,0) != COALESCE(tmp.call_record_generic_field3,0)            
            OR COALESCE(t.call_record_generic_field4,0) != COALESCE(tmp.call_record_generic_field4,0)         
            OR COALESCE(t.call_record_generic_field5,'*') != COALESCE(tmp.call_record_generic_field5,'*')
            OR COALESCE(t.call_record_generic_field6,'*') != COALESCE(tmp.call_record_generic_field6,'*')
            OR COALESCE(t.call_record_generic_field7,'*') != COALESCE(tmp.call_record_generic_field7,'*')            
            OR COALESCE(t.call_record_generic_field8,'*') != COALESCE(tmp.call_record_generic_field8,'*')
            OR COALESCE(t.call_record_generic_field9,'*') != COALESCE(tmp.call_record_generic_field9,'*')            
            OR COALESCE(t.call_record_generic_field10,'*') != COALESCE(tmp.call_record_generic_field10,'*')            
            OR COALESCE(t.medchat_topic,'*') != COALESCE(tmp.medchat_topic,'*')            
            OR COALESCE(t.medchat_status,'*') != COALESCE(tmp.medchat_status,'*')  
            OR COALESCE(t.medchat_id,'*') != COALESCE(tmp.medchat_id,'*')  
          ) ce ON (e.call_record_id = ce.call_record_id)
    WHEN MATCHED THEN UPDATE
     SET e.call_type_cd = ce.call_type_cd
        ,e.caller_type_cd = ce.caller_type_cd
        ,e.call_tracking_number = ce.call_tracking_number
        ,e.worker_id = ce.worker_id
        ,e.worker_username = ce.worker_username
        ,e.language_cd = ce.language_cd
        ,e.call_start_ts = ce.call_start_ts
        ,e.call_end_ts = ce.call_end_ts
        ,e.caller_phone = ce.caller_phone
        ,e.ext_telephony_ref = ce.ext_telephony_ref
        ,e.created_by = ce.created_by
        ,e.create_ts = ce.create_ts
        ,e.updated_by = ce.updated_by
        ,e.update_ts = ce.update_ts
        ,e.note_ref_id = ce.note_ref_id
        ,e.caller_first_name = ce.caller_first_name
        ,e.caller_last_name = ce.caller_last_name
        ,e.call_start_ndt = ce.call_start_ndt
        ,e.call_record_field1 = ce.call_record_field1
        ,e.call_record_field2 = ce.call_record_field2
        ,e.call_record_field3 = ce.call_record_field3
        ,e.call_record_field4 = ce.call_record_field4
        ,e.call_record_field5 = ce.call_record_field5
        ,e.parent_call_record_id = ce.parent_call_record_id
        ,e.call_record_generic_field1 = ce.call_record_generic_field1
        ,e.call_record_generic_field2 = ce.call_record_generic_field2
        ,e.call_record_generic_field3 = ce.call_record_generic_field3
        ,e.call_record_generic_field4 = ce.call_record_generic_field4
        ,e.call_record_generic_field5 = ce.call_record_generic_field5
        ,e.call_record_generic_field6 = ce.call_record_generic_field6
        ,e.call_record_generic_field7 = ce.call_record_generic_field7
        ,e.call_record_generic_field8 = ce.call_record_generic_field8
        ,e.call_record_generic_field9 = ce.call_record_generic_field9
        ,e.call_record_generic_field10 = ce.call_record_generic_field10
        ,e.medchat_topic = ce.medchat_topic
        ,e.medchat_status = ce.medchat_status
        ,e.medchat_id = ce.medchat_id
     Log Errors INTO Errlog_CallRecord ('CALL_RECORD_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CALL_RECORD', CALL_RECORD_ID
      FROM Errlog_CallRecord
     WHERE Ora_Err_Tag$ = 'CALL_RECORD_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_UPD', 1, v_desc, v_code, 'D_CALL_RECORD');

      COMMIT;
END CALL_RECORD_UPD;

PROCEDURE CALL_RECORD_LINK_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_CallRecordLink WHERE ora_err_tag$ = 'CALL_RECORD_LINK_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CALL_RECORD_LINK_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_CALL_RECORD_LINK 
          (call_record_link_id,
            call_record_id,
            client_id,
            case_id,
            ext_client_num,
            ext_case_num,
            client_last_name,
            client_first_name,
            client_mi,
            ref_type,
            ref_id,
            create_ts,
            created_by,
            update_ts,
            updated_by,
            caller_ind)
    SELECT
           call_record_link_id,
            call_record_id,
            client_id,
            case_id,
            ext_client_num,
            ext_case_num,
            client_last_name,
            client_first_name,
            client_mi,
            ref_type,
            ref_id,
            create_ts,
            created_by,
            update_ts,
            updated_by,
            caller_ind        
    FROM s_call_record_link_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_call_record_link ce WHERE e.call_record_link_id = ce.call_record_link_id)
     LOG Errors INTO Errlog_CallRecordLink ('CALL_RECORD_LINK_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_LINK_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CALL_RECORD_LINK', CALL_RECORD_LINK_ID
      FROM Errlog_CallRecordLink
     WHERE Ora_Err_Tag$ = 'CALL_RECORD_LINK_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_LINK_INS', 1, v_desc, v_code, 'D_CALL_RECORD_LINK');

      COMMIT;
END CALL_RECORD_LINK_INS;

PROCEDURE CALL_RECORD_LINK_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_CallRecordLink WHERE ora_err_tag$ = 'CALL_RECORD_LINK_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CALL_RECORD_LINK_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_CALL_RECORD_LINK e
   USING (SELECT tmp.*
          FROM (SELECT
                 call_record_link_id,
                  call_record_id,
                  client_id,
                  case_id,
                  ext_client_num,
                  ext_case_num,
                  client_last_name,
                  client_first_name,
                  client_mi,
                  ref_type,
                  ref_id,
                  create_ts,
                  created_by,
                  update_ts,
                  updated_by,
                  caller_ind
                FROM s_call_record_link_stg e                
              ) tmp
          JOIN d_call_record_link t ON tmp.call_record_link_id = t.call_record_link_id
          WHERE COALESCE(t.call_record_id,0) != COALESCE(tmp.call_record_id,0)            
            OR COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0) 
            OR COALESCE(t.case_id,0) != COALESCE(tmp.case_id,0) 
            OR COALESCE(t.ext_client_num,'*') != COALESCE(tmp.ext_client_num,'*')          
            OR COALESCE(t.ext_case_num,'*') != COALESCE(tmp.ext_case_num,'*')
            OR COALESCE(t.client_last_name,'*') != COALESCE(tmp.client_last_name,'*')
            OR COALESCE(t.client_first_name,'*') != COALESCE(tmp.client_first_name,'*')
            OR COALESCE(t.client_mi,'*') != COALESCE(tmp.client_mi,'*')
            OR COALESCE(t.ref_type,'*') != COALESCE(tmp.ref_type,'*')
            OR COALESCE(t.ref_id,0) != COALESCE(tmp.ref_id,0) 
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.caller_ind,0) != COALESCE(tmp.caller_ind,0)              
          ) ce ON (e.call_record_link_id = ce.call_record_link_id)
    WHEN MATCHED THEN UPDATE
     SET e.call_record_id = ce.call_record_id
        ,e.client_id = ce.client_id
        ,e.case_id = ce.case_id
        ,e.ext_client_num = ce.ext_client_num
        ,e.ext_case_num = ce.ext_case_num
        ,e.client_last_name = ce.client_last_name
        ,e.client_first_name = ce.client_first_name
        ,e.client_mi = ce.client_mi
        ,e.ref_type = ce.ref_type
        ,e.ref_id = ce.ref_id
        ,e.create_ts = ce.create_ts
        ,e.created_by = ce.created_by        
        ,e.update_ts = ce.update_ts
        ,e.updated_by = ce.updated_by        
        ,e.caller_ind = ce.caller_ind        
     Log Errors INTO Errlog_CallRecordLink ('CALL_RECORD_LINK_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_LINK_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CALL_RECORD_LINK', CALL_RECORD_LINK_ID
      FROM Errlog_CallRecordLink
     WHERE Ora_Err_Tag$ = 'CALL_RECORD_LINK_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.CALL_RECORD_LINK_UPD', 1, v_desc, v_code, 'D_CALL_RECORD_LINK');

      COMMIT;
END CALL_RECORD_LINK_UPD;

PROCEDURE INCIDENT_HEADER_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Incident WHERE ora_err_tag$ = 'INCIDENT_HEADER_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INCIDENT_HEADER_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_INCIDENT_HEADER 
          (incident_header_id,
            client_id,
            case_id,
            tracking_number,
            origin_cd,
            origin_id,
            status_cd,
            status_ts,
            received_ts,
            reporter_first_name,
            reporter_last_name,
            reporter_id,
            reporter_phone,
            reporter_type_cd,
            reporter_relationship,
            update_ts,
            updated_by,
            version_num,
            create_ts,
            created_by,
            incident_header_type_cd,
            state_received_ts,
            responsible_staff_id,
            eb_follow_up_needed_ind,        
            description,    
            other_party_name,
            actions_taken,
            priority_cd,
            resolution,
            hearing_date,
            plan_id_ext,
            network_id_ext,
            affected_party_type_cd,
            selection_id,
            affected_party_subtype_cd,
            fair_hearing_tracking_nbr,
            aid_to_continue_ind,
            responsible_staff_group_id,
            outreach_contact_info,
            state_id,
            application_id,
            other_party_type_cd,
            action_taken_cd,
            resolution_type_cd,
            non_incident_ind,
            generic_field1,
            generic_field2,
            generic_field3,
            generic_field4,
            generic_field5,
            survey_id)
    SELECT
           incident_header_id,
            client_id,
            case_id,
            tracking_number,
            origin_cd,
            origin_id,
            status_cd,
            status_ts,
            received_ts,
            reporter_first_name,
            reporter_last_name,
            reporter_id,
            reporter_phone,
            reporter_type_cd,
            reporter_relationship,
            update_ts,
            updated_by,
            version_num,
            create_ts,
            created_by,
            incident_header_type_cd,
            state_received_ts,
            responsible_staff_id,
            eb_follow_up_needed_ind,        
            description,    
            other_party_name,
            actions_taken,
            priority_cd,
            resolution,
            hearing_date,
            plan_id_ext,
            network_id_ext,
            affected_party_type_cd,
            selection_id,
            affected_party_subtype_cd,
            fair_hearing_tracking_nbr,
            aid_to_continue_ind,
            responsible_staff_group_id,
            outreach_contact_info,
            state_id,
            application_id,
            other_party_type_cd,
            action_taken_cd,
            resolution_type_cd,
            non_incident_ind,
            generic_field1,
            generic_field2,
            generic_field3,
            generic_field4,
            generic_field5,
            survey_id       
    FROM s_incident_header_stg s  
    WHERE NOT EXISTS(SELECT 1 FROM d_incident_header i WHERE s.incident_header_id = i.incident_header_id)
     LOG Errors INTO Errlog_Incident ('INCIDENT_HEADER_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.INCIDENT_HEADER_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_INCIDENT_HEADER', INCIDENT_HEADER_ID
      FROM Errlog_Incident
     WHERE Ora_Err_Tag$ = 'INCIDENT_HEADER_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.INCIDENT_HEADER_INS', 1, v_desc, v_code, 'D_INCIDENT_HEADER');

      COMMIT;
END INCIDENT_HEADER_INS;

PROCEDURE INCIDENT_HEADER_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Incident WHERE ora_err_tag$ = 'INCIDENT_HEADER_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INCIDENT_HEADER_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_INCIDENT_HEADER e
   USING (SELECT tmp.*
          FROM(SELECT
                incident_header_id,
                client_id,
                case_id,
                tracking_number,
                origin_cd,
                origin_id,
                status_cd,
                status_ts,
                received_ts,
                reporter_first_name,
                reporter_last_name,
                reporter_id,
                reporter_phone,
                reporter_type_cd,
                reporter_relationship,
                update_ts,
                updated_by,
                version_num,
                create_ts,
                created_by,
                incident_header_type_cd,
                state_received_ts,
                responsible_staff_id,
                eb_follow_up_needed_ind,        
                description,    
                other_party_name,
                actions_taken,
                priority_cd,
                resolution,
                hearing_date,
                plan_id_ext,
                network_id_ext,
                affected_party_type_cd,
                selection_id,
                affected_party_subtype_cd,
                fair_hearing_tracking_nbr,
                aid_to_continue_ind,
                responsible_staff_group_id,
                outreach_contact_info,
                state_id,
                application_id,
                other_party_type_cd,
                action_taken_cd,
                resolution_type_cd,
                non_incident_ind,
                generic_field1,
                generic_field2,
                generic_field3,
                generic_field4,
                generic_field5,
                survey_id   
                FROM s_incident_header_stg e  ) tmp
          JOIN d_incident_header t ON tmp.incident_header_id = t.incident_header_id
          WHERE COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)             
            OR COALESCE(t.case_id,0) != COALESCE(tmp.case_id,0)             
            OR COALESCE(t.tracking_number,'*') != COALESCE(tmp.tracking_number,'*')          
            OR COALESCE(t.origin_cd,'*') != COALESCE(tmp.origin_cd,'*')
            OR COALESCE(t.origin_id,0) != COALESCE(tmp.origin_id,0) 
            OR COALESCE(t.status_cd,'*') != COALESCE(tmp.status_cd,'*')
            OR COALESCE(t.status_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.status_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.received_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.received_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.reporter_first_name,'*') != COALESCE(tmp.reporter_first_name,'*')
            OR COALESCE(t.reporter_last_name,'*') != COALESCE(tmp.reporter_last_name,'*')
            OR COALESCE(t.reporter_id,0) != COALESCE(tmp.reporter_id,0) 
            OR COALESCE(t.reporter_phone,'*') != COALESCE(tmp.reporter_phone,'*')
            OR COALESCE(t.reporter_type_cd,'*') != COALESCE(tmp.reporter_type_cd,'*')
            OR COALESCE(t.reporter_relationship,'*') != COALESCE(tmp.reporter_relationship,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.version_num,0) != COALESCE(tmp.version_num,0)  
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.incident_header_type_cd,'*') != COALESCE(tmp.incident_header_type_cd,'*')
            OR COALESCE(t.state_received_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.state_received_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.responsible_staff_id,0) != COALESCE(tmp.responsible_staff_id,0)  
            OR COALESCE(t.eb_follow_up_needed_ind,0) != COALESCE(tmp.eb_follow_up_needed_ind,0)  
            OR COALESCE(t.description,'*') != COALESCE(tmp.description,'*')
            OR COALESCE(t.other_party_name,'*') != COALESCE(tmp.other_party_name,'*')
            OR COALESCE(t.actions_taken,'*') != COALESCE(tmp.actions_taken,'*')
            OR COALESCE(t.priority_cd,'*') != COALESCE(tmp.priority_cd,'*')
            OR COALESCE(t.resolution,'*') != COALESCE(tmp.resolution,'*')
            OR COALESCE(t.hearing_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.hearing_date, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.plan_id_ext,'*') != COALESCE(tmp.plan_id_ext,'*')
            OR COALESCE(t.network_id_ext,'*') != COALESCE(tmp.network_id_ext,'*')
            OR COALESCE(t.affected_party_type_cd,'*') != COALESCE(tmp.affected_party_type_cd,'*')
            OR COALESCE(t.selection_id,0) != COALESCE(tmp.selection_id,0)  
            OR COALESCE(t.affected_party_subtype_cd,'*') != COALESCE(tmp.affected_party_subtype_cd,'*')
            OR COALESCE(t.fair_hearing_tracking_nbr,'*') != COALESCE(tmp.fair_hearing_tracking_nbr,'*')
            OR COALESCE(t.aid_to_continue_ind,0) != COALESCE(tmp.aid_to_continue_ind,0) 
            OR COALESCE(t.responsible_staff_group_id,0) != COALESCE(tmp.responsible_staff_group_id,0) 
            OR COALESCE(t.outreach_contact_info,'*') != COALESCE(tmp.outreach_contact_info,'*')
            OR COALESCE(t.state_id,'*') != COALESCE(tmp.state_id,'*')
            OR COALESCE(t.application_id,'*') != COALESCE(tmp.application_id,'*')
            OR COALESCE(t.other_party_type_cd,'*') != COALESCE(tmp.other_party_type_cd,'*')
            OR COALESCE(t.action_taken_cd,'*') != COALESCE(tmp.action_taken_cd,'*')
            OR COALESCE(t.resolution_type_cd,'*') != COALESCE(tmp.resolution_type_cd,'*')
            OR COALESCE(t.non_incident_ind,0) != COALESCE(tmp.non_incident_ind,0) 
            OR COALESCE(t.generic_field1,'*') != COALESCE(tmp.generic_field1,'*')
            OR COALESCE(t.generic_field2,'*') != COALESCE(tmp.generic_field2,'*')
            OR COALESCE(t.generic_field3,'*') != COALESCE(tmp.generic_field3,'*')
            OR COALESCE(t.generic_field4,'*') != COALESCE(tmp.generic_field4,'*')
            OR COALESCE(t.generic_field5,'*') != COALESCE(tmp.generic_field5,'*')
            OR COALESCE(t.survey_id,0) != COALESCE(tmp.survey_id,0) 
          ) ce ON (e.incident_header_id = ce.incident_header_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.case_id = ce.case_id
        ,e.tracking_number = ce.tracking_number
        ,e.origin_cd = ce.origin_cd
        ,e.origin_id = ce.origin_id
        ,e.status_cd = ce.status_cd
        ,e.status_ts = ce.status_ts
        ,e.received_ts = ce.received_ts
        ,e.reporter_first_name = ce.reporter_first_name
        ,e.reporter_last_name = ce.reporter_last_name
        ,e.reporter_id = ce.reporter_id        
        ,e.reporter_phone = ce.reporter_phone
        ,e.reporter_type_cd = ce.reporter_type_cd        
        ,e.reporter_relationship = ce.reporter_relationship
        ,e.update_ts = ce.update_ts
        ,e.updated_by = ce.updated_by
        ,e.version_num = ce.version_num        
        ,e.create_ts = ce.create_ts
        ,e.created_by = ce.created_by        
        ,e.incident_header_type_cd = ce.incident_header_type_cd        
        ,e.state_received_ts = ce.state_received_ts
        ,e.responsible_staff_id = ce.responsible_staff_id        
        ,e.eb_follow_up_needed_ind = ce.eb_follow_up_needed_ind
        ,e.description = ce.description
        ,e.other_party_name = ce.other_party_name
        ,e.actions_taken = ce.actions_taken        
        ,e.priority_cd = ce.priority_cd
        ,e.resolution = ce.resolution        
        ,e.hearing_date = ce.hearing_date        
        ,e.plan_id_ext = ce.plan_id_ext        
        ,e.network_id_ext = ce.network_id_ext
        ,e.affected_party_type_cd = ce.affected_party_type_cd        
        ,e.selection_id = ce.selection_id        
        ,e.affected_party_subtype_cd = ce.affected_party_subtype_cd
        ,e.fair_hearing_tracking_nbr = ce.fair_hearing_tracking_nbr        
        ,e.aid_to_continue_ind = ce.aid_to_continue_ind
        ,e.responsible_staff_group_id = ce.responsible_staff_group_id
        ,e.outreach_contact_info = ce.outreach_contact_info
        ,e.state_id = ce.state_id        
        ,e.application_id = ce.application_id
        ,e.other_party_type_cd = ce.other_party_type_cd        
        ,e.action_taken_cd = ce.action_taken_cd       
        ,e.resolution_type_cd = ce.resolution_type_cd        
        ,e.non_incident_ind = ce.non_incident_ind
        ,e.generic_field1 = ce.generic_field1        
        ,e.generic_field2 = ce.generic_field2
        ,e.generic_field3 = ce.generic_field3
        ,e.generic_field4 = ce.generic_field4        
        ,e.generic_field5 = ce.generic_field5
        ,e.survey_id = ce.survey_id
     Log Errors INTO Errlog_Incident ('INCIDENT_HEADER_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.INCIDENT_HEADER_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_INCIDENT_HEADER', INCIDENT_HEADER_ID
      FROM Errlog_Incident
     WHERE Ora_Err_Tag$ = 'INCIDENT_HEADER_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.INCIDENT_HEADER_UPD', 1, v_desc, v_code, 'D_INCIDENT_HEADER');

      COMMIT;
END INCIDENT_HEADER_UPD;

PROCEDURE EVENT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Event WHERE ora_err_tag$ = 'EVENT_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'EVENT_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_EVENT
          (event_id,
            event_type_cd,
            context,
            comments,
            create_ts,
            created_by,
            update_ts,
            updated_by,
            ref_type,
            ref_id,
            event_level,
            image_repo_ref_id,
            effective_date,
            case_id,
            client_id,
            call_record_id,
            task_instance_id,
            cscl_id,
            disabled_ind,
            generic_field1_date,
            generic_field2_date,
            generic_field3_num,
            generic_field4_num,
            generic_field5_txt,
            generic_field6_txt,
            generic_field7_txt,
            generic_field8_txt,
            generic_field9_txt,
            generic_field10_txt)
    SELECT
           event_id,
            event_type_cd,
            context,
            comments,
            create_ts,
            created_by,
            update_ts,
            updated_by,
            ref_type,
            ref_id,
            event_level,
            image_repo_ref_id,
            effective_date,
            case_id,
            client_id,
            call_record_id,
            task_instance_id,
            cscl_id,
            disabled_ind,
            generic_field1_date,
            generic_field2_date,
            generic_field3_num,
            generic_field4_num,
            generic_field5_txt,
            generic_field6_txt,
            generic_field7_txt,
            generic_field8_txt,
            generic_field9_txt,
            generic_field10_txt        
    FROM s_event_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_event ce WHERE e.event_id = ce.event_id)
     LOG Errors INTO Errlog_Event ('EVENT_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.EVENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_EVENT', EVENT_ID
      FROM Errlog_Event
     WHERE Ora_Err_Tag$ = 'EVENT_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.EVENT_INS', 1, v_desc, v_code, 'D_EVENT');

      COMMIT;
END EVENT_INS;

PROCEDURE EVENT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Event WHERE ora_err_tag$ = 'EVENT_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'EVENT_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_EVENT e
   USING (SELECT tmp.*
          FROM (SELECT event_id,
                  event_type_cd,
                  context,
                  comments,
                  create_ts,
                  created_by,
                  update_ts,
                  updated_by,
                  ref_type,
                  ref_id,
                  event_level,
                  image_repo_ref_id,
                  effective_date,
                  case_id,
                  client_id,
                  call_record_id,
                  task_instance_id,
                  cscl_id,
                  disabled_ind,
                  generic_field1_date,
                  generic_field2_date,
                  generic_field3_num,
                  generic_field4_num,
                  generic_field5_txt,
                  generic_field6_txt,
                  generic_field7_txt,
                  generic_field8_txt,
                  generic_field9_txt,
                  generic_field10_txt  
                FROM s_event_stg e                
              ) tmp
          JOIN d_event t ON tmp.event_id = t.event_id
          WHERE COALESCE(t.event_type_cd,'*') != COALESCE(tmp.event_type_cd,'*')          
            OR COALESCE(t.context,'*') != COALESCE(tmp.context,'*')                 
            OR COALESCE(t.comments,'*') != COALESCE(tmp.comments,'*')     
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.ref_type,'*') != COALESCE(tmp.ref_type,'*')
            OR COALESCE(t.ref_id,0) != COALESCE(tmp.ref_id,0) 
            OR COALESCE(t.event_level,0) != COALESCE(tmp.event_level,0)
            OR COALESCE(t.image_repo_ref_id,0) != COALESCE(tmp.image_repo_ref_id,0)
            OR COALESCE(t.effective_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.effective_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.case_id,0) != COALESCE(tmp.case_id,0) 
            OR COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0) 
            OR COALESCE(t.call_record_id,0) != COALESCE(tmp.call_record_id,0) 
            OR COALESCE(t.task_instance_id,0) != COALESCE(tmp.task_instance_id,0) 
            OR COALESCE(t.cscl_id,0) != COALESCE(tmp.cscl_id,0) 
            OR COALESCE(t.disabled_ind,0) != COALESCE(tmp.disabled_ind,0) 
            OR COALESCE(t.generic_field1_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.generic_field1_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.generic_field2_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.generic_field2_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.generic_field3_num,0) != COALESCE(tmp.generic_field3_num,0) 
            OR COALESCE(t.generic_field4_num,0) != COALESCE(tmp.generic_field4_num,0)             
            OR COALESCE(t.generic_field5_txt,'*') != COALESCE(tmp.generic_field5_txt,'*')          
            OR COALESCE(t.generic_field6_txt,'*') != COALESCE(tmp.generic_field6_txt,'*')          
            OR COALESCE(t.generic_field7_txt,'*') != COALESCE(tmp.generic_field7_txt,'*')          
            OR COALESCE(t.generic_field8_txt,'*') != COALESCE(tmp.generic_field8_txt,'*')          
            OR COALESCE(t.generic_field9_txt,'*') != COALESCE(tmp.generic_field9_txt,'*')          
            OR COALESCE(t.generic_field10_txt,'*') != COALESCE(tmp.generic_field10_txt,'*')          
          ) ce ON (e.event_id = ce.event_id)
    WHEN MATCHED THEN UPDATE
     SET e.event_type_cd = ce.event_type_cd
        ,e.context = ce.context
        ,e.comments = ce.comments
        ,e.create_ts = ce.create_ts
        ,e.created_by = ce.created_by
        ,e.update_ts = ce.update_ts
        ,e.updated_by = ce.updated_by
        ,e.ref_type = ce.ref_type
        ,e.ref_id = ce.ref_id
        ,e.event_level = ce.event_level
        ,e.image_repo_ref_id = ce.image_repo_ref_id
        ,e.effective_date = ce.effective_date        
        ,e.case_id = ce.case_id
        ,e.client_id = ce.client_id        
        ,e.call_record_id = ce.call_record_id             
        ,e.task_instance_id = ce.task_instance_id
        ,e.cscl_id = ce.cscl_id
        ,e.disabled_ind = ce.disabled_ind
        ,e.generic_field1_date = ce.generic_field1_date
        ,e.generic_field2_date = ce.generic_field2_date        
        ,e.generic_field3_num = ce.generic_field3_num
        ,e.generic_field4_num = ce.generic_field4_num        
        ,e.generic_field5_txt = ce.generic_field5_txt
        ,e.generic_field6_txt = ce.generic_field6_txt
        ,e.generic_field7_txt = ce.generic_field7_txt
        ,e.generic_field8_txt = ce.generic_field8_txt
        ,e.generic_field9_txt = ce.generic_field9_txt
        ,e.generic_field10_txt = ce.generic_field10_txt
     Log Errors INTO Errlog_Event ('EVENT_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.EVENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_EVENT', EVENT_ID
      FROM Errlog_Event
     WHERE Ora_Err_Tag$ = 'EVENT_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'LAEB_CRM_ETL_PKG.EVENT_UPD', 1, v_desc, v_code, 'D_EVENT');

      COMMIT;
END EVENT_UPD;
END;
/

grant execute on LAEB_CRM_ETL_PKG to MAXDAT_LAEB_READ_ONLY;

alter session set plsql_code_type = interpreted;