CREATE SEQUENCE  "EMRS_SEQ_ENROLLMENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ENROLLMENT_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_F_ENROLLMENT
(DP_ENROLLMENT_ID NUMBER NOT NULL,
ACCEPT_IND DATE,
AID_CATEGORY_CODE VARCHAR2(32), 
CASE_NUMBER NUMBER(10), 
CHANGE_REASON_CODE VARCHAR2(32), 
CHANNEL_ID NUMBER,
CHIP_ANNUAL_ENROLL_DATE DATE, 
CLDL_NEEDS_SENDING_FLAG VARCHAR2(1),
CLDL_SENT_DATE DATE,
CLIENT_NUMBER NUMBER(10), 
CO_PAY_AMOUNT NUMBER(22,3), 
COST_SHARE_END_DATE DATE, 
COST_SHARE_START_DATE DATE, 
COUNTY_CODE VARCHAR2(32), 
CREATED_BY VARCHAR2(30), 
CSDA_CODE VARCHAR2(32), 
DATE_CREATED DATE, 
DATE_ERRORS_FIXED DATE,
DATE_TIMED_OUT DATE,
DATE_UPDATED DATE, 
DCN VARCHAR2(64),
DISENROLL_REASON_CD_2 VARCHAR2(32), 
DISREGARD_TRANS_IND VARCHAR2(1),
DISREGARDED_DUPLICATE VARCHAR2(1),
DISREGARDED_DUPLICATE_DATE DATE,
DUP_FORM_NUM_COUNT NUMBER(5),
ELIGIBILITY_RECEIPT_DATE DATE, 
END_ND NUMBER(8,0),
ENRL_CLOSE_DATE DATE,
ENROLLMENT_FEE_ASSESSED NUMBER(22,4), 
ENROLLMENT_FEE_ASSESSED_DATE DATE, 
ENROLLMENT_FEE_FREQUENCY VARCHAR2(30), 
ENROLLMENT_FEE_PAID NUMBER(22,4), 
ENROLLMENT_FEE_PAID_DATE DATE, 
ENROLLMENT_ID NUMBER(10), 
ENROLLMENT_TRANS_TYPE_CODE VARCHAR2(32), 
ENROLLMENT_TYPE VARCHAR2(32),
ERRORS NUMBER(5),
ESR_ID VARCHAR2(6),
EXPIRY_DATE DATE,
FPL_PERCENTAGE NUMBER(22,4),
GMC_COMBINED_CHOICE VARCHAR2(3),
GMC_DENTAL_CHOICE VARCHAR2(3),
HCP_STATUS VARCHAR2(10),
ID_FORM_VERIFIER VARCHAR2(6),
IS_CHOICE_IND VARCHAR2(1),
JYEAR_OF_LAST_ENROLLMENT_FORM DATE, 
LAST_MEDS_CHANGE_DATE DATE,
MANAGED_CARE_END_DATE DATE, 
MANAGED_CARE_START_DATE DATE, 
MEDICAID_BUY_IN_FEE NUMBER(4,2), 
MEDICAID_BUY_IN_FEE_DATE DATE, 
MEDICAID_RECERTIFICATION_DATE DATE, 
MEDICAL_AFFILIATE VARCHAR2(4),
MEDICAL_ID_NUMBER VARCHAR2(14),
MEDICAL_START_DATE DATE,
MEDS_ACCEPT_TRANS_IND VARCHAR2(1),
MEDS_AD_FLAG VARCHAR2(1),
MEDS_CCS_FLAG VARCHAR2(1),
MEDS_FILE_CREATE_DATE DATE,
MEDS_IMPORT_DATE DATE,
MEDS_PLAN_ID VARCHAR2(3),
MEDS_READ_TRANS_DATE DATE,
MEDS_TERMINAL_ID VARCHAR2(6),
MEDS_TRANS_TYPE VARCHAR2(1),
MET_COST_SHARE_CAP_DATE DATE, 
MODIFIED_DATE DATE, 
MODIFIED_NAME VARCHAR2(50), 
MODIFIED_STATUS VARCHAR2(1),
MONTHS_ENRL_OR_DISENRL VARCHAR2(4),
NEWBORN_FLAG VARCHAR2(1),
NON_MEDS_IND VARCHAR2(1),
NUMBER_COUNT NUMBER, 
OHC_FLAG VARCHAR2(1),
ORIGINAL_END_DATE DATE, 
ORIGINAL_START_DATE DATE, 
PCP_DATE DATE,
PCP_SENT VARCHAR2(1),
PLAN_ID VARCHAR2(32), 
PLAN_ID_EXT VARCHAR2(32), 
PLAN_TYPE VARCHAR2(32), 
PRIOR_CHOICE_REASON_CD VARCHAR2(32), 
PRIOR_CLIENT_AID_CATEGORY_CD VARCHAR2(32), 
PRIOR_COUNTY_CD VARCHAR2(32), 
PRIOR_DISENROLL_REASON_CD_1 VARCHAR2(32), 
PRIOR_DISENROLL_REASON_CD_2 VARCHAR2(32), 
PRIOR_PLAN_ID VARCHAR2(32), 
PRIOR_PLAN_ID_EXT VARCHAR2(32), 
PRIOR_SELECTION_END_DATE DATE, 
PRIOR_SELECTION_SEGMENT_ID NUMBER(10), 
PRIOR_SELECTION_START_DATE DATE, 
PRIOR_ZIPCODE VARCHAR2(32), 
PROGRAM_CODE VARCHAR2(32), 
PROVIDER_NUMBER VARCHAR2(10), 
RECEIVED_MEDICAL_START_DATE DATE,
RECORD_DATE DATE, 
RECORD_NAME VARCHAR2(50), 
REDACTION VARCHAR2(1),
RTEAM_TRANS_MARKER VARCHAR2(1),
SELECTION_REASON_CODE VARCHAR2(32), 
SELECTION_SEGMENT_ID NUMBER(10), 
SELECTION_SOURCE_CODE VARCHAR2(32), 
SELECTION_STATUS_CODE VARCHAR2(32), 
SELECTION_TRANSACTION_ID NUMBER(10), 
START_ND NUMBER(8,0), 
STATUS_DATE DATE, 
SUBPROGRAM_CODE VARCHAR2(32), 
SWITCH_TO_MEDS_DATE DATE,
SWITCH_TO_MEDS_IND VARCHAR2(1),
TERM_REASON_CODE VARCHAR2(32), 
TRANSACTION_DATE DATE,
TRANSACTION_DISPOSITION VARCHAR2(1),
TRANSACTION_EXPORT_DATE DATE,
UPDATED_BY VARCHAR2(30), 
VERIFIER_ID VARCHAR2(6),
ZIP_CODE VARCHAR2(32),
DATE_OF_VALIDITY_START DATE,
DATE_OF_VALIDITY_END DATE,
TRANSFER_FLAG VARCHAR2(1)
 ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_F_ENROLLMENT" ADD CONSTRAINT "ENRL_ENRLID_PK" PRIMARY KEY ("DP_ENROLLMENT_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;

CREATE INDEX EMRSFENROLLMENT_IDX01 ON EMRS_F_ENROLLMENT (ENROLLMENT_ID) TABLESPACE MAXDAT_INDX;   
CREATE INDEX EMRSFENROLLMENT_IDX02 ON EMRS_F_ENROLLMENT (DATE_OF_VALIDITY_START,DATE_OF_VALIDITY_END) TABLESPACE MAXDAT_INDX;   
CREATE INDEX EMRSFENROLLMENT_IDX03 ON EMRS_F_ENROLLMENT(selection_reason_code) TABLESPACE MAXDAT_INDX;     
CREATE INDEX EMRSFENROLLMENT_IDX04 ON EMRS_F_ENROLLMENT(enrollment_trans_type_code) TABLESPACE MAXDAT_INDX;
CREATE INDEX EMRSFENROLLMENT_IDX05 ON EMRS_F_ENROLLMENT(selection_source_code) TABLESPACE MAXDAT_INDX;
CREATE INDEX EMRSFENROLLMENT_IDX06 ON EMRS_F_ENROLLMENT(client_number) TABLESPACE MAXDAT_INDX; 
  
GRANT SELECT ON "EMRS_F_ENROLLMENT" TO "MAXDAT_READ_ONLY";
GRANT select, insert, update on EMRS_F_ENROLLMENT to MAXDAT_OLTP_SIU;
GRANT select, insert, update, delete on EMRS_F_ENROLLMENT to MAXDAT_OLTP_SIUD;

BEGIN
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_F_ENROLLMENT','ERRLOG_ENROLL');
END;
/


CREATE OR REPLACE TRIGGER "BUIR_F_ENROLLMENTS" 
 BEFORE INSERT OR UPDATE
 ON emrs_f_enrollment
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_F_ENROLLMENT.dp_enrollment_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_enrollment_id IS NULL THEN
      SElECT EMRS_SEQ_ENROLLMENT_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_enrollment_id       := v_seq_id;
    END IF;
    :NEW.date_created := sysdate;
    :NEW.created_by := user;
  END IF;
  
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BUIR_F_ENROLLMENTS;
/
ALTER TRIGGER "BUIR_F_ENROLLMENTS" ENABLE;
/


CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
AS
SELECT 	
e.accept_ind,
e.aid_category_code, 
e.case_number, 
e.change_reason_code, 
e.channel_id,
e.chip_annual_enroll_date, 
e.cldl_needs_sending_flag,
e.cldl_sent_date,
e.client_number, 
e.co_pay_amount, 
e.cost_share_end_date, 
e.cost_share_start_date, 
e.county_code, 
e.created_by, 
e.csda_code, 
e.date_created, 
e.date_errors_fixed,
e.date_timed_out,
e.date_updated, 
e.dcn,
e.disenroll_reason_cd_2, 
e.disregard_trans_ind,
e.disregarded_duplicate,
e.disregarded_duplicate_date,
e.dup_form_num_count,
e.eligibility_receipt_date, 
e.end_nd,
e.enrl_close_date,
e.enrollment_fee_assessed, 
e.enrollment_fee_assessed_date, 
e.enrollment_fee_frequency, 
e.enrollment_fee_paid, 
e.enrollment_fee_paid_date, 
e.enrollment_id, 
e.enrollment_trans_type_code, 
e.enrollment_type,
e.errors,
e.esr_id,
e.expiry_date,
e.fpl_percentage,
e.gmc_combined_choice,
e.gmc_dental_choice,
e.hcp_status,
e.id_form_verifier,
e.is_choice_ind,
e.jyear_of_last_enrollment_form, 
e.last_meds_change_date,
e.managed_care_end_date, 
e.managed_care_start_date, 
e.medicaid_buy_in_fee, 
e.medicaid_buy_in_fee_date, 
e.medicaid_recertification_date, 
e.medical_affiliate,
e.medical_id_number,
e.medical_start_date,
e.meds_accept_trans_ind,
e.meds_ad_flag,
e.meds_ccs_flag,
e.meds_file_create_date,
e.meds_import_date,
e.meds_plan_id,
e.meds_read_trans_date,
e.meds_terminal_id,
e.meds_trans_type,
e.met_cost_share_cap_date, 
e.modified_date, 
e.modified_name, 
e.modified_status,
e.months_enrl_or_disenrl,
e.newborn_flag,
e.non_meds_ind,
e.number_count, 
e.ohc_flag,
e.original_end_date, 
e.original_start_date, 
e.pcp_date,
e.pcp_sent,
e.plan_id, 
e.plan_id_ext, 
e.plan_type, 
e.prior_choice_reason_cd, 
e.prior_client_aid_category_cd, 
e.prior_county_cd, 
e.prior_disenroll_reason_cd_1, 
e.prior_disenroll_reason_cd_2, 
e.prior_plan_id, 
e.prior_plan_id_ext, 
e.prior_selection_end_date, 
e.prior_selection_segment_id, 
e.prior_selection_start_date, 
e.prior_zipcode, 
e.program_code, 
e.provider_number, 
e.received_medical_start_date,
e.record_date, 
e.record_name, 
e.redaction,
e.rteam_trans_marker,
e.selection_reason_code, 
e.selection_segment_id, 
e.selection_source_code, 
e.selection_status_code, 
e.selection_transaction_id, 
e.start_nd, 
e.status_date, 
e.subprogram_code, 
e.switch_to_meds_date,
e.switch_to_meds_ind,
e.term_reason_code reason_code, 
e.transaction_date,
e.transaction_disposition,
e.transaction_export_date,
e.updated_by, 
e.verifier_id,
e.zip_code,
e.provider_number med_provid_num,
e.provider_number dr_clinic_code,
e.date_of_validity_start,
e.date_of_validity_end,
e.selection_reason_code transaction_type,
sr.selection_reason transactiontype_description,
e.enrollment_trans_type_code type_transaction,
tt.enrollment_trans_type typetransaction_description,
e.transfer_flag,
(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
 FROM D_DATES_SV
 WHERE business_day_flag = 'Y'
 AND d_date BETWEEN TRUNC(record_date) AND COALESCE(TRUNC(accept_ind),TRUNC(sysdate)) ) age_in_business_days,
(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
 FROM D_DATES_SV
 WHERE business_day_flag = 'Y'
 AND d_date BETWEEN TRUNC(transaction_date) AND COALESCE(TRUNC(accept_ind),TRUNC(sysdate)) ) history_age_in_business_days 
FROM emrs_f_enrollment e
 LEFT JOIN emrs_d_selection_reason sr ON e.selection_reason_code = sr.selection_reason_code
 LEFT JOIN emrs_d_enroll_trans_type tt ON e.enrollment_trans_type_code = tt.enrollment_trans_type_code ;

GRANT SELECT ON "EMRS_F_ENROLLMENT_SV" TO "MAXDAT_READ_ONLY";