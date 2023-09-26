CREATE SEQUENCE  "EMRS_SEQ_SELTRANS_HIST_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_SELTRANS_HIST_ID" TO "MAXDAT_READ_ONLY";


CREATE TABLE EMRS_D_SELECTION_TRANS_HISTORY
  (DP_SELTRANS_HIST_ID NUMBER NOT NULL,
 AID_CATEGORY_CODE VARCHAR2(32), 
BENEFITS_PACKAGE_CD VARCHAR2(32), 
CHANGE_REASON_CODE VARCHAR2(32), 
CLIENT_NUMBER NUMBER(10), 
CLIENT_RESIDENCE_ADDRESS_ID NUMBER(10), 
COUNTY_CODE VARCHAR2(32), 
CREATED_BY VARCHAR2(30), 
CSDA_CODE VARCHAR2(32),
CURRENT_SELECTION_STATUS_ID NUMBER(10), 
CUSTOM_FIELD1 VARCHAR2(240),
CUSTOM_FIELD2 VARCHAR2(240),
CUSTOM_FIELD3 VARCHAR2(240),
CUSTOM_FIELD4 VARCHAR2(240),
CUSTOM_FIELD5 VARCHAR2(240),
CONTRACT_ID NUMBER(10),
DATE_CREATED DATE, 
DATE_UPDATED DATE, 
DISENROLL_REASON_CD_2 VARCHAR2(32), 
END_DATE DATE, 
END_ND NUMBER(8,0), 
MISSING_INFO_ID NUMBER(10), 
MISSING_SIGNATURE_IND NUMBER(1,0), 
MODIFIED_DATE DATE, 
MODIFIED_NAME VARCHAR2(50), 
NEWBORN_FLAG VARCHAR2(1),
ORIGINAL_END_DATE DATE, 
ORIGINAL_START_DATE DATE, 
OUTREACH_SESSION_ID NUMBER(10), 
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
RECORD_DATE DATE, 
RECORD_NAME VARCHAR2(50), 
SELECTION_GENERIC_FIELD1_DATE DATE, 
SELECTION_GENERIC_FIELD10_TXT VARCHAR2(256), 
SELECTION_GENERIC_FIELD2_DATE DATE, 
SELECTION_GENERIC_FIELD3_NUM NUMBER(22,0), 
SELECTION_GENERIC_FIELD4_NUM NUMBER(22,0), 
SELECTION_GENERIC_FIELD5_TXT VARCHAR2(256), 
SELECTION_GENERIC_FIELD6_TXT VARCHAR2(256), 
SELECTION_GENERIC_FIELD7_TXT VARCHAR2(256), 
SELECTION_GENERIC_FIELD8_TXT VARCHAR2(256), 
SELECTION_GENERIC_FIELD9_TXT VARCHAR2(256), 
SELECTION_REASON_CODE VARCHAR2(32), 
SELECTION_SEGMENT_ID NUMBER(10), 
SELECTION_SOURCE_CODE VARCHAR2(32), 
SELECTION_STATUS_CODE VARCHAR2(32), 
SELECTION_TRANSACTION_ID NUMBER(10), 
START_DATE DATE, 
START_ND NUMBER(8,0), 
STATUS_DATE DATE, 
SUBPROGRAM_CODE VARCHAR2(32),
TRANSACTION_TYPE_CD VARCHAR2(32), 
UPDATED_BY VARCHAR2(30),
ZIP_CODE VARCHAR2(32), 
ACCEPT_IND DATE,
CLDL_NEEDS_SENDING_FLAG VARCHAR2(1),
CLDL_SENT_DATE DATE,
DATE_TIMED_OUT DATE,
DCN VARCHAR2(64),
DISREGARD_TRANS_IND VARCHAR2(1),
EXPIRY_DATE DATE,
GMC_COMBINED_CHOICE VARCHAR2(3),
GMC_DENTAL_CHOICE VARCHAR2(3),
MEDS_ACCEPT_TRANS_IND VARCHAR2(1),
MEDS_PLAN_ID VARCHAR2(32),
MODIFIED_STATUS VARCHAR2(1),
NON_MEDS_IND VARCHAR2(1),
NOTES VARCHAR2(4000),
PCP_DATE DATE,
PCP_SENT VARCHAR2(1),
RECEIVED_MEDICAL_START_DATE DATE,
SWITCH_TO_MEDS_DATE DATE,
SWITCH_TO_MEDS_IND VARCHAR2(1),
TRANSACTION_DATE DATE,
TRANSACTION_DISPOSITION VARCHAR2(1),
TRANSACTION_EXPORT_DATE DATE,
DATE_OF_VALIDITY_START DATE,
DATE_OF_VALIDITY_END DATE,
TRANSFER_FLAG VARCHAR2(1),
ESR_ID VARCHAR2(6),
VERIFIER_ID VARCHAR2(6)
   ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" ADD CONSTRAINT "SELTRANS_HIST_PK" PRIMARY KEY ("DP_SELTRANS_HIST_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
  
CREATE INDEX EMRSDSELTRANSHIST_IDX01 ON EMRS_D_SELECTION_TRANS_HISTORY (SELECTION_TRANSACTION_ID) TABLESPACE MAXDAT_INDX;   
CREATE INDEX EMRSDSELTRANSHIST_IDX02 ON EMRS_D_SELECTION_TRANS_HISTORY (DATE_OF_VALIDITY_START,DATE_OF_VALIDITY_END) TABLESPACE MAXDAT_INDX;   
CREATE INDEX EMRSDSELTRANSHIST_IDX03 ON EMRS_D_SELECTION_TRANS_HISTORY(selection_reason_code) TABLESPACE MAXDAT_INDX;     
CREATE INDEX EMRSDSELTRANSHIST_IDX04 ON EMRS_D_SELECTION_TRANS_HISTORY(transaction_type_cd) TABLESPACE MAXDAT_INDX;
CREATE INDEX EMRSDSELTRANSHIST_IDX05 ON EMRS_D_SELECTION_TRANS_HISTORY(selection_source_code) TABLESPACE MAXDAT_INDX;
CREATE INDEX EMRSDSELTRANSHIST_IDX06 ON EMRS_D_SELECTION_TRANS_HISTORY(client_number) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON "EMRS_D_SELECTION_TRANS_HISTORY" TO "MAXDAT_READ_ONLY";
GRANT select, insert, update on EMRS_D_SELECTION_TRANS_HISTORY to MAXDAT_OLTP_SIU;
GRANT select, insert, update, delete on EMRS_D_SELECTION_TRANS_HISTORY to MAXDAT_OLTP_SIUD;

BEGIN
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_SELECTION_TRANS_HISTORY','ERRLOG_SELTRANS_HIST');
END;
/

CREATE OR REPLACE TRIGGER "BUIR_SELTRANS_HIST" 
 BEFORE INSERT
 ON EMRS_D_SELECTION_TRANS_HISTORY
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_TRANS_HISTORY.dp_seltrans_hist_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_seltrans_hist_id IS NULL THEN
      SElECT EMRS_SEQ_SELTRANS_HIST_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_seltrans_hist_id   := v_seq_id;
    END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
  END IF; 
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_SELTRANS_HIST;
/
ALTER TRIGGER "BUIR_SELTRANS_HIST" ENABLE;
/

CREATE OR REPLACE VIEW emrs_d_selection_trans_history_sv
AS 
SELECT
st.dp_seltrans_hist_id selection_trans_history_id,
st.date_of_validity_start,
st.date_of_validity_end,
st.csda_code,
st.selection_generic_field1_date,
st.selection_generic_field2_date,
st.selection_generic_field3_num,
st.selection_generic_field4_num,
st.selection_generic_field5_txt,
st.selection_generic_field6_txt,
st.selection_generic_field7_txt,
st.selection_generic_field8_txt,
st.selection_generic_field9_txt,
st.selection_generic_field10_txt,
st.selection_transaction_id,
st.program_code,
st.transaction_type_cd,
st.selection_source_code,
st.plan_type,
st.plan_id,
st.plan_id_ext,
st.selection_reason_code,
st.change_reason_code,
st.disenroll_reason_cd_2,
st.missing_info_id,
st.missing_signature_ind,
st.outreach_session_id,
st.benefits_package_cd,
st.selection_segment_id,
st.client_number,
st.current_selection_status_id,
st.status_date,
st.aid_category_code,
st.county_code,
st.zip_code,
st.client_residence_address_id,
st.prior_selection_segment_id,
st.selection_status_code,
st.subprogram_code,
st.custom_field1,
st.custom_field2,
st.custom_field3,
st.custom_field4,
st.custom_field5,
st.prior_selection_start_date,
st.prior_selection_end_date,
st.prior_plan_id,
st.prior_plan_id_ext,
st.record_date,
st.record_name,
st.start_nd,
st.end_nd,
st.prior_choice_reason_cd,
st.prior_disenroll_reason_cd_1,
st.prior_disenroll_reason_cd_2,
st.prior_client_aid_category_cd,
st.prior_county_cd,
st.prior_zipcode,
st.original_start_date,
st.original_end_date,
st.non_meds_ind,
st.switch_to_meds_ind,
st.disregard_trans_ind,
st.meds_accept_trans_ind,
st.accept_ind,
st.transaction_export_date,
st.cldl_sent_date cld_sent_date,
st.modified_status,
st.received_medical_start_date,
st.cldl_needs_sending_flag cld_needs_sending_flag,
st.pcp_sent,
st.pcp_date,
st.expiry_date,
st.meds_plan_id,
st.gmc_dental_choice,
st.gmc_combined_choice,
st.switch_to_meds_date,
st.transaction_disposition,
st.date_timed_out,
sr.selection_reason selection_reason_description,
tt.enrollment_trans_type transaction_type_description,
st.transfer_flag,
(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
 FROM D_DATES_SV
 WHERE business_day_flag = 'Y'
 AND d_date BETWEEN TRUNC(st.record_date) AND COALESCE(TRUNC(accept_ind),TRUNC(sysdate)) ) age_in_business_days,
(SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
 FROM D_DATES_SV
 WHERE business_day_flag = 'Y'
 AND d_date BETWEEN TRUNC(transaction_date) AND COALESCE(TRUNC(accept_ind),TRUNC(sysdate)) ) history_age_in_business_days,
CASE WHEN st.transaction_type_cd = '6' THEN 'FFS' ELSE p.plan_name END plan_name,
CASE WHEN st.transaction_type_cd = '1' THEN 'R' ELSE 
     CASE WHEN st.selection_reason_code IS NULL THEN 'N' ELSE st.selection_reason_code END END selection_reason_code_drv ,     
CASE WHEN st.transaction_type_cd NOT IN('1','5') AND (st.change_reason_code IS NULL OR LENGTH(st.change_reason_code)=0 OR st.change_reason_code in ('F07','F08')) 
  THEN 'F10' ELSE st.change_reason_code END  change_reason_code_drv ,
null status_sort --not needed in history so defaulting to null  
FROM emrs_d_selection_trans_history st
 LEFT JOIN emrs_d_selection_reason sr ON st.selection_reason_code = sr.selection_reason_code
 LEFT JOIN emrs_d_enroll_trans_type tt ON st.transaction_type_cd = tt.enrollment_trans_type_code 
 LEFT JOIN emrs_d_plan p ON st.plan_id = p.plan_id;

GRANT SELECT ON "EMRS_D_SELECTION_TRANS_HISTORY_SV" TO "MAXDAT_READ_ONLY";
