alter session set plsql_code_type = native;

create or replace package CAHCO_FORM_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CAHCO/createdb/EMRS/EMRS_CAHCO_ENROLL_ETL_PKG.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 23484 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-24 19:12:49 -0700 (Thu, 24 May 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: aa24065 $';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE FORM_INS;
  PROCEDURE FORM_TYPE_UPD;
  
  PROCEDURE FORM_INCOMPLETE_DTL_INS;
  PROCEDURE FORM_INCOMPLETE_DTL_UPD;
  
  PROCEDURE FORM_INCOMPLETE_INS;
  PROCEDURE FORM_INCOMPLETE_UPD;
  
  PROCEDURE FORM_MANUAL_ENROLL_DTL_INS;
  PROCEDURE FORM_MANUAL_ENROLL_DTL_UPD;
  
  PROCEDURE FORM_MANUAL_ENROLL_INS;
  PROCEDURE FORM_MANUAL_ENROLL_UPD;
  
  PROCEDURE FORM_ENROLL_INS;
  PROCEDURE FORM_ENROLL_UPD;
  
  PROCEDURE FORM_REMOVE_DUPLICATE_ENROLL;  
  PROCEDURE FORM_UPD_FROM_ENRLHIST;    
end;
/


CREATE OR REPLACE PACKAGE BODY CAHCO_FORM_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE FORM_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM (reference_id
          ,reference_type
          ,envelope_id
          ,dcn 
          ,form_phone_number
          ,mail_type
          ,form_signed
          ,record_date
          ,date_form_received
          ,esr_id
          ,verifier_id
          ,form_status_code
          ,client_number
          ,plan_type_a
          ,plan_type_b
          ,plan_id_a
          ,plan_id_b
          ,incomplete_reason_code_a
          ,incomplete_reason_code_b
          ,bene_status_plan_a
          ,bene_status_plan_b
          ,sent_to_manual_a
          ,sent_to_manual_b          
          ,plan_partner
          ,clinic_code_a
          ,clinic_code_b
          ,case_number
          ,form_type          
          ,form_incomplete          
          ,form_manually_entered                    
          ,plan_originated_flag
          ,created_by_agent_flag          
          ,county_code          
          ,processed_date
          )
    SELECT  rr.OcrRecordID reference_id
          ,'OCRRECORD' reference_type
          ,rr.EnvelopeID envelope_id
          ,rr.dcn
          ,rr.CaseHeadPhone form_phone_number
          ,rr.MailType mail_type
          ,UPPER(rr.FormSigned) form_signed
          ,rr.CreatedOn record_date
          ,rr.DateFormReceived date_form_received
          ,rr.EsrID esr_id
          ,rr.VerifierID verifier_id
          ,rr.OcrRecordStatus form_status_code
          ,rr.BeneficiaryID client_number
          ,rr.PlanTypeA plan_type_a
          ,rr.PlanTypeB plan_type_b
          ,rr.PlanIDA plan_id_a
          ,rr.PlanIDB plan_id_b          
          ,rr.OCRIncompleteReasonA incomplete_reason_code_a
          ,rr.OCRIncompleteReasonB incomplete_reason_code_b
          ,rr.OCRBeneStatusPlanA bene_status_plan_a
          ,rr.OCRBeneStatusPlanB bene_status_plan_b
          ,rr.SentToManualA sent_to_manual_a
          ,rr.SentToManualB sent_to_manual_b       
          ,rr.PlanPartner plan_partner
          ,rr.ClinicCodeA clinic_code_a
          ,rr.ClinicCodeB clinic_code_b
          ,rr.CaseRowID case_number
          ,'Choice Form' form_type          
          ,'N' form_incomplete           
          ,'N' form_manually_entered          
          ,CASE WHEN SUBSTR(rr.EsrID,1,3) = 'PLN' THEN 'Y' ELSE 'N' END plan_orig_flag         
          ,'N' created_by_agent_flag          
          ,rr.ResidenceCounty county_code  
          ,rr.CreatedOn processed_date
    FROM (SELECT *
          FROM(SELECT rr.*, ROW_NUMBER() OVER (PARTITION BY rr.dcn ORDER BY rr.OCrRecordId,BeneficiaryID) rn
               FROM hco_s_form_stg rr)
          WHERE rn = 1) rr          
      --JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT' 
     WHERE NOT EXISTS(SELECT 1 FROM hco_d_form f WHERE f.dcn = rr.dcn)
     LOG Errors INTO Errlog_Form ('FORM_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INS', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_INS;

PROCEDURE FORM_TYPE_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_TYPE_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_TYPE_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM s
   USING (SELECT sf.*
                ,f.dp_form_id
                ,CASE WHEN sf.CreatedOn < COALESCE(f.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))  THEN  sf.CreatedOn ELSE f.processed_date END ft_processed_date
          FROM (SELECT *
             FROM (SELECT s.* , ROW_NUMBER() OVER (PARTITION BY s.dcn ORDER BY DECODE(FormType,'EDER',1,2)) rn
                   FROM hco_s_form_type_stg s)
             WHERE rn = 1) sf              
          JOIN hco_d_form f ON sf.dcn = f.dcn
          WHERE COALESCE(sf.FormType,'*') != COALESCE(f.form_type,'*')            
            OR COALESCE(sf.CreatedOn, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(f.exempt_or_eder_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))    
            OR COALESCE(sf.CreatedOn, TO_DATE('07/07/7777','mm/dd/yyyy')) !=  COALESCE(f.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))   
          ) st ON (s.dp_form_id = st.dp_form_id)
    WHEN MATCHED THEN UPDATE
     SET s.form_type = st.FormType
        ,s.exempt_or_eder_create_date = st.CreatedOn   
        ,s.processed_date = st.ft_processed_date
     Log Errors INTO Errlog_Form ('FORM_TYPE_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_TYPE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_TYPE_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_TYPE_UPD', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_TYPE_UPD;

PROCEDURE FORM_INCOMPLETE_DTL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_INCOMPLETE_DTL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_INCOMPLETE_DTL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM_INCOMPLETE (dcn,
                                  file_received_from_hyland,
                                  campaign_completed,
                                  record_date,
                                  modified_date,
                                  record_name,
                                  modified_name,
                                  bene_reason_id,
                                  esr_id,
                                  verifier_id,
                                  reason_code,
                                  envelope_id,
                                  client_number,
                                  form_received_date,
                                  case_number,
                                  residence_county,
                                  ocr_record_id )
     SELECT DocumentBatchNum dcn
            ,FileReceivedFromHyland file_rcvd_from_hyland
            ,CampaignCompleted campaign_completed
            ,RecordCreateDate record_date
            ,DateLastModified modified_date
            ,RecordCreateName record_name
            ,NameLastModified modified_name            
            ,BeneReasonID bene_reason_id
            ,EsrID esr_id
            ,VerifierID verifier_id            
            ,ReasonCode reason_code
            ,EnvelopeId envelope_id
            ,BeneficiaryID client_number            
            ,FormReceivedDate date_form_received
            ,CaseRowID case_number
            ,ResidenceCounty county_code
            ,OcrRecordId ocr_record_id            
     FROM (SELECT i.* ,ROW_NUMBER() OVER (PARTITION BY BeneReasonID ORDER BY BeneReasonID,OcrRecordId) rn
          FROM hco_s_form_incomplete_stg i ) i
     WHERE rn = 1
     AND NOT EXISTS(SELECT 1 FROM hco_d_form_incomplete f WHERE f.bene_reason_id = i.BeneReasonID)
     LOG Errors INTO Errlog_Form ('FORM_INCOMPLETE_DTL_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_DTL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM_INCOMPLETE', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_INCOMPLETE_DTL_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_DTL_INS', 1, v_desc, v_code, 'HCO_D_FORM_INCOMPLETE');

      COMMIT;
END FORM_INCOMPLETE_DTL_INS;


PROCEDURE FORM_INCOMPLETE_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    FORM_INCOMPLETE_DTL_INS;
    
    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_INCOMPLETE_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_INCOMPLETE_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM (reference_id
                       ,reference_type
                       ,envelope_id
                       ,dcn
                       ,record_date
                       ,date_form_received
                       ,esr_id
                       ,verifier_id
                       ,form_status_code
                       ,client_number
                       ,incomplete_reason_code_a
                       ,case_number
                       ,county_code
                       ,form_type
                       ,form_incomplete
                       ,form_manually_entered
                       ,plan_originated_flag
                       ,created_by_agent_flag
                       ,modified_name
                       ,record_name
                       ,modified_date
                       ,processed_date
                       ,file_rcvd_from_hyland
                       ,campaign_completed
                       ,form_incomplete_create_date
                       )
     SELECT BeneReasonID reference_id
            ,'BENEFORMINCOMPLETEREASON' reference_type
            ,EnvelopeId envelope_id
            ,DocumentBatchNum dcn
            ,RecordCreateDate record_date
            ,FormReceivedDate date_form_received
            ,EsrID esr_id
            ,VerifierID verifier_id            
            ,'U' form_status_code
            ,BeneficiaryID client_number
            ,ReasonCode incomplete_reason_code_a
            ,CaseRowID case_number
            ,ResidenceCounty county_code
            ,'Choice Form' form_type
            ,'Y' form_incomplete
            ,'N' form_manually_entered
            ,CASE WHEN SUBSTR(EsrID,1,3) = 'PLN' THEN 'Y' ELSE 'N' END plan_originated_flag
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
            ,NameLastModified modified_name
            ,RecordCreateName record_name
            ,DateLastModified modified_date
            ,RecordCreateDate processed_date
            ,FileReceivedFromHyland file_rcvd_from_hyland
            ,CampaignCompleted campaign_completed
            ,GREATEST(DateLastModified,RecordCreateDate) form_incomplete_create_date            
     FROM(SELECT i.* ,ROW_NUMBER() OVER (PARTITION BY DocumentBatchNum ORDER BY BeneReasonID DESC) rn
          FROM hco_s_form_incomplete_stg i
          WHERE OcrRecordId IS NULL 
          AND DocumentBatchNum IS NOT NULL) i
        JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'                   
     WHERE rn = 1
     AND NOT EXISTS(SELECT 1 FROM hco_d_form f WHERE f.dcn = i.DocumentBatchNum)
     LOG Errors INTO Errlog_Form ('FORM_INCOMPLETE_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_INCOMPLETE_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_INS', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_INCOMPLETE_INS;

PROCEDURE FORM_INCOMPLETE_DTL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_INCOMPLETE_DTL_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'FORM_INCOMPLETE_DTL_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM_INCOMPLETE s
   USING (SELECT tmp.*
                 ,t.bene_reason_id 
          FROM(SELECT DocumentBatchNum dcn
                      ,FileReceivedFromHyland file_rcvd_from_hyland
                      ,CampaignCompleted campaign_completed
                      ,RecordCreateDate record_date
                      ,DateLastModified modified_date
                      ,RecordCreateName record_name
                      ,NameLastModified modified_name            
                      ,BeneReasonID
                      ,EsrID esr_id
                      ,VerifierID verifier_id            
                      ,ReasonCode reason_code
                      ,EnvelopeId envelope_id
                      ,BeneficiaryID client_number            
                      ,FormReceivedDate date_form_received
                      ,CaseRowID case_number
                      ,ResidenceCounty county_code
                      ,OcrRecordId ocr_record_id            
               FROM (SELECT i.* ,ROW_NUMBER() OVER (PARTITION BY BeneReasonID ORDER BY BeneReasonID,OcrRecordId) rn
                      FROM hco_s_form_incomplete_stg i ) i
               WHERE rn = 1) tmp
          JOIN hco_d_form_incomplete t ON  tmp.BeneReasonID = t.bene_reason_id              
          WHERE COALESCE(t.file_received_from_hyland,'*') != COALESCE(tmp.file_rcvd_from_hyland,'*')             
          OR COALESCE(t.campaign_completed,'*') != COALESCE(tmp.campaign_completed,'*')
          OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')           
          OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
          OR COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
          OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')            
          OR COALESCE(t.reason_code,'*') != COALESCE(tmp.reason_code,'*')
          OR COALESCE(t.residence_county,'*') != COALESCE(tmp.county_code,'*') 
          OR COALESCE(t.ocr_record_id,0) != COALESCE(tmp.ocr_record_id,0)
          ) st ON (s.bene_reason_id = st.bene_reason_id)
    WHEN MATCHED THEN UPDATE
     SET s.esr_id = st.esr_id
        ,s.verifier_id = st.verifier_id
        ,s.reason_code = st.reason_code
        ,s.residence_county = st.county_code       
        ,s.modified_name = st.modified_name
        ,s.modified_date = st.modified_date       
        ,s.file_received_from_hyland = st.file_rcvd_from_hyland
        ,s.campaign_completed = st.campaign_completed
        ,s.ocr_record_id = st.ocr_record_id
     Log Errors INTO Errlog_Form ('FORM_INCOMPLETE_DTL_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;
   

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = record_count + v_upd_cnt
         , PROCESSED_COUNT = processed_count + v_upd_cnt
         , RECORD_UPDATED_COUNT = record_updated_count + v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_DTL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM_INCOMPLETE', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_INCOMPLETE_DTL_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_DTL_UPD', 1, v_desc, v_code, 'HCO_D_FORM_INCOMPLETE');

      COMMIT;
END FORM_INCOMPLETE_DTL_UPD;

PROCEDURE FORM_INCOMPLETE_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   FORM_INCOMPLETE_DTL_UPD;
   
   DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_INCOMPLETE_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'FORM_INCOMPLETE_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM s
   USING (SELECT tmp.*
                 ,t.dp_form_id
                 ,CASE WHEN t.processed_date IS NULL THEN GREATEST(tmp.modified_date,RecordCreateDate) ELSE t.processed_date END processed_date                 
          FROM(SELECT           
             EsrID esr_id
            ,VerifierID verifier_id                       
            ,ReasonCode incomplete_reason_code_a
            ,ResidenceCounty county_code
            ,CASE WHEN SUBSTR(EsrID,1,3) = 'PLN' THEN 'Y' ELSE 'N' END plan_originated_flag
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
            ,NameLastModified modified_name
            ,DateLastModified modified_date          
            ,FileReceivedFromHyland file_rcvd_from_hyland
            ,CampaignCompleted campaign_completed
            ,GREATEST(DateLastModified,RecordCreateDate) form_incomplete_create_date  
            ,BeneficiaryID
            ,DocumentBatchNum dcn
            ,'Y' form_incomplete
            ,RecordCreateName record_name
            ,RecordCreateDate
            ,OCRRecordID
          FROM(SELECT i.* ,ROW_NUMBER() OVER (PARTITION BY DocumentBatchNum ORDER BY BeneReasonID DESC) rn
                  FROM hco_s_form_incomplete_stg i) i
             JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'                   
           WHERE rn = 1 ) tmp
          JOIN hco_d_form t ON  tmp.dcn = t.dcn              
          WHERE  COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')            
            OR COALESCE(t.incomplete_reason_code_a,'*') != COALESCE(tmp.incomplete_reason_code_a,'*')
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')            
            OR COALESCE(t.plan_originated_flag,'*') != COALESCE(tmp.plan_originated_flag,'*')
            OR COALESCE(t.created_by_agent_flag,'*') != COALESCE(tmp.created_by_agent_flag,'*')
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')           
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.RecordCreateDate, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.file_rcvd_from_hyland,'*') != COALESCE(tmp.file_rcvd_from_hyland,'*')            
            OR COALESCE(t.campaign_completed,'*') != COALESCE(tmp.campaign_completed,'*')
            OR COALESCE(t.form_incomplete,'*') != COALESCE(tmp.form_incomplete,'*')
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')
            OR COALESCE(t.form_incomplete_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.form_incomplete_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
          ) st ON (s.dp_form_id = st.dp_form_id)
    WHEN MATCHED THEN UPDATE
     SET s.esr_id = st.esr_id
        ,s.verifier_id = st.verifier_id
        ,s.incomplete_reason_code_a = st.incomplete_reason_code_a
        ,s.county_code = st.county_code
        ,s.plan_originated_flag = st.plan_originated_flag
        ,s.created_by_agent_flag = st.created_by_agent_flag
        ,s.modified_name = st.modified_name
        ,s.modified_date = st.modified_date
        ,s.processed_date = st.processed_date
        ,s.file_rcvd_from_hyland = st.file_rcvd_from_hyland
        ,s.campaign_completed = st.campaign_completed
        ,s.form_incomplete_create_date = st.form_incomplete_create_date 
        ,s.record_name = st.record_name
        ,s.form_incomplete = st.form_incomplete
     Log Errors INTO Errlog_Form ('FORM_INCOMPLETE_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_INCOMPLETE_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_INCOMPLETE_UPD', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_INCOMPLETE_UPD;

PROCEDURE FORM_MANUAL_ENROLL_DTL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN
    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_MANUAL_ENROLL_DTL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_MANUAL_ENROLL_DTL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM_MANUAL_ENROLL (dcn,
                                     record_date,
                                     modified_date, 
                                     record_name,
                                     modified_name,
                                     processed,
                                     manual_enr_id,
                                     client_number,
                                     eid,
                                     form_received_date,
                                     case_number,
                                     residence_county,
                                     ocr_record_id)
      SELECT dcn
            ,RecordCreateDate record_date
            ,DateLastModified modified_date  
            ,RecordCreateName record_name 
            ,NameLastModified modified_name
            ,Processed
            ,ManualEnrId
            ,BeneficiaryId
            ,EID envelope_id
            ,FormReceivedDate date_form_received            
            ,CaseRowID case_number
            ,ResidenceCounty county_code            
            ,OcrRecordId
      FROM (SELECT m.*, ROW_NUMBER() OVER (PARTITION BY ManualEnrID ORDER BY ManualEnrID,OcrRecordId) rn
            FROM hco_s_form_manual_enroll_stg m ) m       
      WHERE rn = 1           
      AND NOT EXISTS(SELECT 1 FROM hco_d_form_manual_enroll f WHERE m.ManualEnrID = f.manual_enr_id)   
     LOG Errors INTO Errlog_Form ('FORM_MANUAL_ENROLL_DTL_INS') Reject Limit Unlimited;
   
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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_DTL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM_MANUAL_ENROLL', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_MANUAL_ENROLL_DTL_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_DTL_INS', 1, v_desc, v_code, 'HCO_D_FORM_MANUAL_ENROLL');

      COMMIT;

END FORM_MANUAL_ENROLL_DTL_INS;


PROCEDURE FORM_MANUAL_ENROLL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN

    FORM_MANUAL_ENROLL_DTL_INS;
    
    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_MANUAL_ENROLL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_MANUAL_ENROLL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM (reference_id
            ,reference_type
            ,envelope_id
            ,dcn
            ,record_date
            ,date_form_received
            ,form_status_code
            ,client_number
            ,case_number
            ,county_code
            ,form_incomplete
            ,form_manually_entered
            ,plan_originated_flag
            ,created_by_agent_flag
            ,modified_name
            ,record_name
            ,modified_date
            ,processed_date
            ,manual_enr_create_date
            ,form_type            
            --,selection_source_code
            )
      SELECT ManualEnrID reference_id
            ,'MANUALENROLLMENT' reference_type
            ,EID envelope_id
            ,dcn
            ,RecordCreateDate record_date
            ,FormReceivedDate date_form_received
            ,'U' form_status_code
            ,BeneficiaryID client_number
            ,CaseRowID case_number
            ,ResidenceCounty county_code            
            ,'N' form_incomplete
            ,'Y' form_manually_entered
            ,'N' plan_originated_flag
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
            ,NameLastModified modified_name
            ,RecordCreateName record_name
            ,DateLastModified modified_date  
            ,GREATEST(DateLastModified,RecordCreateDate) processed_date
            ,GREATEST(DateLastModified,RecordCreateDate) manual_enr_create_date
            ,'Choice Form' form_type
           -- ,'Manual' selection_source_code
      FROM (SELECT m.*, ROW_NUMBER() OVER (PARTITION BY dcn ORDER BY ManualEnrID DESC) rn
            FROM hco_s_form_manual_enroll_stg m 
            WHERE OcrRecordID IS NULL
            AND dcn IS NOT NULL) m
       JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'  
      WHERE rn = 1           
      AND NOT EXISTS(SELECT 1 FROM hco_d_form f WHERE m.dcn = f.dcn)   
     LOG Errors INTO Errlog_Form ('FORM_MANUAL_ENROLL_INS') Reject Limit Unlimited;
   
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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_MANUAL_ENROLL_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_INS', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;

END FORM_MANUAL_ENROLL_INS;

PROCEDURE FORM_MANUAL_ENROLL_DTL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_MANUAL_ENROLL_DTL_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'FORM_MANUAL_ENROLL_DTL_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM_MANUAL_ENROLL s
   USING (SELECT tmp.*
                 ,t.manual_enr_id                 
          FROM(SELECT                       
            ResidenceCounty county_code            
            ,NameLastModified modified_name
            ,DateLastModified modified_date            
            ,BeneficiaryID
            ,dcn
            ,RecordCreateDate
            ,RecordCreateName record_name
            ,m.OcrRecordID   
            ,processed
            ,ManualEnrId
          FROM(SELECT m.* ,ROW_NUMBER() OVER (PARTITION BY ManualEnrID ORDER BY ManualEnrID,OcrRecordId) rn
                  FROM hco_s_form_manual_enroll_stg m) m
             JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'                   
           WHERE rn = 1 ) tmp
          JOIN hco_d_form_manual_enroll t ON tmp.ManualEnrId = t.manual_enr_id
          WHERE  COALESCE(t.residence_county,'*') != COALESCE(tmp.county_code,'*')                             
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')           
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')           
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))                        
            OR COALESCE(t.processed,'*') != COALESCE(tmp.processed,'*')            
            OR COALESCE(t.ocr_record_id,0) != COALESCE(tmp.OcrRecordID,0)            
          ) st ON (s.manual_enr_id = st.manual_enr_id)
    WHEN MATCHED THEN UPDATE
     SET s.residence_county = st.county_code            
        ,s.modified_name = st.modified_name
        ,s.record_name = st.record_name
        ,s.modified_date = st.modified_date
        ,s.processed = st.processed 
        ,s.ocr_record_id = st.OcrRecordID
     Log Errors INTO Errlog_Form ('FORM_MANUAL_ENROLL_DTL_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_DTL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM_MANUAL_ENROLL', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_MANUAL_ENROLL_DTL_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_DTL_UPD', 1, v_desc, v_code, 'HCO_D_FORM_MANUAL_ENROLL');

      COMMIT;
END FORM_MANUAL_ENROLL_DTL_UPD;

PROCEDURE FORM_MANUAL_ENROLL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   FORM_MANUAL_ENROLL_DTL_UPD;

   DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_MANUAL_ENROLL_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'FORM_MANUAL_ENROLL_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM s
   USING (SELECT tmp.*
                 ,t.dp_form_id
                 ,CASE WHEN t.processed_date IS NOT NULL THEN
                     CASE WHEN reference_type = 'OCRRECORD' THEN t.processed_date ELSE GREATEST(tmp.modified_date,RecordCreateDate) END
                  ELSE GREATEST(tmp.modified_date,RecordCreateDate) END processed_date                 
          FROM(SELECT                       
            ResidenceCounty county_code            
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
          --  ,'N' plan_originated_flag
            ,NameLastModified modified_name
            ,DateLastModified modified_date
            ,GREATEST(DateLastModified,RecordCreateDate) manual_enr_create_date  
            ,BeneficiaryID
            ,dcn
            ,'Y' form_manually_entered
            ,RecordCreateDate
            ,RecordCreateName record_name
            ,m.OcrRecordID
           -- ,'Manual' selection_source_code
          FROM(SELECT m.* ,ROW_NUMBER() OVER (PARTITION BY dcn ORDER BY ManualEnrID DESC) rn
                  FROM hco_s_form_manual_enroll_stg m) m
             JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'                   
           WHERE rn = 1 ) tmp
          JOIN hco_d_form t ON tmp.dcn = t.dcn
          WHERE  COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')            
     --       OR COALESCE(t.plan_originated_flag,'*') != COALESCE(tmp.plan_originated_flag,'*')
            OR COALESCE(t.created_by_agent_flag,'*') != COALESCE(tmp.created_by_agent_flag,'*')
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')           
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')           
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(GREATEST(tmp.modified_date,tmp.RecordCreateDate), TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.form_manually_entered,'*') != COALESCE(tmp.form_manually_entered,'*')            
          --  OR COALESCE(t.selection_source_code,'*') != COALESCE(tmp.selection_source_code,'*')           
            OR COALESCE(t.manual_enr_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.manual_enr_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
          ) st ON (s.dp_form_id = st.dp_form_id)
    WHEN MATCHED THEN UPDATE
     SET s.county_code = st.county_code
    --    ,s.plan_originated_flag = st.plan_originated_flag
        ,s.created_by_agent_flag = st.created_by_agent_flag
        ,s.modified_name = st.modified_name
        ,s.record_name = st.record_name
        ,s.modified_date = st.modified_date
        ,s.processed_date = st.processed_date   
        ,s.form_manually_entered = st.form_manually_entered
        ,s.manual_enr_create_date = st.manual_enr_create_date 
      --  ,s.selection_source_code = st.selection_source_code
     Log Errors INTO Errlog_Form ('FORM_MANUAL_ENROLL_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_MANUAL_ENROLL_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_MANUAL_ENROLL_UPD', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_MANUAL_ENROLL_UPD;

PROCEDURE FORM_ENROLL_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;
BEGIN
    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_ENROLL_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_ENROLL_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO HCO_D_FORM (reference_id
              ,reference_type
              ,dcn
              ,record_date
              ,date_form_received
              ,esr_id
              ,verifier_id
              ,form_status_code
              ,client_number
              ,plan_type_a
              ,plan_id_a
              ,case_number
              ,county_code
              ,form_type
              ,form_incomplete
              ,form_manually_entered
              ,plan_originated_flag
              ,created_by_agent_flag
              ,processed_date
              ,enrollment_id
              ,change_reason_code
              ,modified_name
              ,record_name
              ,modified_date
              ,selection_source_code)
      SELECT EnrollmentID reference_id
            ,'ENROLLMENT' reference_type
            ,DocumentBatchNum dcn
            ,RecordCreateDate record_date
            ,DateFormReceived date_form_received
            ,EsrID esr_id
            ,VerifierID verifier_id
            ,'D' form_status_code
            ,BeneficiaryID client_number
            ,PlanType plan_type_a
            ,EnrlPlanID plan_id_a
            ,CaseRowID case_number
            ,County county_code
            ,'Choice Form' form_type
            ,'N' form_incomplete
            ,'N' form_manually_entered
            ,CASE WHEN SUBSTR(EsrID,1,3) = 'PLN' THEN 'Y' ELSE 'N' END plan_originated_flag
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
            ,GREATEST(TransDate,DateLastModified) processed_date
            ,EnrollmentID enrollment_id
            ,DisEnrlReasonCode change_reason_code
            ,NameLastModified modified_name
            ,RecordCreateName record_name
            ,DateLastModified modified_date
            ,channelname selection_source_code 
      FROM (SELECT s.*,ROW_NUMBER() OVER (PARTITION BY DocumentBatchNum ORDER BY DECODE(disregardtrans,'N',1,2),EnrollmentID) rn
            FROM emrs_s_enrollment_stg s) s
        JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'         
      WHERE rn = 1     
      AND DocumentBatchNum IS NOT NULL
      AND NOT EXISTS(SELECT 1 FROM hco_d_form f WHERE s.DocumentBatchNum = f.dcn)                  
      LOG Errors INTO Errlog_Form ('FORM_ENROLL_INS') Reject Limit Unlimited;
   
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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_ENROLL_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_ENROLL_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_ENROLL_INS', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_ENROLL_INS;

PROCEDURE FORM_REMOVE_DUPLICATE_ENROLL
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
    CURSOR temp_cur IS
      SELECT DISTINCT f.dp_form_id --f.dcn,f.date_form_received,f.reference_id,f.reference_type,d.reference_id,d.date_form_received,d.dcn
      FROM hco_d_form f
        JOIN hco_d_form d on f.reference_id = d.reference_id
      WHERE f.reference_type = 'ENROLLMENT'
      AND d.reference_type = 'ENROLLMENT'
      AND f.dcn != d.dcn
      AND f.date_form_received < d.date_form_received 
      UNION
      SELECT DISTINCT f.dp_form_id
      FROM hco_d_form f
        JOIN hco_d_form d on f.enrollment_id = d.enrollment_id
      WHERE f.reference_type = 'ENROLLMENT'
      AND d.reference_type != 'ENROLLMENT'
      AND f.dcn != d.dcn
      AND f.date_form_received < d.date_form_received
      ;   
    
    TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
    temp_tab t_tab;
    v_bulk_limit NUMBER := 500;      
    
BEGIN

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_REMOVE_DUPLICATE_ENROLL','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         DELETE FROM hco_d_form                              
		     WHERE dp_form_id = temp_tab(indx).dp_form_id;		   
     END;
     COMMIT;
    END LOOP;
    COMMIT;
    CLOSE temp_cur;
    
     UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;


  /*  INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_REMOVE_DUPLICATE_ENROLL', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_REMOVE_DUPLICATE_ENROLL';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;     

    COMMIT;
*/
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_REMOVE_DUPLICATE_ENROLL', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_REMOVE_DUPLICATE_ENROLL;

PROCEDURE FORM_UPD_FROM_ENRLHIST
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_UPD_FROM_ENRLHIST';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'FORM_UPD_FROM_ENRLHIST','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  hco_d_form s
   USING (SELECT *
          FROM (SELECT d.dp_form_id
                       ,d.esr_id
                       ,d.verifier_id verifier_id
                       ,d.county_code county_code           
                       ,d.created_by_agent_flag
                       ,d.plan_originated_flag
                       ,d.modified_name
                       ,d.modified_date
                       ,d.client_number
                       ,d.dcn
                       ,d.processed_date
                       ,d.change_reason_code
                       ,d.enrollment_id
                       ,d.record_name
                       ,d.selection_source_code
                       ,s.esr_id enrl_esr_id
                       ,s.verifier_id enrl_verifier_id
                       ,s.county_code enrl_county_code           
                       ,CASE WHEN INSTR(ll.out_var,s.record_name) = 0 THEN 'Y' ELSE 'N' END enrl_created_by_agent_flag
                       ,CASE WHEN SUBSTR(UPPER(s.esr_id),1,3) = 'PLN' THEN 'Y' ELSE 'N' END enrl_plan_originated_flag
                       ,s.modified_name enrl_modified_name
                       ,s.modified_date  enrl_modified_date          
                       ,s.client_number enrl_client_number
                       ,s.dcn enrl_dcn                    
                       ,CASE WHEN d.processed_date IS NULL THEN GREATEST(s.transaction_date,s.modified_date) ELSE d.processed_date END enrl_processed_date
                       ,s.change_reason_code enrl_change_reason_code
                       ,s.selection_transaction_id  enrl_enrollment_id
                      -- ,CASE WHEN date_of_validity_end = to_date('12/31/2050','mm/dd/yyyy') THEN s.enrollment_id ELSE NULL END enrl_enrollment_id
                       ,s.record_name enrl_record_name
                       ,s.selection_source_code enrl_selection_source_code
                       ,ROW_NUMBER() OVER (PARTITION BY d.dp_form_id ORDER BY DECODE(disregard_trans_ind,'N',1,2),s.selection_transaction_id) rn
                FROM hco_d_form d
                  JOIN emrs_d_selection_trans s on d.dcn = s.dcn
                  JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'
                WHERE 1=1
                --AND d.enrollment_id is null
               -- AND d.form_incomplete = 'N'
                --AND s.date_of_validity_end = to_date('12/31/2050','mm/dd/yyyy')                
                AND NOT EXISTS(SELECT 1 FROM hco_d_form e WHERE d.dcn = e.dcn AND d.dp_form_id != e.dp_form_id AND d.reference_type != e.reference_type)                
              ) t
          WHERE rn = 1
          AND (COALESCE(t.esr_id,'*') != COALESCE(t.enrl_esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(t.enrl_verifier_id,'*')   
            OR COALESCE(t.county_code,'*') != COALESCE(t.enrl_county_code,'*')            
            OR COALESCE(t.plan_originated_flag,'*') != COALESCE(t.enrl_plan_originated_flag,'*')
            OR COALESCE(t.created_by_agent_flag,'*') != COALESCE(t.enrl_created_by_agent_flag,'*')
            OR COALESCE(t.change_reason_code,'*') != COALESCE(t.enrl_change_reason_code,'*')
            OR COALESCE(t.modified_name,'*') != COALESCE(t.enrl_modified_name,'*')     
            OR COALESCE(t.record_name,'*') != COALESCE(t.enrl_record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.enrl_modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(t.enrl_processed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))        
            OR COALESCE(t.enrollment_id,0) != COALESCE(t.enrl_enrollment_id, 0)
             OR COALESCE(t.selection_source_code,'*') != COALESCE(t.enrl_selection_source_code,'*')
            --OR COALESCE(t.client_number,0) != COALESCE(t.enrl_client_number, 0)  
            )          
          ) st ON (s.dp_form_id = st.dp_form_id)
    WHEN MATCHED THEN UPDATE
     SET s.esr_id = st.enrl_esr_id
        ,s.verifier_id = st.enrl_verifier_id
        ,s.county_code = st.enrl_county_code
        ,s.plan_originated_flag = st.enrl_plan_originated_flag
        ,s.created_by_agent_flag = st.enrl_created_by_agent_flag
        ,s.change_reason_code = st.enrl_change_reason_code
        ,s.modified_name = st.enrl_modified_name
        ,s.modified_date = st.enrl_modified_date
        ,s.processed_date = st.enrl_processed_date
        ,s.enrollment_id = st.enrl_enrollment_id
        ,s.record_name = st.enrl_record_name
        ,s.selection_source_code = st.enrl_selection_source_code
     --   ,s.client_number = st.enrl_client_number
     Log Errors INTO Errlog_Form ('FORM_UPD_FROM_ENRLHIST') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_UPD_FROM_ENRLHIST', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_UPD_FROM_ENRLHIST';

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
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_UPD_FROM_ENRLHIST', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_UPD_FROM_ENRLHIST;


PROCEDURE FORM_ENROLL_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Form WHERE ora_err_tag$ = 'FORM_ENROLL_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'FORM_ENROLL_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  HCO_D_FORM s
   USING (SELECT tmp.*
                 ,t.dp_form_id
                 ,CASE WHEN t.processed_date IS NULL THEN GREATEST(COALESCE(TransDate,tmp.modified_date),tmp.modified_date) ELSE t.processed_date END processed_date                 
          FROM(SELECT                       
            EsrID esr_id
            ,VerifierID verifier_id
            ,County county_code            
            ,CASE WHEN INSTR(ll.out_var,RecordCreateName) = 0 THEN 'Y' ELSE 'N' END created_by_agent_flag
            ,CASE WHEN SUBSTR(EsrID,1,3) = 'PLN' THEN 'Y' ELSE 'N' END plan_originated_flag
            ,NameLastModified modified_name
            ,DateLastModified modified_date            
            ,BeneficiaryID
            ,DocumentBatchNum            
            ,CASE WHEN TransDate IS NULL THEN DateLastModified ELSE TransDate END TransDate
            ,DisEnrlReasonCode change_reason_code
            ,EnrollmentID enrollment_id
            ,RecordCreateName record_name
            ,ChannelName selection_source_code
          FROM(SELECT m.* ,ROW_NUMBER() OVER (PARTITION BY DocumentBatchNum ORDER BY DECODE(disregardtrans,'N',1,2),EnrollmentID) rn
                  FROM emrs_s_enrollment_stg m) m
             JOIN corp_etl_list_lkup ll ON name = 'FORM_CREATEDBY_SCRIPT'                   
           WHERE rn = 1 ) tmp
          JOIN hco_d_form t ON tmp.DocumentBatchNum = t.dcn
          WHERE  COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')   
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')            
            OR COALESCE(t.plan_originated_flag,'*') != COALESCE(tmp.plan_originated_flag,'*')
            OR COALESCE(t.created_by_agent_flag,'*') != COALESCE(tmp.created_by_agent_flag,'*')
            OR COALESCE(t.change_reason_code,'*') != COALESCE(tmp.change_reason_code,'*')
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')     
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.processed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(GREATEST(TransDate,tmp.modified_date), TO_DATE('07/07/7777','mm/dd/yyyy'))        
            OR COALESCE(t.enrollment_id,0) != COALESCE(tmp.enrollment_id, 0)
            OR COALESCE(t.client_number,0) != COALESCE(tmp.BeneficiaryID, 0)
            OR COALESCE(t.selection_source_code,'*') != COALESCE(tmp.selection_source_code,'*')
          ) st ON (s.dp_form_id = st.dp_form_id)
    WHEN MATCHED THEN UPDATE
     SET s.esr_id = st.esr_id
        ,s.verifier_id = st.verifier_id
        ,s.county_code = st.county_code
        ,s.plan_originated_flag = st.plan_originated_flag
        ,s.created_by_agent_flag = st.created_by_agent_flag
        ,s.change_reason_code = st.change_reason_code
        ,s.modified_name = st.modified_name
        ,s.modified_date = st.modified_date
        ,s.processed_date = st.processed_date
        ,s.enrollment_id = st.enrollment_id
        ,s.record_name = st.record_name
        ,s.client_number = st.BeneficiaryID
        ,s.selection_source_code = st.selection_source_code
     Log Errors INTO Errlog_Form ('FORM_ENROLL_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_ENROLL_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'HCO_D_FORM', DCN
      FROM Errlog_Form
     WHERE Ora_Err_Tag$ = 'FORM_MANUAL_ENROLL_UPD';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;
     
    COMMIT;

   -- FORM_REMOVE_DUPLICATE_ENROLL;  
   -- FORM_UPD_FROM_ENRLHIST;
    
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'CAHCO_FORM_ETL_PKG.FORM_ENROLL_UPD', 1, v_desc, v_code, 'HCO_D_FORM');

      COMMIT;
END FORM_ENROLL_UPD;


END;
/


grant execute on CAHCO_FORM_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;