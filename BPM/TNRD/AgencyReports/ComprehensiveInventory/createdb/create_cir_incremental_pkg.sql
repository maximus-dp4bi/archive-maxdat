alter session set plsql_code_type = native;

create or replace package CIR_INCREMENTAL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(35) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE INS_CIR_APPS;    
  PROCEDURE UPD_CIR_APPS;  
  PROCEDURE UPD_CIR_LATEST_DOC_RECEIVED;
  PROCEDURE UPD_CIR_APP_OPEN_TASK;
  PROCEDURE UPD_CIR_MAGI_DATA;
  PROCEDURE UPD_CIR_APP_RECEIVED;
  PROCEDURE UPD_CIR_APP_RFE_STATUS;
  
end;
/

CREATE OR REPLACE PACKAGE BODY CIR_INCREMENTAL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE INS_CIR_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'INS_CIR_APPS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'INS_CIR_APPS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO TN_CI_REDETERMINATION (application_id
                                  ,maxe_ats_application_status
                                  ,cob_indicator
                                  ,status_date
                                  ,app_form_cd
                                  ,rcvd_during_reconsider_prd)
   SELECT ah.application_id
      ,ah.status_cd
      ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END cob_indicator
      ,status_date
      ,app_form_cd
      ,rcvd_90day_indicator
  FROM app_header_stg ah
  WHERE  NOT EXISTS(SELECT 1 FROM tn_ci_redetermination r WHERE r.application_id = ah.application_id)
    Log Errors INTO Errlog_CIRTab ('INS_CIR_APPS') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.INS_CIR_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'INS_CIR_APPS';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.INS_CIR_APPS', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END INS_CIR_APPS;

PROCEDURE UPD_CIR_APPS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_APPS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_APPS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (SELECT ah.*
          FROM (
            SELECT cl.clnt_fname new_first_name
                  ,cl.clnt_mi new_middle_name
                  ,cl.clnt_lname new_last_name
                  ,cl.clnt_dob new_dob
                  ,cl.clnt_ssn new_ssn     
                  ,DECODE(cl.clnt_gender_cd, 'M','Male','F','Female',null) new_gender 
                  ,CASE WHEN cl.supplemental_nbr IS NULL THEN cl.clnt_generic_field1_date ELSE NULL END new_pool_file_select_date
                  ,CASE WHEN cl.supplemental_nbr IS NULL THEN TO_CHAR(cl.clnt_generic_field1_date,'YYYYMMDD') ELSE NULL END new_med_rfi_selection_date
                  ,CASE WHEN cl.supplemental_nbr IS NULL THEN 
                      CASE WHEN cl.clnt_generic_field8_txt IS NOT NULL THEN
                        (SELECT value
                         FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
                         WHERE cc.client_id =  cl.client_id 
                         AND cc.cscl_adlk_id != '00'
                         AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                                        WHERE cc.client_id = cc1.client_id
                                        AND cc1.cscl_adlk_id != '00'))||' '||clnt_generic_field8_txt 
                      ELSE (SELECT subprogram_codes
                            FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
                            WHERE cc.client_id =  cl.client_id 
                            AND cc.cscl_adlk_id != '00'
                            AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                                           WHERE cc.client_id = cc1.client_id
                                           AND cc1.cscl_adlk_id != '00')) END 
                      ELSE NULL END new_previous_aid_category
                  ,'Self' new_relationship_person1
                  ,CASE WHEN cl.supplemental_nbr IS NOT NULL THEN cl.clnt_generic_field1_date ELSE NULL END new_ck_pool_file_selection_date
                  ,ah.application_id
                  ,ah.status_date new_status_date
                  ,ah.app_form_cd new_app_form_cd
                  ,ah.status_cd new_status_cd
                  ,ah.rcvd_90day_indicator new_rcvd_90day_indicator
                  ,CASE WHEN ah.ref_value_1 = '1' THEN 'Y' ELSE 'N' END new_cob_indicator
                  ,ai.app_individual_id new_app_individual_id
                  ,cl.client_id new_client_id
                  ,cl.clnt_cin new_rid
                  ,cl.case_id new_case_id
                  ,cl.case_cin new_case_cin
                  ,ai.elig_outcome_cd new_elig_outcome_cd
                  ,ai.elig_outcome_reason_cd new_elig_outcome_reason_cd
                  ,ai.program_cd new_program_cd
                  ,ai.program_subtype_cd new_new_aid_category
                  ,cl.supplemental_nbr new_supplemental_nbr
                  ,CASE WHEN ci.in_rfi_yn = 'Y' THEN 'Y' ELSE CASE WHEN EXISTS(SELECT 1 FROM etl_l_app_renewal_stg r WHERE r.matched_client_id = cl.client_id) THEN 'Y' ELSE 'N' END END new_in_rfi_yn      
                  ,ci.first_name
                  ,ci.middle_name
                  ,ci.last_name
                  ,ci.date_of_birth
                  ,ci.ssn     
                  ,ci.gender 
                  ,ci.pool_file_select_date
                  ,ci.medicaid_rfi_selection_date
                  ,ci.previous_aid_category
                  ,ci.relationship_person1
                  ,ci.ck_pool_file_selection_date     
                  ,ci.status_date
                  ,ci.app_form_cd
                  ,ci.maxe_ats_application_status
                  ,ci.rcvd_during_reconsider_prd
                  ,ci.cob_indicator
                  ,ci.app_individual_id
                  ,ci.client_id
                  ,ci.rid
                  ,ci.case_id
                  ,ci.case_cin
                  ,ci.elig_outcome_cd
                  ,ci.elig_outcome_reason_cd
                  ,ci.program_cd
                  ,ci.new_aid_category
                  ,ci.supplemental_nbr
                  ,ci.in_rfi_yn      
                  ,ci.authorized_representative
                  ,ci.outstanding_mi_count
                  ,ar.new_authorized_representative
                  ,mi.mi_count
            FROM tn_ci_redetermination ci
              JOIN app_header_stg ah  ON ci.application_id = ah.application_id
              JOIN (SELECT *
                    FROM (SELECT ai.*, o.elig_outcome_cd, o.program_subtype_cd,o.program_cd,o.elig_outcome_reason_cd, 
                            ROW_NUMBER() OVER(PARTITION BY ai.application_id ORDER BY o.create_ts DESC) rn
                          FROM app_individual_stg ai
                            LEFT JOIN app_elig_outcome_stg o ON ai.application_id = o.application_id
                          WHERE ai.applicant_ind = 1) 
                    WHERE rn =1 ) ai ON ah.application_id = ai.application_id 
              JOIN client_stg cl  ON ai.client_id = cl.client_id 
              LEFT JOIN (SELECT *
                         FROM (SELECT ac_case_id,ac_first_name||' '||ac_last_name new_authorized_representative
                                ,ROW_NUMBER() OVER (PARTITION BY ac_case_id ORDER BY authorized_contact_id DESC) rn
                               FROM authorized_contact_stg      
                               WHERE ac_type_code = 'AUTH_REP'
                               AND ac_status_code != 'V'
                               AND ac_end_date IS NULL)
                          WHERE rn = 1     
                    ) ar ON ci.case_id = ar.ac_case_id 
              LEFT JOIN (SELECT application_id,COUNT(1) mi_count
                         FROM app_missing_info_stg
                         WHERE satisfied_date IS NULL
                         GROUP BY application_id) mi ON ci.application_id = mi.application_id       
                    ) ah 
          WHERE COALESCE(first_name,'*') != COALESCE(new_first_name,'*')
          OR COALESCE(last_name,'*') != COALESCE(new_last_name,'*')
          OR COALESCE(middle_name,'*') != COALESCE(new_middle_name,'*')
          OR COALESCE(date_of_birth, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(new_dob, TO_DATE('07/07/7777','mm/dd/yyyy'))
          OR COALESCE(ssn,'*') != COALESCE(new_ssn,'*')
          OR COALESCE(gender,'*') != COALESCE(new_gender,'*')
          OR COALESCE(pool_file_select_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(new_pool_file_select_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
          OR COALESCE(medicaid_rfi_selection_date,'*') != COALESCE(new_med_rfi_selection_date, '*')
          OR COALESCE(previous_aid_category,'*') != COALESCE(new_previous_aid_category,'*')
          OR COALESCE(relationship_person1,'*') != COALESCE(new_relationship_person1,'*')
          OR COALESCE(ck_pool_file_selection_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(new_ck_pool_file_selection_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
          OR COALESCE(status_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(new_status_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
          OR COALESCE(app_form_cd,'*') != COALESCE(new_app_form_cd,'*')
          OR COALESCE(maxe_ats_application_status,'*') != COALESCE(new_status_cd,'*')
          OR COALESCE(rcvd_during_reconsider_prd,'*') != COALESCE(new_rcvd_90day_indicator,'*')
          OR COALESCE(cob_indicator,'*') != COALESCE(new_cob_indicator,'*')
          OR COALESCE(app_individual_id,0) != COALESCE(new_app_individual_id,0)
          OR COALESCE(client_id,0) != COALESCE(new_client_id,0)
          OR COALESCE(rid,'*') != COALESCE(new_rid,'*')
          OR COALESCE(case_id,0) != COALESCE(new_case_id,0)
          OR COALESCE(case_cin,'*') != COALESCE(new_case_cin,'*')
          OR COALESCE(elig_outcome_cd,'*') != COALESCE(new_elig_outcome_cd,'*')
          OR COALESCE(elig_outcome_reason_cd,'*') != COALESCE(new_elig_outcome_reason_cd,'*')
          OR COALESCE(program_cd,'*') != COALESCE(new_program_cd,'*')
          OR COALESCE(new_aid_category,'*') != COALESCE(new_new_aid_category,'*')
          OR COALESCE(supplemental_nbr,'*') != COALESCE(new_supplemental_nbr,'*')
          OR COALESCE(in_rfi_yn,'*') != COALESCE(new_in_rfi_yn,'*')
          OR COALESCE(authorized_representative,'*') != COALESCE(new_authorized_representative,'*')
          OR COALESCE(outstanding_mi_count,0) != COALESCE(mi_count,0)
        ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
    SET first_name = tmp.new_first_name
        ,last_name = tmp.new_last_name
        ,middle_name = tmp.new_middle_name
        ,date_of_birth = tmp.new_dob
        ,ssn = tmp.new_ssn
        ,gender = tmp.new_gender
        ,pool_file_select_date = tmp.new_pool_file_select_date
        ,medicaid_rfi_selection_date = tmp.new_med_rfi_selection_date
        ,previous_aid_category = tmp.new_previous_aid_category
        ,relationship_person1 = tmp.new_relationship_person1
        ,ck_pool_file_selection_date = tmp.new_ck_pool_file_selection_date
        ,status_date = tmp.new_status_date
        ,app_form_cd = tmp.new_app_form_cd
        ,maxe_ats_application_status = tmp.new_status_cd
        ,rcvd_during_reconsider_prd = tmp.new_rcvd_90day_indicator
        ,cob_indicator = tmp.new_cob_indicator
        ,app_individual_id = tmp.new_app_individual_id
        ,client_id = tmp.new_client_id
        ,rid = tmp.new_rid
        ,case_id = tmp.new_case_id
        ,case_cin = tmp.new_case_cin
        ,elig_outcome_cd = tmp.new_elig_outcome_cd
        ,elig_outcome_reason_cd = tmp.new_elig_outcome_reason_cd
        ,program_cd = tmp.new_program_cd
        ,new_aid_category = tmp.new_new_aid_category
        ,supplemental_nbr = tmp.new_supplemental_nbr
        ,in_rfi_yn = tmp.new_in_rfi_yn
        ,authorized_representative = tmp.new_authorized_representative
        ,outstanding_mi_count = tmp.mi_count
    Log Errors INTO Errlog_CIRTab ('UPD_CIR_APPS') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APPS', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_APPS';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APPS', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_APPS;

PROCEDURE UPD_CIR_LATEST_DOC_RECEIVED
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_LATEST_DOC_RECEIVED';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_LATEST_DOC_RECEIVED','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (SELECT ci.application_id,latest_doc_receipt_date,latest_app_receipt_date,received_date,COALESCE(new_latest_app_receipt_date,latest_app_receipt_date) new_latest_app_receipt_date 
          FROM  tn_ci_redetermination ci
          JOIN(SELECT * 
               FROM (SELECT doc.*, 
                            CASE WHEN doc.doc_type_cd = 'APPLICATION' THEN received_date ELSE NULL END new_latest_app_receipt_date,
                            ROW_NUMBER() OVER (PARTITION BY doc.application_id ORDER BY doc.received_date DESC) rn
                     FROM (SELECT dl.*,doc_type_cd,CASE WHEN ahi.application_id IS NOT NULL THEN ah.application_id ELSE ai.application_id END application_id,TRUNC(dss.received_date) received_date
                           FROM doc_link_stg dl
                            JOIN document_stg ds ON dl.document_id = ds.document_id
                            JOIN document_set_stg dss ON ds.document_set_id = dss.document_set_id
                            LEFT JOIN document_type_lkup dtl ON ds.doc_type_cd = dtl.value
                            JOIN app_header_stg ah ON dl.link_ref_id = ah.application_id
                            LEFT JOIN app_individual_stg ahi ON ah.application_id = ahi.application_id AND dl.client_id = ahi.client_id
                            LEFT JOIN (SELECT *
                                       FROM(SELECT ai.application_id,ai.app_individual_id, ai.client_id,ROW_NUMBER() OVER (PARTITION BY ai.client_id ORDER BY ai.create_ts DESC) airn                        
                                            FROM app_individual_stg ai                    
                                            WHERE applicant_ind = 1)
                                        WHERE airn = 1 ) ai ON dl.client_id = ai.client_id
                     WHERE dl.link_type_cd = 'APPLICATION'
                     AND NOT EXISTS(SELECT 1 FROM app_event_log_stg e WHERE e.application_id = dl.link_ref_id AND app_event_cd = 'DOCUMENT_REMOVED' AND INSTR(e.note,ds.dcn) > 0) 
                     --AND doc_type_cd IN('APPLICATION','INSURANCE_PROOF','INCOME_PROOF','CITIZENSHIP_PROOF','OTHER_MI')  
                     ) doc  )     
                WHERE 1=1       
                AND rn = 1 ) doc ON ci.application_id = doc.application_id
          WHERE COALESCE(latest_doc_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(received_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(latest_app_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(new_latest_app_receipt_date, latest_app_receipt_date,TO_DATE('07/07/7777','mm/dd/yyyy'))
        ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
    SET latest_doc_receipt_date = tmp.received_date   
        ,latest_app_receipt_date = tmp.new_latest_app_receipt_date   
    Log Errors INTO Errlog_CIRTab ('UPD_CIR_LATEST_DOC_RECEIVED') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_LATEST_DOC_RECEIVED', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_LATEST_DOC_RECEIVED';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_LATEST_DOC_RECEIVED', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_LATEST_DOC_RECEIVED;

PROCEDURE UPD_CIR_APP_RECEIVED
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_APP_RECEIVED';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_APP_RECEIVED','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (   SELECT ci.renewal_receipt_date,ci.scan_date,ci.method_of_receipt,
               ds.received_date,ds.new_scan_date,ds.new_method_of_receipt,ci.application_id
          FROM tn_ci_redetermination ci 
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,TRUNC(s.received_date) received_date,d.scan_date new_scan_date,COALESCE(ds.report_label,s.doc_source_cd) new_method_of_receipt
                               ,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg s 
                         JOIN document_stg d ON s.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                         LEFT JOIN document_source_lkup ds ON s.doc_source_cd = ds.value
                        WHERE doc_type_cd = 'APPLICATION' 
                        AND  link_type_cd = 'APPLICATION'
                        AND NOT EXISTS(SELECT 1 FROM app_event_log_stg e WHERE e.application_id = dl.link_ref_id AND app_event_cd = 'DOCUMENT_REMOVED' AND INSTR(e.note,d.dcn) > 0) )
                  WHERE rn = 1) ds ON ci.application_id = ds.application_id                     
          WHERE ( COALESCE(TRUNC(ds.received_date), TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ci.renewal_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy'))              
             OR COALESCE(ds.new_scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ci.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.new_method_of_receipt,'*') != COALESCE(ci.method_of_receipt, '*')  )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  renewal_receipt_date = tmp.received_date          
          ,scan_date = tmp.new_scan_date
          ,method_of_receipt = tmp.new_method_of_receipt
     Log Errors INTO Errlog_CIRTab ('UPD_CIR_APP_RECEIVED') Reject Limit Unlimited
     ;
     
     v_upd_cnt := SQL%RowCount;
     COMMIT;
   --try to get any doc linked receipt date if app receipt date is null
   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (   SELECT ci.renewal_receipt_date,ci.scan_date,ci.method_of_receipt,
               ds.received_date,ds.new_scan_date,ds.new_method_of_receipt,ci.application_id
          FROM tn_ci_redetermination ci 
            LEFT JOIN (SELECT *
                  FROM (SELECT link_ref_id application_id,TRUNC(s.received_date) received_date,d.scan_date new_scan_date,COALESCE(ds.report_label,s.doc_source_cd) new_method_of_receipt
                               ,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY received_date,dl.create_ts) rn
                        FROM document_set_stg s 
                         JOIN document_stg d ON s.document_set_id = d.document_set_id
                         JOIN doc_link_stg dl ON d.document_id = dl.document_id  
                         LEFT JOIN document_source_lkup ds ON s.doc_source_cd = ds.value
                        WHERE 1=1
                        --AND doc_type_cd = 'APPLICATION' 
                        AND  link_type_cd = 'APPLICATION'
                        AND NOT EXISTS(SELECT 1 FROM app_event_log_stg e WHERE e.application_id = dl.link_ref_id AND app_event_cd = 'DOCUMENT_REMOVED' AND INSTR(e.note,d.dcn) > 0) )
                  WHERE rn = 1) ds ON ci.application_id = ds.application_id                     
          WHERE renewal_receipt_date IS NULL          
          AND ( COALESCE(TRUNC(ds.received_date), TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ci.renewal_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy'))              
             OR COALESCE(ds.new_scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ci.scan_date, TO_DATE('07/07/7777','mm/dd/yyyy')) 
             OR COALESCE(ds.new_method_of_receipt,'*') != COALESCE(ci.method_of_receipt, '*')  )             
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
     SET  renewal_receipt_date = tmp.received_date        
          ,scan_date = tmp.new_scan_date
          ,method_of_receipt = tmp.new_method_of_receipt
     Log Errors INTO Errlog_CIRTab ('UPD_CIR_APP_RECEIVED') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_RECEIVED', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_APP_RECEIVED';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_RECEIVED', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_APP_RECEIVED;


PROCEDURE UPD_CIR_APP_OPEN_TASK
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_APP_OPEN_TASK';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_APP_OPEN_TASK','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (SELECT  ci.uc_task_type
                   ,ci.uc_task_bu_name
                   ,ci.uc_task_owner_name
                   ,ci.uc_task_owner_type
                   ,ci.uc_task_id
                   ,ci.uc_task_status     
                   ,ci.uc_task_create_date
                   ,ci.application_id 
                   ,tmp.*
          FROM  tn_ci_redetermination ci
          LEFT JOIN(SELECT *
                    FROM(SELECT i.step_instance_id nw_open_task_id
                                ,i.create_ts nw_open_task_create_date                                                
                                ,step_instance_history_id                                
                                ,hist_status nw_open_task_status                                                              
                                ,i.task_name nw_open_task_name
                                ,CASE WHEN hist_status = 'CLAIMED' THEN i.first_name||' '||i.last_name ELSE NULL END nw_open_task_owner_name
                                ,i.business_unit_name nw_open_task_bu_name
                                ,i.staff_type_cd nw_open_task_owner_type
                                ,ROW_NUMBER() OVER (PARTITION BY i.ref_id ORDER BY i.step_instance_id DESC, DECODE(i.hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1)) vrn                                        
                                ,i.ref_id
                         FROM  (SELECT *
                                FROM (SELECT i.*,dt.task_name,co.first_name,last_name,co.staff_type_cd,business_unit_name,
                                              ROW_NUMBER() OVER (PARTITION BY i.ref_id,i.step_instance_id ORDER BY DECODE(hist_status,'COMPLETED',4,'TERMINATED',5,'CLAIMED',3,1) DESC,step_instance_id,step_instance_history_id) srn
                                      FROM step_instance_stg i
                                        JOIN d_task_types dt ON i.step_definition_id = dt.task_type_id
                                        LEFT JOIN d_staff co  ON i.owner = TO_CHAR(co.staff_id)
                                        LEFT JOIN d_business_units d ON d.business_unit_id = i.group_id
                                      WHERE ref_type = 'APP_HEADER' )
                                 WHERE srn = 1 ) i                 
                         WHERE hist_status IN('UNCLAIMED','CLAIMED'))
                    WHERE vrn = 1 )  tmp ON tmp.ref_id = ci.application_id                
          WHERE ( COALESCE(tmp.nw_open_task_id,0) != COALESCE(ci.uc_task_id,0)   
             OR COALESCE(tmp.nw_open_task_status,'*') != COALESCE(ci.uc_task_status,'*')  
             OR COALESCE(tmp.nw_open_task_name,'*') != COALESCE(ci.uc_task_type,'*')  
             OR COALESCE(tmp.nw_open_task_owner_name,'*') != COALESCE(ci.uc_task_owner_name,'*')  
             OR COALESCE(tmp.nw_open_task_bu_name,'*') != COALESCE(ci.uc_task_bu_name,'*')  
             OR COALESCE(tmp.nw_open_task_owner_type,'*') != COALESCE(ci.uc_task_owner_type,'*')   
             OR COALESCE(tmp.nw_open_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(ci.uc_task_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) )
        ) tmp ON ( tmp.application_id = s.application_id )
    WHEN MATCHED THEN UPDATE
     SET  uc_task_id = tmp.nw_open_task_id
         ,uc_task_status = tmp.nw_open_task_status
         ,uc_task_type = tmp.nw_open_task_name
         ,uc_task_owner_name = tmp.nw_open_task_owner_name
         ,uc_task_bu_name = tmp.nw_open_task_bu_name
         ,uc_task_owner_type = tmp.nw_open_task_owner_type       
         ,uc_task_create_date = tmp.nw_open_task_create_date
     Log Errors INTO Errlog_CIRTab ('UPD_CIR_APP_OPEN_TASK') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_OPEN_TASK', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_APP_OPEN_TASK';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_OPEN_TASK', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_APP_OPEN_TASK;

PROCEDURE UPD_CIR_MAGI_DATA
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_MAGI_DATA';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_MAGI_DATA','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (SELECT ci.household_size
                  ,ci.household_income
                  ,ci.us_citizen_indicator
                  ,ci.eligible_immigrant_alleged
                  ,ci.other_coverage
                  ,ci.parent_caretaker_indicator
                  ,ci.residency_verified
                  ,ci.mitc_result_redetermination
                  ,ci.student_indicator
                  ,ci.pregnancy_indicator
                  ,mg.*
          FROM tn_ci_redetermination ci
          JOIN (SELECT
                  application_id
                  ,household_size new_household_size
                  ,household_income new_household_income
                  ,citizen_ind new_us_citizen_indicator
                  ,eligible_immigrant_attest new_eligible_immigrant_alleged
                  ,other_coverage new_other_coverage
                  ,parent_ct_category new_parent_caretaker_indicator
                  ,residency_verified new_residency_verified
                  ,CASE WHEN medicaid_eligible = 'Y' THEN 'Medicaid'
                        WHEN chip_eligible = 'Y' THEN 'CHIP'
                    ELSE 'None' END new_mitc_result_redetermination
                  ,student_indicator new_student_indicator
                  ,pregnancy new_pregnancy_indicator
                  ,ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY magi_log_id DESC,magi_transaction_data_id DESC) rn
                FROM magi_service_audit_log_stg 
                WHERE magi_transaction_data_id IS NOT NULL) mg ON ci.application_id = mg.application_id
          WHERE rn = 1
          AND ( COALESCE(household_size,0) != COALESCE(new_household_size,0)
            OR COALESCE(household_income,0) != COALESCE(new_household_income,0)
            OR COALESCE(us_citizen_indicator,'*') != COALESCE(new_us_citizen_indicator,'*')
            OR COALESCE(eligible_immigrant_alleged,'*') != COALESCE(new_eligible_immigrant_alleged,'*')
            OR COALESCE(other_coverage,'*') != COALESCE(new_other_coverage,'*')
            OR COALESCE(parent_caretaker_indicator,'*') != COALESCE(new_parent_caretaker_indicator,'*')
            OR COALESCE(residency_verified,'*') != COALESCE(new_residency_verified,'*')
            OR COALESCE(mitc_result_redetermination,'*') != COALESCE(new_mitc_result_redetermination,'*')
            OR COALESCE(student_indicator,'*') != COALESCE(new_student_indicator,'*')
            OR COALESCE(pregnancy_indicator,'*') != COALESCE(new_pregnancy_indicator,'*') )
          ) tmp ON (tmp.application_id = s.application_id)
    WHEN MATCHED THEN UPDATE
    SET household_size = tmp.new_household_size
       ,household_income = new_household_income
       ,us_citizen_indicator = new_us_citizen_indicator
       ,eligible_immigrant_alleged = new_eligible_immigrant_alleged
       ,other_coverage = new_other_coverage
       ,parent_caretaker_indicator = new_parent_caretaker_indicator
       ,residency_verified = new_residency_verified
       ,mitc_result_redetermination = new_mitc_result_redetermination
       ,student_indicator = new_student_indicator
       ,pregnancy_indicator = new_pregnancy_indicator
    Log Errors INTO Errlog_CIRTab ('UPD_CIR_MAGI_DATA') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_MAGI_DATA', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_MAGI_DATA';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_MAGI_DATA', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_MAGI_DATA;

PROCEDURE UPD_CIR_APP_RFE_STATUS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_CIRTab WHERE ora_err_tag$ = 'UPD_CIR_APP_RFE_STATUS';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'UPD_CIR_APP_RFE_STATUS','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

  MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (SELECT ci.application_id, ci.rfe_status_cd,ts.nw_rfe_status_cd
          FROM tn_ci_redetermination ci
          JOIN (SELECT ts.application_id,ts.rfe_status_cd nw_rfe_status_cd, ROW_NUMBER() OVER (PARTITION BY ts.application_id ORDER BY app_tracker_id DESC) rn
                FROM app_tracker_stg ts ) ts ON ci.application_id = ts.application_id                
           WHERE rn = 1
           AND COALESCE(ts.nw_rfe_status_cd,'*') != COALESCE(ci.rfe_status_cd,'*')         
        ) tmp ON (tmp.application_id = s.application_id) 
    WHEN MATCHED THEN UPDATE
    SET rfe_status_cd = tmp.nw_rfe_status_cd             
    Log Errors INTO Errlog_CIRTab ('UPD_CIR_APP_RFE_STATUS') Reject Limit Unlimited
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
    SELECT c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_RFE_STATUS', 1, Ora_Err_Mesg$, ora_err_number$, 'TN_CI_REDETERMINATION', APPLICATION_ID
      FROM Errlog_CIRTab
     WHERE Ora_Err_Tag$ = 'UPD_CIR_APP_RFE_STATUS';

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
      VALUES( c_critical, con_pkg, 'CIR_INCREMENTAL_PKG.UPD_CIR_APP_RFE_STATUS', 1, v_desc, v_code, 'TN_CI_REDETERMINATION');

      COMMIT;
END UPD_CIR_APP_RFE_STATUS;

END;
/


grant execute on CIR_INCREMENTAL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;