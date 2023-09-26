alter session set plsql_code_type = native;

create or replace package BILLABLE_OUTCOMES_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(35) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE INS_REFER_HCFA_APPS;  
  PROCEDURE INS_APPR_REJ_APPS;  
  PROCEDURE INS_APPS_MI;  
  PROCEDURE UPD_APPS_RFE_STATUS;
  PROCEDURE UPD_APPS_RECEIVED_INFO;
  PROCEDURE UPD_APPS_DENIAL;
  PROCEDURE UPD_REJECTED_APPS;
  PROCEDURE UPD_APPS_PACKET_INFO;
  PROCEDURE UPD_REFER_HCFA_APPS; 
  PROCEDURE UPD_APPR_REJ_APPS;
  PROCEDURE UPD_BILLABLE_COUNT;
  PROCEDURE UPD_APPS_MI;    
end;
/

CREATE OR REPLACE PACKAGE BODY BILLABLE_OUTCOMES_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE INS_REFER_HCFA_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'INS_REFER_HCFA_APPS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_REFER_HCFA_APPS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_BILLABLE_OUTCOMES (app_event_log_id
                                ,application_id
                                ,outcome_date
                                ,outcome_cd
                                ,outcome_reason_cd
                                ,program_cd
                                ,application_status_cd
                                ,program_subtype_cd
                                ,staff_name
                                ,staff_type
                                ,letter_id
                                ,letter_name
                                ,billable_date
                                ,mmis_app_status
                                ,trmdn_substantive
                                ,trmdn_procedural
                                ,denial_type
                                ,billable_counter
                                ,event_type
                                ,client_id
                                ,app_individual_id)
   SELECT el.app_event_log_id
      ,el.application_id
      ,el.create_ts outcome_date
      ,COALESCE(el.outcome_cd,'PENDING') outcome_cd
      ,COALESCE(el.outcome_reason_cd,o.elig_outcome_reason_cd) outcome_reason_cd
      ,COALESCE(el.program_cd, o.program_cd) program_cd
      ,COALESCE(el.app_status_cd,'INPROCESS') app_status_cd
      ,COALESCE(el.program_subtype_cd,o.program_subtype_cd) program_subtype_cd
      ,COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name
      ,s.staff_type_cd staff_type
      ,null letter_id
      ,null letter_name
      ,null billable_date
      ,null mmis_app_status
      ,0 trmdn_substantive
      ,0 trmdn_procedural
      ,null denial_type  
      ,1 billable_counter
      ,el.rfe_status_cd
      ,o.client_id
      ,o.app_individual_id
  FROM app_event_log_stg el   
    LEFT JOIN (SELECT *
               FROM (SELECT ai.application_id, ai.app_individual_id, ai.client_id, o.elig_outcome_cd, o.program_subtype_cd,o.program_cd,o.elig_outcome_reason_cd,
                            ROW_NUMBER() OVER(PARTITION BY ai.application_id ORDER BY o.create_ts DESC) rn
                     FROM app_individual_stg ai
                       JOIN app_elig_outcome_stg o ON ai.application_id = o.application_id
                     WHERE ai.applicant_ind = 1) 
               WHERE rn =1 ) o ON el.application_id = o.application_id
    LEFT JOIN d_staff s ON el.created_by = TO_CHAR(s.staff_id)      
  WHERE rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE'
  AND  NOT EXISTS(SELECT 1 FROM d_billable_outcomes mp WHERE mp.app_event_log_id = el.app_event_log_id)
  Log Errors INTO Errlog_BillOm ('INS_REFER_HCFA_APPS') Reject Limit Unlimited
    ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_REFER_HCFA_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'INS_REFER_HCFA_APPS';

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
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_REFER_HCFA_APPS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END INS_REFER_HCFA_APPS;


PROCEDURE INS_APPR_REJ_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'INS_APPR_REJ_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'INS_APPR_REJ_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_BILLABLE_OUTCOMES (app_event_log_id
                                ,application_id
                                ,outcome_date
                                ,outcome_cd
                                ,outcome_reason_cd
                                ,program_cd
                                ,application_status_cd
                                ,program_subtype_cd
                                ,staff_name
                                ,staff_type
                                ,letter_id
                                ,letter_name
                                ,billable_date
                                ,mmis_app_status
                                ,trmdn_substantive
                                ,trmdn_procedural
                                ,denial_type
                                ,billable_counter
                                ,event_type
                                ,client_id
                                ,app_individual_id)
   SELECT *
   FROM (SELECT el.app_event_log_id
               ,el.application_id
               ,el.create_ts outcome_date
               ,el.outcome_cd
               ,COALESCE(el.outcome_reason_cd,o.elig_outcome_reason_cd) outcome_reason_cd
               ,COALESCE(el.program_cd,o.program_cd) program_cd
               ,el.app_status_cd
               ,COALESCE(el.program_subtype_cd,o.program_subtype_cd) program_subtype_cd
               ,COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name
               ,s.staff_type_cd staff_type
               ,ls.ref_id letter_id
               ,lr.letter_type_cd
               ,es.process_ts billable_date
               ,es.mmis_app_status
               ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 1 ELSE 0 END trmdn_substantive
               ,CASE WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 1 ELSE 0 END trmdn_procedural
               ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 'Substantive'
                     WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 'Procedural'
                 ELSE null END denial_type 
              ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.app_event_log_id,es.process_ts) billable_counter
              ,el.action_cd
              ,o.client_id
              ,o.app_individual_id
         FROM app_event_log_stg el
            LEFT JOIN (SELECT *
               FROM (SELECT ai.application_id, ai.app_individual_id, ai.client_id, o.elig_outcome_cd, o.program_subtype_cd,o.program_cd,o.elig_outcome_reason_cd,
                            ROW_NUMBER() OVER(PARTITION BY ai.application_id ORDER BY o.create_ts DESC) rn
                     FROM app_individual_stg ai
                       JOIN app_elig_outcome_stg o ON ai.application_id = o.application_id
                     WHERE ai.applicant_ind = 1) 
               WHERE rn =1 ) o ON el.application_id = o.application_id
            LEFT JOIN (SELECT e.application_id,e.create_ts,MAX(ls.ref_id) ref_id
                       FROM app_event_log_stg e 
                         JOIN app_event_log_stg ls ON ls.application_id = e.application_id                                 
                       WHERE e.app_event_cd = 'STATUS_CHANGE'
                       AND e.action_cd = 'END_APPLICATION_TRACKING'  
                       AND e.outcome_cd = 'REJECTED'
                       AND ls.app_event_cd = 'LETTER_REQ' 
                       AND ls.ref_type = 'LETTER_REQUEST' 
                       AND ls.app_event_context IN('TN 408','TN 408ftp','TN 409','TN 409ftp', 'TN 411') 
                       AND ls.outcome_cd = 'REJECTED' 
                       AND TRUNC(ls.create_ts) = TRUNC(e.create_ts)
                       GROUP BY e.application_id,e.create_ts) ls ON ls.application_id = el.application_id AND ls.create_ts = el.create_ts AND el.outcome_cd = 'REJECTED'
            LEFT JOIN d_staff s ON el.created_by = TO_CHAR(s.staff_id)  
            LEFT JOIN etl_e_app_status_staging_stg es ON el.application_id = es.application_id AND ls.ref_id = es.letter_req_id AND mmis_app_status IN('TRMDN','NR')      
            LEFT JOIN letters_stg lr ON es.letter_req_id = lr.letter_id    
          WHERE app_event_cd = 'STATUS_CHANGE'
          AND action_cd = 'END_APPLICATION_TRACKING'  
          AND outcome_cd IN('REJECTED','APPROVED')
          AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                         AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) ) el
      WHERE  NOT EXISTS(SELECT 1 FROM d_billable_outcomes mp WHERE mp.app_event_log_id = el.app_event_log_id AND mp.billable_counter = el.billable_counter)
    Log Errors INTO Errlog_BillOm ('INS_REFER_HCFA_APPS') Reject Limit Unlimited
    ;
     
   
    v_upd_cnt :=  SQL%RowCount;
    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_APPR_REJ_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'INS_APPR_REJ_APPS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_APPR_REJ_APPS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END INS_APPR_REJ_APPS;

PROCEDURE INS_APPS_MI
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'INS_APPS_MI';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_APPS_MI','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_BILLABLE_OUTCOMES (app_event_log_id
                                ,application_id
                                ,outcome_date
                                ,outcome_cd                                
                                ,staff_name
                                ,staff_type                                
                                ,billable_counter
                                ,event_type
                                ,client_id
                                ,app_individual_id)
   SELECT el.app_event_log_id
      ,el.application_id
      ,el.create_ts outcome_date
      ,'DETERMINED_TO_HAVE_MI' outcome_cd
      ,el.staff_name
      ,el.staff_type
      ,1 billable_counter
      ,el.app_event_cd
      ,el.client_id
      ,el.app_individual_id
  FROM (SELECT el.app_event_log_id,el.application_id,el.create_ts,el.app_event_cd
              ,COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name
              ,s.staff_type_cd staff_type
              ,o.app_individual_id,o.client_id
              ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.create_ts) ern
        FROM app_event_log_stg el   
          LEFT JOIN (SELECT ai.application_id, ai.app_individual_id, ai.client_id                           
                     FROM app_individual_stg ai                       
                     WHERE ai.applicant_ind = 1 ) o ON el.application_id = o.application_id
          LEFT JOIN d_staff s ON el.created_by = TO_CHAR(s.staff_id)      
        WHERE app_event_cd = 'APP_MI_ADDED') el
  WHERE ern = 1
  AND NOT EXISTS(SELECT 1 FROM d_billable_outcomes mp WHERE mp.app_event_log_id = el.app_event_log_id)
  Log Errors INTO Errlog_BillOm ('INS_APPS_MI') Reject Limit Unlimited
    ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_APPS_MI', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'INS_APPS_MI';

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
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.INS_APPS_MI', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END INS_APPS_MI;


PROCEDURE UPD_APPS_RFE_STATUS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPS_RFE_STATUS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_RFE_STATUS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT bo.app_event_log_id,bo.billable_counter,ts.application_id, ts.nw_rfe_status_cd
          FROM d_billable_outcomes bo
          JOIN (SELECT ts.application_id,ts.rfe_status_cd nw_rfe_status_cd, ROW_NUMBER() OVER (PARTITION BY ts.application_id ORDER BY app_tracker_id DESC) rn
                FROM app_tracker_stg ts ) ts ON bo.application_id = ts.application_id                
           WHERE rn = 1
           AND COALESCE(ts.nw_rfe_status_cd,'*') != COALESCE(bo.rfe_status_cd,'*')         
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET rfe_status_cd = tmp.nw_rfe_status_cd             
     Log Errors INTO Errlog_BillOm ('UPD_APPS_RFE_STATUS') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_RFE_STATUS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPS_RFE_STATUS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_RFE_STATUS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPS_RFE_STATUS;

PROCEDURE UPD_APPS_RECEIVED_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPS_RECEIVED_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_RECEIVED_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT dmi.app_event_log_id,dmi.billable_counter,dmi.application_id,dmi.received_date,ds.received_date nw_received_date
          FROM d_billable_outcomes dmi           
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE   COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.received_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
          ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter)
    WHEN MATCHED THEN UPDATE
     SET  received_date = tmp.nw_received_date    
     Log Errors INTO Errlog_BillOm ('UPD_APPS_RECEIVED_INFO') Reject Limit Unlimited
     ;
     
     v_upd_cnt := SQL%RowCount;
     COMMIT;
   --try to get any doc linked receipt date if app receipt date is null
 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT dmi.app_event_log_id, dmi.billable_counter,dmi.application_id,dmi.received_date,ds.received_date nw_received_date
          FROM d_billable_outcomes dmi           
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE   COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.received_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
          ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter)
    WHEN MATCHED THEN UPDATE
     SET  received_date = tmp.nw_received_date    
     Log Errors INTO Errlog_BillOm ('UPD_APPS_RECEIVED_INFO') Reject Limit Unlimited
     ;

    v_upd_cnt := v_upd_cnt + SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   
    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_RECEIVED_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPS_RECEIVED_INFO';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_RECEIVED_INFO', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPS_RECEIVED_INFO;

PROCEDURE UPD_APPS_DENIAL
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPS_DENIAL';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_DENIAL','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT el.*
   FROM d_billable_outcomes b
   JOIN (SELECT el.app_event_log_id
               ,el.application_id
               ,el.create_ts outcome_date
               ,el.outcome_cd
               ,COALESCE(el.outcome_reason_cd,o.elig_outcome_reason_cd) outcome_reason_cd
               ,COALESCE(el.program_cd,o.program_cd) program_cd
               ,el.app_status_cd
               ,COALESCE(el.program_subtype_cd,o.program_subtype_cd) program_subtype_cd
               ,COALESCE(s.first_name||' '||REPLACE(s.last_name,' S',''),el.created_by) staff_name
               ,s.staff_type_cd staff_type
               ,ls.ref_id letter_id
               ,lr.letter_type_cd
               ,es.process_ts billable_date
               ,es.mmis_app_status
               ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 1 ELSE 0 END trmdn_substantive
               ,CASE WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 1 ELSE 0 END trmdn_procedural
               ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 'Substantive'
                     WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 'Procedural'
                 ELSE null END denial_type 
              ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.app_event_log_id,es.process_ts) billable_counter
              ,el.action_cd
              ,o.client_id
              ,o.app_individual_id
         FROM app_event_log_stg el
            LEFT JOIN (SELECT *
               FROM (SELECT ai.application_id, ai.app_individual_id, ai.client_id, o.elig_outcome_cd, o.program_subtype_cd,o.program_cd,o.elig_outcome_reason_cd,
                            ROW_NUMBER() OVER(PARTITION BY ai.application_id ORDER BY o.create_ts DESC) rn
                     FROM app_individual_stg ai
                       JOIN app_elig_outcome_stg o ON ai.application_id = o.application_id
                     WHERE ai.applicant_ind = 1) 
               WHERE rn =1 ) o ON el.application_id = o.application_id
            LEFT JOIN (SELECT e.application_id,e.create_ts,MAX(ls.ref_id) ref_id
                       FROM app_event_log_stg e 
                         JOIN app_event_log_stg ls ON ls.application_id = e.application_id                                 
                       WHERE e.app_event_cd = 'STATUS_CHANGE'
                       AND e.action_cd = 'END_APPLICATION_TRACKING'  
                       AND e.outcome_cd = 'REJECTED'
                       AND ls.app_event_cd = 'LETTER_REQ' 
                       AND ls.ref_type = 'LETTER_REQUEST' 
                       AND ls.app_event_context IN('TN 408','TN 408ftp','TN 409','TN 409ftp', 'TN 411') 
                       AND ls.outcome_cd = 'REJECTED' 
                       AND TRUNC(ls.create_ts) = TRUNC(e.create_ts)
                       GROUP BY e.application_id,e.create_ts) ls ON ls.application_id = el.application_id AND ls.create_ts = el.create_ts AND el.outcome_cd = 'REJECTED'
            LEFT JOIN d_staff s ON el.created_by = TO_CHAR(s.staff_id)  
            LEFT JOIN etl_e_app_status_staging_stg es ON el.application_id = es.application_id AND ls.ref_id = es.letter_req_id AND mmis_app_status IN('TRMDN','NR')      
            LEFT JOIN letters_stg lr ON es.letter_req_id = lr.letter_id    
          WHERE app_event_cd = 'STATUS_CHANGE'
          AND action_cd = 'END_APPLICATION_TRACKING'  
          AND outcome_cd IN('REJECTED','APPROVED')
          AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                         AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) ) el ON b.app_event_log_id = el.app_event_log_id and b.billable_counter = el.billable_counter      
        WHERE COALESCE(b.denial_type,'*') <> COALESCE(el.denial_type,'*')
         OR COALESCE(b.letter_id,0) <> COALESCE(el.letter_id,0)
         OR COALESCE(b.letter_name,'*') <> COALESCE(el.letter_type_cd,'*')
         OR COALESCE(b.mmis_app_status,'*') <> COALESCE(el.mmis_app_status,'*')
         OR COALESCE(b.billable_date,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(el.billable_date,TO_DATE('07/07/7777','mm/dd/yyyy')) 
         ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET denial_type = tmp.denial_type
        ,letter_id = tmp.letter_id
        ,letter_name = tmp.letter_type_cd
        ,mmis_app_status = tmp.mmis_app_status
        ,billable_date = tmp.billable_date
     Log Errors INTO Errlog_BillOm ('UPD_APPS_DENIAL') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_DENIAL', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPS_DENIAL';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_DENIAL', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPS_DENIAL;

PROCEDURE UPD_REJECTED_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   UPD_APPS_DENIAL;
   
   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_REFER_HCFA_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_REJECTED_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT bo.denial_reason,bo.app_event_log_id,bo.billable_counter,tmp.*
          FROM  d_billable_outcomes bo
            JOIN (SELECT application_id,case_id,client_id,LISTAGG(denial_reason,', ') WITHIN GROUP (ORDER BY case_id) nw_denial_reason
               FROM(SELECT DISTINCT bo.application_id,ce.case_id,ce.client_id,ma.report_label denial_reason
                    FROM d_billable_outcomes bo
                      JOIN app_case_link_stg cs ON bo.application_id = cs.application_id
                      JOIN case_event_stg ce ON cs.case_id = ce.case_id
                      JOIN case_manual_action_lkup ma ON ce.context =  ma.value
                    WHERE ce.event_type_cd = 'CASE_MANUAL_ACTION'
                    AND  bo.outcome_cd = 'REJECTED'
                    AND ce.event_id = (SELECT MAX(event_id)
                                       FROM case_event_stg ce1
                                       WHERE ce1.case_id = ce.case_id
                                       AND ce1.client_id = ce.client_id
                                       AND ce1.event_type_cd = ce.event_type_cd
                                       AND ce1.context = ce.context) )                     
          GROUP BY application_id,case_id, client_id ) tmp ON bo.application_id = tmp.application_id
          WHERE bo.outcome_cd = 'REJECTED'
          AND COALESCE(tmp.nw_denial_reason,'*') != COALESCE(bo.denial_reason,'*')         
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET denial_reason = tmp.nw_denial_reason             
     Log Errors INTO Errlog_BillOm ('UPD_REJECTED_APPS') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_REJECTED_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_REJECTED_APPS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_REJECTED_APPS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_REJECTED_APPS;

PROCEDURE UPD_APPS_PACKET_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPS_PACKET_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_PACKET_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT bo.app_event_log_id,bo.billable_counter,bo.application_id,tmp.nw_packet_mailed_date,bo.packet_mailed_date
          FROM d_billable_outcomes bo
          JOIN (SELECT ls.reference_id,MIN(letter_mailed_date) nw_packet_mailed_date
                FROM letters_stg lr
                  JOIN letter_request_link_stg ls ON lr.letter_id = ls.lmreq_id          
                WHERE ls.reference_type = 'APP_HEADER'
                AND lr.letter_type_cd IN('TN 401','TN 401a')
                AND lr.letter_status_cd = 'MAIL' 
                GROUP BY ls.reference_id )tmp  ON tmp.reference_id = bo.application_id
           WHERE  COALESCE(tmp.nw_packet_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(bo.packet_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET packet_mailed_date = tmp.nw_packet_mailed_date             
     Log Errors INTO Errlog_BillOm ('UPD_APPS_PACKET_INFO') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_PACKET_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPS_PACKET_INFO';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_PACKET_INFO', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPS_PACKET_INFO;

PROCEDURE UPD_REFER_HCFA_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_REFER_HCFA_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_REFER_HCFA_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT bo.app_event_log_id,bo.billable_counter,bo.application_id,el.prev_reactivation_reason,el.curr_reactivation_reason,bo.previous_reactivation_reason,bo.current_reactivation_reason
          FROM d_billable_outcomes bo
          JOIN (SELECT *
                FROM(SELECT ae.application_id, ae.app_event_log_id,rfe_status_cd      
                            ,LAG(app_event_context, 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS prev_reactivation_reason      
                            ,LEAD(app_event_context, 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS curr_reactivation_reason      
                      FROM app_event_log_stg ae                          
                      WHERE ( (app_event_cd ='APP_REACTIVATED' AND action_cd ='APP_REACTIVATED')
                           OR rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' ) )
                WHERE rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' ) el ON bo.app_event_log_id = el.app_event_log_id
          WHERE bo.event_type = 'AWAITING_STATE_ACCEPTANCE'
          AND ( COALESCE(el.prev_reactivation_reason,'*') != COALESCE(bo.previous_reactivation_reason,'*')  
          OR COALESCE(el.curr_reactivation_reason,'*') != COALESCE(bo.current_reactivation_reason,'*')  )
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET previous_reactivation_reason = tmp.prev_reactivation_reason   
        ,current_reactivation_reason = tmp.curr_reactivation_reason   
     Log Errors INTO Errlog_BillOm ('UPD_REFER_HCFA_APPS') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_REFER_HCFA_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_REFER_HCFA_APPS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_REFER_HCFA_APPS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_REFER_HCFA_APPS;

PROCEDURE UPD_APPR_REJ_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPR_REJ_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPR_REJ_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT bo.app_event_log_id,bo.billable_counter,bo.application_id,el.prev_reactivation_reason,el.curr_reactivation_reason,bo.previous_reactivation_reason,bo.current_reactivation_reason
          FROM d_billable_outcomes bo
          JOIN (SELECT *
                FROM(SELECT ae.application_id, ae.app_event_log_id,action_cd      
                            ,LAG(DECODE(app_event_context,'APPLICATION_TRACKING',null,app_event_context), 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS prev_reactivation_reason      
                            ,LEAD(DECODE(app_event_context,'APPLICATION_TRACKING',null,app_event_context), 1) OVER (PARTITION BY application_id ORDER BY app_event_log_id) AS curr_reactivation_reason      
                     FROM app_event_log_stg ae                          
                     WHERE app_event_cd IN('APP_REACTIVATED','STATUS_CHANGE') 
                     AND action_cd IN('APP_REACTIVATED','END_APPLICATION_TRACKING'))
                 WHERE action_cd = 'END_APPLICATION_TRACKING' ) el ON bo.app_event_log_id = el.app_event_log_id
          WHERE bo.event_type = 'END_APPLICATION_TRACKING'
          AND ( COALESCE(el.prev_reactivation_reason,'*') != COALESCE(bo.previous_reactivation_reason,'*')  
            OR COALESCE(el.curr_reactivation_reason,'*') != COALESCE(bo.current_reactivation_reason,'*')  )
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET previous_reactivation_reason = tmp.prev_reactivation_reason   
        ,current_reactivation_reason = tmp.curr_reactivation_reason 
    Log Errors INTO Errlog_BillOm ('UPD_APPR_REJ_APPS') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPR_REJ_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPR_REJ_APPS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPR_REJ_APPS', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPR_REJ_APPS;


PROCEDURE UPD_BILLABLE_COUNT
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_BILLABLE_COUNT';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_BILLABLE_COUNT','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT *
          FROM (SELECT app_event_log_id,billable_counter,bill_outcome_count, COUNT(1) OVER (PARTITION BY bo.application_id) nw_bill_outcome_count
                FROM d_billable_outcomes bo
                WHERE event_type !=  'APP_MI_ADDED')
          WHERE COALESCE(bill_outcome_count,0) !=  COALESCE(nw_bill_outcome_count,0)    
          ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET bill_outcome_count = tmp.nw_bill_outcome_count          
     Log Errors INTO Errlog_BillOm ('UPD_BILLABLE_COUNT') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_BILLABLE_COUNT', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_BILLABLE_COUNT';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_BILLABLE_COUNT', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_BILLABLE_COUNT;

PROCEDURE UPD_APPS_MI
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_BillOm WHERE ora_err_tag$ = 'UPD_APPS_MI';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_MI','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_billable_outcomes s
   USING (SELECT *
          FROM (SELECT bo.application_id,bo.app_event_log_id,bo.billable_counter,bo.mi_type,LISTAGG(mi.mi_category||'-'||mi.mi_type, ', ') WITHIN GROUP (ORDER BY bo.application_id) nw_mi_type
                FROM d_billable_outcomes bo
                  JOIN (SELECT DISTINCT application_id, mi_type_cd,t.report_label mi_type, ic.report_label mi_category
                        FROM app_missing_info_stg i
                          INNER JOIN app_mi_type_lkup t ON i.mi_type_cd = t.value 
                          INNER JOIN app_mi_category_lkup ic  ON t.mi_category = ic.value) mi ON bo.application_id = mi.application_id
                WHERE bo.event_type = 'APP_MI_ADDED'        
                GROUP BY bo.application_id,bo.app_event_log_id,bo.billable_counter,bo.mi_type  )
          WHERE COALESCE(mi_type,'*') != COALESCE(nw_mi_type,'*')
        ) tmp ON (tmp.app_event_log_id = s.app_event_log_id AND tmp.billable_counter = s.billable_counter) 
    WHEN MATCHED THEN UPDATE
    SET mi_type = tmp.nw_mi_type           
    Log Errors INTO Errlog_BillOm ('UPD_APPS_MI') Reject Limit Unlimited
     ;

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
    SELECT c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_MI', 1, Ora_Err_Mesg$, ora_err_number$, 'D_BILLABLE_OUTCOMES', APPLICATION_ID
      FROM Errlog_BillOm
     WHERE Ora_Err_Tag$ = 'UPD_APPS_MI';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'BILLABLE_OUTCOMES_PKG.UPD_APPS_MI', 1, v_desc, v_code, 'D_BILLABLE_OUTCOMES');

      COMMIT;
END UPD_APPS_MI;


END;
/


grant execute on BILLABLE_OUTCOMES_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;