alter session set plsql_code_type = native;

create or replace package CAHCO_ENROLL_ETL_PKG as


  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  con_pkg    CONSTANT  VARCHAR2(30) := $$PLSQL_UNIT;
  c_abort    CONSTANT  corp_etl_error_log.err_level%TYPE := 'ABORT';
  c_critical CONSTANT  corp_etl_error_log.err_level%TYPE := 'CRITICAL';
  c_log      CONSTANT  corp_etl_error_log.err_level%TYPE := 'LOG';

  PROCEDURE SELTRANS_INS;
  PROCEDURE SELTRANS_UPD;
  
  PROCEDURE SELTRANS_HIST_INS;
  PROCEDURE SELTRANS_HIST_UPD;  
  
  PROCEDURE ENROLLMENT_INS;
  PROCEDURE ENROLLMENT_UPD;
    
end;
/


CREATE OR REPLACE PACKAGE BODY CAHCO_ENROLL_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE SELTRANS_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_SelTrans WHERE ora_err_tag$ = 'SELTRANS_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'SELTRANS_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_SELECTION_TRANS (selection_transaction_id
        ,program_code
        ,transaction_type_cd
        ,selection_source_code
        ,plan_type
        ,plan_id
        ,plan_id_ext
        ,start_date
        ,selection_reason_code
        ,change_reason_code
        ,selection_segment_id
        ,client_number
        ,status_date
        ,aid_category_code
        ,county_code
        ,client_residence_address_id
        ,zip_code
        ,selection_status_code       
        ,newborn_flag
        ,subprogram_code
        ,prior_plan_id
        ,prior_plan_id_ext
        ,prior_selection_end_date
        ,prior_disenroll_reason_cd_1
        ,prior_selection_segment_id
        ,prior_selection_start_date
        ,csda_code
        ,record_date
        ,record_name
        ,start_nd
        ,end_nd
        ,non_meds_ind
        ,switch_to_meds_ind
        ,transaction_date
        ,disregard_trans_ind
        ,meds_accept_trans_ind
        ,accept_ind
        ,transaction_export_date
        ,cldl_sent_date
        ,modified_status
        ,dcn
        ,received_medical_start_date
        ,cldl_needs_sending_flag
        ,pcp_sent
        ,pcp_date
        ,expiry_date
        ,meds_plan_id
        ,gmc_dental_choice
        ,gmc_combined_choice
        ,switch_to_meds_date
        ,transaction_disposition
        ,date_timed_out
        ,modified_date
        ,modified_name
        ,transfer_flag
        ,esr_id
        ,verifier_id)
    SELECT
        e.EnrollmentID selection_transaction_id
        ,'HCO' program_code
        ,e.TypeTransaction transaction_type_cd
        ,e.ChannelName selection_source_code
        ,e.PlanType plan_type
        ,e.EnrlPlanID plan_id
        ,e.EnrlPlanID plan_id_ext
        ,e.TransEffectiveDate start_date
        ,e.TransactionType selection_reason_code
        ,e.DisEnrlReasonCode change_reason_code
        ,e.EnrollmentID selection_segment_id
        ,e.BeneficiaryID client_number
        ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
          ELSE e.DateLastModified END  status_date
        ,e.AidCode aid_category_code
        ,e.County county_code
        ,e.DemographyId client_residence_address_id
        ,e.ZipCode zip_code
        ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
              WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
              WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
              WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
          ELSE 'readyToUpload' END selection_status_code       
        ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
        ,SubProgram subprogram_code
        ,PriorPlanId prior_plan_id
        ,PriorPlanId prior_plan_id_ext
        ,PriorEnrlEndDate prior_selection_end_date
        ,PriorDisenrlReason prior_disenroll_reason_cd_1
        ,PriorEnrollmentId prior_selection_segment_id
        ,PriorEnrlStartDate prior_selection_start_date
        ,'U' csda_code
        ,e.RecordCreateDate record_date
        ,e.RecordCreateName record_name
        ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
        ,20501231 end_nd
        ,e.IsNonMEDS non_meds_ind
        ,e.SwitchToMEDS switch_to_meds_ind
        ,e.TransDate transaction_date
        ,e.DisregardTrans disregard_trans_ind
        ,e.MEDSAccptTrans meds_accept_trans_ind
        ,e.Accept accept_ind
        ,e.TransExportDate transaction_export_date
        ,e.CLDLSentDate cldl_sent_date
        ,e.ModifiedStatus modified_status
        ,e.DocumentBatchNum dcn
        ,e.RcvdMCalStartDate received_medical_start_date
        ,e.CLDLNeedToBeSent cldl_needs_sending_flag
        ,e.PcpSent pcp_sent
        ,e.PcpDate pcp_date
        ,e.ExpiryDate expiry_date
        ,e.MedsPlan meds_plan_id
        ,e.GMCDentalChoice gmc_dental_choice
        ,e.GMCCombinedChoice gmc_combined_choice
        ,e.SwitchToMEDSDate switch_to_meds_date
        ,e.TransactionDisposition transaction_disposition
        ,e.DateTimedOut date_timed_out
        ,e.DateLastModified modified_date
        ,e.NameLastModified modified_name
        ,e.TransferFlag transfer_flag 
        ,e.esrid esr_id
        ,e.verifierid verifier_id
    FROM emrs_s_enrollment_stg e
      LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code   
    WHERE NOT EXISTS(SELECT 1 FROM emrs_d_selection_trans st WHERE e.EnrollmentId = st.selection_transaction_id)
     LOG Errors INTO Errlog_SelTrans ('SELTRANS_INS') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_SELECTION_TRANS', SELECTION_TRANSACTION_ID
      FROM Errlog_SelTrans
     WHERE Ora_Err_Tag$ = 'SELTRANS_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_INS', 1, v_desc, v_code, 'EMRS_D_SELECTION_TRANS');

      COMMIT;
END SELTRANS_INS;

PROCEDURE SELTRANS_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_SelTrans WHERE ora_err_tag$ = 'SELTRANS_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'SELTRANS_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_SELECTION_TRANS s
   USING (SELECT tmp.*
          FROM (SELECT
                  e.EnrollmentID selection_transaction_id
                  ,'HCO' program_code
                  ,e.TypeTransaction transaction_type_cd
                  ,e.ChannelName selection_source_code
                  ,e.PlanType plan_type
                  ,e.EnrlPlanID plan_id
                  ,e.EnrlPlanID plan_id_ext
                  ,e.TransEffectiveDate start_date
                  ,e.TransactionType selection_reason_code
                  ,e.DisEnrlReasonCode change_reason_code
                  ,e.EnrollmentID selection_segment_id
                  ,e.BeneficiaryID client_number
                  ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
                    ELSE e.DateLastModified END  status_date
                  ,e.AidCode aid_category_code
                  ,e.County county_code
                  ,e.DemographyId client_residence_address_id
                  ,e.ZipCode zip_code
                  ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
                        WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
                        WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
                        WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
                    ELSE 'readyToUpload' END selection_status_code       
                  ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
                  ,SubProgram subprogram_code
                  ,PriorPlanId prior_plan_id
                  ,PriorPlanId prior_plan_id_ext
                  ,PriorEnrlEndDate prior_selection_end_date
                  ,PriorDisenrlReason prior_disenroll_reason_cd_1
                  ,PriorEnrollmentId prior_selection_segment_id
                  ,PriorEnrlStartDate prior_selection_start_date
                  ,'U' csda_code
                  ,e.RecordCreateDate record_date
                  ,e.RecordCreateName record_name
                  ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
                  ,20501231 end_nd
                  ,e.IsNonMEDS non_meds_ind
                  ,e.SwitchToMEDS switch_to_meds_ind
                  ,e.TransDate transaction_date
                  ,e.DisregardTrans disregard_trans_ind
                  ,e.MEDSAccptTrans meds_accept_trans_ind
                  ,e.Accept accept_ind
                  ,e.TransExportDate transaction_export_date
                  ,e.CLDLSentDate cldl_sent_date
                  ,e.ModifiedStatus modified_status
                  ,e.DocumentBatchNum dcn
                  ,e.RcvdMCalStartDate received_medical_start_date
                  ,e.CLDLNeedToBeSent cldl_needs_sending_flag
                  ,e.PcpSent pcp_sent
                  ,e.PcpDate pcp_date
                  ,e.ExpiryDate expiry_date
                  ,e.MedsPlan meds_plan_id
                  ,e.GMCDentalChoice gmc_dental_choice
                  ,e.GMCCombinedChoice gmc_combined_choice
                  ,e.SwitchToMEDSDate switch_to_meds_date
                  ,e.TransactionDisposition transaction_disposition
                  ,e.DateTimedOut date_timed_out
                  ,e.DateLastModified modified_date
                  ,e.NameLastModified modified_name
                  ,e.TransferFlag transfer_flag      
                  ,e.esrid esr_id
                  ,e.verifierid verifier_id
                FROM emrs_s_enrollment_stg e
                  LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code
              ) tmp
          JOIN emrs_d_selection_trans t ON tmp.selection_transaction_id = t.selection_transaction_id
          WHERE COALESCE(t.program_code,'*') != COALESCE(tmp.program_code,'*') 
            OR COALESCE(t.transaction_type_cd,'*') != COALESCE(tmp.transaction_type_cd,'*')
            OR COALESCE(t.selection_source_code,'*') != COALESCE(tmp.selection_source_code,'*')
            OR COALESCE(t.plan_type,'*') != COALESCE(tmp.plan_type,'*')
            OR COALESCE(t.plan_id,'*') != COALESCE(tmp.plan_id,'*')
            OR COALESCE(t.plan_id_ext,'*') != COALESCE(tmp.plan_id_ext,'*')
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.selection_reason_code,'*') != COALESCE(tmp.selection_reason_code,'*')
            OR COALESCE(t.change_reason_code,'*') != COALESCE(tmp.change_reason_code,'*')
            OR COALESCE(t.selection_segment_id,0) != COALESCE(tmp.selection_segment_id,0)
            OR COALESCE(t.client_number,0) != COALESCE(tmp.client_number,0)
            OR COALESCE(t.status_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.status_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.aid_category_code,'*') != COALESCE(tmp.aid_category_code,'*')
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')
            OR COALESCE(t.client_residence_address_id,0) != COALESCE(tmp.client_residence_address_id,0)
            OR COALESCE(t.zip_code,'*') != COALESCE(tmp.zip_code,'*')
            OR COALESCE(t.selection_status_code,'*') != COALESCE(tmp.selection_status_code,'*')
            OR COALESCE(t.newborn_flag,'*') != COALESCE(tmp.newborn_flag,'*')
            OR COALESCE(t.subprogram_code,'*') != COALESCE(tmp.subprogram_code,'*')
            OR COALESCE(t.prior_plan_id,'*') != COALESCE(tmp.prior_plan_id,'*')
            OR COALESCE(t.prior_plan_id_ext,'*') != COALESCE(tmp.prior_plan_id_ext,'*')
            OR COALESCE(t.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.prior_disenroll_reason_cd_1,'*') != COALESCE(tmp.prior_disenroll_reason_cd_1,'*')
            OR COALESCE(t.prior_selection_segment_id,0) != COALESCE(tmp.prior_selection_segment_id,0)
            OR COALESCE(t.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.csda_code,'*') != COALESCE(tmp.csda_code,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.non_meds_ind,'*') != COALESCE(tmp.non_meds_ind,'*')
            OR COALESCE(t.switch_to_meds_ind,'*') != COALESCE(tmp.switch_to_meds_ind,'*')
            OR COALESCE(t.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.disregard_trans_ind,'*') != COALESCE(tmp.disregard_trans_ind,'*')
            OR COALESCE(t.meds_accept_trans_ind,'*') != COALESCE(tmp.meds_accept_trans_ind,'*')
            OR COALESCE(t.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_status,'*') != COALESCE(tmp.modified_status,'*')
            OR COALESCE(t.dcn,'*') != COALESCE(tmp.dcn,'*')
            OR COALESCE(t.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_needs_sending_flag,'*') != COALESCE(tmp.cldl_needs_sending_flag,'*')
            OR COALESCE(t.pcp_sent,'*') != COALESCE(tmp.pcp_sent,'*')
            OR COALESCE(t.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_plan_id,'*') != COALESCE(tmp.meds_plan_id,'*')
            OR COALESCE(t.gmc_dental_choice,'*') != COALESCE(tmp.gmc_dental_choice,'*')
            OR COALESCE(t.gmc_combined_choice,'*') != COALESCE(tmp.gmc_combined_choice,'*')
            OR COALESCE(t.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_disposition,'*') != COALESCE(tmp.transaction_disposition,'*')
            OR COALESCE(t.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.transfer_flag,'*') != COALESCE(tmp.transfer_flag,'*')
            OR COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')
          ) st ON (s.selection_transaction_id = st.selection_transaction_id)
    WHEN MATCHED THEN UPDATE
     SET s.program_code = st.program_code
        ,s.transaction_type_cd = st.transaction_type_cd
        ,s.selection_source_code = st.selection_source_code
        ,s.plan_type = st.plan_type
        ,s.plan_id = st.plan_id
        ,s.plan_id_ext = st.plan_id_ext
        ,s.start_date = st.start_date
        ,s.selection_reason_code = st.selection_reason_code
        ,s.change_reason_code = st.change_reason_code
        ,s.selection_segment_id = st.selection_segment_id
        ,s.client_number = st.client_number
        ,s.status_date = st.status_date
        ,s.aid_category_code = st.aid_category_code
        ,s.county_code = st.county_code
        ,s.client_residence_address_id = st.client_residence_address_id
        ,s.zip_code = st.zip_code
        ,s.selection_status_code = st.selection_status_code
        ,s.newborn_flag = st.newborn_flag
        ,s.subprogram_code = st.subprogram_code
        ,s.prior_plan_id = st.prior_plan_id
        ,s.prior_plan_id_ext = st.prior_plan_id_ext
        ,s.prior_selection_end_date = st.prior_selection_end_date
        ,s.prior_disenroll_reason_cd_1 = st.prior_disenroll_reason_cd_1
        ,s.prior_selection_segment_id = st.prior_selection_segment_id
        ,s.prior_selection_start_date = st.prior_selection_start_date
        ,s.csda_code = st.csda_code
        ,s.record_date = st.record_date
        ,s.record_name = st.record_name
        ,s.start_nd = st.start_nd
        ,s.end_nd = st.end_nd
        ,s.non_meds_ind = st.non_meds_ind
        ,s.switch_to_meds_ind = st.switch_to_meds_ind
        ,s.transaction_date = st.transaction_date
        ,s.disregard_trans_ind = st.disregard_trans_ind
        ,s.meds_accept_trans_ind = st.meds_accept_trans_ind
        ,s.accept_ind = st.accept_ind
        ,s.transaction_export_date = st.transaction_export_date
        ,s.cldl_sent_date = st.cldl_sent_date
        ,s.modified_status = st.modified_status
        ,s.dcn = st.dcn
        ,s.received_medical_start_date =  st.received_medical_start_date 
        ,s.cldl_needs_sending_flag = st.cldl_needs_sending_flag
        ,s.pcp_sent = st.pcp_sent
        ,s.pcp_date = st.pcp_date
        ,s.expiry_date = st.expiry_date
        ,s.meds_plan_id = st.meds_plan_id
        ,s.gmc_dental_choice = st.gmc_dental_choice
        ,s.gmc_combined_choice = st.gmc_combined_choice
        ,s.switch_to_meds_date = st.switch_to_meds_date
        ,s.transaction_disposition = st.transaction_disposition
        ,s.date_timed_out = st.date_timed_out
        ,s.modified_date = st.modified_date
        ,s.modified_name = st.modified_name
        ,s.transfer_flag = st.transfer_flag
        ,s.esr_id = st.esr_id
        ,s.verifier_id = st.verifier_id
     Log Errors INTO Errlog_SelTrans ('SELTRANS_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_SELECTION_TRANS', SELECTION_TRANSACTION_ID
      FROM Errlog_SelTrans
     WHERE Ora_Err_Tag$ = 'SELTRANS_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_UPD', 1, v_desc, v_code, 'EMRS_D_SELECTION_TRANS');

      COMMIT;
END SELTRANS_UPD;


PROCEDURE SELTRANS_HIST_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_SelTrans_Hist WHERE ora_err_tag$ = 'SELTRANS_HIST_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'SELTRANS_HIST_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_D_SELECTION_TRANS_HISTORY (selection_transaction_id
        ,program_code
        ,transaction_type_cd
        ,selection_source_code
        ,plan_type
        ,plan_id
        ,plan_id_ext
        ,start_date
        ,selection_reason_code
        ,change_reason_code
        ,selection_segment_id
        ,client_number
        ,status_date
        ,aid_category_code
        ,county_code
        ,client_residence_address_id
        ,zip_code
        ,selection_status_code       
        ,newborn_flag
        ,subprogram_code
        ,prior_plan_id
        ,prior_plan_id_ext
        ,prior_selection_end_date
        ,prior_disenroll_reason_cd_1
        ,prior_selection_segment_id
        ,prior_selection_start_date
        ,csda_code
        ,record_date
        ,record_name
        ,start_nd
        ,end_nd
        ,non_meds_ind
        ,switch_to_meds_ind
        ,transaction_date
        ,disregard_trans_ind
        ,meds_accept_trans_ind
        ,accept_ind
        ,transaction_export_date
        ,cldl_sent_date
        ,modified_status
        ,dcn
        ,received_medical_start_date
        ,cldl_needs_sending_flag
        ,pcp_sent
        ,pcp_date
        ,expiry_date
        ,meds_plan_id
        ,gmc_dental_choice
        ,gmc_combined_choice
        ,switch_to_meds_date
        ,transaction_disposition
        ,date_timed_out
        ,modified_date
        ,modified_name
        ,transfer_flag
        ,esr_id
        ,verifier_id
        ,date_of_validity_start
        ,date_of_validity_end)
    SELECT
        e.EnrollmentID selection_transaction_id
        ,'HCO' program_code
        ,e.TypeTransaction transaction_type_cd
        ,e.ChannelName selection_source_code
        ,e.PlanType plan_type
        ,e.EnrlPlanID plan_id
        ,e.EnrlPlanID plan_id_ext
        ,e.TransEffectiveDate start_date
        ,e.TransactionType selection_reason_code
        ,e.DisEnrlReasonCode change_reason_code
        ,e.EnrollmentID selection_segment_id
        ,e.BeneficiaryID client_number
        ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
          ELSE e.DateLastModified END  status_date
        ,e.AidCode aid_category_code
        ,e.County county_code
        ,e.DemographyId client_residence_address_id
        ,e.ZipCode zip_code
        ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
              WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
              WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
              WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
          ELSE 'readyToUpload' END selection_status_code       
        ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
        ,SubProgram subprogram_code
        ,PriorPlanId prior_plan_id
        ,PriorPlanId prior_plan_id_ext
        ,PriorEnrlEndDate prior_selection_end_date
        ,PriorDisenrlReason prior_disenroll_reason_cd_1
        ,PriorEnrollmentId prior_selection_segment_id
        ,PriorEnrlStartDate prior_selection_start_date
        ,'U' csda_code
        ,e.RecordCreateDate record_date
        ,e.RecordCreateName record_name
        ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
        ,20501231 end_nd
        ,e.IsNonMEDS non_meds_ind
        ,e.SwitchToMEDS switch_to_meds_ind
        ,e.TransDate transaction_date
        ,e.DisregardTrans disregard_trans_ind
        ,e.MEDSAccptTrans meds_accept_trans_ind
        ,e.Accept accept_ind
        ,e.TransExportDate transaction_export_date
        ,e.CLDLSentDate cldl_sent_date
        ,e.ModifiedStatus modified_status
        ,e.DocumentBatchNum dcn
        ,e.RcvdMCalStartDate received_medical_start_date
        ,e.CLDLNeedToBeSent cldl_needs_sending_flag
        ,e.PcpSent pcp_sent
        ,e.PcpDate pcp_date
        ,e.ExpiryDate expiry_date
        ,e.MedsPlan meds_plan_id
        ,e.GMCDentalChoice gmc_dental_choice
        ,e.GMCCombinedChoice gmc_combined_choice
        ,e.SwitchToMEDSDate switch_to_meds_date
        ,e.TransactionDisposition transaction_disposition
        ,e.DateTimedOut date_timed_out
        ,e.DateLastModified modified_date
        ,e.NameLastModified modified_name
        ,e.TransferFlag transfer_flag 
        ,e.esrid esr_id
        ,e.verifierid verifier_id
        ,CASE WHEN e.existing_rec_dp_seltrans_id IS NULL THEN TRUNC(e.RecordCreateDate) ELSE TRUNC(e.DateLastModified) END date_of_validity_start
        ,TO_DATE('12/31/2050','mm/dd/yyyy') date_of_validity_end
    FROM emrs_s_enrollment_stg e
      LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code   
    WHERE e.existing_rec_dp_seltrans_id IS NULL
      OR EXISTS(SELECT 1 FROM emrs_d_selection_trans_history h WHERE e.existing_rec_dp_seltrans_id = h.dp_seltrans_hist_id AND TRUNC(e.DateLastModified) != h.date_of_validity_start)
     LOG Errors INTO Errlog_SelTrans_Hist ('SELTRANS_HIST_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_SELECTION_TRANS_HISTORY h
     USING (SELECT existing_rec_dp_seltrans_id
                    ,TRUNC(s.DateLastModified) date_of_validity_start
                    ,CASE WHEN TRUNC(s.DateLastModified-1) < h.date_of_validity_start THEN h.date_of_validity_start ELSE TRUNC(s.DateLastModified-1) END nw_date_of_validity_end
            FROM emrs_s_enrollment_stg s
              JOIN emrs_d_selection_trans_history h ON s.existing_rec_dp_seltrans_id = h.dp_seltrans_hist_id
            WHERE  TRUNC(s.DateLastModified) != h.date_of_validity_start
            AND h.date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy') ) ht ON (ht.existing_rec_dp_seltrans_id = h.dp_seltrans_hist_id)
    WHEN MATCHED THEN UPDATE
     SET h.date_of_validity_end = ht.nw_date_of_validity_end      
     Log Errors INTO Errlog_SelTrans_Hist ('SELTRANS_HIST_INS') Reject Limit Unlimited;
          

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_HIST_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_SELECTION_TRANS_HISTORY', SELECTION_TRANSACTION_ID
      FROM Errlog_SelTrans_Hist
     WHERE Ora_Err_Tag$ = 'SELTRANS_HIST_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_HIST_INS', 1, v_desc, v_code, 'EMRS_D_SELECTION_TRANS_HISTORY');

      COMMIT;
END SELTRANS_HIST_INS;

PROCEDURE SELTRANS_HIST_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_SelTrans_Hist WHERE ora_err_tag$ = 'SELTRANS_HIST_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'SELTRANS_HIST_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_D_SELECTION_TRANS_HISTORY s
   USING (SELECT tmp.*
          FROM (SELECT
                  e.EnrollmentID selection_transaction_id
                  ,'HCO' program_code
                  ,e.TypeTransaction transaction_type_cd
                  ,e.ChannelName selection_source_code
                  ,e.PlanType plan_type
                  ,e.EnrlPlanID plan_id
                  ,e.EnrlPlanID plan_id_ext
                  ,e.TransEffectiveDate start_date
                  ,e.TransactionType selection_reason_code
                  ,e.DisEnrlReasonCode change_reason_code
                  ,e.EnrollmentID selection_segment_id
                  ,e.BeneficiaryID client_number
                  ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
                    ELSE e.DateLastModified END  status_date
                  ,e.AidCode aid_category_code
                  ,e.County county_code
                  ,e.DemographyId client_residence_address_id
                  ,e.ZipCode zip_code
                  ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
                        WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
                        WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
                        WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
                    ELSE 'readyToUpload' END selection_status_code       
                  ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
                  ,SubProgram subprogram_code
                  ,PriorPlanId prior_plan_id
                  ,PriorPlanId prior_plan_id_ext
                  ,PriorEnrlEndDate prior_selection_end_date
                  ,PriorDisenrlReason prior_disenroll_reason_cd_1
                  ,PriorEnrollmentId prior_selection_segment_id
                  ,PriorEnrlStartDate prior_selection_start_date
                  ,'U' csda_code
                  ,e.RecordCreateDate record_date
                  ,e.RecordCreateName record_name
                  ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
                  ,20501231 end_nd
                  ,e.IsNonMEDS non_meds_ind
                  ,e.SwitchToMEDS switch_to_meds_ind
                  ,e.TransDate transaction_date
                  ,e.DisregardTrans disregard_trans_ind
                  ,e.MEDSAccptTrans meds_accept_trans_ind
                  ,e.Accept accept_ind
                  ,e.TransExportDate transaction_export_date
                  ,e.CLDLSentDate cldl_sent_date
                  ,e.ModifiedStatus modified_status
                  ,e.DocumentBatchNum dcn
                  ,e.RcvdMCalStartDate received_medical_start_date
                  ,e.CLDLNeedToBeSent cldl_needs_sending_flag
                  ,e.PcpSent pcp_sent
                  ,e.PcpDate pcp_date
                  ,e.ExpiryDate expiry_date
                  ,e.MedsPlan meds_plan_id
                  ,e.GMCDentalChoice gmc_dental_choice
                  ,e.GMCCombinedChoice gmc_combined_choice
                  ,e.SwitchToMEDSDate switch_to_meds_date
                  ,e.TransactionDisposition transaction_disposition
                  ,e.DateTimedOut date_timed_out
                  ,e.DateLastModified modified_date
                  ,e.NameLastModified modified_name
                  ,e.TransferFlag transfer_flag     
                  ,e.existing_rec_dp_seltrans_id
                  ,TRUNC(e.DateLastModified) nw_date_of_validity_start
                  ,e.esrid esr_id
                  ,e.verifierid verifier_id
                FROM emrs_s_enrollment_stg e
                  LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code
              ) tmp
          JOIN emrs_d_selection_trans_history t ON tmp.existing_rec_dp_seltrans_id = t.dp_seltrans_hist_id AND tmp.nw_date_of_validity_start = t.date_of_validity_start
          WHERE COALESCE(t.program_code,'*') != COALESCE(tmp.program_code,'*') 
            OR COALESCE(t.transaction_type_cd,'*') != COALESCE(tmp.transaction_type_cd,'*')
            OR COALESCE(t.selection_source_code,'*') != COALESCE(tmp.selection_source_code,'*')
            OR COALESCE(t.plan_type,'*') != COALESCE(tmp.plan_type,'*')
            OR COALESCE(t.plan_id,'*') != COALESCE(tmp.plan_id,'*')
            OR COALESCE(t.plan_id_ext,'*') != COALESCE(tmp.plan_id_ext,'*')
            OR COALESCE(t.start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.selection_reason_code,'*') != COALESCE(tmp.selection_reason_code,'*')
            OR COALESCE(t.change_reason_code,'*') != COALESCE(tmp.change_reason_code,'*')
            OR COALESCE(t.selection_segment_id,0) != COALESCE(tmp.selection_segment_id,0)
            OR COALESCE(t.client_number,0) != COALESCE(tmp.client_number,0)
            OR COALESCE(t.status_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.status_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.aid_category_code,'*') != COALESCE(tmp.aid_category_code,'*')
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')
            OR COALESCE(t.client_residence_address_id,0) != COALESCE(tmp.client_residence_address_id,0)
            OR COALESCE(t.zip_code,'*') != COALESCE(tmp.zip_code,'*')
            OR COALESCE(t.selection_status_code,'*') != COALESCE(tmp.selection_status_code,'*')
            OR COALESCE(t.newborn_flag,'*') != COALESCE(tmp.newborn_flag,'*')
            OR COALESCE(t.subprogram_code,'*') != COALESCE(tmp.subprogram_code,'*')
            OR COALESCE(t.prior_plan_id,'*') != COALESCE(tmp.prior_plan_id,'*')
            OR COALESCE(t.prior_plan_id_ext,'*') != COALESCE(tmp.prior_plan_id_ext,'*')
            OR COALESCE(t.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.prior_disenroll_reason_cd_1,'*') != COALESCE(tmp.prior_disenroll_reason_cd_1,'*')
            OR COALESCE(t.prior_selection_segment_id,0) != COALESCE(tmp.prior_selection_segment_id,0)
            OR COALESCE(t.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.csda_code,'*') != COALESCE(tmp.csda_code,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.non_meds_ind,'*') != COALESCE(tmp.non_meds_ind,'*')
            OR COALESCE(t.switch_to_meds_ind,'*') != COALESCE(tmp.switch_to_meds_ind,'*')
            OR COALESCE(t.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.disregard_trans_ind,'*') != COALESCE(tmp.disregard_trans_ind,'*')
            OR COALESCE(t.meds_accept_trans_ind,'*') != COALESCE(tmp.meds_accept_trans_ind,'*')
            OR COALESCE(t.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_status,'*') != COALESCE(tmp.modified_status,'*')
            OR COALESCE(t.dcn,'*') != COALESCE(tmp.dcn,'*')
            OR COALESCE(t.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_needs_sending_flag,'*') != COALESCE(tmp.cldl_needs_sending_flag,'*')
            OR COALESCE(t.pcp_sent,'*') != COALESCE(tmp.pcp_sent,'*')
            OR COALESCE(t.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_plan_id,'*') != COALESCE(tmp.meds_plan_id,'*')
            OR COALESCE(t.gmc_dental_choice,'*') != COALESCE(tmp.gmc_dental_choice,'*')
            OR COALESCE(t.gmc_combined_choice,'*') != COALESCE(tmp.gmc_combined_choice,'*')
            OR COALESCE(t.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_disposition,'*') != COALESCE(tmp.transaction_disposition,'*')
            OR COALESCE(t.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.transfer_flag,'*') != COALESCE(tmp.transfer_flag,'*')
            OR COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')
          ) st ON (s.dp_seltrans_hist_id = st.existing_rec_dp_seltrans_id)
    WHEN MATCHED THEN UPDATE
     SET s.program_code = st.program_code
        ,s.transaction_type_cd = st.transaction_type_cd
        ,s.selection_source_code = st.selection_source_code
        ,s.plan_type = st.plan_type
        ,s.plan_id = st.plan_id
        ,s.plan_id_ext = st.plan_id_ext
        ,s.start_date = st.start_date
        ,s.selection_reason_code = st.selection_reason_code
        ,s.change_reason_code = st.change_reason_code
        ,s.selection_segment_id = st.selection_segment_id
        ,s.client_number = st.client_number
        ,s.status_date = st.status_date
        ,s.aid_category_code = st.aid_category_code
        ,s.county_code = st.county_code
        ,s.client_residence_address_id = st.client_residence_address_id
        ,s.zip_code = st.zip_code
        ,s.selection_status_code = st.selection_status_code
        ,s.newborn_flag = st.newborn_flag
        ,s.subprogram_code = st.subprogram_code
        ,s.prior_plan_id = st.prior_plan_id
        ,s.prior_plan_id_ext = st.prior_plan_id_ext
        ,s.prior_selection_end_date = st.prior_selection_end_date
        ,s.prior_disenroll_reason_cd_1 = st.prior_disenroll_reason_cd_1
        ,s.prior_selection_segment_id = st.prior_selection_segment_id
        ,s.prior_selection_start_date = st.prior_selection_start_date
        ,s.csda_code = st.csda_code
        ,s.record_date = st.record_date
        ,s.record_name = st.record_name
        ,s.start_nd = st.start_nd
        ,s.end_nd = st.end_nd
        ,s.non_meds_ind = st.non_meds_ind
        ,s.switch_to_meds_ind = st.switch_to_meds_ind
        ,s.transaction_date = st.transaction_date
        ,s.disregard_trans_ind = st.disregard_trans_ind
        ,s.meds_accept_trans_ind = st.meds_accept_trans_ind
        ,s.accept_ind = st.accept_ind
        ,s.transaction_export_date = st.transaction_export_date
        ,s.cldl_sent_date = st.cldl_sent_date
        ,s.modified_status = st.modified_status
        ,s.dcn = st.dcn
        ,s.received_medical_start_date =  st.received_medical_start_date 
        ,s.cldl_needs_sending_flag = st.cldl_needs_sending_flag
        ,s.pcp_sent = st.pcp_sent
        ,s.pcp_date = st.pcp_date
        ,s.expiry_date = st.expiry_date
        ,s.meds_plan_id = st.meds_plan_id
        ,s.gmc_dental_choice = st.gmc_dental_choice
        ,s.gmc_combined_choice = st.gmc_combined_choice
        ,s.switch_to_meds_date = st.switch_to_meds_date
        ,s.transaction_disposition = st.transaction_disposition
        ,s.date_timed_out = st.date_timed_out
        ,s.modified_date = st.modified_date
        ,s.modified_name = st.modified_name
        ,s.transfer_flag = st.transfer_flag
        ,s.esr_id = st.esr_id
        ,s.verifier_id = st.verifier_id
     Log Errors INTO Errlog_SelTrans_Hist ('SELTRANS_HIST_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_HIST_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_D_SELECTION_TRANS_HISTORY', SELECTION_TRANSACTION_ID
      FROM Errlog_SelTrans_Hist
     WHERE Ora_Err_Tag$ = 'SELTRANS_HIST_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.SELTRANS_HIST_UPD', 1, v_desc, v_code, 'EMRS_D_SELECTION_TRANS_HISTORY');

      COMMIT;
END SELTRANS_HIST_UPD;

PROCEDURE ENROLLMENT_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Enroll WHERE ora_err_tag$ = 'ENROLLMENT_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'ENROLLMENT_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;
 
    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO EMRS_F_ENROLLMENT (enrollment_id
        ,program_code
        ,enrollment_trans_type_code
        ,selection_source_code
        ,plan_type
        ,plan_id
        ,plan_id_ext
        ,managed_care_start_date
        ,selection_reason_code
        ,change_reason_code
        ,selection_segment_id
        ,client_number
        ,status_date
        ,aid_category_code
        ,county_code
        ,zip_code
        ,selection_status_code      
        ,newborn_flag
        ,subprogram_code
        ,prior_plan_id
        ,prior_plan_id_ext
        ,prior_selection_end_date
        ,prior_disenroll_reason_cd_1
        ,prior_selection_segment_id
        ,prior_selection_start_date
        ,csda_code
        ,record_date
        ,record_name
        ,start_nd
        ,end_nd
        ,non_meds_ind
        ,switch_to_meds_ind
        ,transaction_date
        ,disregard_trans_ind
        ,meds_accept_trans_ind
        ,accept_ind
        ,transaction_export_date
        ,cldl_sent_date
        ,modified_status
        ,dcn
        ,received_medical_start_date
        ,cldl_needs_sending_flag
        ,pcp_sent
        ,pcp_date
        ,expiry_date
        ,meds_plan_id
        ,gmc_dental_choice
        ,gmc_combined_choice
        ,switch_to_meds_date
        ,transaction_disposition
        ,date_timed_out
        ,modified_date
        ,modified_name
        ,medical_start_date
        ,meds_read_trans_date
        ,meds_file_create_date
        ,errors 
        ,medical_id_number 
        ,redaction
        ,meds_import_date
        ,date_errors_fixed
        ,rteam_trans_marker 
        ,meds_terminal_id
        ,id_form_verifier
        ,months_enrl_or_disenrl
        ,dup_form_num_count
        ,enrollment_type
        ,enrl_close_date
        ,meds_trans_type
        ,disregarded_duplicate_date
        ,disregarded_duplicate
        ,esr_id
        ,verifier_id
        ,provider_number
        ,channel_id
        ,medical_affiliate
        ,selection_transaction_id
        ,eligibility_receipt_date
        ,case_number
        ,is_choice_ind
        ,term_reason_code
        ,date_of_validity_start
        ,date_of_validity_end
        ,last_meds_change_date
        ,ohc_flag
        ,meds_ccs_flag
        ,hcp_status
        ,number_count
        ,transfer_flag )
    SELECT        
        e.EnrollmentID enrollment_id
        ,'HCO' program_code
        ,e.TypeTransaction enrollment_trans_type_code
        ,e.ChannelName selection_source_code
        ,e.PlanType plan_type
        ,e.EnrlPlanID plan_id
        ,e.EnrlPlanID plan_id_ext
        ,e.TransEffectiveDate managed_care_start_date
        ,e.TransactionType selection_reason_code
        ,e.DisEnrlReasonCode change_reason_code
        ,e.EnrollmentID selection_segment_id
        ,e.BeneficiaryID client_number
        ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
              WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
            ELSE e.DateLastModified END  status_date
        ,e.AidCode aid_category_code
        ,e.County county_code
        ,e.ZipCode zip_code
        ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
              WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
              WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
              WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
            ELSE 'readyToUpload' END selection_status_code      
        ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
        ,SubProgram subprogram_code
        ,PriorPlanId prior_plan_id
        ,PriorPlanId prior_plan_id_ext
        ,PriorEnrlEndDate prior_selection_end_date
        ,PriorDisenrlReason prior_disenroll_reason_cd_1
        ,PriorEnrollmentId prior_selection_segment_id
        ,PriorEnrlStartDate prior_selection_start_date
        ,'U' csda_code
        ,e.RecordCreateDate record_date
        ,e.RecordCreateName record_name
        ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
        ,20151231 end_nd
        ,e.IsNonMEDS non_meds_ind
        ,e.SwitchToMEDS switch_to_meds_ind
        ,e.TransDate transaction_date
        ,e.DisregardTrans disregard_trans_ind
        ,e.MEDSAccptTrans meds_accept_trans_ind
        ,e.Accept accept_ind
        ,e.TransExportDate transaction_export_date
        ,e.CLDLSentDate cldl_sent_date
        ,e.ModifiedStatus modified_status
        ,e.DocumentBatchNum dcn
        ,e.RcvdMCalStartDate received_medical_start_date
        ,e.CLDLNeedToBeSent cldl_needs_sending_flag
        ,e.PcpSent pcp_sent
        ,e.PcpDate pcp_date
        ,e.ExpiryDate expiry_date
        ,e.MedsPlan meds_plan_id
        ,e.GMCDentalChoice gmc_dental_choice
        ,e.GMCCombinedChoice gmc_combined_choice
        ,e.SwitchToMEDSDate switch_to_meds_date
        ,e.TransactionDisposition transaction_disposition
        ,e.DateTimedOut date_timed_out
        ,e.DateLastModified modified_date
        ,e.NameLastModified modified_name
        ,e.MedicalStartDate medical_start_date
        ,e.MEDSReadTransDate meds_read_trans_date
        ,e.MEDSFileCreateDate meds_file_create_date
        ,e.Errors errors 
        ,e.MediCalIDNumber medical_id_number 
        ,e.Redaction redaction
        ,e.MEDSImportDate meds_import_date
        ,e.DateErrorsFixed date_errors_fixed
        ,e.RTeamTransMarker rteam_trans_marker 
        ,e.MEDSTerminalID meds_terminal_id
        ,e.IDFormVerifier id_form_verifier
        ,e.MonthsEnrlOrDisEnrl months_enrl_or_disenrl
        ,e.DupFormNumCount dup_form_num_count
        ,e.EnrollmentType enrollment_type
        ,e.EnrlCloseDate enrl_close_date
        ,e.MEDSTransType meds_trans_type
        ,e.DisregardedDuplicateDate disregarded_duplicate_date
        ,e.DisregardedDuplicate disregarded_duplicate
        ,e.EsrID esr_id
        ,e.VerifierID verifier_id
        ,e.MEDProvIDNum provider_number
        ,e.ChannelID channel_id
        ,e.MedicalAffiliate medical_affiliate
        ,e.EnrollmentID selection_transaction_id
        ,e.ImportDate eligibility_receipt_date
        ,e.CaseRowID case_number
        ,ss.is_choice_ind
        ,'U' term_reason_code
        ,CASE WHEN e.existing_rec_dp_enrollment_id IS NULL THEN TRUNC(e.RecordCreateDate) ELSE TRUNC(e.DateLastModified) END date_of_validity_start
        ,TO_DATE('2050/12/31','YYYY/MM/DD') date_of_validity_end
        ,e.ImportDate last_meds_change_date
        ,e.OthHealthCoverageCode ohc_flag
        ,e.CCSIndicator meds_ccs_flag
        ,e.McalPlnMEDSStatus hcp_status
        ,1 number_count
        ,TransferFlag transfer_flag      
         --meds_ad_flag
      FROM emrs_s_enrollment_stg e
        LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code 
        LEFT JOIN emrs_d_selection_source ss ON e.ChannelName = ss.selection_source_code  
      WHERE e.existing_rec_dp_enrollment_id IS NULL
        OR EXISTS(SELECT 1 FROM emrs_f_enrollment f WHERE e.existing_rec_dp_enrollment_id  = f.dp_enrollment_id AND TRUNC(e.DateLastModified) != f.date_of_validity_start)
     LOG Errors INTO Errlog_Enroll ('ENROLLMENT_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
    SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
    WHERE JOB_ID =  v_job_id;

    COMMIT;

    MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_F_ENROLLMENT f
     USING (SELECT existing_rec_dp_enrollment_id 
                    ,TRUNC(s.DateLastModified) date_of_validity_start
                    ,CASE WHEN TRUNC(s.DateLastModified-1) < f.date_of_validity_start THEN f.date_of_validity_start ELSE TRUNC(s.DateLastModified-1) END nw_date_of_validity_end
            FROM emrs_s_enrollment_stg s
              JOIN emrs_f_enrollment f ON s.existing_rec_dp_enrollment_id = f.dp_enrollment_id
            WHERE  TRUNC(s.DateLastModified) != f.date_of_validity_start
            AND f.date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy') ) fe ON (fe.existing_rec_dp_enrollment_id  = f.dp_enrollment_id)
    WHEN MATCHED THEN UPDATE
     SET f.date_of_validity_end = fe.nw_date_of_validity_end      
     Log Errors INTO Errlog_Enroll ('ENROLLMENT_INS') Reject Limit Unlimited;
          

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.ENROLLMENT_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_F_ENROLLMENT', SELECTION_TRANSACTION_ID
      FROM Errlog_Enroll
     WHERE Ora_Err_Tag$ = 'ENROLLMENT_INS';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.ENROLLMENT_INS', 1, v_desc, v_code, 'EMRS_F_ENROLLMENT');

      COMMIT;
END ENROLLMENT_INS;

PROCEDURE ENROLLMENT_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

   DELETE FROM Errlog_Enroll WHERE ora_err_tag$ = 'ENROLLMENT_UPD';

   INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
   VALUES (SEQ_JOB_ID.Nextval, 'ENROLLMENT_UPD','STARTED',SYSDATE)
   RETURNING JOB_ID INTO v_job_id;
    
   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  EMRS_F_ENROLLMENT f
   USING (SELECT tmp.*
          FROM ( SELECT        
                  e.EnrollmentID enrollment_id
                  ,'HCO' program_code
                  ,e.TypeTransaction enrollment_trans_type_code
                  ,e.ChannelName selection_source_code
                  ,e.PlanType plan_type
                  ,e.EnrlPlanID plan_id
                  ,e.EnrlPlanID plan_id_ext
                  ,e.TransEffectiveDate managed_care_start_date
                  ,e.TransactionType selection_reason_code
                  ,e.DisEnrlReasonCode change_reason_code
                  ,e.EnrollmentID selection_segment_id
                  ,e.BeneficiaryID client_number
                  ,CASE WHEN e.DisregardTrans = 'N' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN e.Accept
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NOT NULL THEN e.TransExportDate
                        WHEN e.DisregardTrans = 'N' AND e.Accept IS NULL AND e.TransExportDate IS NULL THEN e.TransDate 
                      ELSE e.DateLastModified END  status_date
                  ,e.AidCode aid_category_code
                  ,e.County county_code
                  ,e.ZipCode zip_code
                  ,CASE WHEN e.DisregardTrans = 'Y' THEN 'disregarded'
                        WHEN e.DisregardTrans = 'N' AND e.MEDSAccptTrans = 'Y' AND e.Accept IS NOT NULL AND e.TransEffectiveDate IS NOT NULL THEN 'acceptedByState'
                        WHEN e.DisregardTrans = 'N' AND COALESCE(e.MEDSAccptTrans,'N') = 'N' AND e.TransExportDate IS NOT NULL THEN 'uploadedToState'
                        WHEN COALESCE(e.Errors,0) <> 0 AND (e.IsCorrected IS NULL OR e.IsCorrected = 'N') THEN 'inResearch'
                      ELSE 'readyToUpload' END selection_status_code      
                  ,CASE WHEN UPPER(ac.aid_category_name) like '%INFANT%' THEN 'Y' ELSE 'N' END newborn_flag
                  ,SubProgram subprogram_code
                  ,PriorPlanId prior_plan_id
                  ,PriorPlanId prior_plan_id_ext
                  ,PriorEnrlEndDate prior_selection_end_date
                  ,PriorDisenrlReason prior_disenroll_reason_cd_1
                  ,PriorEnrollmentId prior_selection_segment_id
                  ,PriorEnrlStartDate prior_selection_start_date
                  ,'U' csda_code
                  ,e.RecordCreateDate record_date
                  ,e.RecordCreateName record_name
                  ,TO_NUMBER(TO_CHAR(e.TransEffectiveDate,'YYYYMMDD')) start_nd
                  ,20151231 end_nd
                  ,e.IsNonMEDS non_meds_ind
                  ,e.SwitchToMEDS switch_to_meds_ind
                  ,e.TransDate transaction_date
                  ,e.DisregardTrans disregard_trans_ind
                  ,e.MEDSAccptTrans meds_accept_trans_ind
                  ,e.Accept accept_ind
                  ,e.TransExportDate transaction_export_date
                  ,e.CLDLSentDate cldl_sent_date
                  ,e.ModifiedStatus modified_status
                  ,e.DocumentBatchNum dcn
                  ,e.RcvdMCalStartDate received_medical_start_date
                  ,e.CLDLNeedToBeSent cldl_needs_sending_flag
                  ,e.PcpSent pcp_sent
                  ,e.PcpDate pcp_date
                  ,e.ExpiryDate expiry_date
                  ,e.MedsPlan meds_plan_id
                  ,e.GMCDentalChoice gmc_dental_choice
                  ,e.GMCCombinedChoice gmc_combined_choice
                  ,e.SwitchToMEDSDate switch_to_meds_date
                  ,e.TransactionDisposition transaction_disposition
                  ,e.DateTimedOut date_timed_out
                  ,e.DateLastModified modified_date
                  ,e.NameLastModified modified_name
                  ,e.MedicalStartDate medical_start_date
                  ,e.MEDSReadTransDate meds_read_trans_date
                  ,e.MEDSFileCreateDate meds_file_create_date
                  ,e.Errors errors 
                  ,e.MediCalIDNumber medical_id_number 
                  ,e.Redaction redaction
                  ,e.MEDSImportDate meds_import_date
                  ,e.DateErrorsFixed date_errors_fixed
                  ,e.RTeamTransMarker rteam_trans_marker 
                  ,e.MEDSTerminalID meds_terminal_id
                  ,e.IDFormVerifier id_form_verifier
                  ,e.MonthsEnrlOrDisEnrl months_enrl_or_disenrl
                  ,e.DupFormNumCount dup_form_num_count
                  ,e.EnrollmentType enrollment_type
                  ,e.EnrlCloseDate enrl_close_date
                  ,e.MEDSTransType meds_trans_type
                  ,e.DisregardedDuplicateDate disregarded_duplicate_date
                  ,e.DisregardedDuplicate disregarded_duplicate
                  ,e.EsrID esr_id
                  ,e.VerifierID verifier_id
                  ,e.MEDProvIDNum provider_number
                  ,e.ChannelID channel_id
                  ,e.MedicalAffiliate medical_affiliate
                  ,e.EnrollmentID selection_transaction_id
                  ,e.ImportDate eligibility_receipt_date
                  ,e.CaseRowID case_number
                  ,ss.is_choice_ind
                  ,'U' term_reason_code
                  ,TRUNC(e.DateLastModified) nw_date_of_validity_start
                  --,TO_DATE('2050/12/31','YYYY/MM/DD') date_of_validity_end
                  ,e.ImportDate last_meds_change_date
                  ,e.OthHealthCoverageCode ohc_flag
                  ,e.CCSIndicator meds_ccs_flag
                  ,e.McalPlnMEDSStatus hcp_status             
                  ,TransferFlag transfer_flag      
                  ,existing_rec_dp_enrollment_id
                  --meds_ad_flag
                FROM emrs_s_enrollment_stg e
                  LEFT JOIN emrs_d_aid_category ac ON e.AidCode = ac.aid_category_code 
                  LEFT JOIN emrs_d_selection_source ss ON e.ChannelName = ss.selection_source_code  
              ) tmp
          JOIN emrs_f_enrollment t ON tmp.existing_rec_dp_enrollment_id = t.dp_enrollment_id AND tmp.nw_date_of_validity_start = t.date_of_validity_start
          WHERE COALESCE(t.program_code,'*') != COALESCE(tmp.program_code,'*') 
            OR COALESCE(t.enrollment_trans_type_code,'*') != COALESCE(tmp.enrollment_trans_type_code,'*')
            OR COALESCE(t.selection_source_code,'*') != COALESCE(tmp.selection_source_code,'*')
            OR COALESCE(t.plan_type,'*') != COALESCE(tmp.plan_type,'*')
            OR COALESCE(t.plan_id,'*') != COALESCE(tmp.plan_id,'*')
            OR COALESCE(t.plan_id_ext,'*') != COALESCE(tmp.plan_id_ext,'*')
            OR COALESCE(t.managed_care_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.managed_care_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.selection_reason_code,'*') != COALESCE(tmp.selection_reason_code,'*')
            OR COALESCE(t.change_reason_code,'*') != COALESCE(tmp.change_reason_code,'*')
            OR COALESCE(t.selection_segment_id,0) != COALESCE(tmp.selection_segment_id,0)
            OR COALESCE(t.client_number,0) != COALESCE(tmp.client_number,0)
            OR COALESCE(t.status_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.status_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.aid_category_code,'*') != COALESCE(tmp.aid_category_code,'*')
            OR COALESCE(t.county_code,'*') != COALESCE(tmp.county_code,'*')            
            OR COALESCE(t.zip_code,'*') != COALESCE(tmp.zip_code,'*')
            OR COALESCE(t.selection_status_code,'*') != COALESCE(tmp.selection_status_code,'*')
            OR COALESCE(t.newborn_flag,'*') != COALESCE(tmp.newborn_flag,'*')
            OR COALESCE(t.subprogram_code,'*') != COALESCE(tmp.subprogram_code,'*')
            OR COALESCE(t.prior_plan_id,'*') != COALESCE(tmp.prior_plan_id,'*')
            OR COALESCE(t.prior_plan_id_ext,'*') != COALESCE(tmp.prior_plan_id_ext,'*')
            OR COALESCE(t.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_end_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.prior_disenroll_reason_cd_1,'*') != COALESCE(tmp.prior_disenroll_reason_cd_1,'*')
            OR COALESCE(t.prior_selection_segment_id,0) != COALESCE(tmp.prior_selection_segment_id,0)
            OR COALESCE(t.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.prior_selection_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.csda_code,'*') != COALESCE(tmp.csda_code,'*')
            OR COALESCE(t.record_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.record_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.record_name,'*') != COALESCE(tmp.record_name,'*')
            OR COALESCE(t.start_nd,0) != COALESCE(tmp.start_nd,0)
            OR COALESCE(t.end_nd,0) != COALESCE(tmp.end_nd,0)
            OR COALESCE(t.non_meds_ind,'*') != COALESCE(tmp.non_meds_ind,'*')
            OR COALESCE(t.switch_to_meds_ind,'*') != COALESCE(tmp.switch_to_meds_ind,'*')
            OR COALESCE(t.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.disregard_trans_ind,'*') != COALESCE(tmp.disregard_trans_ind,'*')
            OR COALESCE(t.meds_accept_trans_ind,'*') != COALESCE(tmp.meds_accept_trans_ind,'*')
            OR COALESCE(t.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.accept_ind, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.transaction_export_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.cldl_sent_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_status,'*') != COALESCE(tmp.modified_status,'*')
            OR COALESCE(t.dcn,'*') != COALESCE(tmp.dcn,'*')
            OR COALESCE(t.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.received_medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.cldl_needs_sending_flag,'*') != COALESCE(tmp.cldl_needs_sending_flag,'*')
            OR COALESCE(t.pcp_sent,'*') != COALESCE(tmp.pcp_sent,'*')
            OR COALESCE(t.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.pcp_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.expiry_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_plan_id,'*') != COALESCE(tmp.meds_plan_id,'*')
            OR COALESCE(t.gmc_dental_choice,'*') != COALESCE(tmp.gmc_dental_choice,'*')
            OR COALESCE(t.gmc_combined_choice,'*') != COALESCE(tmp.gmc_combined_choice,'*')
            OR COALESCE(t.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.switch_to_meds_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.transaction_disposition,'*') != COALESCE(tmp.transaction_disposition,'*')
            OR COALESCE(t.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_timed_out, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.modified_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.modified_name,'*') != COALESCE(tmp.modified_name,'*')
            OR COALESCE(t.medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.medical_start_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_read_trans_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.meds_read_trans_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_file_create_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.meds_file_create_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.errors,0) !=  COALESCE(tmp.errors,0)
            OR COALESCE(t.medical_id_number,'*') != COALESCE(tmp.medical_id_number,'*')
            OR COALESCE(t.redaction,'*') != COALESCE(tmp.redaction,'*')
            OR COALESCE(t.meds_import_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.meds_import_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.date_errors_fixed, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.date_errors_fixed, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.rteam_trans_marker,'*') != COALESCE(tmp.rteam_trans_marker,'*')
            OR COALESCE(t.meds_terminal_id,'*') != COALESCE(tmp.meds_terminal_id,'*')
            OR COALESCE(t.id_form_verifier,'*') != COALESCE(tmp.id_form_verifier,'*')
            OR COALESCE(t.months_enrl_or_disenrl,'*')  !=  COALESCE(tmp.months_enrl_or_disenrl,'*')
            OR COALESCE(t.dup_form_num_count,0) != COALESCE(tmp.dup_form_num_count,0)
            OR COALESCE(t.enrollment_type,'*') != COALESCE(tmp.enrollment_type,'*')
            OR COALESCE(t.enrl_close_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.enrl_close_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.meds_trans_type,'*') != COALESCE(tmp.meds_trans_type,'*')
            OR COALESCE(t.disregarded_duplicate_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.disregarded_duplicate_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.disregarded_duplicate,'*') != COALESCE (tmp.disregarded_duplicate,'*')
            OR COALESCE(t.esr_id,'*') != COALESCE(tmp.esr_id,'*')
            OR COALESCE(t.verifier_id,'*') != COALESCE(tmp.verifier_id,'*')
            OR COALESCE(t.provider_number,'*') !=  COALESCE(tmp.provider_number,'*')
            OR COALESCE(t.channel_id,999) != COALESCE(tmp.channel_id,999)
            OR COALESCE(t.medical_affiliate,'*') != COALESCE(tmp.medical_affiliate,'*')
            OR COALESCE(t.selection_transaction_id,0) != COALESCE(tmp.selection_transaction_id,0)
            OR COALESCE(t.eligibility_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.eligibility_receipt_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.case_number,0) != COALESCE(tmp.case_number,0)
            OR COALESCE(t.is_choice_ind,'*') != COALESCE(tmp.is_choice_ind,'*')
            OR COALESCE(t.term_reason_code,'*') != COALESCE(tmp.term_reason_code,'*')
            OR COALESCE(t.last_meds_change_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.last_meds_change_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.ohc_flag,'*') != COALESCE(tmp.ohc_flag,'*')
            OR COALESCE(t.meds_ccs_flag,'*') != COALESCE(tmp.meds_ccs_flag,'*') 
            OR COALESCE(t.hcp_status,'*') != COALESCE(tmp.hcp_status,'*')
            OR COALESCE(t.transfer_flag,'*') != COALESCE(tmp.transfer_flag,'*') 
          ) ft ON (f.dp_enrollment_id = ft.existing_rec_dp_enrollment_id)
    WHEN MATCHED THEN UPDATE
     SET f.program_code = ft.program_code
        ,f.enrollment_trans_type_code = ft.enrollment_trans_type_code
        ,f.selection_source_code = ft.selection_source_code
        ,f.plan_type = ft.plan_type
        ,f.plan_id = ft.plan_id
        ,f.plan_id_ext = ft.plan_id_ext
        ,f.managed_care_start_date = ft.managed_care_start_date
        ,f.selection_reason_code = ft.selection_reason_code
        ,f.change_reason_code = ft.change_reason_code
        ,f.selection_segment_id = ft.selection_segment_id
        ,f.client_number = ft.client_number
        ,f.status_date = ft.status_date
        ,f.aid_category_code = ft.aid_category_code
        ,f.county_code = ft.county_code        
        ,f.zip_code = ft.zip_code
        ,f.selection_status_code = ft.selection_status_code
        ,f.newborn_flag = ft.newborn_flag
        ,f.subprogram_code = ft.subprogram_code
        ,f.prior_plan_id = ft.prior_plan_id
        ,f.prior_plan_id_ext = ft.prior_plan_id_ext
        ,f.prior_selection_end_date = ft.prior_selection_end_date
        ,f.prior_disenroll_reason_cd_1 = ft.prior_disenroll_reason_cd_1
        ,f.prior_selection_segment_id = ft.prior_selection_segment_id
        ,f.prior_selection_start_date = ft.prior_selection_start_date
        ,f.csda_code = ft.csda_code
        ,f.record_date = ft.record_date
        ,f.record_name = ft.record_name
        ,f.start_nd = ft.start_nd
        ,f.end_nd = ft.end_nd
        ,f.non_meds_ind = ft.non_meds_ind
        ,f.switch_to_meds_ind = ft.switch_to_meds_ind
        ,f.transaction_date = ft.transaction_date
        ,f.disregard_trans_ind = ft.disregard_trans_ind
        ,f.meds_accept_trans_ind = ft.meds_accept_trans_ind
        ,f.accept_ind = ft.accept_ind
        ,f.transaction_export_date = ft.transaction_export_date
        ,f.cldl_sent_date = ft.cldl_sent_date
        ,f.modified_status = ft.modified_status
        ,f.dcn = ft.dcn
        ,f.received_medical_start_date =  ft.received_medical_start_date 
        ,f.cldl_needs_sending_flag = ft.cldl_needs_sending_flag
        ,f.pcp_sent = ft.pcp_sent
        ,f.pcp_date = ft.pcp_date
        ,f.expiry_date = ft.expiry_date
        ,f.meds_plan_id = ft.meds_plan_id
        ,f.gmc_dental_choice = ft.gmc_dental_choice
        ,f.gmc_combined_choice = ft.gmc_combined_choice
        ,f.switch_to_meds_date = ft.switch_to_meds_date
        ,f.transaction_disposition = ft.transaction_disposition
        ,f.date_timed_out = ft.date_timed_out
        ,f.modified_date = ft.modified_date
        ,f.modified_name = ft.modified_name        
        ,f.medical_start_date =  ft.medical_start_date
        ,f.meds_read_trans_date = ft.meds_read_trans_date
        ,f.meds_file_create_date = ft.meds_file_create_date
        ,f.errors = ft.errors 
        ,f.medical_id_number = ft.medical_id_number 
        ,f.redaction = ft.redaction
        ,f.meds_import_date = ft.meds_import_date
        ,f.date_errors_fixed = ft.date_errors_fixed
        ,f.rteam_trans_marker = ft.rteam_trans_marker 
        ,f.meds_terminal_id = ft.meds_terminal_id
        ,f.id_form_verifier = ft.id_form_verifier
        ,f.months_enrl_or_disenrl = ft.months_enrl_or_disenrl
        ,f.dup_form_num_count = ft.dup_form_num_count
        ,f.enrollment_type = ft.enrollment_type
        ,f.enrl_close_date = ft.enrl_close_date
        ,f.meds_trans_type = ft.meds_trans_type
        ,f.disregarded_duplicate_date = ft.disregarded_duplicate_date
        ,f.disregarded_duplicate = ft.disregarded_duplicate
        ,f.esr_id = ft.esr_id
        ,f.verifier_id = ft.verifier_id
        ,f.provider_number = ft.provider_number
        ,f.channel_id = ft.channel_id
        ,f.medical_affiliate = ft.medical_affiliate
        ,f.selection_transaction_id = ft.selection_transaction_id
        ,f.eligibility_receipt_date = ft.eligibility_receipt_date
        ,f.case_number = ft.case_number
        ,f.is_choice_ind = ft.is_choice_ind
        ,f.term_reason_code = ft.term_reason_code        
        ,f.last_meds_change_date = ft.last_meds_change_date
        ,f.ohc_flag = ft.ohc_flag
        ,f.meds_ccs_flag = ft.meds_ccs_flag
        ,f.hcp_status = ft.hcp_status
        ,f.transfer_flag = ft.transfer_flag
     Log Errors INTO Errlog_Enroll ('ENROLLMENT_UPD') Reject Limit Unlimited;

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
    SELECT c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.ENROLLMENT_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'EMRS_F_ENROLLMENT', ENROLLMENT_ID
      FROM Errlog_Enroll
     WHERE Ora_Err_Tag$ = 'ENROLLMENT_UPD';

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
      VALUES( c_critical, con_pkg, 'CAHCO_ENROLL_ETL_PKG.ENROLLMENT_UPD', 1, v_desc, v_code, 'EMRS_F_ENROLLMENT');

      COMMIT;
END ENROLLMENT_UPD;


END;

/


grant execute on CAHCO_ENROLL_ETL_PKG to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;