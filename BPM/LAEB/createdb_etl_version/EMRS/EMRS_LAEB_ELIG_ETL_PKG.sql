alter session set plsql_code_type = native;

create or replace package EMRS_LAEB_ELIG_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/LAEB/createdb_etl_version/EMRS/EMRS_LAEB_ELIG_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 25551 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-11-10 18:55:32 -0800 (Sat, 10 Nov 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE CLIENT_ELIG_STATUS_INS;
  PROCEDURE CLIENT_ELIG_STATUS_UPD;
  
  PROCEDURE CLIENT_ENROLL_STATUS_INS;
  PROCEDURE CLIENT_ENROLL_STATUS_UPD;
  
  PROCEDURE ELIG_SEGMENT_DTL_INS;
  PROCEDURE ELIG_SEGMENT_DTL_UPD;
    
  PROCEDURE UPDATE_D_CLIENT_ELIGIBILITY;
    
  PROCEDURE ELIG_SEGMENT_DTL_COUNT_UPD;
  PROCEDURE ELIG_SEGMENT_DTL_DEL;
  
  PROCEDURE ELIG_SEGMENT_DTL_INS_ELIG;
  PROCEDURE ELIG_SEGMENT_DTL_UPD_ELIG;
  
  PROCEDURE ELIG_SEGMENT_DTL_INS_OHC;
  PROCEDURE ELIG_SEGMENT_DTL_UPD_OHC;
  
  PROCEDURE ELIG_SEGMENT_DTL_INS_LTC;
  PROCEDURE ELIG_SEGMENT_DTL_UPD_LTC;
  
  PROCEDURE ELIG_SEGMENT_DTL_INS_MI;
  PROCEDURE ELIG_SEGMENT_DTL_INS_ME;
  PROCEDURE UPDATE_D_CLIENT_ELIGIBILITY_ME;
    
end;
/

CREATE OR REPLACE PACKAGE BODY EMRS_LAEB_ELIG_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE CLIENT_ELIG_STATUS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Elig WHERE ora_err_tag$ = 'CLIENT_ELIG_STATUS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_ELIG_STATUS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_CLIENT_ELIGIBILITY 
          (client_elig_status_id,
            client_id,
            plan_type_cd,
            elig_status_cd,
            start_date,
            end_date,
            program_cd,
            sub_status_codes,
            reasons,
            mvx_core_reason,
            debug,
            start_ndt,
            end_ndt,
            disposition_cd,
            subprogram_type,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT
        client_elig_status_id,
            client_id,
            plan_type_cd,
            elig_status_cd,
            start_date,
            end_date,
            program_cd,
            sub_status_codes,
            reasons,
            mvx_core_reason,
            debug,
            start_ndt,
            end_ndt,
            disposition_cd,
            subprogram_type,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by            
    FROM emrs_s_eligibility_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_client_eligibility ce WHERE e.client_elig_status_id = ce.client_elig_status_id)
     LOG Errors INTO Errlog_Elig ('CLIENT_ELIG_STATUS_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ELIG_STATUS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_ELIGIBILITY', CLIENT_ELIG_STATUS_ID
      FROM Errlog_Elig
     WHERE Ora_Err_Tag$ = 'CLIENT_ELIG_STATUS_INS';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ELIG_STATUS_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_ELIGIBILITY');

      COMMIT;
END CLIENT_ELIG_STATUS_INS;

PROCEDURE CLIENT_ELIG_STATUS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Elig WHERE ora_err_tag$ = 'CLIENT_ELIG_STATUS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_ELIG_STATUS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_CLIENT_ELIGIBILITY e
   USING (SELECT tmp.*
          FROM (SELECT
                  client_elig_status_id,
                  client_id,
                  plan_type_cd,
                  elig_status_cd,
                  start_date,
                  end_date,
                  program_cd,
                  sub_status_codes,
                  reasons,
                  mvx_core_reason,
                  debug,
                  start_ndt,
                  end_ndt,
                  disposition_cd,
                  subprogram_type,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_eligibility_stg e                
              ) tmp
          JOIN emrs_d_client_eligibility t ON tmp.client_elig_status_id = t.client_elig_status_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.plan_type_cd,'*') != COALESCE(tmp.plan_type_cd,'*')
            OR COALESCE(t.elig_status_cd,'*') != COALESCE(tmp.elig_status_cd,'*')
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.program_cd,'*') != COALESCE(tmp.program_cd,'*')
            OR COALESCE(t.sub_status_codes,'*') != COALESCE(tmp.sub_status_codes,'*')
            OR COALESCE(t.reasons,'*') != COALESCE(tmp.reasons,'*')
            OR COALESCE(t.mvx_core_reason,'*') != COALESCE(tmp.mvx_core_reason,'*')
            OR COALESCE(t.debug,'*') != COALESCE(tmp.debug,'*')
            OR COALESCE(t.start_ndt,0) != COALESCE(tmp.start_ndt,0)
            OR COALESCE(t.end_ndt,0) != COALESCE(tmp.end_ndt,0)
            OR COALESCE(t.disposition_cd,'*') != COALESCE(tmp.disposition_cd,'*') 
            OR COALESCE(t.subprogram_type,'*') != COALESCE(tmp.subprogram_type,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.client_elig_status_id = ce.client_elig_status_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.plan_type_cd = ce.plan_type_cd
        ,e.elig_status_cd = ce.elig_status_cd
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.program_cd = ce.program_cd
        ,e.sub_status_codes = ce.sub_status_codes
        ,e.reasons = ce.reasons
        ,e.mvx_core_reason = ce.mvx_core_reason
        ,e.debug = ce.debug
        ,e.start_ndt = ce.start_ndt
        ,e.end_ndt = ce.end_ndt
        ,e.disposition_cd = ce.disposition_cd
        ,e.subprogram_type = ce.subprogram_type
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name              
     Log Errors INTO Errlog_Elig ('CLIENT_ELIG_STATUS_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ELIG_STATUS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_ELIGIBILITY', CLIENT_ELIG_STATUS_ID
      FROM Errlog_Elig
     WHERE Ora_Err_Tag$ = 'CLIENT_ELIG_STATUS_UPD';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ELIG_STATUS_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_ELIGIBILITY');

      COMMIT;
END CLIENT_ELIG_STATUS_UPD;

PROCEDURE CLIENT_ENROLL_STATUS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Enrollstat WHERE ora_err_tag$ = 'CLIENT_ENROLL_STATUS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_ENROLL_STATUS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_CLIENT_ENROLL_STATUS 
          ( client_enroll_status_id,
            client_id,
            plan_type_cd,
            enroll_status_cd,
            start_date,
            end_date,
            program_cd,
            start_ndt,
            end_ndt,
            disposition_cd,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT client_enroll_status_id,
            client_id,
            plan_type_cd,
            enroll_status_cd,
            start_date,
            end_date,
            program_cd,
            start_ndt,
            end_ndt,
            disposition_cd,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by                 
    FROM emrs_s_enroll_status_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_client_enroll_status ce WHERE e.client_enroll_status_id = ce.client_enroll_status_id)
     LOG Errors INTO Errlog_Enrollstat ('CLIENT_ENROLL_STATUS_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ENROLL_STATUS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_ENROLL_STATUS', CLIENT_ENROLL_STATUS_ID
      FROM Errlog_Enrollstat
     WHERE Ora_Err_Tag$ = 'CLIENT_ENROLL_STATUS_INS';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ENROLL_STATUS_INS', 1, v_desc, v_code, 'EMRS_D_CLIENT_ENROLL_STATUS');

      COMMIT;
END CLIENT_ENROLL_STATUS_INS;

PROCEDURE CLIENT_ENROLL_STATUS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Enrollstat WHERE ora_err_tag$ = 'CLIENT_ENROLL_STATUS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'CLIENT_ENROLL_STATUS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_CLIENT_ENROLL_STATUS e
   USING (SELECT tmp.*
          FROM (SELECT
                  client_enroll_status_id,
                  client_id,
                  plan_type_cd,
                  enroll_status_cd,
                  start_date,
                  end_date,
                  program_cd,
                  start_ndt,
                  end_ndt,
                  disposition_cd,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_enroll_status_stg e                
              ) tmp
          JOIN emrs_d_client_enroll_status t ON tmp.client_enroll_status_id = t.client_enroll_status_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.plan_type_cd,'*') != COALESCE(tmp.plan_type_cd,'*')
            OR COALESCE(t.enroll_status_cd,'*') != COALESCE(tmp.enroll_status_cd,'*')
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.program_cd,'*') != COALESCE(tmp.program_cd,'*')            
            OR COALESCE(t.start_ndt,0) != COALESCE(tmp.start_ndt,0)
            OR COALESCE(t.end_ndt,0) != COALESCE(tmp.end_ndt,0)
            OR COALESCE(t.disposition_cd,'*') != COALESCE(tmp.disposition_cd,'*')             
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.client_enroll_status_id = ce.client_enroll_status_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.plan_type_cd = ce.plan_type_cd
        ,e.enroll_status_cd = ce.enroll_status_cd
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.program_cd = ce.program_cd       
        ,e.start_ndt = ce.start_ndt
        ,e.end_ndt = ce.end_ndt
        ,e.disposition_cd = ce.disposition_cd      
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name             
     Log Errors INTO Errlog_Enrollstat ('CLIENT_ENROLL_STATUS_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ENROLL_STATUS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_CLIENT_ENROLL_STATUS', CLIENT_ENROLL_STATUS_ID
      FROM Errlog_Enrollstat
     WHERE Ora_Err_Tag$ = 'CLIENT_ENROLL_STATUS_UPD';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.CLIENT_ENROLL_STATUS_UPD', 1, v_desc, v_code, 'EMRS_D_CLIENT_ENROLL_STATUS');

      COMMIT;
END CLIENT_ENROLL_STATUS_UPD;

PROCEDURE ELIG_SEGMENT_DTL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Segment_Dtl WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS 
          ( elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by                 
    FROM emrs_s_segment_detail_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl ('ELIG_SEGMENT_DTL_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS');

      COMMIT;
END ELIG_SEGMENT_DTL_INS;

PROCEDURE ELIG_SEGMENT_DTL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ELIG_SEGMENT_DETAILS e
   USING (SELECT tmp.*
          FROM (SELECT
                  elig_segment_and_details_id,
                  segment_type_cd,
                  client_id,
                  start_date,
                  end_date,
                  segment_detail_value_1,
                  segment_detail_value_2,
                  segment_detail_value_3,
                  segment_detail_value_4,
                  segment_detail_value_5,
                  segment_detail_value_6,
                  segment_detail_value_7,
                  segment_detail_value_8,
                  segment_detail_value_9,
                  segment_detail_value_10,
                  start_nd,
                  end_nd,
                  sequence_num,
                  comparable_key,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_segment_detail_stg e                
              ) tmp
          JOIN emrs_d_elig_segment_details t ON tmp.elig_segment_and_details_id = t.elig_segment_and_details_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.segment_type_cd,'*') != COALESCE(tmp.segment_type_cd,'*')           
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.segment_detail_value_1,'*') != COALESCE(tmp.segment_detail_value_1,'*')            
            OR COALESCE(t.segment_detail_value_2,'*') != COALESCE(tmp.segment_detail_value_2,'*')            
            OR COALESCE(t.segment_detail_value_3,'*') != COALESCE(tmp.segment_detail_value_3,'*')            
            OR COALESCE(t.segment_detail_value_4,'*') != COALESCE(tmp.segment_detail_value_4,'*')            
            OR COALESCE(t.segment_detail_value_5,'*') != COALESCE(tmp.segment_detail_value_5,'*')            
            OR COALESCE(t.segment_detail_value_6,'*') != COALESCE(tmp.segment_detail_value_6,'*')            
            OR COALESCE(t.segment_detail_value_7,'*') != COALESCE(tmp.segment_detail_value_7,'*')            
            OR COALESCE(t.segment_detail_value_8,'*') != COALESCE(tmp.segment_detail_value_8,'*')            
            OR COALESCE(t.segment_detail_value_9,'*') != COALESCE(tmp.segment_detail_value_9,'*')            
            OR COALESCE(t.segment_detail_value_10,'*') != COALESCE(tmp.segment_detail_value_10,'*')            
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.sequence_num,0) != COALESCE(tmp.sequence_num,0)
            OR COALESCE(t.comparable_key,'*') != COALESCE(tmp.comparable_key,'*')             
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.segment_type_cd = ce.segment_type_cd        
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.segment_detail_value_1 = ce.segment_detail_value_1       
        ,e.segment_detail_value_2 = ce.segment_detail_value_2       
        ,e.segment_detail_value_3 = ce.segment_detail_value_3       
        ,e.segment_detail_value_4 = ce.segment_detail_value_4       
        ,e.segment_detail_value_5 = ce.segment_detail_value_5       
        ,e.segment_detail_value_6 = ce.segment_detail_value_6       
        ,e.segment_detail_value_7 = ce.segment_detail_value_7       
        ,e.segment_detail_value_8 = ce.segment_detail_value_8       
        ,e.segment_detail_value_9 = ce.segment_detail_value_9       
        ,e.segment_detail_value_10 = ce.segment_detail_value_10
        ,e.start_nd = ce.start_nd
        ,e.end_nd = ce.end_nd
        ,e.sequence_num = ce.sequence_num
        ,e.comparable_key = ce.comparable_key      
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name             
     Log Errors INTO Errlog_Segment_Dtl ('ELIG_SEGMENT_DTL_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_UPD';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS');

      COMMIT;
END ELIG_SEGMENT_DTL_UPD;

PROCEDURE UPDATE_D_CLIENT_ELIGIBILITY
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN

    EXECUTE IMMEDIATE 'TRUNCATE TABLE s_client_eligibility_stg';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE s_client_elig_prior_stg';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE d_client_eligibility';

    DELETE FROM Errlog_DClientElig WHERE ora_err_tag$ = 'UPDATE_D_CLIENT_ELIGIBILITY';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'UPDATE_D_CLIENT_ELIGIBILITY','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO s_client_eligibility_stg 
          (segment_type_cd
           ,client_id
           ,aid_category
           ,type_case
           ,coa
           ,sequence_id
           ,elig_segment_and_details_id
           ,me_start_date
           ,me_end_date
           ,me_start_nd
           ,me_end_nd
           ,close_reason
           ,last_activity
           ,approval_cd
           ,segment_create_date
           ,sequence_num
           ,comparable_key)
      SELECT esad.segment_type_cd,
      esad.client_id,
      esad.segment_detail_value_1 AS aid_category,
      esad.segment_detail_value_2 AS type_case,
      m.acute_coa AS coa,
      MIN(esad.segment_detail_value_5) AS SEQUENCE_ID,
      MAX(esad.ELIG_SEGMENT_AND_DETAILS_ID) AS ELIG_SEGMENT_AND_DETAILS_ID,
      MIN(esad.START_DATE) AS ME_START_DATE,
      MAX(esad.END_DATE) AS ME_END_DATE,
      MIN(esad.START_ND) AS ME_START_ND,
      MAX(esad.END_ND) AS ME_END_ND,
      MAX(esad.segment_detail_value_3) AS CLOSE_REASON,
      MAX(esad.segment_detail_value_6) AS LAST_ACTIVITY,
      MAX(esad.segment_detail_value_7) AS APPROVAL_CD,
      MIN(esad.segment_detail_value_8) AS SEGMENT_CREATE_DATE,
      MIN(esad.sequence_num) AS SEQUENCE_NUM,
      esad.comparable_key
    --FROM emrs_d_elig_segment_details esad
     FROM (SELECT * 
           FROM (SELECT esad.*,
                      RANK() OVER (PARTITION BY client_id,start_date,end_date,segment_detail_value_1,segment_detail_value_2 ORDER BY elig_segment_and_details_id DESC) rnk
                 FROM  emrs_d_elig_segment_details esad
                 WHERE segment_type_cd = 'ME') esad
           WHERE rnk = 1 ) esad    
       LEFT JOIN d_mvx_xwalk m ON (esad.segment_detail_value_1 = m.aid_category AND esad.segment_detail_value_2 = m.type_case)
     WHERE esad.segment_type_cd = 'ME'
     AND CASE WHEN esad.segment_detail_value_1 = '17' AND esad.segment_detail_value_2 = '095' AND esad.sequence_num <> 1 THEN 1 ELSE 0 END = 0
     GROUP BY esad.segment_type_cd,
      esad.client_id,
      esad.segment_detail_value_1,
      esad.segment_detail_value_2,
      m.acute_coa,
      esad.comparable_key   ;
      
    COMMIT;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO s_client_elig_prior_stg 
          (segment_type_cd
           ,client_id
           ,aid_category
           ,type_case
           ,coa
           ,sequence_id
           ,elig_segment_and_details_id
           ,me_start_date
           ,me_end_date
           ,me_start_nd
           ,me_end_nd
           ,close_reason
           ,last_activity
           ,approval_cd
           ,segment_create_date
           ,sequence_num
           ,comparable_key
           ,prior_start_date
           ,prior_end_date
           ,prior_coa
           ,prior_ac
           ,prior_tc
           ,prior_esad_id)  
    SELECT esad2.segment_type_cd,
          esad2.client_id,
          esad2.aid_category,
          esad2.type_case,          
          esad2.coa,
          esad2.sequence_id,          
          esad2.elig_segment_and_details_id,
          esad2.me_start_date,
          esad2.me_end_date,
          esad2.me_start_nd,
          esad2.me_end_nd,
          esad2.close_reason,        
          esad2.last_activity,
          esad2.approval_cd,
          esad2.segment_create_date,
          esad2.sequence_num,
          esad2.comparable_key,
          LEAD( esad2.me_start_date, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_start_date,
          LEAD( esad2.me_end_date, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_end_date,
          LEAD( esad2.coa, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_coa,   --priors are only populated when there is less than 95 days between the last elig seg and the start of the current elig seg
          LEAD( esad2.aid_category, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_ac,
          LEAD( esad2.type_case, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_tc,
          LEAD( esad2.elig_segment_and_details_id, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_esad_id
    FROM s_client_eligibility_stg esad2;

    COMMIT;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_CLIENT_ELIGIBILITY 
          (elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            me_start_date,
            me_end_date,
            me_start_nd,
            me_end_nd,
            aid_category,
            type_case,
            ac_tc,
            coa,
            prior_start_date,
            prior_end_date,
            prior_coa,
            prior_ac,
            prior_tc,
            prior_esad_id,
            pregnancy_flag,
            close_reason,
            sequence_id,
            last_activity,
            approval_cd,
            segment_create_date,
            sequence_num,
            comparable_key)
    SELECT esad3.elig_segment_and_details_id ,
          esad3.segment_type_cd ,
          esad3.client_id ,
          esad3.me_start_date ,
          esad3.me_end_date ,
          esad3.me_start_nd ,
          esad3.me_end_nd ,
          esad3.aid_category ,
          esad3.type_case ,
          esad3.aid_category || '/' || esad3.type_case AS ac_tc,
          esad3.coa ,
          esad3.prior_start_date AS prior_start_date,
          esad3.prior_end_date AS prior_end_date,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_coa ELSE NULL END AS prior_coa,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_ac ELSE NULL END AS prior_ac,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_tc ELSE NULL END AS prior_tc,
          esad3.prior_esad_id ,
          CASE WHEN esad3.AID_CATEGORY = '03' and esad3.TYPE_CASE in ('013','053','104','127') THEN 1 ELSE 0 END AS pregnancy_flag,
          esad3.close_reason ,
          esad3.sequence_id ,
          esad3.last_activity ,
          esad3.approval_cd ,
          esad3.segment_create_date ,
          RANK() OVER(PARTITION BY esad3.CLIENT_ID ORDER BY esad3.sequence_num) AS sequence_num ,
          esad3.comparable_key 
    FROM s_client_elig_prior_stg esad3
    LOG Errors INTO Errlog_DClientElig ('UPDATE_D_CLIENT_ELIGIBILITY') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.UPDATE_D_CLIENT_ELIGIBILITY', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CLIENT_ELIGIBILITY', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_DClientElig
     WHERE Ora_Err_Tag$ = 'UPDATE_D_CLIENT_ELIGIBILITY';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.UPDATE_D_CLIENT_ELIGIBILITY', 1, v_desc, v_code, 'D_CLIENT_ELIGIBILITY');

      COMMIT;

END UPDATE_D_CLIENT_ELIGIBILITY;

PROCEDURE ELIG_SEGMENT_DTL_COUNT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_COUNT_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    MERGE 
    INTO  emrs_s_elig_segment_details_count_stg e
    USING (SELECT dp.record_date, dp.segment_detail_record_count, dp.segment_type_cd,'Y' load_data_flag,dp.min_elig_segment_and_details_id,dp.max_elig_segment_and_details_id
          FROM emrs_d_elig_segment_details_dpcount dp
             LEFT JOIN emrs_s_elig_segment_details_count_stg s ON dp.record_date = s.record_date AND dp.segment_type_cd = s.segment_type_cd
          WHERE dp.segment_detail_record_count > s.segment_detail_record_count
            OR s.record_date IS NULL) ce ON (e.record_date = ce.record_date AND e.segment_type_cd = ce.segment_type_cd)
    WHEN MATCHED THEN UPDATE
     SET load_data_flag = ce.load_data_flag
    WHEN NOT MATCHED THEN INSERT (e.record_date,e.segment_type_cd,e.segment_detail_record_count,e.min_elig_segment_and_details_id,e.max_elig_segment_and_details_id,e.load_data_flag)
      VALUES(ce.record_date,ce.segment_type_cd,ce.segment_detail_record_count,ce.min_elig_segment_and_details_id,ce.max_elig_segment_and_details_id,ce.load_data_flag);
    
    /*MERGE 
    INTO  emrs_d_elig_segment_details_dpcount e
    USING (SELECT s.record_date, s.segment_detail_record_count,s.min_elig_segment_and_details_id,s.max_elig_segment_and_details_id
          FROM emrs_d_elig_segment_details_dpcount dp
             JOIN emrs_s_elig_segment_details_count_stg s ON dp.record_date = s.record_date
          WHERE dp.segment_detail_record_count <> s.segment_detail_record_count) ce ON (e.record_date = ce.record_date)
    WHEN MATCHED THEN UPDATE
    SET e.segment_detail_record_count = ce.segment_detail_record_count
        --,e.min_elig_segment_and_details_id = ce.min_elig_segment_and_details_id
        --,e.max_elig_segment_and_details_id = ce.max_elig_segment_and_details_id
        ;*/
        
    COMMIT;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;


EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_COUNT_UPD', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT');

      COMMIT;
END ELIG_SEGMENT_DTL_COUNT_UPD;

PROCEDURE ELIG_SEGMENT_DTL_DEL
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_del_cnt number;
    v_err_cnt number;

BEGIN

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_DEL','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    DELETE FROM emrs_d_elig_segment_details d
    WHERE elig_segment_and_details_id IN(SELECT elig_segment_and_details_id from emrs_s_segment_detail_stg s);

    v_del_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_del_cnt
         , PROCESSED_COUNT = v_del_cnt         
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_DEL', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS');

      COMMIT;
END ELIG_SEGMENT_DTL_DEL;

PROCEDURE ELIG_SEGMENT_DTL_INS_ELIG
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Segment_Dtl_Elig WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS_ELIG';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS_ELIG','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS_ELIG 
          ( elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by                 
    FROM emrs_s_segment_detail_elig_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details_elig ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl_Elig ('ELIG_SEGMENT_DTL_INS_ELIG') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_ELIG', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_ELIG', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Elig
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS_ELIG';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_ELIG', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_ELIG');

      COMMIT;
END ELIG_SEGMENT_DTL_INS_ELIG;

PROCEDURE ELIG_SEGMENT_DTL_UPD_ELIG
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Elig WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_UPD_ELIG';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_UPD_ELIG','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ELIG_SEGMENT_DETAILS_ELIG e
   USING (SELECT tmp.*
          FROM (SELECT
                  elig_segment_and_details_id,
                  segment_type_cd,
                  client_id,
                  start_date,
                  end_date,
                  segment_detail_value_1,
                  segment_detail_value_2,
                  segment_detail_value_3,
                  segment_detail_value_4,
                  segment_detail_value_5,
                  segment_detail_value_6,
                  segment_detail_value_7,
                  segment_detail_value_8,
                  segment_detail_value_9,
                  segment_detail_value_10,
                  start_nd,
                  end_nd,
                  sequence_num,
                  comparable_key,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_segment_detail_elig_stg e                
              ) tmp
          JOIN emrs_d_elig_segment_details_elig t ON tmp.elig_segment_and_details_id = t.elig_segment_and_details_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.segment_type_cd,'*') != COALESCE(tmp.segment_type_cd,'*')           
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.segment_detail_value_1,'*') != COALESCE(tmp.segment_detail_value_1,'*')            
            OR COALESCE(t.segment_detail_value_2,'*') != COALESCE(tmp.segment_detail_value_2,'*')            
            OR COALESCE(t.segment_detail_value_3,'*') != COALESCE(tmp.segment_detail_value_3,'*')            
            OR COALESCE(t.segment_detail_value_4,'*') != COALESCE(tmp.segment_detail_value_4,'*')            
            OR COALESCE(t.segment_detail_value_5,'*') != COALESCE(tmp.segment_detail_value_5,'*')            
            OR COALESCE(t.segment_detail_value_6,'*') != COALESCE(tmp.segment_detail_value_6,'*')            
            OR COALESCE(t.segment_detail_value_7,'*') != COALESCE(tmp.segment_detail_value_7,'*')            
            OR COALESCE(t.segment_detail_value_8,'*') != COALESCE(tmp.segment_detail_value_8,'*')            
            OR COALESCE(t.segment_detail_value_9,'*') != COALESCE(tmp.segment_detail_value_9,'*')            
            OR COALESCE(t.segment_detail_value_10,'*') != COALESCE(tmp.segment_detail_value_10,'*')            
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.sequence_num,0) != COALESCE(tmp.sequence_num,0)
            OR COALESCE(t.comparable_key,'*') != COALESCE(tmp.comparable_key,'*')             
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.segment_type_cd = ce.segment_type_cd        
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.segment_detail_value_1 = ce.segment_detail_value_1       
        ,e.segment_detail_value_2 = ce.segment_detail_value_2       
        ,e.segment_detail_value_3 = ce.segment_detail_value_3       
        ,e.segment_detail_value_4 = ce.segment_detail_value_4       
        ,e.segment_detail_value_5 = ce.segment_detail_value_5       
        ,e.segment_detail_value_6 = ce.segment_detail_value_6       
        ,e.segment_detail_value_7 = ce.segment_detail_value_7       
        ,e.segment_detail_value_8 = ce.segment_detail_value_8       
        ,e.segment_detail_value_9 = ce.segment_detail_value_9       
        ,e.segment_detail_value_10 = ce.segment_detail_value_10
        ,e.start_nd = ce.start_nd
        ,e.end_nd = ce.end_nd
        ,e.sequence_num = ce.sequence_num
        ,e.comparable_key = ce.comparable_key      
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name             
     Log Errors INTO Errlog_Segment_Dtl_Elig ('ELIG_SEGMENT_DTL_UPD_ELIG') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_ELIG', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_ELIG', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Elig
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_UPD_ELIG';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_ELIG', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_ELIG');

      COMMIT;
END ELIG_SEGMENT_DTL_UPD_ELIG;

PROCEDURE ELIG_SEGMENT_DTL_INS_OHC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    v_reload_day VARCHAR2(1);
    v_ohc_count number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Ohc WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS_OHC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS_OHC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
    
    BEGIN
      SELECT CASE WHEN TO_CHAR(sysdate,'d') = value THEN 'Y' ELSE 'N' END
      INTO v_reload_day
      FROM corp_etl_control
      WHERE name = 'EMRS_OHCSEGMENTDTL_RELOAD_DAY';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_reload_day := 'N';
    END;
    
    IF v_reload_day = 'Y' THEN
    --create temp table 
      BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_ohc_'||TO_CHAR(sysdate,'yyyymmdd');
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      EXECUTE IMMEDIATE 'CREATE TABLE emrs_s_elig_segment_dtl_ohc_'||TO_CHAR(sysdate,'yyyymmdd')||' AS SELECT * FROM emrs_d_elig_segment_details_ohc';
      EXECUTE IMMEDIATE 'TRUNCATE TABLE emrs_d_elig_segment_details_ohc';    
    END IF;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS_OHC
          ( elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by                 
    FROM emrs_s_segment_detail_ohc_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details_ohc ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl_Ohc ('ELIG_SEGMENT_DTL_INS_OHC') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_OHC', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_OHC', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Ohc
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS_OHC';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    --drop temp table
    SELECT COUNT(*)
    INTO v_ohc_count
    FROM emrs_d_elig_segment_details_ohc;
   
    IF v_ohc_count > 0 THEN   
      EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_ohc_'||TO_CHAR(sysdate,'yyyymmdd');
      dbms_stats.gather_table_stats('MAXDAT_LAEB','EMRS_D_ELIG_SEGMENT_DETAILS_OHC');
    END IF; 

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_OHC', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_OHC');

      COMMIT;
END ELIG_SEGMENT_DTL_INS_OHC;

PROCEDURE ELIG_SEGMENT_DTL_UPD_OHC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Ohc WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_UPD_OHC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_UPD_OHC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ELIG_SEGMENT_DETAILS_OHC e
   USING (SELECT tmp.*
          FROM (SELECT
                  elig_segment_and_details_id,
                  segment_type_cd,
                  client_id,
                  start_date,
                  end_date,
                  segment_detail_value_1,
                  segment_detail_value_2,
                  segment_detail_value_3,
                  segment_detail_value_4,
                  segment_detail_value_5,
                  segment_detail_value_6,
                  segment_detail_value_7,
                  segment_detail_value_8,
                  segment_detail_value_9,
                  segment_detail_value_10,
                  start_nd,
                  end_nd,
                  sequence_num,
                  comparable_key,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_segment_detail_ohc_stg e                
              ) tmp
          JOIN emrs_d_elig_segment_details_ohc t ON tmp.elig_segment_and_details_id = t.elig_segment_and_details_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.segment_type_cd,'*') != COALESCE(tmp.segment_type_cd,'*')           
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.segment_detail_value_1,'*') != COALESCE(tmp.segment_detail_value_1,'*')            
            OR COALESCE(t.segment_detail_value_2,'*') != COALESCE(tmp.segment_detail_value_2,'*')            
            OR COALESCE(t.segment_detail_value_3,'*') != COALESCE(tmp.segment_detail_value_3,'*')            
            OR COALESCE(t.segment_detail_value_4,'*') != COALESCE(tmp.segment_detail_value_4,'*')            
            OR COALESCE(t.segment_detail_value_5,'*') != COALESCE(tmp.segment_detail_value_5,'*')            
            OR COALESCE(t.segment_detail_value_6,'*') != COALESCE(tmp.segment_detail_value_6,'*')            
            OR COALESCE(t.segment_detail_value_7,'*') != COALESCE(tmp.segment_detail_value_7,'*')            
            OR COALESCE(t.segment_detail_value_8,'*') != COALESCE(tmp.segment_detail_value_8,'*')            
            OR COALESCE(t.segment_detail_value_9,'*') != COALESCE(tmp.segment_detail_value_9,'*')            
            OR COALESCE(t.segment_detail_value_10,'*') != COALESCE(tmp.segment_detail_value_10,'*')            
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.sequence_num,0) != COALESCE(tmp.sequence_num,0)
            OR COALESCE(t.comparable_key,'*') != COALESCE(tmp.comparable_key,'*')             
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.segment_type_cd = ce.segment_type_cd        
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.segment_detail_value_1 = ce.segment_detail_value_1       
        ,e.segment_detail_value_2 = ce.segment_detail_value_2       
        ,e.segment_detail_value_3 = ce.segment_detail_value_3       
        ,e.segment_detail_value_4 = ce.segment_detail_value_4       
        ,e.segment_detail_value_5 = ce.segment_detail_value_5       
        ,e.segment_detail_value_6 = ce.segment_detail_value_6       
        ,e.segment_detail_value_7 = ce.segment_detail_value_7       
        ,e.segment_detail_value_8 = ce.segment_detail_value_8       
        ,e.segment_detail_value_9 = ce.segment_detail_value_9       
        ,e.segment_detail_value_10 = ce.segment_detail_value_10
        ,e.start_nd = ce.start_nd
        ,e.end_nd = ce.end_nd
        ,e.sequence_num = ce.sequence_num
        ,e.comparable_key = ce.comparable_key      
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name             
     Log Errors INTO Errlog_Segment_Dtl_Ohc ('ELIG_SEGMENT_DTL_UPD_OHC') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_OHC', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_OHC', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Ohc
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_UPD_OHC';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_OHC', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_OHC');

      COMMIT;
END ELIG_SEGMENT_DTL_UPD_OHC;

PROCEDURE ELIG_SEGMENT_DTL_INS_LTC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    v_ltc_count NUMBER;
    v_reload_data VARCHAR2(1);
    v_reload_day VARCHAR2(1);
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Ltc WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS_LTC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS_LTC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    BEGIN
      SELECT value
      INTO v_reload_data
      FROM corp_etl_control
      WHERE name = 'EMRS_LTC_SEGMENTDTL_TRUNC_INS_YN';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_reload_data := 'N';
    END;

    BEGIN
      SELECT CASE WHEN TO_CHAR(sysdate,'d') = value THEN 'Y' ELSE 'N' END
      INTO v_reload_day
      FROM corp_etl_control
      WHERE name = 'EMRS_LTCSEGMENTDTL_RELOAD_DAY';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_reload_day := 'N';
    END;
    
    IF v_reload_data = 'Y' OR v_reload_day = 'Y' THEN
    --create temp table 
      BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_ltc_'||TO_CHAR(sysdate,'yyyymmdd');
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      EXECUTE IMMEDIATE 'CREATE TABLE emrs_s_elig_segment_dtl_ltc_'||TO_CHAR(sysdate,'yyyymmdd')||' AS SELECT * FROM emrs_d_elig_segment_details_ltc';
      EXECUTE IMMEDIATE 'TRUNCATE TABLE emrs_d_elig_segment_details_ltc';    
    END IF;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS_LTC
          ( elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name)
    SELECT elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by                 
    FROM emrs_s_segment_detail_ltc_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details_ltc ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl_Ltc ('ELIG_SEGMENT_DTL_INS_LTC') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_LTC', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_LTC', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Ltc
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS_LTC';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    --drop temp table
    SELECT COUNT(*)
    INTO v_ltc_count
    FROM emrs_d_elig_segment_details_ltc;
   
    IF v_ltc_count > 0 THEN   
      EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_ltc_'||TO_CHAR(sysdate,'yyyymmdd');
      dbms_stats.gather_table_stats('MAXDAT_LAEB','EMRS_D_ELIG_SEGMENT_DETAILS_LTC');
    END IF; 


EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_LTC', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_LTC');
      COMMIT;
      
END ELIG_SEGMENT_DTL_INS_LTC;

PROCEDURE ELIG_SEGMENT_DTL_UPD_LTC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Ltc WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_UPD_LTC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_UPD_LTC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_ELIG_SEGMENT_DETAILS_LTC e
   USING (SELECT tmp.*
          FROM (SELECT
                  elig_segment_and_details_id,
                  segment_type_cd,
                  client_id,
                  start_date,
                  end_date,
                  segment_detail_value_1,
                  segment_detail_value_2,
                  segment_detail_value_3,
                  segment_detail_value_4,
                  segment_detail_value_5,
                  segment_detail_value_6,
                  segment_detail_value_7,
                  segment_detail_value_8,
                  segment_detail_value_9,
                  segment_detail_value_10,
                  start_nd,
                  end_nd,
                  sequence_num,
                  comparable_key,
                  update_ts modified_date,
                  updated_by modified_name,
                  TO_CHAR(update_ts,'HH24MI') modified_time,
                  create_ts record_date,
                  TO_CHAR(create_ts,'HH24MI') record_time,
                  created_by record_name
                FROM emrs_s_segment_detail_ltc_stg e                
              ) tmp
          JOIN emrs_d_elig_segment_details_ltc t ON tmp.elig_segment_and_details_id = t.elig_segment_and_details_id
          WHERE  COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0)
            OR COALESCE(t.segment_type_cd,'*') != COALESCE(tmp.segment_type_cd,'*')           
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.segment_detail_value_1,'*') != COALESCE(tmp.segment_detail_value_1,'*')            
            OR COALESCE(t.segment_detail_value_2,'*') != COALESCE(tmp.segment_detail_value_2,'*')            
            OR COALESCE(t.segment_detail_value_3,'*') != COALESCE(tmp.segment_detail_value_3,'*')            
            OR COALESCE(t.segment_detail_value_4,'*') != COALESCE(tmp.segment_detail_value_4,'*')            
            OR COALESCE(t.segment_detail_value_5,'*') != COALESCE(tmp.segment_detail_value_5,'*')            
            OR COALESCE(t.segment_detail_value_6,'*') != COALESCE(tmp.segment_detail_value_6,'*')            
            OR COALESCE(t.segment_detail_value_7,'*') != COALESCE(tmp.segment_detail_value_7,'*')            
            OR COALESCE(t.segment_detail_value_8,'*') != COALESCE(tmp.segment_detail_value_8,'*')            
            OR COALESCE(t.segment_detail_value_9,'*') != COALESCE(tmp.segment_detail_value_9,'*')            
            OR COALESCE(t.segment_detail_value_10,'*') != COALESCE(tmp.segment_detail_value_10,'*')            
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.sequence_num,0) != COALESCE(tmp.sequence_num,0)
            OR COALESCE(t.comparable_key,'*') != COALESCE(tmp.comparable_key,'*')             
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.modified_time,'*') != COALESCE(tmp.modified_time,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
             OR COALESCE(t.record_time,'*') != COALESCE(tmp.record_time,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')            
          ) ce ON (e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
    WHEN MATCHED THEN UPDATE
     SET e.client_id = ce.client_id
        ,e.segment_type_cd = ce.segment_type_cd        
        ,e.start_date = ce.start_date
        ,e.end_date = ce.end_date
        ,e.segment_detail_value_1 = ce.segment_detail_value_1       
        ,e.segment_detail_value_2 = ce.segment_detail_value_2       
        ,e.segment_detail_value_3 = ce.segment_detail_value_3       
        ,e.segment_detail_value_4 = ce.segment_detail_value_4       
        ,e.segment_detail_value_5 = ce.segment_detail_value_5       
        ,e.segment_detail_value_6 = ce.segment_detail_value_6       
        ,e.segment_detail_value_7 = ce.segment_detail_value_7       
        ,e.segment_detail_value_8 = ce.segment_detail_value_8       
        ,e.segment_detail_value_9 = ce.segment_detail_value_9       
        ,e.segment_detail_value_10 = ce.segment_detail_value_10
        ,e.start_nd = ce.start_nd
        ,e.end_nd = ce.end_nd
        ,e.sequence_num = ce.sequence_num
        ,e.comparable_key = ce.comparable_key      
        ,e.modified_date = ce.modified_date
        ,e.modified_name = ce.modified_name
        ,e.modified_time = ce.modified_time
        ,e.record_date = ce.record_date
        ,e.record_time = ce.record_time
        ,e.record_name = ce.record_name             
     Log Errors INTO Errlog_Segment_Dtl_Ltc ('ELIG_SEGMENT_DTL_UPD_LTC') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_LTC', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_LTC', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Ltc
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_UPD_LTC';

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
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_UPD_LTC', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_LTC');

      COMMIT;
END ELIG_SEGMENT_DTL_UPD_LTC;

PROCEDURE ELIG_SEGMENT_DTL_INS_MI
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    v_mi_count number;    
    v_bak_count number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Mi WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS_MI';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS_MI','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    --create temp table 
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_mi_'||TO_CHAR(sysdate,'yyyymmdd');
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    EXECUTE IMMEDIATE 'CREATE TABLE emrs_s_elig_segment_dtl_mi_'||TO_CHAR(sysdate,'yyyymmdd')||' AS SELECT * FROM emrs_d_elig_segment_details_mi mi WHERE NOT EXISTS(SELECT 1 FROM emrs_s_segment_detail_mi_stg stg WHERE mi.client_id = stg.client_id)';    
    --rename existing table
    EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_MI_BAK_'||TO_CHAR(sysdate,'yyyymmdd');    
    --rename new table
    EXECUTE IMMEDIATE 'ALTER TABLE emrs_s_elig_segment_dtl_mi_'||TO_CHAR(sysdate,'yyyymmdd')||' RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_MI';
    EXECUTE IMMEDIATE 'GRANT SELECT ON EMRS_D_ELIG_SEGMENT_DETAILS_MI TO MAXDAT_LAEB_READ_ONLY';
    
    EXECUTE IMMEDIATE 'ALTER VIEW LTC_MEMBER_ENROLLMENT_SV COMPILE';
    EXECUTE IMMEDIATE 'ALTER VIEW EMRS_D_CLIENT_CCM_SV COMPILE';
    EXECUTE IMMEDIATE 'ALTER VIEW EMRS_D_CLIENT_ELIG_OUTCOME_SV COMPILE';
    EXECUTE IMMEDIATE 'ALTER VIEW EMRS_D_CLIENT_ELIGIBILITY_SV COMPILE';
    
    --truncate table
    --EXECUTE IMMEDIATE 'TRUNCATE TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI';   
   
   --insert back records
   -- EXECUTE IMMEDIATE 'INSERT /*+ Enable_Parallel_Dml Parallel */
   --                      INTO emrs_d_elig_segment_details_mi( elig_segment_and_details_id,segment_type_cd,client_id,start_date,end_date,segment_detail_value_1,segment_detail_value_2,segment_detail_value_3,
   --                                    segment_detail_value_4,segment_detail_value_5,segment_detail_value_6,segment_detail_value_7,segment_detail_value_8,segment_detail_value_9,segment_detail_value_10,
   --                                    start_nd,end_nd,sequence_num,comparable_key,modified_date,modified_name,modified_time,record_date,record_time,record_name) 
   --                      SELECT elig_segment_and_details_id,segment_type_cd,client_id,start_date,end_date,segment_detail_value_1,segment_detail_value_2,segment_detail_value_3,
   --                                    segment_detail_value_4,segment_detail_value_5,segment_detail_value_6,segment_detail_value_7,segment_detail_value_8,segment_detail_value_9,segment_detail_value_10,
   --                                    start_nd,end_nd,sequence_num,comparable_key,modified_date,modified_name,modified_time,record_date,record_time,record_name
   --                      FROM emrs_s_elig_segment_dtl_mi_'||TO_CHAR(sysdate,'yyyymmdd');
   -- EXECUTE IMMEDIATE 'COMMIT';

   --SELECT COUNT(*)
   --INTO v_mi_count
   --FROM emrs_d_elig_segment_details_mi;
   
   --IF v_mi_count > 0 THEN   
     -- EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_mi_'||TO_CHAR(sysdate,'yyyymmdd');
   --END IF;   
   
   --insert new records
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS_MI
          ( dp_segment_detail_mi_id,
            elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name,
            updated_by,
            created_by,
            date_created,
            date_updated)
    SELECT dp_segment_detail_mi_id,
            elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by,
            dp_updated_by,
            dp_created_by,
            dp_date_created,
            dp_date_updated
    FROM emrs_s_segment_detail_mi_stg e     
    --WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details_ltc ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl_Mi ('ELIG_SEGMENT_DTL_INS_MI') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_MI', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_MI', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Mi
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS_MI';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;
    
    --drop renamed existing table
    SELECT COUNT(*)
    INTO v_mi_count
    FROM emrs_d_elig_segment_details_mi;
   
    IF v_mi_count > 0 THEN   
      EXECUTE IMMEDIATE 'DROP TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI_BAK_'||TO_CHAR(sysdate,'yyyymmdd');
    END IF; 

    --build indexes        
    EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI add constraint SEGMENTDTLMI_PK primary key(dp_segment_detail_mi_id) USING INDEX TABLESPACE MAXDAT_LAEB_DATA';    
    EXECUTE IMMEDIATE 'CREATE INDEX IDX1_SEGMENTDTLNUMMI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (elig_segment_and_details_id) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX2_SEGMENTDTLCLNUMMI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (client_id) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX3_SEGMENTDTLVAL1MI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (SEGMENT_DETAIL_VALUE_1) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX4_SEGMENTDTLVAL2MI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (SEGMENT_DETAIL_VALUE_2) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX5_SEGMENTTYPEMI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (SEGMENT_TYPE_CD) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX6_ENDNDMI ON EMRS_D_ELIG_SEGMENT_DETAILS_MI (END_ND) TABLESPACE MAXDAT_LAEB_DATA';
    
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_MI', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_MI');
      
      COMMIT;
      BEGIN
        --check if backup table got created
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM EMRS_D_ELIG_SEGMENT_DETAILS_MI_BAK_'||TO_CHAR(sysdate,'yyyymmdd') INTO v_bak_count;
      EXCEPTION
        WHEN OTHERS THEN
          v_bak_count := 0;
      END;    
      IF v_bak_count > 0 AND v_mi_count = 0 THEN
        --restore old data
        EXECUTE IMMEDIATE 'DROP TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI';
        EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_MI_BAK_'||TO_CHAR(sysdate,'yyyymmdd')||' RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_MI';   
      END IF;
END ELIG_SEGMENT_DTL_INS_MI;

PROCEDURE ELIG_SEGMENT_DTL_INS_ME
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
    v_me_count number;
    v_bak_count number;
BEGIN

    DELETE FROM Errlog_Segment_Dtl_Me WHERE ora_err_tag$ = 'ELIG_SEGMENT_DTL_INS_ME';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ELIG_SEGMENT_DTL_INS_ME','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    --create temp table 
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_me_'||TO_CHAR(sysdate,'yyyymmdd');
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    EXECUTE IMMEDIATE 'CREATE TABLE emrs_s_elig_segment_dtl_me_'||TO_CHAR(sysdate,'yyyymmdd')||' AS SELECT * FROM emrs_d_elig_segment_details_me me WHERE NOT EXISTS(SELECT 1 FROM emrs_s_segment_detail_me_stg stg WHERE me.client_id = stg.client_id)';    
    --rename existing table
    EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_ME_BAK_'||TO_CHAR(sysdate,'yyyymmdd');    
    --rename new table
    EXECUTE IMMEDIATE 'ALTER TABLE emrs_s_elig_segment_dtl_me_'||TO_CHAR(sysdate,'yyyymmdd')||' RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_ME';
    EXECUTE IMMEDIATE 'GRANT SELECT ON EMRS_D_ELIG_SEGMENT_DETAILS_ME TO MAXDAT_LAEB_READ_ONLY';

    --truncate table
    --EXECUTE IMMEDIATE 'TRUNCATE TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME';   
   
   --insert back records
    --EXECUTE IMMEDIATE 'INSERT /*+ Enable_Parallel_Dml Parallel */
    --                     INTO emrs_d_elig_segment_details_me( elig_segment_and_details_id,segment_type_cd,client_id,start_date,end_date,segment_detail_value_1,segment_detail_value_2,segment_detail_value_3,
    --                                   segment_detail_value_4,segment_detail_value_5,segment_detail_value_6,segment_detail_value_7,segment_detail_value_8,segment_detail_value_9,segment_detail_value_10,
    --                                   start_nd,end_nd,sequence_num,comparable_key,modified_date,modified_name,modified_time,record_date,record_time,record_name) 
    --                     SELECT elig_segment_and_details_id,segment_type_cd,client_id,start_date,end_date,segment_detail_value_1,segment_detail_value_2,segment_detail_value_3,
    --                                   segment_detail_value_4,segment_detail_value_5,segment_detail_value_6,segment_detail_value_7,segment_detail_value_8,segment_detail_value_9,segment_detail_value_10,
    --                                   start_nd,end_nd,sequence_num,comparable_key,modified_date,modified_name,modified_time,record_date,record_time,record_name
    --                     FROM emrs_s_elig_segment_dtl_me_'||TO_CHAR(sysdate,'yyyymmdd');
    --EXECUTE IMMEDIATE 'COMMIT';

   --SELECT COUNT(*)
   --INTO v_me_count
   --FROM emrs_d_elig_segment_details_me;
   
   --IF v_me_count > 0 THEN   
     -- EXECUTE IMMEDIATE 'DROP TABLE emrs_s_elig_segment_dtl_me_'||TO_CHAR(sysdate,'yyyymmdd');
   --END IF;   
   
   --insert new records
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_ELIG_SEGMENT_DETAILS_ME
          ( dp_segment_detail_me_id,
            elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            modified_date,
            modified_name,
            modified_time,
            record_date,
            record_time,
            record_name,
            date_created,
            date_updated,
            created_by,
            updated_by)
    SELECT dp_segment_detail_me_id,
            elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            start_date,
            end_date,
            segment_detail_value_1,
            segment_detail_value_2,
            segment_detail_value_3,
            segment_detail_value_4,
            segment_detail_value_5,
            segment_detail_value_6,
            segment_detail_value_7,
            segment_detail_value_8,
            segment_detail_value_9,
            segment_detail_value_10,
            start_nd,
            end_nd,
            sequence_num,
            comparable_key,
            update_ts,
            updated_by,
            TO_CHAR(update_ts,'HH24MI'),
            create_ts,
            TO_CHAR(create_ts,'HH24MI'),
            created_by,
            dp_date_created,
            dp_date_updated,
            dp_created_by,
            dp_updated_by
    FROM emrs_s_segment_detail_me_stg e     
    --WHERE NOT EXISTS(SELECT 1 FROM emrs_d_elig_segment_details_ltc ce WHERE e.elig_segment_and_details_id = ce.elig_segment_and_details_id)
     LOG Errors INTO Errlog_Segment_Dtl_Me ('ELIG_SEGMENT_DTL_INS_ME') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_ME', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_ELIG_SEGMENT_DETAILS_ME', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_Segment_Dtl_Me
     WHERE Ora_Err_Tag$ = 'ELIG_SEGMENT_DTL_INS_ME';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;
    
    --drop renamed existing table
    SELECT COUNT(*)
    INTO v_me_count
    FROM emrs_d_elig_segment_details_me;
   
    IF v_me_count > 0 THEN   
      EXECUTE IMMEDIATE 'DROP TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME_BAK_'||TO_CHAR(sysdate,'yyyymmdd');    
    END IF; 
    --build indexes        
    EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME add constraint SEGMENTDTLME_PK primary key(dp_segment_detail_me_id) USING INDEX TABLESPACE MAXDAT_LAEB_DATA';    
    EXECUTE IMMEDIATE 'CREATE INDEX IDX1_SEGMENTDTLNUMME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (elig_segment_and_details_id) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX2_SEGMENTDTLCLNUMME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (client_id) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX3_SEGMENTDTLVAL1ME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (SEGMENT_DETAIL_VALUE_1) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX4_SEGMENTDTLVAL2ME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (SEGMENT_DETAIL_VALUE_2) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX5_SEGMENTTYPEME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (SEGMENT_TYPE_CD) TABLESPACE MAXDAT_LAEB_DATA';
    EXECUTE IMMEDIATE 'CREATE INDEX IDX6_ENDNDME ON EMRS_D_ELIG_SEGMENT_DETAILS_ME (END_ND) TABLESPACE MAXDAT_LAEB_DATA';
        
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.ELIG_SEGMENT_DTL_INS_ME', 1, v_desc, v_code, 'EMRS_D_ELIG_SEGMENT_DETAILS_ME');

      COMMIT;
      
      BEGIN
        --check if backup table got created
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM EMRS_D_ELIG_SEGMENT_DETAILS_ME_BAK_'||TO_CHAR(sysdate,'yyyymmdd') INTO v_bak_count;
      EXCEPTION
        WHEN OTHERS THEN
          v_bak_count := 0;
      END;    
      IF v_bak_count > 0 AND v_me_count = 0 THEN
        --restore old data
        EXECUTE IMMEDIATE 'DROP TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME';
        EXECUTE IMMEDIATE 'ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_ME_BAK_'||TO_CHAR(sysdate,'yyyymmdd')||' RENAME TO EMRS_D_ELIG_SEGMENT_DETAILS_ME';
      END IF;
      
END ELIG_SEGMENT_DTL_INS_ME;

PROCEDURE UPDATE_D_CLIENT_ELIGIBILITY_ME
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN

    EXECUTE IMMEDIATE 'TRUNCATE TABLE s_client_eligibility_me_stg';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE s_client_elig_prior_me_stg';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE d_client_eligibility_me';

    DELETE FROM Errlog_DClientElig_Me WHERE ora_err_tag$ = 'UPDATE_D_CLIENT_ELIGIBILITY_ME';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'UPDATE_D_CLIENT_ELIGIBILITY_ME','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO s_client_eligibility_me_stg 
          (segment_type_cd
           ,client_id
           ,aid_category
           ,type_case
           ,coa
           ,sequence_id
           ,elig_segment_and_details_id
           ,me_start_date
           ,me_end_date
           ,me_start_nd
           ,me_end_nd
           ,close_reason
           ,last_activity
           ,approval_cd
           ,segment_create_date
           ,sequence_num
           ,comparable_key)
      SELECT esad.segment_type_cd,
      esad.client_id,
      esad.segment_detail_value_1 AS aid_category,
      esad.segment_detail_value_2 AS type_case,
      m.acute_coa AS coa,
      MIN(esad.segment_detail_value_5) AS SEQUENCE_ID,
      MAX(esad.ELIG_SEGMENT_AND_DETAILS_ID) AS ELIG_SEGMENT_AND_DETAILS_ID,
      MIN(esad.START_DATE) AS ME_START_DATE,
      MAX(esad.END_DATE) AS ME_END_DATE,
      MIN(esad.START_ND) AS ME_START_ND,
      MAX(esad.END_ND) AS ME_END_ND,
      MAX(esad.segment_detail_value_3) AS CLOSE_REASON,
      MAX(esad.segment_detail_value_6) AS LAST_ACTIVITY,
      MAX(esad.segment_detail_value_7) AS APPROVAL_CD,
      MIN(esad.segment_detail_value_8) AS SEGMENT_CREATE_DATE,
      MIN(esad.sequence_num) AS SEQUENCE_NUM,
      esad.comparable_key
    --FROM emrs_d_elig_segment_details esad
     FROM emrs_d_elig_segment_details_me esad    
       LEFT JOIN d_mvx_xwalk m ON (esad.segment_detail_value_1 = m.aid_category AND esad.segment_detail_value_2 = m.type_case)
     WHERE esad.segment_type_cd = 'ME'
     AND CASE WHEN esad.segment_detail_value_1 = '17' AND esad.segment_detail_value_2 = '095' AND esad.sequence_num <> 1 THEN 1 ELSE 0 END = 0
     GROUP BY esad.segment_type_cd,
      esad.client_id,
      esad.segment_detail_value_1,
      esad.segment_detail_value_2,
      m.acute_coa,
      esad.comparable_key   ;
      
    COMMIT;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO s_client_elig_prior_me_stg 
          (segment_type_cd
           ,client_id
           ,aid_category
           ,type_case
           ,coa
           ,sequence_id
           ,elig_segment_and_details_id
           ,me_start_date
           ,me_end_date
           ,me_start_nd
           ,me_end_nd
           ,close_reason
           ,last_activity
           ,approval_cd
           ,segment_create_date
           ,sequence_num
           ,comparable_key
           ,prior_start_date
           ,prior_end_date
           ,prior_coa
           ,prior_ac
           ,prior_tc
           ,prior_esad_id)  
    SELECT esad2.segment_type_cd,
          esad2.client_id,
          esad2.aid_category,
          esad2.type_case,          
          esad2.coa,
          esad2.sequence_id,          
          esad2.elig_segment_and_details_id,
          esad2.me_start_date,
          esad2.me_end_date,
          esad2.me_start_nd,
          esad2.me_end_nd,
          esad2.close_reason,        
          esad2.last_activity,
          esad2.approval_cd,
          esad2.segment_create_date,
          esad2.sequence_num,
          esad2.comparable_key,
          LEAD( esad2.me_start_date, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_start_date,
          LEAD( esad2.me_end_date, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_end_date,
          LEAD( esad2.coa, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_coa,   --priors are only populated when there is less than 95 days between the last elig seg and the start of the current elig seg
          LEAD( esad2.aid_category, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_ac,
          LEAD( esad2.type_case, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_tc,
          LEAD( esad2.elig_segment_and_details_id, 1) OVER (PARTITION BY esad2.client_id ORDER BY esad2.sequence_num) prior_esad_id
    FROM s_client_eligibility_me_stg esad2;

    COMMIT;
    
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_CLIENT_ELIGIBILITY_ME 
          (elig_segment_and_details_id,
            segment_type_cd,
            client_id,
            me_start_date,
            me_end_date,
            me_start_nd,
            me_end_nd,
            aid_category,
            type_case,
            ac_tc,
            coa,
            prior_start_date,
            prior_end_date,
            prior_coa,
            prior_ac,
            prior_tc,
            prior_esad_id,
            pregnancy_flag,
            close_reason,
            sequence_id,
            last_activity,
            approval_cd,
            segment_create_date,
            sequence_num,
            comparable_key)
    SELECT esad3.elig_segment_and_details_id ,
          esad3.segment_type_cd ,
          esad3.client_id ,
          esad3.me_start_date ,
          esad3.me_end_date ,
          esad3.me_start_nd ,
          esad3.me_end_nd ,
          esad3.aid_category ,
          esad3.type_case ,
          esad3.aid_category || '/' || esad3.type_case AS ac_tc,
          esad3.coa ,
          esad3.prior_start_date AS prior_start_date,
          esad3.prior_end_date AS prior_end_date,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_coa ELSE NULL END AS prior_coa,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_ac ELSE NULL END AS prior_ac,
          CASE WHEN (esad3.me_start_date - esad3.prior_end_date) <= 95 THEN esad3.prior_tc ELSE NULL END AS prior_tc,
          esad3.prior_esad_id ,
          CASE WHEN esad3.AID_CATEGORY = '03' and esad3.TYPE_CASE in ('013','053','104','127') THEN 1 ELSE 0 END AS pregnancy_flag,
          esad3.close_reason ,
          esad3.sequence_id ,
          esad3.last_activity ,
          esad3.approval_cd ,
          esad3.segment_create_date ,
          RANK() OVER(PARTITION BY esad3.CLIENT_ID ORDER BY esad3.sequence_num) AS sequence_num ,
          esad3.comparable_key 
    FROM s_client_elig_prior_me_stg esad3
    LOG Errors INTO Errlog_DClientElig_Me ('UPDATE_D_CLIENT_ELIGIBILITY_ME') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.UPDATE_D_CLIENT_ELIGIBILITY_ME', 1, Ora_Err_Mesg$, ora_err_number$, 'D_CLIENT_ELIGIBILITY_ME', ELIG_SEGMENT_AND_DETAILS_ID
      FROM Errlog_DClientElig_Me
     WHERE Ora_Err_Tag$ = 'UPDATE_D_CLIENT_ELIGIBILITY_ME';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

   dbms_stats.gather_table_stats('MAXDAT_LAEB','D_CLIENT_ELIGIBILITY_ME');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'EMRS_LAEB_ELIG_ETL_PKG.UPDATE_D_CLIENT_ELIGIBILITY_ME', 1, v_desc, v_code, 'D_CLIENT_ELIGIBILITY_ME');

      COMMIT;

END UPDATE_D_CLIENT_ELIGIBILITY_ME;


END;

/

grant execute on EMRS_LAEB_ELIG_ETL_PKG to MAXDAT_LAEB_READ_ONLY;

alter session set plsql_code_type = interpreted;