alter session set plsql_code_type = native;

create or replace package APP_PROCESSING_TIMELINESS_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE INS_APPLICATIONS;
  PROCEDURE UPD_APP_DOC_AFTER_TRM;
  PROCEDURE UPD_APPLICATIONS;  
  PROCEDURE UPD_APPLICATION_TERM_LTR;  
  PROCEDURE UPD_APP_TN411_LTR;  
  PROCEDURE UPD_APP_FTP_LTR;  
  PROCEDURE UPD_APP_FORWARD_TASK;
  PROCEDURE UPD_APP_DATA_EVAL_TASK;
  PROCEDURE UPD_APP_OPEN_TASK;
  PROCEDURE UPD_APP_BILLABLE;
  PROCEDURE UPD_APP_REFERRAL;    
  PROCEDURE UPD_APP_REACTIVATION;   
  PROCEDURE UPD_APP_MI_ADDED;  
  PROCEDURE UPD_APP_VOIDED_MI;
  PROCEDURE UPD_MODIFIED_FORWARD_TASK;
  PROCEDURE UPD_MODIFIED_APP_REFERRAL;
  PROCEDURE UPD_APP_EXCEPTION;
  PROCEDURE UPD_APP_CYCLE_STOP;
  PROCEDURE UPD_APP_RECENT_DOCUMENT;
      
end;
/

CREATE OR REPLACE PACKAGE BODY APP_PROCESSING_TIMELINESS_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE INS_APPLICATIONS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'INS_APPLICATIONS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_APPLICATIONS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_APP_PROCESSING_TIMELINESS (
          application_id
          ,member_id          
          ,reactivation_date
          ,application_status
          ,coverage_end_date
          ,eligibility_outcome                                          
          ,application_type          
          ,cob_indicator                    
          ,application_status_cd
          ,app_form_cd
          ,mi_determination_dt
          ,receipt_date
          ,scan_date
          ,link_date
          ,document_type
          ,document_form_type
          ,rcvd_during_90day_prd)
    SELECT ah.application_id
          ,ai.client_cin
          ,ah.reactivation_ts
          ,ast.report_label 
          ,ah.renewal_due_date
          ,eeo.report_label eligibility_outcome
          ,apt.report_label
          ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END
          ,ah.status_cd
          ,ah.app_form_cd
          ,ah.first_mi_added_date
          ,doc_rcvd.received_date
          ,doc_rcvd.scan_date
          ,doc_rcvd.link_date
          ,doc_rcvd.document_type
          ,doc_rcvd.doc_form_type    
          ,ah.rcvd_90day_indicator
    FROM  app_header_stg ah
      JOIN app_individual_stg ai ON ah.application_id = ai.application_id AND applicant_ind = 1
      JOIN(SELECT *
           FROM(SELECT link_ref_id,ds.received_date,d.scan_date,dl.create_ts link_date,doc_form_type,COALESCE(tl.report_label,d.doc_type_cd) document_type
                       ,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date,dl.create_ts) rn
                FROM document_set_stg ds 
                  JOIN document_stg d ON ds.document_set_id = d.document_set_id
                  LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                  LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                WHERE doc_type_cd = 'APPLICATION' )
           WHERE rn = 1) doc_rcvd  ON doc_rcvd.link_ref_id = ah.application_id      
      LEFT JOIN (SELECT *
                 FROM (SELECT application_id, app_individual_id, elig_outcome_cd, ROW_NUMBER() OVER(PARTITION BY application_id ORDER BY create_ts DESC) rn
                       FROM app_elig_outcome_stg ) 
                 WHERE rn =1 ) aeo ON (ai.app_individual_id = aeo.app_individual_id AND ai.application_id = aeo.application_id) 
      LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
      LEFT OUTER JOIN app_type_lkup apt  ON ah.app_form_cd = apt.value
      LEFT JOIN elig_outcome_lkup eeo ON eeo.value = aeo.elig_outcome_cd 
    WHERE doc_rcvd.received_date >= to_date('06/07/2016','mm/dd/yyyy')
    AND ah.status_cd != 'DISREGARDED'
    AND NOT EXISTS(SELECT 1 FROM d_app_processing_timeliness mp WHERE mp.application_id = ah.application_id)
    Log Errors INTO Errlog_AppProcTm ('INS_APPLICATIONS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.INS_APPLICATIONS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'INS_APPLICATIONS';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.INS_APPLICATIONS', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END INS_APPLICATIONS;

PROCEDURE UPD_APP_DOC_AFTER_TRM
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_DOC_AFTER_TRM';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_DOC_AFTER_TRM','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM (
            WITH al AS
              (SELECT d.application_id, trm_start_date,trm_end_date, link_date_after_trm, trm_event_end_date,trm_event_start_date
               FROM d_app_processing_timeliness d
                  LEFT JOIN (SELECT *
                             FROM (SELECT i.application_id, r.client_id,start_date trm_start_date,ROW_NUMBER() OVER (PARTITION BY r.client_id ORDER BY start_date,end_date,alert_id) trn
                                          ,COALESCE(end_date,TO_DATE('07/07/7777','mm/dd/yyyy')) trm_end_date
                                   FROM alert_stg  r
                                      JOIN app_individual_stg i ON r.client_id = i.client_id
                                   WHERE message_type = 'TRM')
                             WHERE trn = 1) al ON d.application_id = al.application_id)
              SELECT al.*,t.received_date,t.link_date, ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY t.received_date,t.link_date) drn
              FROM al
                LEFT JOIN(SELECT link_ref_id,ds.received_date,d.scan_date,dl.create_ts link_date,doc_form_type,COALESCE(tl.report_label,d.doc_type_cd) document_type                
                          FROM document_set_stg ds 
                           JOIN document_stg d ON ds.document_set_id = d.document_set_id
                           LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                           LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                          WHERE doc_type_cd = 'APPLICATION' ) t ON al.application_id = t.link_ref_id AND t.link_date > al.trm_end_date
                          ) t
              WHERE  drn = 1
              AND (COALESCE(t.trm_event_end_date,TO_DATE('01/01/1900','mm/dd/yyyy')) <> COALESCE(t.trm_end_date,TO_DATE('01/01/1900','mm/dd/yyyy'))   
                OR COALESCE(t.link_date_after_trm,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(t.link_date,TO_DATE('07/07/7777','mm/dd/yyyy'))  
                OR COALESCE(t.trm_event_start_date,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(t.trm_start_date,TO_DATE('07/07/7777','mm/dd/yyyy'))  )
            ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  link_date_after_trm = tmp.link_date
         ,trm_event_end_date = tmp.trm_end_date
         ,trm_event_start_date = tmp.trm_start_date
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_DOC_AFTER_TRM') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_DOC_AFTER_TRM', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_DOC_AFTER_TRM';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_DOC_AFTER_TRM', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_DOC_AFTER_TRM;

PROCEDURE UPD_APPLICATIONS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APPLICATIONS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPLICATIONS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT tmp.*
          FROM(SELECT ah.application_id
                      ,ai.client_cin
                      ,ah.reactivation_ts
                      ,ast.report_label application_status
                      ,ah.renewal_due_date
                      ,eeo.report_label eligibility_outcome
                      ,apt.report_label application_type
                      ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END cob_indicator
                      ,ah.status_cd
                      ,ah.app_form_cd
                      ,ah.first_mi_added_date
                      ,doc_rcvd.received_date
                      ,doc_rcvd.scan_date
                      ,doc_rcvd.link_date
                      ,doc_rcvd.document_type
                      ,doc_rcvd.doc_form_type document_form_type  
                      ,ah.rcvd_90day_indicator
              FROM  app_header_stg ah
                JOIN app_individual_stg ai ON ah.application_id = ai.application_id AND applicant_ind = 1
                JOIN(SELECT *
                     FROM(SELECT link_ref_id,ds.received_date,d.scan_date,dl.create_ts link_date,doc_form_type,COALESCE(tl.report_label,d.doc_type_cd) document_type
                                 ,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY received_date,dl.create_ts) rn
                          FROM document_set_stg ds 
                           JOIN document_stg d ON ds.document_set_id = d.document_set_id
                           LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id AND link_type_cd = 'APPLICATION'
                           LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                          WHERE doc_type_cd = 'APPLICATION' )
                      WHERE rn = 1) doc_rcvd  ON doc_rcvd.link_ref_id = ah.application_id
                LEFT JOIN (SELECT *
                           FROM (SELECT application_id, app_individual_id, elig_outcome_cd, ROW_NUMBER() OVER(PARTITION BY application_id ORDER BY create_ts DESC) rn
                                 FROM app_elig_outcome_stg ) 
                           WHERE rn =1 ) aeo ON (ai.app_individual_id = aeo.app_individual_id AND ai.application_id = aeo.application_id) 
                LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
                LEFT OUTER JOIN app_type_lkup apt  ON ah.app_form_cd = apt.value
                LEFT JOIN elig_outcome_lkup eeo ON eeo.value = aeo.elig_outcome_cd                
              WHERE doc_rcvd.received_date >= to_date('06/07/2016','mm/dd/yyyy')
              --AND ah.status_cd != 'DISREGARDED'
                -- AND dl.create_ts >= TRUNC(sysdate-1) 
                ) tmp
            JOIN d_app_processing_timeliness dmi ON  tmp.application_id = dmi.application_id
            WHERE ( COALESCE(tmp.client_cin,'*') != COALESCE(dmi.member_id,'*')   
             OR COALESCE(tmp.reactivation_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.reactivation_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.application_status,'*') != COALESCE(dmi.application_status,'*')   
              OR COALESCE(tmp.renewal_due_Date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.coverage_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.eligibility_outcome,'*') != COALESCE(dmi.eligibility_outcome,'*')   
              OR COALESCE(tmp.link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.application_type,'*') != COALESCE(dmi.application_type,'*')   
           --   OR COALESCE(tmp.cob_indicator,'*') != COALESCE(dmi.cob_indicator,'*')   
              OR COALESCE(tmp.document_type,'*') != COALESCE(dmi.document_type,'*')   
              OR COALESCE(tmp.document_form_type,'*') != COALESCE(dmi.document_form_type,'*') 
              OR COALESCE(tmp.app_form_cd,'*') != COALESCE(dmi.app_form_cd,'*') 
              OR COALESCE(tmp.status_cd,'*') != COALESCE(dmi.application_status_cd,'*') 
              OR COALESCE(tmp.rcvd_90day_indicator,'*') != COALESCE(dmi.rcvd_during_90day_prd,'*') 
              OR COALESCE(tmp.first_mi_added_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.mi_determination_dt, TO_DATE('07/07/7777','mm/dd/yyyy')) )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  member_id = tmp.client_cin
          ,reactivation_date = tmp.reactivation_ts
          ,application_status = tmp.application_status
          ,coverage_end_date = tmp.renewal_due_Date
          ,eligibility_outcome = tmp.eligibility_outcome        
          ,link_date = tmp.link_date
          ,receipt_date = tmp.received_date
          ,scan_date = tmp.scan_date          
          ,application_type = tmp.application_type
         -- ,cob_indicator = tmp.cob_indicator    --TNERPS-5347
          ,document_type = tmp.document_type
          ,document_form_type = tmp.document_form_type
          ,mi_determination_dt = tmp.first_mi_added_date
          ,app_form_cd = tmp.app_form_cd
          ,application_status_cd = tmp.status_cd
          ,rcvd_during_90day_prd = tmp.rcvd_90day_indicator
      Log Errors INTO Errlog_AppProcTm ('UPD_APPLICATIONS') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APPLICATIONS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APPLICATIONS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;     

    COMMIT; 

    UPD_APP_DOC_AFTER_TRM;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APPLICATIONS', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APPLICATIONS;

PROCEDURE UPD_APPLICATION_TERM_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APPLICATION_TERM_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APPLICATION_TERM_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT * FROM
            (SELECT   dmi.term_date,dmi.term_ltr_mailed_date,dmi.application_id, dmi.recon_period_end_date, dmi.sla, dmi.jeopardy_days
                ,letter_mailed_date,response_due_date,ll.nw_recon_period_end_date   
                FROM  d_app_processing_timeliness dmi 
                   LEFT JOIN (SELECT *
                         FROM (SELECT letter_mailed_date,response_due_date,TRUNC(response_due_date+90) nw_recon_period_end_date, reference_id application_id,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn  
                               FROM  letters_stg lr                          
                                JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id                   
                               WHERE lr.letter_type_cd IN ('TN 411', 'TN 408', 'TN 408ftp') 
                               AND ll.reference_type = 'APP_HEADER'
                               AND lr.letter_status_cd = 'MAIL'
                               AND lr.letter_request_type IN('L','S') )
                          WHERE rn = 1) ll  ON ll.application_id = dmi.application_id  ) tmp                   
           WHERE ( COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_date, TO_DATE('07/07/7777','mm/dd/yyyy'))         
          OR COALESCE(tmp.letter_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.term_ltr_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
          OR COALESCE(tmp.nw_recon_period_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.recon_period_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))        
        ) 
        ) tmp ON (tmp.application_id = s.application_id) 
    WHEN MATCHED THEN UPDATE
     SET  term_date = tmp.response_due_date    
         ,term_ltr_mailed_date = tmp.letter_mailed_date
         ,recon_period_end_date = tmp.nw_recon_period_end_date
       --  ,sla = tmp.nw_sla
       --  ,jeopardy_days = tmp.nw_jeopardy_days
     Log Errors INTO Errlog_AppProcTm ('UPD_APPLICATION_TERM_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APPLICATION_TERM_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APPLICATION_TERM_LTR';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APPLICATION_TERM_LTR', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APPLICATION_TERM_LTR;


PROCEDURE UPD_APP_TN411_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_TN411_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_TN411_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT tmp.*                
          FROM (SELECT ll.reference_id application_id, MAX(letter_mailed_date) last_tn411_mailed_date
                FROM letters_stg lr 
                  JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id 
                WHERE lr.letter_type_cd = 'TN 411' 
                AND ll.reference_type = 'APP_HEADER'
                AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L'                  
                --AND (lr.letter_create_ts >= TRUNC(sysdate-1)
                 --OR lr.letter_update_ts >= TRUNC(sysdate-1)  )
                GROUP BY ll.reference_id) tmp
            JOIN d_app_processing_timeliness dmi ON  tmp.application_id = dmi.application_id              
          WHERE COALESCE(tmp.last_tn411_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.tn411_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))                   
        ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  tn411_mailed_date = tmp.last_tn411_mailed_date            
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_TN411_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_TN411_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_TN411_LTR';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_TN411_LTR', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_TN411_LTR;

PROCEDURE UPD_APP_FTP_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_FTP_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_FTP_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT tmp.*                
          FROM (SELECT ll.reference_id application_id, MAX(letter_mailed_date) last_ftp_mailed_date
                FROM letters_stg lr 
                  JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id 
                WHERE lr.letter_type_cd IN('TN 408ftp', 'TN 409ftp') 
                AND ll.reference_type = 'APP_HEADER'
                AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L'                  
                --AND (lr.letter_create_ts >= TRUNC(sysdate-1)
                 --OR lr.letter_update_ts >= TRUNC(sysdate-1)  )
                GROUP BY ll.reference_id) tmp
            JOIN d_app_processing_timeliness dmi ON  tmp.application_id = dmi.application_id              
          WHERE COALESCE(tmp.last_ftp_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.ftp_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))                   
        ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  ftp_mailed_date = tmp.last_ftp_mailed_date            
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_FTP_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_FTP_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_FTP_LTR';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_FTP_LTR', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_FTP_LTR;


PROCEDURE UPD_APP_FORWARD_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_FORWARD_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_FORWARD_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM(SELECT  i.step_instance_id nw_fwd_task_id
                       ,i.hist_create_ts fwd_create_ts
                       ,sfwd.first_name||' '||sfwd.last_name nw_staff_fwd_by
                       ,sfwdto.first_name||' '||sfwdto.last_name nw_staff_fwd_to
                       ,step_instance_history_id
                       ,sfwd.staff_type_cd nw_fwdby_staff_type
                       ,sfwdto.staff_type_cd nw_fwdto_staff_type
                       ,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY step_instance_id,i.hist_create_ts,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC) trn 
                       ,dmi.fwd_task_id
                       ,dmi.forward_task_to_state_dt
                       ,dmi.staff_fwd_by
                       ,dmi.fwdby_staff_type 
                       ,dmi.staff_fwd_to
                       ,dmi.fwdto_staff_type 
                       ,dmi.application_id                       
                       ,i.ref_id
                 FROM  step_instance_stg i 
                     JOIN d_app_processing_timeliness dmi ON  i.ref_id = dmi.application_id
                     JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                     LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                     LEFT JOIN d_staff sfwd   ON i.forwarded_by = TO_CHAR(sfwd.staff_id)
                     LEFT JOIN d_staff sfwdto  ON i.owner = TO_CHAR(sfwdto.staff_id)                         
                 WHERE ref_type = 'APP_HEADER'                
                 AND ((sfwd.staff_type_cd = 'PROJECT_STAFF' AND sfwdto.staff_type_cd = 'STATE') 
                   OR d.business_unit_name = 'HCFA Verifications') ) tmp
            WHERE trn = 1     
            AND ( COALESCE(tmp.fwd_create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.forward_task_to_state_dt, TO_DATE('07/07/7777','mm/dd/yyyy'))  
              OR COALESCE(tmp.nw_fwd_task_id,0) != COALESCE(tmp.fwd_task_id,0)   
              OR COALESCE(tmp.nw_staff_fwd_by,'*') != COALESCE(tmp.staff_fwd_by,'*')   
              OR COALESCE(tmp.nw_fwdby_staff_type,'*') != COALESCE(tmp.fwdby_staff_type,'*')   
              OR COALESCE(tmp.nw_staff_fwd_to,'*') != COALESCE(tmp.staff_fwd_to,'*')   
              OR COALESCE(tmp.nw_fwdto_staff_type,'*') != COALESCE(tmp.fwdto_staff_type,'*') )                           
        ) tmp ON ( tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  forward_task_to_state_dt = tmp.fwd_create_ts
         ,fwd_task_id = tmp.nw_fwd_task_id
         ,staff_fwd_by = tmp.nw_staff_fwd_by
         ,fwdby_staff_type = tmp.nw_fwdby_staff_type
         ,staff_fwd_to = tmp.nw_staff_fwd_to
         ,fwdto_staff_type = tmp.nw_fwdto_staff_type
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_FORWARD_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_FORWARD_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_FORWARD_TASK';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_FORWARD_TASK', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_FORWARD_TASK;


PROCEDURE UPD_APP_DATA_EVAL_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_DATA_EVAL_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_DATA_EVAL_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING ( SELECT *
                FROM(SELECT i.step_instance_id nw_de_task_id
                        ,i.create_ts nw_de_task_create_date
                        ,i.completed_ts nw_de_task_complete_date
                        ,CASE WHEN hist_status = 'CLAIMED' AND co.staff_type_cd = 'STATE' THEN i.hist_create_ts ELSE NULL END nw_detask_cycle_stop_date                    
                        ,step_instance_history_id                                
                        ,hist_status nw_de_task_status                                                              
                        ,ROW_NUMBER() OVER (PARTITION BY i.ref_id ORDER BY step_instance_id,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC,step_instance_history_id) vrn
                        ,dmi.de_task_id
                        ,dmi.de_task_create_date
                        ,dmi.de_task_complete_date
                        ,dmi.detask_cycle_stop_date                
                        ,dmi.de_task_status                      
                        ,dmi.application_id                       
                        ,i.ref_id
                   FROM  step_instance_stg i
                     JOIN d_app_processing_timeliness dmi ON  i.ref_id = dmi.application_id
                     JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                     LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                   WHERE ref_type = 'APP_HEADER'                  
                   AND task_name ='Data Evaluation' 
                   AND i.create_ts >= dmi.receipt_date) tmp                   
                WHERE vrn = 1                 
                AND ( COALESCE(tmp.nw_de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_de_task_complete_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.de_task_complete_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_detask_cycle_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.detask_cycle_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_de_task_id,0) != COALESCE(tmp.de_task_id,0)   
                  OR COALESCE(tmp.nw_de_task_status,'*') != COALESCE(tmp.de_task_status,'*')  )
        ) tmp ON ( tmp.application_id = s.application_id )
    WHEN MATCHED THEN UPDATE
     SET  de_task_create_date = tmp.nw_de_task_create_date
         ,de_task_complete_date = tmp.nw_de_task_complete_date
         ,detask_cycle_stop_date = tmp.nw_detask_cycle_stop_date
         ,de_task_id = tmp.nw_de_task_id
         ,de_task_status = tmp.nw_de_task_status       
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_DATA_EVAL_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_DATA_EVAL_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_DATA_EVAL_TASK';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_DATA_EVAL_TASK', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_DATA_EVAL_TASK;

PROCEDURE UPD_APP_OPEN_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_OPEN_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_OPEN_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT dmi.open_task_name
                  ,dmi.open_task_bu_name
                  ,dmi.open_task_owner_name
                  ,dmi.open_task_owner_type
                  ,dmi.open_task_id
                  ,dmi.open_task_status                      
                  ,dmi.application_id  
                  ,tmp.*
          FROM  d_app_processing_timeliness dmi 
            LEFT JOIN(SELECT *
                      FROM (SELECT i.step_instance_id nw_open_task_id
                                   ,i.create_ts nw_open_task_create_date                                                
                                   ,step_instance_history_id                                
                                   ,hist_status nw_open_task_status                                                              
                                   ,i.task_name nw_open_task_name
                                   ,CASE WHEN hist_status = 'CLAIMED' THEN i.first_name||' '||i.last_name ELSE NULL END nw_open_task_owner_name
                                   ,i.business_unit_name nw_open_task_bu_name
                                   ,i.staff_type_cd nw_open_task_owner_type
                                   ,ROW_NUMBER() OVER (PARTITION BY i.ref_id ORDER BY i.step_instance_id DESC, DECODE(i.hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1)) vrn                       
                                   ,i.ref_id
                            FROM (SELECT *
                                  FROM (SELECT i.*,dt.task_name,co.first_name,last_name,co.staff_type_cd,business_unit_name,
                                              ROW_NUMBER() OVER (PARTITION BY i.ref_id,i.step_instance_id ORDER BY DECODE(hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1) DESC,step_instance_id,step_instance_history_id) srn
                                        FROM step_instance_stg i
                                          JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                                          LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                                          LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                                        WHERE ref_type = 'APP_HEADER' )
                                  WHERE srn = 1 ) i 
                            WHERE hist_status IN('UNCLAIMED','CLAIMED'))
                      WHERE vrn = 1 )  tmp ON tmp.ref_id = dmi.application_id
          WHERE ( COALESCE(tmp.nw_open_task_id,0) != COALESCE(dmi.open_task_id,0)   
          OR COALESCE(tmp.nw_open_task_status,'*') != COALESCE(dmi.open_task_status,'*')  
          OR COALESCE(tmp.nw_open_task_name,'*') != COALESCE(dmi.open_task_name,'*')  
          OR COALESCE(tmp.nw_open_task_owner_name,'*') != COALESCE(dmi.open_task_owner_name,'*')  
          OR COALESCE(tmp.nw_open_task_bu_name,'*') != COALESCE(dmi.open_task_bu_name,'*')  
          OR COALESCE(tmp.nw_open_task_owner_type,'*') != COALESCE(dmi.open_task_owner_type,'*')   )
        ) tmp ON ( tmp.application_id = s.application_id )
    WHEN MATCHED THEN UPDATE
     SET  open_task_id = tmp.nw_open_task_id
         ,open_task_status = tmp.nw_open_task_status
         ,open_task_name = tmp.nw_open_task_name
         ,open_task_owner_name = tmp.nw_open_task_owner_name
         ,open_task_bu_name = tmp.nw_open_task_bu_name
         ,open_task_owner_type = tmp.nw_open_task_owner_type       
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_OPEN_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_OPEN_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_OPEN_TASK';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_OPEN_TASK', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_OPEN_TASK;

PROCEDURE UPD_APP_BILLABLE
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_BILLABLE';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_BILLABLE','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT el.application_id
                ,TRUNC(el.create_ts) nw_billable_outcome_date, outcome_cd nw_bo_outcome_cd
                ,ds.first_name||' '||ds.last_name nw_bo_staff_completed_by               
                ,dmi.billable_outcome_date
                ,dmi.bo_staff_completed_by
                ,dmi.bo_outcome_cd
                ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.application_id,el.create_ts) brn
            FROM d_app_processing_timeliness dmi
              JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
              LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
            WHERE app_event_cd = 'STATUS_CHANGE'
            AND action_cd = 'END_APPLICATION_TRACKING'  
            AND outcome_cd IN('REJECTED','APPROVED')                          
            AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                           AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) ) tmp          
          WHERE tmp.brn = 1
          AND ( COALESCE(tmp.nw_bo_outcome_cd,'*') != COALESCE(tmp.bo_outcome_cd,'*')                     
          OR COALESCE(tmp.nw_bo_staff_completed_by,'*') != COALESCE(tmp.bo_staff_completed_by,'*')  
          OR COALESCE(tmp.nw_billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  )
          ) tmp ON ( tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  bo_outcome_cd = tmp.nw_bo_outcome_cd
         ,bo_staff_completed_by = tmp.nw_bo_staff_completed_by
         ,billable_outcome_date = tmp.nw_billable_outcome_date
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_BILLABLE') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_BILLABLE', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_BILLABLE';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_BILLABLE', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_BILLABLE;

PROCEDURE UPD_APP_REFERRAL
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_REFERRAL';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_REFERRAL','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT el.application_id                
                   ,TRUNC(el.create_ts) nw_rf_outcome_date, outcome_cd nw_rf_outcome_cd                         
                   ,ds.first_name||' '||ds.last_name nw_rf_staff_completed_by                   
                   ,dmi.refer_to_hcfa_date
                   ,dmi.rf_staff_completed_by
                   ,dmi.rf_outcome_cd
                  ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.application_id,el.create_ts) rrn
            FROM d_app_processing_timeliness dmi
              JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
              LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
            WHERE el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE'                          
             ) tmp          
          WHERE tmp.rrn = 1
          AND ( COALESCE(tmp.nw_rf_outcome_cd,'*') != COALESCE(tmp.rf_outcome_cd,'*')                     
          OR COALESCE(tmp.nw_rf_staff_completed_by,'*') != COALESCE(tmp.rf_staff_completed_by,'*')  
          OR COALESCE(tmp.nw_rf_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.refer_to_hcfa_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  rf_outcome_cd = tmp.nw_rf_outcome_cd
         ,rf_staff_completed_by = tmp.nw_rf_staff_completed_by
         ,refer_to_hcfa_date = tmp.nw_rf_outcome_date
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_REFERRAL') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_REFERRAL', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_REFERRAL';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_REFERRAL', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_REFERRAL;

PROCEDURE UPD_APP_REACTIVATION
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_REACTIVATION';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_REACTIVATION','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM  (SELECT t.application_id
                        ,e.create_ts nw_reactivation_event_date
                        ,t.cycle_stop
                        ,e.app_event_context nw_reactivation_reason      
                        ,t.reactivation_reason
                        ,t.reactivation_event_date
                        ,ROW_NUMBER() OVER (PARTITION BY t.application_id ORDER BY e.create_ts DESC) rn      
                 FROM d_app_processing_timeliness t
                  JOIN app_event_log_stg e ON t.application_id = e.application_id
                 WHERE  e.app_event_cd ='APP_REACTIVATED'
                 AND e.action_cd ='APP_REACTIVATED'
                 AND TRUNC(e.create_ts) <= TRUNC(t.cycle_stop) ) t
          WHERE t.rn = 1
          AND (COALESCE(t.reactivation_reason,'*') <> COALESCE(t.nw_reactivation_reason,'*')
              OR COALESCE(t.reactivation_event_date,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(t.nw_reactivation_event_date,TO_DATE('07/07/7777','mm/dd/yyyy')) )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  reactivation_reason = tmp.nw_reactivation_reason
         ,reactivation_event_date = tmp.nw_reactivation_event_date         
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_REACTIVATION') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_REACTIVATION', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_REACTIVATION';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_REACTIVATION', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_REACTIVATION;

PROCEDURE UPD_APP_MI_ADDED
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_MI_ADDED';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_MI_ADDED','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
   INTO  d_app_processing_timeliness s
   USING ( SELECT t.application_id, t.modified_mi_added_date,mi.mi_added_date
 FROM d_app_processing_timeliness t
  LEFT JOIN(SELECT application_id, MIN(mi_added_date) mi_added_date
            FROM (SELECT application_id, MIN(create_ts) mi_added_date
                  FROM app_missing_info_stg
                  WHERE 1=1
                  --AND application_id = 711074
                  AND (satisfied_date IS NULL OR (satisfied_date IS NOT NULL AND COALESCE(satisfied_reason_cd,'X') != 'void'))
                  GROUP BY application_id
                  UNION
                  SELECT application_id, MIN(create_ts) mi_added_date
                  FROM app_missing_info_stg m
                  WHERE 1=1
                  --AND application_id = 711074
                  AND COALESCE(satisfied_reason_cd,'X') = 'void'                                 
                  AND NOT EXISTS(SELECT 1 FROM app_event_log_stg e WHERE e.application_id = m.application_id AND TRUNC(e.create_ts) = TRUNC(m.create_ts) AND e.app_event_cd = 'RFE_STATUS_CHANGE' AND e.action_cd = 'DISREGARDED') 
                  GROUP BY application_id      ) 
            GROUP BY application_id ) mi ON t.application_id = mi.application_id
  WHERE   COALESCE(t.modified_mi_added_date,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(mi.mi_added_date,TO_DATE('07/07/7777','mm/dd/yyyy')) 
   ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  modified_mi_added_date = tmp.mi_added_date         
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_MI_ADDED') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_ADDED', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_MI_ADDED';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_ADDED', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_MI_ADDED;

PROCEDURE UPD_APP_VOIDED_MI
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_VOIDED_MI';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_VOIDED_MI','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
   INTO  d_app_processing_timeliness s
   USING ( SELECT t.application_id,t.mi_voided_date,mi.voided_date
           FROM d_app_processing_timeliness t
              LEFT JOIN(SELECT mi.application_id,mi.voided_date,mi.create_ts
                        FROM(SELECT *
                              FROM (SELECT application_id,create_ts,missing_info_id,satisfied_reason_cd,voided_date,ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY create_ts,missing_info_id) rn
                                    FROM app_missing_info_stg )
                               WHERE rn = 1) mi
                        WHERE mi.satisfied_reason_cd = 'void'
                        AND TRUNC(mi.voided_date) = TRUNC(mi.create_ts)
                        AND NOT EXISTS(SELECT 1 FROM app_missing_info_stg mi1 WHERE mi.application_id = mi1.application_id AND mi.missing_info_id != mi1.missing_info_id AND mi1.satisfied_reason_cd != 'void') ) mi ON t.application_id = mi.application_id                               
            WHERE COALESCE(t.mi_voided_date,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(mi.voided_date,TO_DATE('07/07/7777','mm/dd/yyyy'))              
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  mi_voided_date = tmp.voided_date         
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_VOIDED_MI') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_VOIDED_MI', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_VOIDED_MI';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_VOIDED_MI', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_VOIDED_MI;


PROCEDURE UPD_MODIFIED_FORWARD_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_MODIFIED_FORWARD_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_MODIFIED_FORWARD_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT t.application_id,t.trm_event_end_date,fwd.fwd_create_ts, de.nw_detask_cycle_stop_date
          FROM d_app_processing_timeliness t
            LEFT JOIN(SELECT *
                      FROM(SELECT  i.step_instance_id nw_fwd_task_id
                                   ,i.hist_create_ts fwd_create_ts                       
                                   ,ROW_NUMBER() OVER (PARTITION BY ref_id,ref_type ORDER BY step_instance_id,i.hist_create_ts,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC) trn                                    
                                   ,i.ref_id application_id
                            FROM  step_instance_stg i 
                              JOIN (SELECT * FROM d_app_processing_timeliness dmi
                                    WHERE trm_event_end_date IS NOT NULL) dmi ON  i.ref_id = dmi.application_id
                              JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                              LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                              LEFT JOIN d_staff sfwd   ON i.forwarded_by = TO_CHAR(sfwd.staff_id)
                              LEFT JOIN d_staff sfwdto  ON i.owner = TO_CHAR(sfwdto.staff_id)                         
                            WHERE ref_type = 'APP_HEADER'                
                            AND TRUNC(i.hist_create_ts) >= TRUNC(dmi.link_date_after_trm)
                            --AND TRUNC(i.hist_create_ts) >= TRUNC(dmi.trm_event_end_date)
                            AND ((sfwd.staff_type_cd = 'PROJECT_STAFF' AND sfwdto.staff_type_cd = 'STATE') 
                              OR d.business_unit_name = 'HCFA Verifications') ) tmp
                      WHERE trn = 1 )fwd ON t.application_id = fwd.application_id
             LEFT JOIN ( SELECT *
                         FROM(SELECT i.step_instance_id nw_de_task_id
                                    ,i.create_ts nw_de_task_create_date
                                    ,i.completed_ts nw_de_task_complete_date
                                    ,CASE WHEN hist_status = 'CLAIMED' AND co.staff_type_cd = 'STATE' THEN i.hist_create_ts ELSE NULL END nw_detask_cycle_stop_date                    
                                    ,step_instance_history_id                                
                                    ,hist_status nw_de_task_status                                                              
                                    ,ROW_NUMBER() OVER (PARTITION BY i.ref_id ORDER BY step_instance_id,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC,step_instance_history_id) vrn                         
                                    ,i.ref_id application_id
                              FROM  step_instance_stg i
                                JOIN (SELECT * FROM d_app_processing_timeliness dmi
                                      WHERE trm_event_end_date IS NOT NULL) dmi ON  i.ref_id = dmi.application_id
                                JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                                LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                              WHERE ref_type = 'APP_HEADER'                  
                              AND task_name ='Data Evaluation' 
                              --AND i.create_ts >= dmi.receipt_date
                              AND TRUNC(i.create_ts) >= TRUNC(dmi.link_date_after_trm)
                              --AND TRUNC(i.create_ts) >= TRUNC(dmi.trm_event_end_date)
                              ) tmp                   
                         WHERE vrn = 1 ) de ON t.application_id = de.application_id
            WHERE t.trm_event_end_date IS NOT NULL 
            AND ( COALESCE(fwd.fwd_create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.modified_fwd_to_state_dt, TO_DATE('07/07/7777','mm/dd/yyyy'))      
              OR  COALESCE(de.nw_detask_cycle_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.modified_detask_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy'))      )
        ) tmp ON ( tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  modified_fwd_to_state_dt = tmp.fwd_create_ts 
         ,modified_detask_stop_date = tmp.nw_detask_cycle_stop_date
     Log Errors INTO Errlog_AppProcTm ('UPD_MODIFIED_FORWARD_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_MODIFIED_FORWARD_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_MODIFIED_FORWARD_TASK';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_MODIFIED_FORWARD_TASK', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_MODIFIED_FORWARD_TASK;

PROCEDURE UPD_MODIFIED_APP_REFERRAL
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_MODIFIED_APP_REFERRAL';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_MODIFIED_APP_REFERRAL','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT t.application_id,t.trm_event_end_date,btmp.nw_billable_outcome_date,rftmp.nw_rf_outcome_date,tah.mi_added_after_trm
          FROM d_app_processing_timeliness t
            LEFT JOIN (SELECT *
                       FROM(SELECT el.application_id
                                ,TRUNC(el.create_ts) nw_billable_outcome_date, outcome_cd nw_bo_outcome_cd
                                ,ds.first_name||' '||ds.last_name nw_bo_staff_completed_by               
                                ,dmi.billable_outcome_date
                                ,dmi.bo_staff_completed_by
                                ,dmi.bo_outcome_cd
                               ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.application_id,el.create_ts) brn                           
                            FROM d_app_processing_timeliness dmi
                              JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
                              LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
                            WHERE TRUNC(el.create_ts) >= TRUNC(dmi.link_date_after_trm)
                            --TRUNC(el.create_ts) >= TRUNC(dmi.trm_event_end_date)
                            AND app_event_cd = 'STATUS_CHANGE'
                            AND action_cd = 'END_APPLICATION_TRACKING'  
                            AND outcome_cd IN('REJECTED','APPROVED')                          
                            AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                                            AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) )
                       WHERE brn = 1 )   btmp ON t.application_id  = btmp.application_id
              LEFT JOIN (SELECT *
                         FROM (SELECT el.application_id                
                                      ,TRUNC(el.create_ts) nw_rf_outcome_date, outcome_cd nw_rf_outcome_cd                         
                                      ,ds.first_name||' '||ds.last_name nw_rf_staff_completed_by                   
                                      ,dmi.refer_to_hcfa_date
                                      ,dmi.rf_staff_completed_by
                                      ,dmi.rf_outcome_cd
                                      ,ROW_NUMBER() OVER (PARTITION BY el.application_id ORDER BY el.application_id,el.create_ts) rrn
                                FROM d_app_processing_timeliness dmi
                                  JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
                                  LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
                                WHERE el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE' 
                                AND TRUNC(el.create_ts) >= TRUNC(dmi.link_date_after_trm)
                                --AND TRUNC(el.create_ts) >= TRUNC(dmi.trm_event_end_date)
                                ) tmp          
                          WHERE tmp.rrn = 1) rftmp ON t.application_id = rftmp.application_id   
              LEFT JOIN(SELECT application_id, mi_added_after_trm
                        FROM (SELECT d.application_id,m.create_ts mi_added_after_trm,missing_info_id,satisfied_reason_cd,voided_date,ROW_NUMBER() OVER (PARTITION BY m.application_id ORDER BY m.create_ts,missing_info_id) rn
                              FROM d_app_processing_timeliness d
                                JOIN app_missing_info_stg m ON d.application_id = m.application_id
                              WHERE 
                                TRUNC(m.create_ts) >= TRUNC(d.link_date_after_trm)
                              --TRUNC(m.create_ts) >= TRUNC(d.trm_event_end_date)
                                AND (satisfied_date IS NULL
                                OR satisfied_reason_cd != 'void'
                                OR (satisfied_reason_cd = 'void'   
                                AND NOT EXISTS(SELECT 1 FROM app_event_log_stg e WHERE e.application_id = m.application_id AND TRUNC(e.create_ts) = TRUNC(m.satisfied_date) AND TRUNC(e.create_ts) = TRUNC(m.create_ts) AND e.app_event_cd = 'RFE_STATUS_CHANGE' AND e.action_cd = 'DISREGARDED') ) ) ) 
                        WHERE rn = 1) tah ON t.application_id = tah.application_id                            
          WHERE t.trm_event_end_date IS NOT NULL
          AND (COALESCE(btmp.nw_billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.modified_billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
           OR COALESCE(rftmp.nw_rf_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.modified_refer_to_hcfa_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
           OR COALESCE(t.mi_added_dt_after_trm,TO_DATE('07/07/7777','mm/dd/yyyy')) <> COALESCE(tah.mi_added_after_trm,TO_DATE('07/07/7777','mm/dd/yyyy')) ) 
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  modified_billable_outcome_date = tmp.nw_billable_outcome_date
         ,modified_refer_to_hcfa_date = tmp.nw_rf_outcome_date  
         ,mi_added_dt_after_trm = tmp.mi_added_after_trm
     Log Errors INTO Errlog_AppProcTm ('UPD_MODIFIED_APP_REFERRAL') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_MODIFIED_APP_REFERRAL', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_MODIFIED_APP_REFERRAL';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_MODIFIED_APP_REFERRAL', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_MODIFIED_APP_REFERRAL;

PROCEDURE UPD_APP_EXCEPTION
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_EXCEPTION';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_EXCEPTION','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT txc.callback_date nw_callback_date
                    ,ttx.new_cycle_start_date nw_new_cycle_start_date
                    ,ttx.new_cycle_end_date nw_new_cycle_end_date
                    ,ttx.hcfa_reactivation_flag nw_hcfa_reactivation_flag
                    ,ttx.exception_type nw_exception_type 
                    ,COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag,'N') nw_exclusion_flag
                    ,dmi.callback_date
                    ,dmi.excp_new_cycle_start_date
                    ,dmi.excp_new_cycle_end_date
                    ,dmi.hcfa_reactivation_flag
                    ,dmi.exception_type                     
                    ,dmi.application_id
                    ,dmi.exclusion_flag
                    ,mttx.new_cycle_end_date md_new_cycle_end_date
                    ,mtxc.md_callback_date 
                    ,dmi.modified_excp_cycle_end_date
                    ,dmi.modified_callback_date
            FROM d_app_processing_timeliness dmi      
              LEFT OUTER JOIN (SELECT ttx.app_id,txl.exception_type,ttx.hcfa_reactivation_flag,ttx.new_cycle_start_date,ttx.new_cycle_end_date,ttx.exclusion_flag,ttx.create_datetime,
                                      ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY ttx.create_datetime DESC) ttxrn
                               FROM d_app_processing_timeliness dmi
                                JOIN ts_timeliness_exception ttx  ON dmi.application_id = ttx.app_id
                                JOIN ts_exception_type_lkup txl ON ttx.exception_type_id = txl.exception_type_id                  
                               WHERE txl.exception_type NOT IN('Callback','Letter Exception') 
                               AND ttx.ignore_flag = 'N'   ) ttx  
                ON ttx.app_id = dmi.application_id    
                AND ttx.ttxrn = 1
              LEFT OUTER JOIN (SELECT ttx.app_id,txl.exception_type,ttx.hcfa_reactivation_flag,ttx.new_cycle_start_date,ttx.new_cycle_end_date,ttx.exclusion_flag,ttx.create_datetime,
                                      ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY ttx.create_datetime DESC) ttxrn
                               FROM d_app_processing_timeliness dmi
                                JOIN ts_timeliness_exception ttx  ON dmi.application_id = ttx.app_id
                                JOIN ts_exception_type_lkup txl ON ttx.exception_type_id = txl.exception_type_id                  
                               WHERE TRUNC(ttx.create_datetime) >= TRUNC(dmi.trm_event_end_date)
                               AND txl.exception_type NOT IN('Callback','Letter Exception') 
                               AND ttx.ignore_flag = 'N'   ) mttx  
                ON mttx.app_id = dmi.application_id    
                AND mttx.ttxrn = 1
              LEFT JOIN (SELECT txc.app_id, txc.callback_date,txc.exclusion_flag,ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY txc.callback_date DESC) txcrn
                         FROM d_app_processing_timeliness dmi
                          JOIN ts_timeliness_exception txc ON dmi.application_id = txc.app_id 
                          JOIN ts_exception_type_lkup  tl ON txc.exception_type_id = tl.exception_type_id 
                         WHERE tl.exception_type = 'Callback'
                         AND txc.ignore_flag = 'N' ) txc
                ON txc.app_id = dmi.application_id    
                AND txc.txcrn = 1
              LEFT JOIN (SELECT txc.app_id, txc.callback_date md_callback_date,txc.exclusion_flag,ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY txc.callback_date DESC) txcrn
                         FROM d_app_processing_timeliness dmi
                          JOIN ts_timeliness_exception txc ON dmi.application_id = txc.app_id 
                          JOIN ts_exception_type_lkup  tl ON txc.exception_type_id = tl.exception_type_id 
                         WHERE TRUNC(txc.create_datetime) >= TRUNC(dmi.trm_event_end_date)
                         AND tl.exception_type = 'Callback'
                         AND txc.ignore_flag = 'N' ) mtxc
                ON mtxc.app_id = dmi.application_id    
                AND mtxc.txcrn = 1                
              LEFT JOIN (SELECT lxc.app_id,lxc.exclusion_flag, lxc.create_datetime, ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY lxc.create_datetime DESC) lxcrn
                         FROM d_app_processing_timeliness dmi
                          JOIN ts_timeliness_exception lxc  ON dmi.application_id = lxc.app_id 
                          JOIN ts_exception_type_lkup  ll ON lxc.exception_type_id = ll.exception_type_id 
                         WHERE  ll.exception_type = 'Letter Exception'
                         AND lxc.ignore_flag = 'N' ) lxc
                ON lxc.app_id = dmi.application_id    
                AND lxc.lxcrn = 1
            WHERE  COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag,'N') IS NOT NULL  
               OR txc.callback_date IS NOT NULL
                OR ttx.new_cycle_start_date IS NOT NULL
                OR ttx.new_cycle_end_date IS NOT NULL
                OR ttx.hcfa_reactivation_flag IS NOT NULL
                OR ttx.exception_type IS NOT NULL
                OR mttx.new_cycle_end_date IS NOT NULL
                OR mtxc.md_callback_date IS NOT NULL) tmp
          WHERE COALESCE(tmp.nw_callback_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.callback_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_new_cycle_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.excp_new_cycle_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_new_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.excp_new_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_hcfa_reactivation_flag,'*') != COALESCE(tmp.hcfa_reactivation_flag,'*') 
            OR COALESCE(tmp.nw_exception_type,'*') != COALESCE(tmp.exception_type,'*') 
            OR COALESCE(tmp.nw_exclusion_flag,'*') != COALESCE(tmp.exclusion_flag,'*') 
            OR COALESCE(tmp.md_callback_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_callback_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.md_new_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_excp_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  excp_new_cycle_end_date = tmp.nw_new_cycle_end_date
          ,excp_new_cycle_start_date = tmp.nw_new_cycle_start_date
          ,callback_date = tmp.nw_callback_date
          ,hcfa_reactivation_flag = tmp.nw_hcfa_reactivation_flag
          ,exception_type = tmp.nw_exception_type
          ,exclusion_flag = tmp.nw_exclusion_flag
          ,modified_callback_date = tmp.md_callback_date
          ,modified_excp_cycle_end_date = tmp.md_new_cycle_end_date
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_EXCEPTION') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_EXCEPTION', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_EXCEPTION';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_EXCEPTION', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_EXCEPTION;

PROCEDURE UPD_APP_CYCLE_STOP
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN
   
   UPD_APP_MI_ADDED;
   UPD_APP_VOIDED_MI;
   UPD_MODIFIED_FORWARD_TASK;
   UPD_MODIFIED_APP_REFERRAL;
   
   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_CYCLE_STOP';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_CYCLE_STOP','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM(
            SELECT
             TRUNC(COALESCE(excp_new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN reactivation_date END,COALESCE(link_date,de_task_create_date))) nw_cycle_start                     
             ,TRUNC(COALESCE(excp_new_cycle_start_date,CASE WHEN hcfa_reactivation_flag = 'Y' THEN reactivation_date END,
                      CASE WHEN trm_event_end_date IS NOT NULL AND COALESCE(link_date,de_task_create_date) >= TRUNC(trm_event_start_date) THEN link_date_after_trm ELSE COALESCE(link_date,de_task_create_date) END )) nw_modified_cycle_start                     
             ,TRUNC(CASE WHEN dmi.exception_type IN('Processing Error','Other') AND dmi.excp_new_cycle_end_date IS NOT NULL THEN TRUNC(dmi.excp_new_cycle_end_date)
                     ELSE LEAST(COALESCE(CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date),
                        COALESCE(dmi.forward_task_to_state_dt,dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date, CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END ),
                        COALESCE(dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt),
                        COALESCE(dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt) ,
                        COALESCE(dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt, dmi.callback_date )) END)  nw_cycle_stop
             
             ,CASE WHEN dmi.trm_event_end_date IS NOT NULL 
               AND TRUNC(COALESCE(link_date,de_task_create_date)) >= TRUNC(trm_event_start_date) THEN
               TRUNC(CASE WHEN dmi.exception_type IN('Processing Error','Other') AND dmi.modified_excp_cycle_end_date IS NOT NULL THEN TRUNC(dmi.modified_excp_cycle_end_date)
                     ELSE LEAST(COALESCE(CASE WHEN dmi.modified_refer_to_hcfa_date IS NULL THEN dmi.modified_billable_outcome_date  ELSE LEAST(dmi.modified_refer_to_hcfa_date,COALESCE(dmi.modified_billable_outcome_date ,dmi.modified_refer_to_hcfa_date)) END,dmi.modified_fwd_to_state_dt,dmi.mi_added_dt_after_trm,dmi.modified_callback_date,dmi.modified_detask_stop_date),
                        COALESCE(dmi.modified_fwd_to_state_dt,dmi.mi_added_dt_after_trm,dmi.modified_callback_date,dmi.modified_detask_stop_date, CASE WHEN dmi.modified_refer_to_hcfa_date IS NULL THEN dmi.modified_billable_outcome_date  ELSE LEAST(dmi.modified_refer_to_hcfa_date,COALESCE(dmi.modified_billable_outcome_date ,dmi.modified_refer_to_hcfa_date)) END ),
                        COALESCE(dmi.mi_added_dt_after_trm,dmi.modified_callback_date,dmi.modified_detask_stop_date,CASE WHEN dmi.modified_refer_to_hcfa_date IS NULL THEN dmi.modified_billable_outcome_date  ELSE LEAST(dmi.modified_refer_to_hcfa_date,COALESCE(dmi.modified_billable_outcome_date ,dmi.modified_refer_to_hcfa_date)) END,dmi.modified_fwd_to_state_dt),
                        COALESCE(dmi.modified_callback_date,dmi.modified_detask_stop_date,CASE WHEN dmi.modified_refer_to_hcfa_date IS NULL THEN dmi.modified_billable_outcome_date  ELSE LEAST(dmi.modified_refer_to_hcfa_date,COALESCE(dmi.modified_billable_outcome_date ,dmi.modified_refer_to_hcfa_date)) END,dmi.modified_fwd_to_state_dt,dmi.mi_added_dt_after_trm) ,
                        COALESCE(dmi.modified_detask_stop_date,CASE WHEN dmi.modified_refer_to_hcfa_date IS NULL THEN dmi.modified_billable_outcome_date  ELSE LEAST(dmi.modified_refer_to_hcfa_date,COALESCE(dmi.modified_billable_outcome_date ,dmi.modified_refer_to_hcfa_date)) END,dmi.modified_fwd_to_state_dt,dmi.mi_added_dt_after_trm, dmi.modified_callback_date )) END)             
              ELSE
               TRUNC(CASE WHEN dmi.exception_type IN('Processing Error','Other') AND dmi.excp_new_cycle_end_date IS NOT NULL THEN TRUNC(dmi.excp_new_cycle_end_date)
                     ELSE LEAST(COALESCE(CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.modified_mi_added_date,dmi.callback_date,dmi.detask_cycle_stop_date),
                        COALESCE(dmi.forward_task_to_state_dt,dmi.modified_mi_added_date,dmi.callback_date,dmi.detask_cycle_stop_date, CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END ),
                        COALESCE(dmi.modified_mi_added_date,dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt),
                        COALESCE(dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.modified_mi_added_date) ,
                        COALESCE(dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_date IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_date,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_date)) END,dmi.forward_task_to_state_dt,dmi.modified_mi_added_date, dmi.callback_date )) END)             
               END nw_modified_cycle_stop  
             ,CASE WHEN EXISTS (SELECT 1 FROM document_stg d INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                                 WHERE doc_type_cd = 'UPLOAD' AND doc_form_type = 'MULT_RESCAN' AND link_type_cd = 'APPLICATION' AND link_ref_id = dmi.application_id)
                THEN 'Y' ELSE 'N' END nw_multi_applying_member_flag
            ,CASE WHEN dmi.sla IS NULL THEN 
                CASE WHEN dmi.document_form_type = 'LTSS' THEN  TO_NUMBER(sla8.out_var) 
                     WHEN dmi.rcvd_during_90day_prd = 'Y' AND dmi.cob_indicator = 'No' THEN TO_NUMBER(sla5.out_var) ELSE TO_NUMBER(sla8.out_var) END
              ELSE dmi.sla END nw_sla
            ,CASE WHEN dmi.jeopardy_days IS NULL THEN
               CASE WHEN dmi.document_form_type = 'LTSS' THEN TO_NUMBER(jp8.out_var)
                    WHEN  dmi.rcvd_during_90day_prd = 'Y' AND dmi.cob_indicator = 'No' THEN TO_NUMBER(jp5.out_var) ELSE TO_NUMBER(jp8.out_var) END
               ELSE dmi.jeopardy_days  END nw_jeopardy_days                 
             ,dmi.cycle_start
             ,dmi.cycle_stop
             ,dmi.application_id               
             ,dmi.multi_applying_member_flag
             ,dmi.sla
             ,dmi.jeopardy_days
             ,dmi.modified_cycle_stop
             ,dmi.modified_cycle_start
            FROM d_app_processing_timeliness dmi 
              JOIN corp_etl_list_lkup jp8 ON jp8.name = 'APPLICATION_JEOPARDY_DAYS8' AND jp8.value = 'JEOPARDY_DAYS8'
              JOIN corp_etl_list_lkup jp5 ON jp5.name = 'APPLICATION_JEOPARDY_DAYS5' AND jp5.value = 'JEOPARDY_DAYS5'
              JOIN corp_etl_list_lkup sla8 ON sla8.name = 'APPLICATION_SLA_DAYS8' AND sla8.value = 'SLA_DAYS8'
              JOIN corp_etl_list_lkup sla5 ON sla5.name = 'APPLICATION_SLA_DAYS5' AND sla5.value = 'SLA_DAYS5'
            )tmp
          WHERE ( COALESCE(tmp.nw_cycle_start, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.cycle_start, TO_DATE('07/07/7777','mm/dd/yyyy')) 
               OR COALESCE(tmp.nw_cycle_stop, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.cycle_stop, TO_DATE('07/07/7777','mm/dd/yyyy')) 
               OR COALESCE(tmp.nw_modified_cycle_start, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_cycle_start, TO_DATE('07/07/7777','mm/dd/yyyy')) 
               OR COALESCE(tmp.nw_modified_cycle_stop, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_cycle_stop, TO_DATE('07/07/7777','mm/dd/yyyy')) 
               OR  COALESCE(tmp.nw_multi_applying_member_flag, '*') != COALESCE(tmp.multi_applying_member_flag, '*') 
               OR  COALESCE(tmp.nw_jeopardy_days, 0) != COALESCE(tmp.jeopardy_days, 0) 
               OR  COALESCE(tmp.nw_sla, 0) != COALESCE(tmp.sla, 0)   )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  cycle_stop = tmp.nw_cycle_stop  
          ,cycle_start = tmp.nw_cycle_start
          ,modified_cycle_stop = tmp.nw_modified_cycle_stop  
          ,modified_cycle_start = tmp.nw_modified_cycle_start
          ,multi_applying_member_flag = tmp.nw_multi_applying_member_flag
          ,sla = tmp.nw_sla
          ,jeopardy_days = tmp.nw_jeopardy_days
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_CYCLE_STOP') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_CYCLE_STOP', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_CYCLE_STOP';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = record_count + v_err_cnt
         , PROCESSED_COUNT = processed_count + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

    UPD_APP_REACTIVATION;
    
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_CYCLE_STOP', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_CYCLE_STOP;

PROCEDURE UPD_APP_RECENT_DOCUMENT
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_AppProcTm WHERE ora_err_tag$ = 'UPD_APP_RECENT_DOCUMENT';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_RECENT_DOCUMENT','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_app_processing_timeliness s
   USING (SELECT *
          FROM 
            (SELECT dmi.recent_doc_type,dmi.application_id,ds.nw_recent_doc_type
                  ,ROW_NUMBER() OVER (PARTITION BY dmi.application_id ORDER BY received_date DESC) rn
              FROM d_app_processing_timeliness dmi 
                JOIN (SELECT link_ref_id application_id,ds.received_date,COALESCE(tl.report_label,d.doc_type_cd) nw_recent_doc_type
                      FROM document_set_stg ds 
                        JOIN document_stg d ON ds.document_set_id = d.document_set_id
                        JOIN doc_link_stg dl ON d.document_id = dl.document_id   
                        LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                      WHERE link_type_cd = 'APPLICATION') ds ON dmi.application_id = ds.application_id
              WHERE TRUNC(ds.received_date) <= COALESCE(TRUNC(cycle_stop),TRUNC(sysdate)) )  tmp
           WHERE rn = 1
           AND COALESCE(tmp.nw_recent_doc_type, '*') != COALESCE(tmp.recent_doc_type,'*')            
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  recent_doc_type = tmp.nw_recent_doc_type        
     Log Errors INTO Errlog_AppProcTm ('UPD_APP_RECENT_DOCUMENT') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_RECENT_DOCUMENT', 1, Ora_Err_Mesg$, ora_err_number$, 'D_APP_PROCESSING_TIMELINESS', APPLICATION_ID
      FROM Errlog_AppProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_RECENT_DOCUMENT';

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
      VALUES( c_critical, con_pkg, 'APP_PROCESSING_TIMELINESS_PKG.UPD_APP_RECENT_DOCUMENT', 1, v_desc, v_code, 'D_APP_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_RECENT_DOCUMENT;

END;
/


grant execute on APP_PROCESSING_TIMELINESS_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;