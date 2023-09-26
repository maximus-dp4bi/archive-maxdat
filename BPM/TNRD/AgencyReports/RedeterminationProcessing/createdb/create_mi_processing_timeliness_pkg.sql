alter session set plsql_code_type = native;

create or replace package MI_PROCESSING_TIMELINESS_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE INS_MI_DOC;
  PROCEDURE UPD_MI_DOC;
  PROCEDURE UPD_APP_RECEIVED_INFO;
  PROCEDURE UPD_APP_TERM_LTR;
  PROCEDURE UPD_APP_INFO;
  PROCEDURE UPD_APP_ELIG_INFO;  
  PROCEDURE UPD_APP_MI_LTR;  
  PROCEDURE UPD_APP_RCVD_AFTER_TERM_INFO;
  PROCEDURE UPD_FORWARD_TASK;
  PROCEDURE UPD_DATA_EVAL_TASK;
  PROCEDURE UPD_APP_BILLABLE_INFO;
  PROCEDURE UPD_APP_REFERRAL_INFO;
  PROCEDURE UPD_APP_MI_INFO;
  PROCEDURE UPD_APP_EXCEPTION_INFO;
  PROCEDURE UPD_MI_CYCLE_STOP;
  PROCEDURE UPD_APP_RECENT_DOC;
      
end;
/


CREATE OR REPLACE PACKAGE BODY MI_PROCESSING_TIMELINESS_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE INS_MI_DOC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'INS_MI_DOC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_MI_DOC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_MI_PROCESSING_TIMELINESS (doc_link_id
          ,document_id
          ,application_id
          ,member_id          
          ,reactivation_date
          ,application_status
          ,coverage_end_date
          ,eligibility_outcome           
          ,mi_link_date
          ,mi_receipt_date
          ,mi_scan_date           
          ,sla
          ,jeopardy_days 
          ,application_type          
          ,cob_indicator          
          ,document_type
          ,document_form_type
          ,rcvd_during_90day_prd)
    SELECT dl.doc_link_id
          ,dl.document_id
          ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.application_id ELSE ai.application_id END application_id
          ,ai.client_cin
          ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.reactivation_ts ELSE ai.reactivation_ts END reactivation_ts
          ,CASE WHEN ahi.application_id IS NOT NULL THEN ast.report_label ELSE ai.ai_app_status END application_status
          ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.renewal_due_Date ELSE  ai.renewal_due_date END renewal_due_date
          ,eeo.report_label eligibility_outcome
          ,dl.create_ts mi_link_date
          ,dss.received_date
          ,ds.scan_date
          ,3 sla
          ,2 jeopardy_days 
          ,CASE WHEN ahi.application_id IS NOT NULL THEN apt.report_label ELSE ai_app_type END application_type
          ,CASE WHEN ahi.application_id IS NOT NULL THEN
            CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END ELSE  ai_cob_indicator END cob_indicator  
          ,COALESCE(dtl.report_label,ds.doc_type_cd) document_type
          ,ds.doc_form_type document_form_type   
          ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.rcvd_90day_indicator ELSE ai_rcvd_90day_indicator END  rcvd_90day_indicator
    FROM doc_link_stg dl
      JOIN document_stg ds ON dl.document_id = ds.document_id
      JOIN app_header_stg ah ON dl.link_ref_id = ah.application_id
      LEFT JOIN app_individual_stg ahi ON ah.application_id = ahi.application_id AND dl.client_id = ahi.client_id
      LEFT JOIN (SELECT *
            FROM(SELECT ai.app_individual_id, ai.client_id,ai.client_cin,ah.application_id,ah.status_cd,ah.renewal_due_date,ah.reactivation_ts
                        ,ast.report_label ai_app_status,apt.report_label ai_app_type
                        ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END ai_cob_indicator
                        ,ah.rcvd_90day_indicator ai_rcvd_90day_indicator
                        ,ROW_NUMBER() OVER (PARTITION BY ai.client_id ORDER BY ai.create_ts DESC) airn                        
                 FROM app_individual_stg ai 
                   JOIN app_header_stg ah ON ai.application_id = ah.application_id
                    LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
                    LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value 
                  WHERE applicant_ind = 1      )
            WHERE airn = 1       
            ) ai ON dl.client_id = ai.client_id
      LEFT JOIN document_set_stg dss ON ds.document_set_id = dss.document_set_id
      LEFT JOIN document_type_lkup dtl ON ds.doc_type_cd = dtl.value 
      LEFT JOIN (SELECT *
                 FROM (SELECT application_id, app_individual_id, elig_outcome_cd, ROW_NUMBER() OVER(PARTITION BY application_id ORDER BY create_ts DESC) rn
                       FROM app_elig_outcome_stg ) 
                 WHERE rn =1 )  aeo ON ai.app_individual_id = aeo.app_individual_id --AND ai.application_id = aeo.application_id
      LEFT JOIN elig_outcome_lkup eeo ON eeo.value = aeo.elig_outcome_cd
      LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
      LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value 
    WHERE link_type_cd = 'APPLICATION'
    --AND mi_task_indicator = 1     
    AND ds.doc_type_cd != 'UPLOAD'
    AND (mi_task_indicator = 1         
        OR (mi_task_indicator = 0 AND TRUNC(dl.create_ts) >= TO_DATE('03/01/2018','mm/dd/yyyy') )     )    
    AND NOT EXISTS(SELECT 1 FROM d_mi_processing_timeliness mp WHERE mp.doc_link_id = dl.doc_link_id AND mp.application_id = CASE WHEN ahi.application_id IS NOT NULL THEN ah.application_id ELSE ai.application_id END)
    Log Errors INTO Errlog_MIProcTm ('INS_MI_DOC') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.INS_MI_DOC', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'INS_MI_DOC';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.INS_MI_DOC', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END INS_MI_DOC;

PROCEDURE UPD_MI_DOC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_MI_DOC';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'UPD_MI_DOC','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT tmp.*
          FROM(SELECT dl.doc_link_id
                    ,dl.document_id
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.application_id ELSE ai.application_id END application_id
                    ,ai.client_cin
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.reactivation_ts ELSE ai.reactivation_ts END reactivation_ts
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN ast.report_label ELSE ai.ai_app_status END application_status
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.renewal_due_Date ELSE  ai.renewal_due_date END renewal_due_date
                    ,eeo.report_label eligibility_outcome
                    ,dl.create_ts mi_link_date
                    ,dss.received_date
                    ,ds.scan_date
                    ,3 sla
                    ,2 jeopardy_days 
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN apt.report_label ELSE ai_app_type END application_type
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN
                      CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END ELSE  ai_cob_indicator END cob_indicator  
                    ,COALESCE(dtl.report_label,ds.doc_type_cd) document_type
                    ,ds.doc_form_type document_form_type
                    ,CASE WHEN ahi.application_id IS NOT NULL THEN ah.rcvd_90day_indicator ELSE ai_rcvd_90day_indicator END  rcvd_90day_indicator
              FROM doc_link_stg dl
                JOIN document_stg ds ON dl.document_id = ds.document_id
                JOIN app_header_stg ah ON dl.link_ref_id = ah.application_id
                LEFT JOIN app_individual_stg ahi ON ah.application_id = ahi.application_id AND dl.client_id = ahi.client_id
                LEFT JOIN (SELECT *
                           FROM(SELECT ai.app_individual_id, ai.client_id,ai.client_cin,ah.application_id,ah.status_cd,ah.renewal_due_date,ah.reactivation_ts
                                      ,ast.report_label ai_app_status,apt.report_label ai_app_type
                                      ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END ai_cob_indicator
                                      ,ah.rcvd_90day_indicator ai_rcvd_90day_indicator
                                      ,ROW_NUMBER() OVER (PARTITION BY ai.client_id ORDER BY ai.create_ts DESC) airn                        
                                FROM app_individual_stg ai 
                                 JOIN app_header_stg ah ON ai.application_id = ah.application_id
                                 LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
                                 LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value 
                                WHERE applicant_ind = 1      )
                            WHERE airn = 1   ) ai ON dl.client_id = ai.client_id
                LEFT JOIN document_set_stg dss ON ds.document_set_id = dss.document_set_id
                LEFT JOIN document_type_lkup dtl ON ds.doc_type_cd = dtl.value 
                LEFT JOIN (SELECT *
                            FROM (SELECT application_id, app_individual_id, elig_outcome_cd, ROW_NUMBER() OVER(PARTITION BY application_id ORDER BY create_ts DESC) rn
                                  FROM app_elig_outcome_stg ) 
                           WHERE rn =1 )  aeo ON ai.app_individual_id = aeo.app_individual_id --AND ai.application_id = aeo.application_id
                LEFT JOIN elig_outcome_lkup eeo ON eeo.value = aeo.elig_outcome_cd
                LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
                LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value 
              WHERE link_type_cd = 'APPLICATION'              
              AND ds.doc_type_cd != 'UPLOAD'
              AND (mi_task_indicator = 1         
                OR (mi_task_indicator = 0 AND TRUNC(dl.create_ts) >= TO_DATE('03/01/2018','mm/dd/yyyy') )   )
                ) tmp
            JOIN d_mi_processing_timeliness dmi ON tmp.doc_link_id = dmi.doc_link_id AND tmp.application_id = dmi.application_id
            WHERE ( COALESCE(tmp.client_cin,'*') != COALESCE(dmi.member_id,'*')   
             OR COALESCE(tmp.reactivation_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.reactivation_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.application_status,'*') != COALESCE(dmi.application_status,'*')   
              OR COALESCE(tmp.renewal_due_Date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.coverage_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.eligibility_outcome,'*') != COALESCE(dmi.eligibility_outcome,'*')   
              OR COALESCE(tmp.mi_link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.mi_link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.mi_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.mi_scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
              OR COALESCE(tmp.application_type,'*') != COALESCE(dmi.application_type,'*')   
              OR COALESCE(tmp.cob_indicator,'*') != COALESCE(dmi.cob_indicator,'*')   
              OR COALESCE(tmp.document_type,'*') != COALESCE(dmi.document_type,'*')   
              OR COALESCE(tmp.document_form_type,'*') != COALESCE(dmi.document_form_type,'*') 
              OR COALESCE(tmp.rcvd_90day_indicator,'*') != COALESCE(dmi.rcvd_during_90day_prd,'*') )             
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  member_id = tmp.client_cin
          ,reactivation_date = tmp.reactivation_ts
          ,application_status = tmp.application_status
          ,coverage_end_date = tmp.renewal_due_Date
          ,eligibility_outcome = tmp.eligibility_outcome        
          ,mi_link_date = tmp.mi_link_date
          ,mi_receipt_date = tmp.received_date
          ,mi_scan_date = tmp.scan_date
          ,sla = tmp.sla
          ,jeopardy_days = tmp.jeopardy_days 
          ,application_type = tmp.application_type
          ,cob_indicator = tmp.cob_indicator    
          ,document_type = tmp.document_type
          ,document_form_type = tmp.document_form_type  
          ,rcvd_during_90day_prd = tmp.rcvd_90day_indicator
     Log Errors INTO Errlog_MIProcTm ('UPD_MI_DOC') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_MI_DOC', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_MI_DOC';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_MI_DOC', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_MI_DOC;

PROCEDURE UPD_APP_RECEIVED_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_RECEIVED_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_RECEIVED_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT dmi.app_receipt_date,dmi.document_id,dmi.app_link_date,dmi.app_scan_date,dmi.doc_link_id,
               ds.received_date,ds.scan_date,ds.link_date,dmi.application_id
          FROM d_mi_processing_timeliness dmi 
            JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE dmi.app_receipt_date IS NULL
          AND ( COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) )
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  app_receipt_date = tmp.received_date
          ,app_link_date = tmp.link_date
          ,app_scan_date = tmp.scan_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_RECEIVED_INFO') Reject Limit Unlimited
     ;
     
     v_upd_cnt := SQL%RowCount;
     COMMIT;
   --try to get any doc linked receipt date if app receipt date is null
   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT dmi.app_receipt_date,dmi.document_id,dmi.app_link_date,dmi.app_scan_date,dmi.doc_link_id,
               ds.received_date,ds.scan_date,ds.link_date,dmi.application_id
          FROM d_mi_processing_timeliness dmi 
            JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id                   
                        WHERE link_type_cd = 'APPLICATION')
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE dmi.app_receipt_date IS NULL
          AND ( COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) )
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  app_receipt_date = tmp.received_date
          ,app_link_date = tmp.link_date
          ,app_scan_date = tmp.scan_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_RECEIVED_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RECEIVED_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_RECEIVED_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RECEIVED_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_RECEIVED_INFO;

PROCEDURE UPD_APP_TERM_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_TERM_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_TERM_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING ( SELECT   dmi.term_date,dmi.document_id,dmi.term_ltr_mailed_date,dmi.doc_link_id,dmi.application_id, letter_mailed_date,response_due_date
                FROM  d_mi_processing_timeliness dmi 
                   JOIN (SELECT *
                         FROM (SELECT letter_mailed_date,response_due_date, reference_id application_id,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn  
                               FROM  letters_stg lr                          
                                JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id                   
                               WHERE lr.letter_type_cd IN ('TN 411', 'TN 408', 'TN 408ftp') 
                               AND ll.reference_type = 'APP_HEADER'
                               AND lr.letter_status_cd = 'MAIL'
                               AND lr.letter_request_type = 'L' )
                          WHERE rn = 1) ll  ON ll.application_id = dmi.application_id                      
                WHERE ( COALESCE(ll.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.term_date, TO_DATE('07/07/7777','mm/dd/yyyy'))         
          OR COALESCE(ll.letter_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.term_ltr_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))   )
        ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  term_date = tmp.response_due_date    
         ,term_ltr_mailed_date = tmp.letter_mailed_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_TERM_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_TERM_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_TERM_LTR';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_TERM_LTR', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_TERM_LTR;

PROCEDURE UPD_APP_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT tmp.*
                 ,dmi.document_id
                 ,dmi.doc_link_id
          FROM(
            SELECT 
              ah.application_id
              ,ai.client_cin
              ,ah.reactivation_ts
              ,ast.report_label application_status
              ,ah.renewal_due_Date
              ,apt.report_label application_type
              ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END cob_indicator     
              ,ah.rcvd_90day_indicator
            FROM  app_header_stg ah 
              JOIN app_individual_stg ai ON ah.application_id = ai.application_id AND applicant_ind = 1                            
              LEFT JOIN app_status_lkup ast  ON ah.status_cd = ast.value
              LEFT JOIN app_type_lkup apt ON ah.app_form_cd = apt.value 
            --WHERE ah.update_ts >= TRUNC(sysdate-1)
            ) tmp
           JOIN d_mi_processing_timeliness dmi ON  tmp.application_id = dmi.application_id
          WHERE (COALESCE(tmp.client_cin,'*') != COALESCE(dmi.member_id,'*')   
          OR COALESCE(tmp.reactivation_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.reactivation_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
          OR COALESCE(tmp.application_status,'*') != COALESCE(dmi.application_status,'*')   
          OR COALESCE(tmp.renewal_due_Date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.coverage_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
          OR COALESCE(tmp.application_type,'*') != COALESCE(dmi.application_type,'*')   
          OR COALESCE(tmp.cob_indicator,'*') != COALESCE(dmi.cob_indicator,'*')  
          OR COALESCE(tmp.rcvd_90day_indicator,'*') != COALESCE(dmi.rcvd_during_90day_prd ,'*')  ) 
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  member_id = tmp.client_cin
          ,reactivation_date = tmp.reactivation_ts
          ,application_status = tmp.application_status
          ,coverage_end_date = tmp.renewal_due_Date
          ,application_type = tmp.application_type
          ,cob_indicator = tmp.cob_indicator    
          ,rcvd_during_90day_prd = tmp.rcvd_90day_indicator
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_INFO;

PROCEDURE UPD_APP_ELIG_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_ELIG_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_ELIG_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT eeo.report_label eligibility_outcome
               ,aeo.application_id
               ,dmi.document_id 
               ,dmi.doc_link_id
          FROM  app_elig_outcome_stg aeo     
            JOIN elig_outcome_lkup eeo ON eeo.value = aeo.elig_outcome_cd
            JOIN d_mi_processing_timeliness dmi ON  aeo.application_id = dmi.application_id
          WHERE 1=1
          --AND aeo.update_ts >= TRUNC(sysdate-1)               
          AND COALESCE(eeo.report_label,'*') != COALESCE(dmi.eligibility_outcome,'*')               
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  eligibility_outcome = tmp.eligibility_outcome         
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_ELIG_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_ELIG_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_ELIG_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_ELIG_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_ELIG_INFO;

PROCEDURE UPD_APP_RCVD_AFTER_TERM_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_RCVD_AFTER_TERM_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_RCVD_AFTER_TERM_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT dmi.app_receipt_dt_after_term,dmi.document_id,dmi.app_link_dt_after_term,dmi.app_scan_dt_after_term,dmi.doc_link_id,
               ds.received_date,ds.scan_date,ds.link_date,dmi.application_id
          FROM d_mi_processing_timeliness dmi 
            JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,ds.received_date,d.scan_date,dl.create_ts link_date,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg ds 
                         JOIN document_stg d ON ds.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id 
                         JOIN d_mi_processing_timeliness dmi ON dl.link_ref_id = dmi.application_id  
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND link_type_cd = 'APPLICATION'
                        AND ds.received_date >= dmi.term_ltr_mailed_date)
                  WHERE rn = 1) ds ON dmi.application_id = ds.application_id                     
          WHERE ( COALESCE(ds.received_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_receipt_dt_after_term, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.link_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_link_dt_after_term, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.app_scan_dt_after_term, TO_DATE('07/07/7777','mm/dd/yyyy')) )
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  app_receipt_dt_after_term = tmp.received_date
          ,app_link_dt_after_term = tmp.link_date
          ,app_scan_dt_after_term = tmp.scan_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_RCVD_AFTER_TERM_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RCVD_AFTER_TERM_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_RCVD_AFTER_TERM_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RCVD_AFTER_TERM_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_RCVD_AFTER_TERM_INFO;

PROCEDURE UPD_APP_MI_LTR
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_MI_LTR';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_MI_LTR','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT tmp.*
                ,dmi.document_id 
                ,dmi.doc_link_id
          FROM (SELECT ll.reference_id application_id, MAX(letter_mailed_date) last_mi_mailed_date
                FROM letters_stg lr 
                  JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id 
                WHERE lr.letter_type_cd LIKE 'TN 406%' 
                AND ll.reference_type = 'APP_HEADER'
                AND lr.letter_status_cd = 'MAIL' AND lr.letter_request_type = 'L'                  
                --AND (lr.letter_create_ts >= TRUNC(sysdate-1)
                 --OR lr.letter_update_ts >= TRUNC(sysdate-1)  )
                GROUP BY ll.reference_id) tmp
            JOIN d_mi_processing_timeliness dmi ON  tmp.application_id = dmi.application_id              
          WHERE COALESCE(tmp.last_mi_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(dmi.last_mi_mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))                   
        ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  last_mi_mailed_date = tmp.last_mi_mailed_date            
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_MI_LTR') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_LTR', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_MI_LTR';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_LTR', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_MI_LTR;

PROCEDURE UPD_FORWARD_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_FORWARD_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_FORWARD_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM(SELECT  i.step_instance_id nw_fwd_task_id
                       ,i.hist_create_ts fwd_create_ts
                       ,sfwd.first_name||' '||sfwd.last_name nw_staff_fwd_by
                       ,sfwdto.first_name||' '||sfwdto.last_name nw_staff_fwd_to
                       ,step_instance_history_id
                       ,sfwd.staff_type_cd nw_fwdby_staff_type
                       ,sfwdto.staff_type_cd nw_fwdto_staff_type
                       ,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,ref_id ORDER BY step_instance_id,i.hist_create_ts,DECODE(hist_status,'COMPLETED',5,'TERMINATED',4,'CLAIMED',3,1) DESC) trn 
                       ,dmi.fwd_task_id
                       ,dmi.forward_task_to_state_dt
                       ,dmi.staff_fwd_by
                       ,dmi.fwdby_staff_type 
                       ,dmi.staff_fwd_to
                       ,dmi.fwdto_staff_type 
                       ,dmi.application_id
                       ,dmi.doc_link_id
                       ,i.ref_id
                 FROM  step_instance_stg i 
                     JOIN d_mi_processing_timeliness dmi ON  i.ref_id = dmi.application_id
                     JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                     LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                     LEFT JOIN d_staff sfwd   ON i.forwarded_by = TO_CHAR(sfwd.staff_id)
                     LEFT JOIN d_staff sfwdto  ON i.owner = TO_CHAR(sfwdto.staff_id)                         
                 WHERE ref_type = 'APP_HEADER'
                 AND i.create_ts >= dmi.mi_link_date
                 AND ((sfwd.staff_type_cd = 'PROJECT_STAFF' AND sfwdto.staff_type_cd = 'STATE') 
                   OR d.business_unit_name = 'HCFA Verifications') ) tmp
            WHERE trn = 1     
            AND ( COALESCE(tmp.fwd_create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.forward_task_to_state_dt, TO_DATE('07/07/7777','mm/dd/yyyy'))  
              OR COALESCE(tmp.nw_fwd_task_id,0) != COALESCE(tmp.fwd_task_id,0)   
              OR COALESCE(tmp.nw_staff_fwd_by,'*') != COALESCE(tmp.staff_fwd_by,'*')   
              OR COALESCE(tmp.nw_fwdby_staff_type,'*') != COALESCE(tmp.fwdby_staff_type,'*')   
              OR COALESCE(tmp.nw_staff_fwd_to,'*') != COALESCE(tmp.staff_fwd_to,'*')   
              OR COALESCE(tmp.nw_fwdto_staff_type,'*') != COALESCE(tmp.fwdto_staff_type,'*') )                           
        ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  forward_task_to_state_dt = tmp.fwd_create_ts
         ,fwd_task_id = tmp.nw_fwd_task_id
         ,staff_fwd_by = tmp.nw_staff_fwd_by
         ,fwdby_staff_type = tmp.nw_fwdby_staff_type
         ,staff_fwd_to = tmp.nw_staff_fwd_to
         ,fwdto_staff_type = tmp.nw_fwdto_staff_type
     Log Errors INTO Errlog_MIProcTm ('UPD_FORWARD_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_FORWARD_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_FORWARD_TASK';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_FORWARD_TASK', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_FORWARD_TASK;


PROCEDURE UPD_DATA_EVAL_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_DATA_EVAL_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_DATA_EVAL_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING ( SELECT *
                FROM(SELECT i.step_instance_id nw_de_task_id
                        ,i.create_ts nw_de_task_create_date
                        ,i.completed_ts nw_de_task_complete_date
                        ,CASE WHEN hist_status = 'CLAIMED' AND i.staff_type_cd = 'STATE' THEN i.hist_create_ts ELSE i.completed_ts END nw_detask_cycle_stop_date                    
                        ,step_instance_history_id                                
                        ,hist_status nw_de_task_status                
                        ,i.task_name nw_de_task_type
                        ,CASE WHEN hist_status = 'CLAIMED' THEN i.first_name||' '||i.last_name ELSE NULL END nw_de_current_owner
                        ,CASE WHEN hist_status = 'CLAIMED' THEN 'Claimed'
                              WHEN hist_status = 'UNCLAIMED' THEN 'Unclaimed'
                          ELSE NULL END nw_de_claimed_unclaimed
                        ,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,i.ref_id ORDER BY ABS(i.create_ts-dmi.mi_link_date), DECODE(hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1)) vrn
                        ,dmi.de_task_id
                        ,dmi.de_task_create_date
                        ,dmi.de_task_complete_date
                        ,dmi.detask_cycle_stop_date                
                        ,dmi.de_task_status
                        ,dmi.de_task_type                
                        ,dmi.de_current_owner
                        ,dmi.de_claimed_unclaimed
                        ,dmi.application_id
                        ,dmi.doc_link_id
                        ,dmi.document_id       
                        ,i.ref_id                      
                   FROM  (SELECT *
                          FROM (
                          SELECT i.*,dt.task_name,co.first_name,last_name,co.staff_type_cd,
                                 ROW_NUMBER() OVER (PARTITION BY i.ref_id,i.step_instance_id ORDER BY DECODE(hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1) DESC,step_instance_id,step_instance_history_id) srn
                          FROM step_instance_stg i
                            JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                             LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                          WHERE ref_type = 'APP_HEADER'
                          AND task_name = 'MI Data Evaluation'   )
                          WHERE srn = 1 ) i
                     JOIN d_mi_processing_timeliness dmi ON  i.ref_id = dmi.application_id                                         
                   WHERE 1=1
                   --AND i.hist_create_ts >= dmi.mi_link_date
                   --AND task_name IN('Data Evaluation','MI Data Evaluation') 
                   AND TRUNC(dmi.mi_link_date) >= TO_DATE('03/01/2018','mm/dd/yyyy') 
                   AND TRUNC(dmi.mi_link_date) >= TRUNC(i.create_ts)-1
                   ) tmp                   
                WHERE 1=1
                AND vrn = 1                      
                AND ( COALESCE(tmp.nw_de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.de_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_de_task_complete_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.de_task_complete_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_detask_cycle_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.detask_cycle_stop_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
                  OR COALESCE(tmp.nw_de_task_id,0) != COALESCE(tmp.de_task_id,0)   
                  OR COALESCE(tmp.nw_de_task_status,'*') != COALESCE(tmp.de_task_status,'*')   
                  OR COALESCE(tmp.nw_de_task_type,'*') != COALESCE(tmp.de_task_type,'*')   
                  OR COALESCE(tmp.nw_de_current_owner,'*') != COALESCE(tmp.de_current_owner,'*')   
                  OR COALESCE(tmp.nw_de_claimed_unclaimed,'*') != COALESCE(tmp.de_claimed_unclaimed,'*')  )          
        ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id )
    WHEN MATCHED THEN UPDATE
     SET  de_task_create_date = tmp.nw_de_task_create_date
         ,de_task_complete_date = tmp.nw_de_task_complete_date
         ,detask_cycle_stop_date = tmp.nw_detask_cycle_stop_date
         ,de_task_id = tmp.nw_de_task_id
         ,de_task_status = tmp.nw_de_task_status
         ,de_task_type = tmp.nw_de_task_type
         ,de_current_owner = tmp.nw_de_current_owner
         ,de_claimed_unclaimed = tmp.nw_de_claimed_unclaimed         
     Log Errors INTO Errlog_MIProcTm ('UPD_DATA_EVAL_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_DATA_EVAL_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_DATA_EVAL_TASK';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_DATA_EVAL_TASK', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_DATA_EVAL_TASK;

PROCEDURE UPD_APP_BILLABLE_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_BILLABLE_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_BILLABLE_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT el.application_id
                ,TRUNC(el.create_ts) nw_billable_outcome_date, outcome_cd nw_bo_outcome_cd
                ,ds.first_name||' '||ds.last_name nw_bo_staff_completed_by
                ,dmi.document_id
                ,dmi.doc_link_id
                ,dmi.billable_outcome_date
                ,dmi.bo_staff_completed_by
                ,dmi.bo_outcome_cd
                ,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,el.application_id ORDER BY el.application_id,el.create_ts) brn
            FROM d_mi_processing_timeliness dmi
              JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
              LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
            WHERE app_event_cd = 'STATUS_CHANGE'
            AND action_cd = 'END_APPLICATION_TRACKING'  
            AND outcome_cd IN('REJECTED','APPROVED')                
            AND el.create_ts >= dmi.mi_link_date            
            AND NOT EXISTS(SELECT 1 FROM app_event_log_stg disapp WHERE disapp.application_id = el.application_id AND  disapp.action_cd = 'DISREGARDED'
                           AND TRUNC(disapp.create_ts) = TRUNC(el.create_ts) ) ) tmp          
          WHERE tmp.brn = 1
          AND ( COALESCE(tmp.nw_bo_outcome_cd,'*') != COALESCE(tmp.bo_outcome_cd,'*')                     
          OR COALESCE(tmp.nw_bo_staff_completed_by,'*') != COALESCE(tmp.bo_staff_completed_by,'*')  
          OR COALESCE(tmp.nw_billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.billable_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  )
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  bo_outcome_cd = tmp.nw_bo_outcome_cd
         ,bo_staff_completed_by = tmp.nw_bo_staff_completed_by
         ,billable_outcome_date = tmp.nw_billable_outcome_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_BILLABLE_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_BILLABLE_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_BILLABLE_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_BILLABLE_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_BILLABLE_INFO;

PROCEDURE UPD_APP_REFERRAL_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_REFERRAL_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_REFERRAL_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT el.application_id                
                   ,TRUNC(el.create_ts) nw_rf_outcome_date, outcome_cd nw_rf_outcome_cd                         
                   ,ds.first_name||' '||ds.last_name nw_rf_staff_completed_by   
                   ,dmi.document_id  
                   ,dmi.doc_link_id
                   ,dmi.refer_to_hcfa_dt
                   ,dmi.rf_staff_completed_by
                   ,dmi.rf_outcome_cd
                  ,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,el.application_id ORDER BY el.application_id,el.create_ts) rrn
            FROM d_mi_processing_timeliness dmi
              JOIN app_event_log_stg el  ON dmi.application_id = el.application_id
              LEFT JOIN d_staff ds ON el.created_by = TO_CHAR(ds.staff_id)
            WHERE el.rfe_status_cd = 'AWAITING_STATE_ACCEPTANCE'              
            AND el.create_ts >= dmi.mi_link_date            
             ) tmp          
          WHERE tmp.rrn = 1
          AND ( COALESCE(tmp.nw_rf_outcome_cd,'*') != COALESCE(tmp.rf_outcome_cd,'*')                     
          OR COALESCE(tmp.nw_rf_staff_completed_by,'*') != COALESCE(tmp.rf_staff_completed_by,'*')  
          OR COALESCE(tmp.nw_rf_outcome_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.refer_to_hcfa_dt, TO_DATE('07/07/7777','mm/dd/yyyy'))  )
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  rf_outcome_cd = tmp.nw_rf_outcome_cd
         ,rf_staff_completed_by = tmp.nw_rf_staff_completed_by
         ,refer_to_hcfa_dt = tmp.nw_rf_outcome_date
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_REFERRAL_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_REFERRAL_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_REFERRAL_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_REFERRAL_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_REFERRAL_INFO;

PROCEDURE UPD_APP_MI_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_MI_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_MI_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM (
            SELECT mi.application_id, mi.create_ts nw_mi_added_date,dmi.document_id,dmi.doc_link_id,dmi.mi_determination_dt,
                     ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,mi.application_id ORDER BY mi.application_id,mi.create_ts) mrn
                  FROM d_mi_processing_timeliness dmi
                    JOIN app_missing_info_stg mi ON dmi.application_id = mi.application_id
                  WHERE mi.create_ts >= dmi.mi_link_date
                  AND mi.satisfied_date IS NULL ) tmp          
          WHERE tmp.mrn = 1
          AND COALESCE(tmp.nw_mi_added_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.mi_determination_dt, TO_DATE('07/07/7777','mm/dd/yyyy'))  
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  mi_determination_dt = tmp.nw_mi_added_date        
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_MI_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_MI_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_MI_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_MI_INFO;

PROCEDURE UPD_APP_EXCEPTION_INFO
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_EXCEPTION_INFO';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_EXCEPTION_INFO','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
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
                    ,dmi.document_id
                    ,dmi.doc_link_id
                    ,dmi.application_id
                    ,dmi.exclusion_flag
            FROM d_mi_processing_timeliness dmi      
              LEFT OUTER JOIN (SELECT ttx.app_id,txl.exception_type,ttx.hcfa_reactivation_flag,ttx.new_cycle_start_date,ttx.new_cycle_end_date,ttx.exclusion_flag,ttx.create_datetime,
                                      dmi.doc_link_id,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,dmi.application_id ORDER BY ttx.create_datetime) ttxrn
                               FROM d_mi_processing_timeliness dmi
                                JOIN ts_timeliness_exception ttx  ON dmi.application_id = ttx.app_id
                                JOIN ts_exception_type_lkup txl ON ttx.exception_type_id = txl.exception_type_id                  
                               WHERE txl.exception_type NOT IN('Callback','Letter Exception') 
                               AND ttx.ignore_flag = 'N'
                               AND ttx.create_datetime >= dmi.mi_link_date) ttx  
                ON ttx.doc_link_id = dmi.doc_link_id    
                AND ttx.ttxrn = 1
              LEFT JOIN (SELECT txc.app_id, txc.callback_date,txc.exclusion_flag,dmi.doc_link_id,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,dmi.application_id ORDER BY txc.callback_date) txcrn
                         FROM d_mi_processing_timeliness dmi
                          JOIN ts_timeliness_exception txc ON dmi.application_id = txc.app_id 
                          JOIN ts_exception_type_lkup  tl ON txc.exception_type_id = tl.exception_type_id 
                         WHERE tl.exception_type = 'Callback'
                         AND txc.ignore_flag = 'N'
                         AND txc.callback_date >= dmi.mi_link_date) txc
                ON txc.doc_link_id = dmi.doc_link_id    
                AND txc.txcrn = 1
              LEFT JOIN (SELECT lxc.app_id,lxc.exclusion_flag, lxc.create_datetime,dmi.doc_link_id, ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,dmi.application_id ORDER BY lxc.create_datetime) lxcrn
                         FROM d_mi_processing_timeliness dmi
                          JOIN ts_timeliness_exception lxc  ON dmi.application_id = lxc.app_id 
                          JOIN ts_exception_type_lkup  ll ON lxc.exception_type_id = ll.exception_type_id 
                         WHERE  ll.exception_type = 'Letter Exception'
                         AND lxc.ignore_flag = 'N'
                         AND lxc.create_datetime >= dmi.mi_link_date) lxc
                ON lxc.doc_link_id = dmi.doc_link_id    
                AND lxc.lxcrn = 1
            WHERE  COALESCE(lxc.exclusion_flag,ttx.exclusion_flag,txc.exclusion_flag,'N') IS NOT NULL  
               OR txc.callback_date IS NOT NULL
                OR ttx.new_cycle_start_date IS NOT NULL
                OR ttx.new_cycle_end_date IS NOT NULL
                OR ttx.hcfa_reactivation_flag IS NOT NULL
                OR ttx.exception_type IS NOT NULL ) tmp          
          WHERE COALESCE(tmp.nw_callback_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.callback_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_new_cycle_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.excp_new_cycle_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_new_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.excp_new_cycle_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  
            OR COALESCE(tmp.nw_hcfa_reactivation_flag,'*') != COALESCE(tmp.hcfa_reactivation_flag,'*') 
            OR COALESCE(tmp.nw_exception_type,'*') != COALESCE(tmp.exception_type,'*') 
            OR COALESCE(tmp.nw_exclusion_flag,'*') != COALESCE(tmp.exclusion_flag,'*') 
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  excp_new_cycle_end_date = tmp.nw_new_cycle_end_date
          ,excp_new_cycle_start_date = tmp.nw_new_cycle_start_date
          ,callback_date = tmp.nw_callback_date
          ,hcfa_reactivation_flag = nw_hcfa_reactivation_flag
          ,exception_type = nw_exception_type
          ,exclusion_flag = nw_exclusion_flag
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_EXCEPTION_INFO') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_EXCEPTION_INFO', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_MI_INFO';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_EXCEPTION_INFO', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_EXCEPTION_INFO;

PROCEDURE UPD_MI_CYCLE_STOP
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_MI_CYCLE_STOP';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_MI_CYCLE_STOP','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM(
            SELECT TRUNC(CASE WHEN dmi.exception_type IN('Processing Error','Other') AND dmi.excp_new_cycle_end_date IS NOT NULL THEN TRUNC(dmi.excp_new_cycle_end_date)
              ELSE LEAST(COALESCE(CASE WHEN dmi.refer_to_hcfa_dt IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_dt,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_dt)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date),
                 COALESCE(dmi.forward_task_to_state_dt,dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date, CASE WHEN dmi.refer_to_hcfa_dt IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_dt,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_dt)) END ),
                 COALESCE(dmi.mi_determination_dt,dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_dt IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_dt,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_dt)) END,dmi.forward_task_to_state_dt),
                 COALESCE(dmi.callback_date,dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_dt IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_dt,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_dt)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt) ,
                 COALESCE(dmi.detask_cycle_stop_date,CASE WHEN dmi.refer_to_hcfa_dt IS NULL THEN dmi.billable_outcome_date ELSE LEAST(dmi.refer_to_hcfa_dt,COALESCE(dmi.billable_outcome_date,dmi.refer_to_hcfa_dt)) END,dmi.forward_task_to_state_dt,dmi.mi_determination_dt, dmi.callback_date )) END)  nw_mi_cycle_stop
                 ,CASE WHEN EXISTS (SELECT 1 FROM document_stg d INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                                    WHERE doc_type_cd = 'UPLOAD' AND doc_form_type = 'MULT_RESCAN' AND link_type_cd = 'APPLICATION' AND link_ref_id = dmi.application_id)
                    THEN 'Y' ELSE 'N' END nw_multi_applying_member_flag  
                 ,dmi.processed_dt
                 ,dmi.application_id
                 ,dmi.document_id
                 ,dmi.doc_link_id
                 ,dmi.multi_applying_member_flag
            FROM d_mi_processing_timeliness dmi )tmp
          WHERE  COALESCE(tmp.nw_mi_cycle_stop, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.processed_dt, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR  COALESCE(tmp.nw_multi_applying_member_flag, '*') != COALESCE(tmp.multi_applying_member_flag, '*') 
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  processed_dt = tmp.nw_mi_cycle_stop  
          ,multi_applying_member_flag = nw_multi_applying_member_flag
     Log Errors INTO Errlog_MIProcTm ('UPD_MI_CYCLE_STOP') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_MI_CYCLE_STOP', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_MI_CYCLE_STOP';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_MI_CYCLE_STOP', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_MI_CYCLE_STOP;

PROCEDURE UPD_APP_RECENT_DOC
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_MIProcTm WHERE ora_err_tag$ = 'UPD_APP_RECENT_DOC';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_APP_RECENT_DOC','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  d_mi_processing_timeliness s
   USING (SELECT *
          FROM 
            (SELECT dmi.recent_doc_type,dmi.document_id,dmi.doc_link_id,dmi.application_id,ds.nw_recent_doc_type
                  ,ROW_NUMBER() OVER (PARTITION BY dmi.doc_link_id,dmi.application_id ORDER BY received_date DESC) rn
              FROM d_mi_processing_timeliness dmi 
                JOIN (SELECT link_ref_id application_id,ds.received_date,COALESCE(tl.report_label,d.doc_type_cd) nw_recent_doc_type
                      FROM document_set_stg ds 
                        JOIN document_stg d ON ds.document_set_id = d.document_set_id
                        JOIN doc_link_stg dl ON d.document_id = dl.document_id   
                        LEFT JOIN document_type_lkup tl ON d.doc_type_cd = tl.value
                      WHERE link_type_cd = 'APPLICATION') ds ON dmi.application_id = ds.application_id
              WHERE TRUNC(ds.received_date) <= COALESCE(TRUNC(processed_dt),TRUNC(sysdate)) )  tmp
           WHERE rn = 1
           AND COALESCE(tmp.nw_recent_doc_type, '*') != COALESCE(tmp.recent_doc_type,'*')            
          ) tmp ON (tmp.doc_link_id = s.doc_link_id AND tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  recent_doc_type = tmp.nw_recent_doc_type        
     Log Errors INTO Errlog_MIProcTm ('UPD_APP_RECENT_DOC') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RECENT_DOC', 1, Ora_Err_Mesg$, ora_err_number$, 'D_MI_PROCESSING_TIMELINESS', DOCUMENT_ID
      FROM Errlog_MIProcTm
     WHERE Ora_Err_Tag$ = 'UPD_APP_RECENT_DOC';

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
      VALUES( c_critical, con_pkg, 'MI_PROCESSING_TIMELINESS_PKG.UPD_APP_RECENT_DOC', 1, v_desc, v_code, 'D_MI_PROCESSING_TIMELINESS');

      COMMIT;
END UPD_APP_RECENT_DOC;

END;
/


grant execute on MI_PROCESSING_TIMELINESS_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;