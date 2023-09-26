alter session set plsql_code_type = native;

create or replace package PROCESS_APP_RECON_INDICATOR_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(35) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE INS_INPROCESS_APPS;  
  PROCEDURE UPD_INPROCESS_APPS;
  PROCEDURE UPD_INPROCESS_APPS_TN411_LTR;  
  PROCEDURE UPD_INPROCESS_APPS_FTP_LTR; 
  PROCEDURE UPD_MIDATA_EVAL_TASK;  
  PROCEDURE UPD_INPROCESS_APPS_RECENT_DOC;
  PROCEDURE UPD_90DAY_INDICATOR;
  PROCEDURE UPD_APPS_TERM_LTR_ONETIME;
  PROCEDURE INS_APPS_ONETIME;
end;
/

CREATE OR REPLACE PACKAGE BODY PROCESS_APP_RECON_INDICATOR_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE INS_INPROCESS_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'INS_INPROCESS_APPS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_INPROCESS_APPS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO d_app_reconsideration_data (application_id
                                         ,app_receipt_date
                                         ,application_status )
    SELECT ah.application_id
          ,doc_rcvd.received_date
          ,ah.status_cd
    FROM  app_header_stg ah     
      LEFT JOIN(SELECT *
           FROM(SELECT link_ref_id,ds.received_date
                       ,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date,dl.create_ts) rn
                FROM document_set_stg ds 
                  JOIN document_stg d ON ds.document_set_id = d.document_set_id
                  LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                  LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                WHERE doc_type_cd = 'APPLICATION' )
           WHERE rn = 1) doc_rcvd  ON doc_rcvd.link_ref_id = ah.application_id            
    WHERE 1=1
    AND (ah.status_cd NOT IN('DISREGARDED','TIMEOUT','COMPLETED') OR ah.rcvd_90day_indicator IS NULL )
    AND NOT EXISTS(SELECT 1 FROM d_app_reconsideration_data mp WHERE mp.application_id = ah.application_id)
    Log Errors INTO Errlog_AppRecon ('INS_INPROCESS_APPS') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.INS_INPROCESS_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'INS_INPROCESS_APPS';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.INS_INPROCESS_APPS', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END INS_INPROCESS_APPS;


PROCEDURE UPD_INPROCESS_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_INPROCESS_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_INPROCESS_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT dmi.application_id,dmi.app_receipt_date,application_status,status_cd,received_date
          FROM d_app_reconsideration_data dmi 
            JOIN app_header_stg ah ON dmi.application_id = ah.application_id
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE  ( COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ah.status_cd, '*') != COALESCE(dmi.application_status, '*') )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  app_receipt_date = tmp.received_date
          ,application_status = tmp.status_cd          
     Log Errors INTO Errlog_AppRecon ('UPD_INPROCESS_APPS') Reject Limit Unlimited
     ;
     
     v_upd_cnt := SQL%RowCount;
     COMMIT;
   --try to get any doc linked receipt date if app receipt date is null
  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT dmi.application_id,dmi.app_receipt_date,application_status,status_cd,received_date
          FROM d_app_reconsideration_data dmi 
            JOIN app_header_stg ah ON dmi.application_id = ah.application_id
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE 1=1
                        --AND doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE dmi.app_receipt_date IS NULL
          AND ( COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
                 OR COALESCE(ah.status_cd, '*') != COALESCE(dmi.application_status, '*') )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  app_receipt_date = tmp.received_date
          ,application_status = tmp.status_cd          
    Log Errors INTO Errlog_AppRecon ('UPD_INPROCESS_APPS') Reject Limit Unlimited     
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_INPROCESS_APPS';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_INPROCESS_APPS;

PROCEDURE UPD_INPROCESS_APPS_TN411_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_INPROCESS_APPS_TN411_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_INPROCESS_APPS_TN411_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT * FROM
            (SELECT   dmi.term_ltr_letter_id,dmi.term_ltr_mailed_date,dmi.term_ltr_response_due_date, dmi.application_id
                      ,ll.letter_mailed_date,ll.response_due_date,ll.letter_id
                FROM  d_app_reconsideration_data dmi 
                   JOIN (SELECT *
                         FROM (SELECT letter_id
                                      ,letter_mailed_date
                                      ,response_due_date
                                      ,reference_id application_id
                                      ,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY letter_mailed_date DESC,letter_id DESC) rn  
                               FROM  letters_stg lr                          
                                JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id                   
                               WHERE lr.letter_type_cd = 'TN 411'
                               AND ll.reference_type = 'APP_HEADER'
                               AND lr.letter_status_cd = 'MAIL'
                               AND lr.letter_request_type IN('L','S') )
                          WHERE rn = 1) ll  ON ll.application_id = dmi.application_id  ) tmp                   
           WHERE ( COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_ltr_response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy'))         
          OR COALESCE(tmp.letter_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_ltr_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))           
          OR COALESCE(tmp.letter_id,0) != COALESCE(tmp.term_ltr_letter_id, 0) )
        ) tmp ON (tmp.application_id = s.application_id) 
    WHEN MATCHED THEN UPDATE
     SET  term_ltr_letter_id = tmp.letter_id    
         ,term_ltr_mailed_date = tmp.letter_mailed_date
         ,term_ltr_response_due_date = tmp.response_due_date         
     Log Errors INTO Errlog_AppRecon ('UPD_INPROCESS_APPS_TN411_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_TN411_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_INPROCESS_APPS_TN411_LTR';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_TN411_LTR', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_INPROCESS_APPS_TN411_LTR;

PROCEDURE UPD_INPROCESS_APPS_FTP_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_INPROCESS_APPS_FTP_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_INPROCESS_APPS_FTP_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT * FROM
            (SELECT   dmi.ftp_ltr_letter_id,dmi.ftp_ltr_mailed_date,dmi.ftp_ltr_response_due_date, dmi.application_id
                      ,ll.letter_mailed_date,ll.response_due_date,ll.letter_id
                FROM  d_app_reconsideration_data dmi 
                   JOIN (SELECT *
                         FROM (SELECT letter_id
                                      ,letter_mailed_date
                                      ,response_due_date
                                      ,reference_id application_id
                                      ,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY letter_mailed_date DESC,letter_id DESC) rn  
                               FROM  letters_stg lr                          
                                JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id                   
                               WHERE lr.letter_type_cd = 'TN 408ftp'
                               AND ll.reference_type = 'APP_HEADER'
                               AND lr.letter_status_cd = 'MAIL'
                               AND lr.letter_request_type IN('L','S') )
                          WHERE rn = 1) ll  ON ll.application_id = dmi.application_id  ) tmp                   
           WHERE ( COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.ftp_ltr_response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy'))         
          OR COALESCE(tmp.letter_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.ftp_ltr_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))           
          OR COALESCE(tmp.letter_id,0) != COALESCE(tmp.ftp_ltr_letter_id, 0) )
        ) tmp ON (tmp.application_id = s.application_id) 
    WHEN MATCHED THEN UPDATE
     SET  ftp_ltr_letter_id = tmp.letter_id    
         ,ftp_ltr_mailed_date = tmp.letter_mailed_date
         ,ftp_ltr_response_due_date = tmp.response_due_date         
     Log Errors INTO Errlog_AppRecon ('UPD_INPROCESS_APPS_FTP_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_FTP_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_INPROCESS_APPS_FTP_LTR';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_FTP_LTR', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_INPROCESS_APPS_FTP_LTR;

PROCEDURE UPD_MIDATA_EVAL_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_MIDATA_EVAL_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_MIDATA_EVAL_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING ( SELECT *
                FROM(SELECT i.step_instance_id nw_de_task_id
                        ,i.create_ts nw_de_task_create_date                        
                        ,ROW_NUMBER() OVER (PARTITION BY i.ref_id ORDER BY step_instance_id DESC,i.create_ts DESC) vrn
                        ,dmi.mi_de_task_id
                        ,dmi.mi_de_task_create_date                        
                        ,i.ref_id application_id
                     FROM d_app_reconsideration_data dmi 
                            JOIN (SELECT * 
                                  FROM (SELECT i.*,
                                          ROW_NUMBER() OVER (PARTITION BY i.ref_id,i.step_instance_id ORDER BY DECODE(hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1) DESC,step_instance_id,step_instance_history_id) srn
                                        FROM step_instance_stg i
                                          JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id                                                                
                                        WHERE ref_type = 'APP_HEADER' 
                                        AND dt.task_name = 'MI Data Evaluation') 
                                  WHERE srn = 1 ) i ON dmi.application_id  = i.ref_id  ) tmp                   
                WHERE vrn = 1                  
                AND ( COALESCE(tmp.nw_de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.mi_de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))                  
                  OR COALESCE(tmp.nw_de_task_id,0) != COALESCE(tmp.mi_de_task_id,0) ) 
        ) tmp ON (tmp.application_id = s.application_id )
    WHEN MATCHED THEN UPDATE
     SET  mi_de_task_create_date = tmp.nw_de_task_create_date
         ,mi_de_task_id = tmp.nw_de_task_id        
     Log Errors INTO Errlog_AppRecon ('UPD_MIDATA_EVAL_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_MIDATA_EVAL_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_MIDATA_EVAL_TASK';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_MIDATA_EVAL_TASK', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_MIDATA_EVAL_TASK;

PROCEDURE UPD_INPROCESS_APPS_RECENT_DOC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_INPROCESS_APPS_RECENT_DOC';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_INPROCESS_APPS_RECENT_DOC','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT *
          FROM 
            (SELECT dmi.latest_document_id,dmi.latest_document_type,dmi.latest_doc_receipt_date,dmi.application_id,ds.nw_recent_doc_type,ds.document_id,ds.received_date
                  ,ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY ABS(dmi.mi_de_task_create_date - link_date),received_date,document_id) rn
              FROM d_app_reconsideration_data dmi 
                JOIN (SELECT link_ref_id application_id,d.document_id,ds.received_date,dl.create_ts link_date,COALESCE(tl.report_label,d.doc_type_cd) nw_recent_doc_type
                      FROM document_set_stg ds 
                        JOIN document_stg d ON ds.document_set_id = d.document_set_id
                        JOIN doc_link_stg dl ON d.document_id = dl.document_id   
                        LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                      WHERE link_type_cd = 'APPLICATION') ds ON dmi.application_id = ds.application_id
              WHERE TRUNC(ds.received_date) <= TRUNC(mi_de_task_create_date) )  tmp
           WHERE rn = 1
           AND (COALESCE(tmp.nw_recent_doc_type, '*') != COALESCE(tmp.latest_document_type,'*')            
           OR COALESCE(tmp.document_id, 0) != COALESCE(tmp.latest_document_id,0)            
           OR  COALESCE(tmp.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.latest_doc_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  latest_document_type = tmp.nw_recent_doc_type        
          ,latest_document_id = tmp.document_id
          ,latest_doc_receipt_date = tmp.received_date
     Log Errors INTO Errlog_AppRecon ('UPD_INPROCESS_APPS_RECENT_DOC') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_RECENT_DOC', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_INPROCESS_APPS_RECENT_DOC';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_INPROCESS_APPS_RECENT_DOC', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_INPROCESS_APPS_RECENT_DOC;


PROCEDURE UPD_90DAY_INDICATOR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_90DAY_INDICATOR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_90DAY_INDICATOR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  app_header_stg s
   USING (SELECT ah.application_id,ah.rcvd_90day_indicator,tmp.rcvd_90day_indicator nw_rcvd_90day_indicator
          FROM (SELECT ar.application_id
                      ,CASE WHEN ftp_ltr_letter_id IS NOT NULL THEN
                              CASE WHEN mi_de_task_id IS NOT NULL THEN
                                 CASE WHEN latest_doc_receipt_date > ftp_ltr_response_due_date AND latest_doc_receipt_date <= ftp_ltr_response_due_date +90 THEN 'Y'
                                      WHEN latest_doc_receipt_date > ftp_ltr_response_due_date +90 THEN 'P'
                                 ELSE 'N' END
                              ELSE CASE WHEN TRUNC(sysdate) > ftp_ltr_response_due_date AND TRUNC(sysdate) <= ftp_ltr_response_due_date +90 THEN 'O' ELSE 'N' END END
                            WHEN term_ltr_letter_id IS NOT NULL THEN 
                                 CASE WHEN app_receipt_date IS NOT NULL THEN
                                   CASE WHEN app_receipt_date > term_ltr_response_due_date AND app_receipt_date <= term_ltr_response_due_date +90 THEN 'Y'
                                        WHEN app_receipt_date > term_ltr_response_due_date +90 THEN 'P'
                                    ELSE 'N' END   
                                 ELSE CASE WHEN TRUNC(sysdate) > term_ltr_response_due_date AND TRUNC(sysdate) <= term_ltr_response_due_date +90 THEN 'O' ELSE 'N' END END
                       ELSE 'N' END rcvd_90day_indicator          
                FROM d_app_reconsideration_data ar)  tmp 
            JOIN app_header_stg ah ON tmp.application_id = ah.application_id
          WHERE COALESCE(ah.rcvd_90day_indicator, '*') != COALESCE(tmp.rcvd_90day_indicator,'*')     
          AND (ah.status_cd NOT IN('DISREGARDED','TIMEOUT','COMPLETED') OR ah.rcvd_90day_indicator IS NULL )          
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  rcvd_90day_indicator = tmp.nw_rcvd_90day_indicator        
     Log Errors INTO Errlog_AppRecon ('UPD_90DAY_INDICATOR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_90DAY_INDICATOR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_90DAY_INDICATOR';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_90DAY_INDICATOR', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_90DAY_INDICATOR;

PROCEDURE UPD_APPS_TERM_LTR_ONETIME
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'UPD_INPROCESS_APPS_TN411_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPS_TERM_LTR_ONETIME','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_reconsideration_data s
   USING (SELECT * FROM
            (SELECT   dmi.term_ltr_letter_id,dmi.term_ltr_mailed_date,dmi.term_ltr_response_due_date, dmi.application_id
                      ,ll.letter_mailed_date,ll.response_due_date,ll.letter_id
                FROM  d_app_reconsideration_data dmi 
                   JOIN (SELECT *
                         FROM (SELECT letter_id
                                      ,letter_mailed_date
                                      ,response_due_date
                                      ,reference_id application_id
                                      ,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY letter_mailed_date DESC,letter_id DESC) rn  
                               FROM  letters_stg lr                          
                                JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id                   
                               WHERE lr.letter_type_cd IN('TN 411', 'TN 408ftp','TN 408', 'TN 409', 'TN 409ftp')
                               AND ll.reference_type = 'APP_HEADER'
                               AND lr.letter_status_cd = 'MAIL'
                               AND lr.letter_request_type IN('L','S') )
                          WHERE rn = 1) ll  ON ll.application_id = dmi.application_id  ) tmp                   
           WHERE ( COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_ltr_response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy'))         
          OR COALESCE(tmp.letter_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_ltr_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))           
          OR COALESCE(tmp.letter_id,0) != COALESCE(tmp.term_ltr_letter_id, 0) )
        ) tmp ON (tmp.application_id = s.application_id) 
    WHEN MATCHED THEN UPDATE
     SET  term_ltr_letter_id = tmp.letter_id    
         ,term_ltr_mailed_date = tmp.letter_mailed_date
         ,term_ltr_response_due_date = tmp.response_due_date         
     Log Errors INTO Errlog_AppRecon ('UPD_APPS_TERM_LTR_ONETIME') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_APPS_TERM_LTR_ONETIME', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'UPD_APPS_TERM_LTR_ONETIME';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.UPD_APPS_TERM_LTR_ONETIME', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END UPD_APPS_TERM_LTR_ONETIME;

PROCEDURE INS_APPS_ONETIME
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_AppRecon WHERE ora_err_tag$ = 'INS_APPS_ONETIME';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_APPS_ONETIME','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO d_app_reconsideration_data (application_id
                                         ,app_receipt_date
                                         ,application_status )
    SELECT ah.application_id
          ,doc_rcvd.received_date
          ,ah.status_cd
    FROM  app_header_stg ah     
      LEFT JOIN(SELECT *
           FROM(SELECT link_ref_id,ds.received_date
                       ,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date,dl.create_ts) rn
                FROM document_set_stg ds 
                  JOIN document_stg d ON ds.document_set_id = d.document_set_id
                  LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                  LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                WHERE doc_type_cd = 'APPLICATION' )
           WHERE rn = 1) doc_rcvd  ON doc_rcvd.link_ref_id = ah.application_id            
    WHERE 1=1
    AND ah.status_cd IN('DISREGARDED','TIMEOUT','COMPLETED')
    AND NOT EXISTS(SELECT 1 FROM d_app_reconsideration_data mp WHERE mp.application_id = ah.application_id)
    Log Errors INTO Errlog_AppRecon ('INS_APPS_ONETIME') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.INS_APPS_ONETIME', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_RECONSIDERATION_DATA', APPLICATION_ID
      FROM Errlog_AppRecon
     WHERE Ora_Err_Tag$ = 'INS_APPS_ONETIME';

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
      VALUES( c_critical, con_pkg, 'PROCESS_APP_RECON_INDICATOR_PKG.INS_APPS_ONETIME', 1, v_desc, v_code, 'D_APP_RECONSIDERATION_DATA');

      COMMIT;
END INS_APPS_ONETIME;


END;
/


grant execute on PROCESS_APP_RECON_INDICATOR_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;