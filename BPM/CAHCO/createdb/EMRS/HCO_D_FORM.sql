CREATE SEQUENCE  "HCO_SEQ_FORMS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_FORMS_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_D_FORM
(REFERENCE_ID NUMBER,
 REFERENCE_TYPE VARCHAR2(32),
CLIENT_NUMBER NUMBER,
DATE_FORM_RECEIVED DATE,
PLAN_TYPE_A VARCHAR2(1),
PLAN_TYPE_B VARCHAR2(1),
ENVELOPE_ID VARCHAR2(20),
FORM_INCOMPLETE VARCHAR2(1) ,
FORM_MANUALLY_ENTERED VARCHAR2(1) ,
DCN VARCHAR2(11),
FORM_PHONE_NUMBER VARCHAR2(20),
MAIL_TYPE VARCHAR2(2),
INCOMPLETE_REASON_CODE_A VARCHAR2(10),
INCOMPLETE_REASON_CODE_B VARCHAR2(10),
FORM_SIGNED VARCHAR2(1),
FILE_RCVD_FROM_HYLAND VARCHAR2(1),
CAMPAIGN_COMPLETED VARCHAR2(1),
RECORD_DATE DATE,
RECORD_NAME VARCHAR2(50),
MODIFIED_NAME VARCHAR2(50),
MODIFIED_DATE DATE,
CREATED_BY VARCHAR2(80),
DATE_CREATED DATE,
UPDATED_BY VARCHAR2(80),
DATE_UPDATED DATE,
VERIFIER_ID VARCHAR2(6),
ESR_ID VARCHAR2(6),
PROCESSED_DATE DATE,
PLAN_ORIGINATED_FLAG VARCHAR2(10),
CREATED_BY_AGENT_FLAG VARCHAR2(10),
PLAN_ID_A VARCHAR2(3),
PLAN_ID_B VARCHAR2(3),
BENE_STATUS_PLAN_A VARCHAR2(2),
BENE_STATUS_PLAN_B VARCHAR2(2),
CLINIC_CODE_A VARCHAR2(10),
CLINIC_CODE_B VARCHAR2(10),
SENT_TO_MANUAL_A VARCHAR2(1),
SENT_TO_MANUAL_B VARCHAR2(1),
CHANGE_REASON_CODE VARCHAR2(10),
PLAN_PARTNER VARCHAR2(4),
CASE_NUMBER NUMBER,
FORM_STATUS_CODE VARCHAR2(2),
FORM_TYPE VARCHAR2(20),
ENROLLMENT_ID NUMBER,
MANUAL_ENR_CREATE_DATE DATE,
FORM_INCOMPLETE_CREATE_DATE DATE,
EXEMPT_OR_EDER_CREATE_DATE DATE,
NOTES VARCHAR2(4000),
COUNTY_CODE VARCHAR2(32),
DP_FORM_ID NUMBER NOT NULL,
SELECTION_SOURCE_CODE VARCHAR2(32)
   ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "HCO_D_FORM" ADD CONSTRAINT "FORM_FORMID_PK" PRIMARY KEY ("DP_FORM_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODFORM_IDX01 ON HCO_D_FORM(REFERENCE_ID,REFERENCE_TYPE) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORM_IDX02 ON HCO_D_FORM(CLIENT_NUMBER) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORM_IDX03 ON HCO_D_FORM(CASE_NUMBER) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORM_IDX04 ON HCO_D_FORM(DCN) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORM_IDX05 ON HCO_D_FORM(TRUNC(record_date)) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORM_IDX06 ON HCO_D_FORM(enrollment_id) TABLESPACE MAXDAT_INDX;   
CREATE INDEX HCODFORM_IDX07 ON HCO_D_FORM(selection_source_code) TABLESPACE MAXDAT_INDX;       
    
GRANT SELECT ON "HCO_D_FORM" TO "MAXDAT_READ_ONLY";
GRANT select, insert, update on HCO_D_FORM to MAXDAT_OLTP_SIU;
GRANT select, insert, update, delete on HCO_D_FORM to MAXDAT_OLTP_SIUD;

BEGIN
DBMS_ERRLOG.CREATE_ERROR_LOG ('HCO_D_FORM','ERRLOG_FORM');
END;
/


CREATE TABLE HCO_S_FORM_INCOMPLETE_STG
(DocumentBatchNum VARCHAR2(11),
FileReceivedFromHyland VARCHAR2(1),
CampaignCompleted VARCHAR2(1),
RecordCreateDate DATE,
DateLastModified DATE,
RecordCreateName VARCHAR2(50),
NameLastModified VARCHAR2(50),
BeneReasonID NUMBER,
EsrID  VARCHAR2(6),
VerifierID VARCHAR2(6),
ReasonCode VARCHAR2(3),
EnvelopeID VARCHAR2(20),
BeneficiaryID NUMBER(10),
FormReceivedDate DATE,
CaseRowID NUMBER(10),
ResidenceCounty VARCHAR2(10),
OCRRecordID NUMBER) TABLESPACE MAXDAT_DATA;

CREATE INDEX HCOSFORMINC_IDX01 ON HCO_S_FORM_INCOMPLETE_STG(DocumentBatchNum) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCOSFORMINC_IDX02 ON HCO_S_FORM_INCOMPLETE_STG(BeneReasonID ) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCOSFORMINC_IDX03 ON HCO_S_FORM_INCOMPLETE_STG(OCRRecordID ) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCOSFORMINC_IDX04 ON HCO_S_FORM_INCOMPLETE_STG(BeneficiaryID) TABLESPACE MAXDAT_INDX; 

CREATE TABLE HCO_D_FORM_INCOMPLETE
(DCN VARCHAR2(11),
File_Received_From_Hyland VARCHAR2(1),
Campaign_Completed VARCHAR2(1),
Record_Date DATE,
Modified_Date DATE,
Record_Name VARCHAR2(50),
Modified_Name VARCHAR2(50),
Bene_Reason_ID NUMBER,
Esr_ID  VARCHAR2(6),
Verifier_ID VARCHAR2(6),
Reason_Code VARCHAR2(3),
Envelope_ID VARCHAR2(20),
Client_Number NUMBER(10),
Form_Received_Date DATE,
Case_Number NUMBER(10),
Residence_County VARCHAR2(10),
OCR_Record_ID NUMBER) TABLESPACE MAXDAT_DATA;

CREATE INDEX HCODFORMINC_IDX01 ON HCO_D_FORM_INCOMPLETE(DCN) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORMINC_IDX02 ON HCO_D_FORM_INCOMPLETE(Bene_Reason_ID ) TABLESPACE MAXDAT_INDX; 
--CREATE INDEX HCODFORMINC_IDX03 ON HCO_D_FORM_INCOMPLETE(OCRRecordID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORMINC_IDX03 ON HCO_D_FORM_INCOMPLETE(Client_Number) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_FORM_INCOMPLETE" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_S_FORM_MANUAL_ENROLL_STG
(DCN  VARCHAR2(11),
 RecordCreateDate DATE,
 DateLastModified DATE, 
 RecordCreateName VARCHAR2(50),
 NameLastModified VARCHAR2(50),
 Processed VARCHAR2(1),
 ManualEnrID NUMBER(10),
 BeneficiaryID NUMBER(10),
 EID VARCHAR2(15),
 FormReceivedDate DATE,
 CaseRowID NUMBER(10),
 ResidenceCounty VARCHAR2(10),
 OCRRecordID NUMBER) TABLESPACE MAXDAT_DATA;

CREATE INDEX HCOSFORMMNLENR_IDX01 ON HCO_S_FORM_MANUAL_ENROLL_STG(DCN) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCOSFORMMNLENR_IDX02 ON HCO_S_FORM_MANUAL_ENROLL_STG(ManualEnrID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCOSFORMMNLENR_IDX03 ON HCO_S_FORM_MANUAL_ENROLL_STG(OCRRecordID) TABLESPACE MAXDAT_INDX;
CREATE INDEX HCOSFORMMNLENR_IDX04 ON HCO_S_FORM_MANUAL_ENROLL_STG(BeneficiaryID) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_S_FORM_MANUAL_ENROLL_STG" TO "MAXDAT_READ_ONLY";


CREATE TABLE HCO_D_FORM_MANUAL_ENROLL
(DCN  VARCHAR2(11),
 Record_Date DATE,
 Modified_Date DATE, 
 Record_Name VARCHAR2(50),
 Modified_Name VARCHAR2(50),
 Processed VARCHAR2(1),
 Manual_Enr_ID NUMBER(10),
 Client_Number NUMBER(10),
 EID VARCHAR2(15),
 Form_Received_Date DATE,
 Case_Number NUMBER(10),
 Residence_County VARCHAR2(10),
 OCR_Record_ID NUMBER) TABLESPACE MAXDAT_DATA;

CREATE INDEX HCODFORMMNLENR_IDX01 ON HCO_D_FORM_MANUAL_ENROLL(DCN) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODFORMMNLENR_IDX02 ON HCO_D_FORM_MANUAL_ENROLL(Manual_Enr_ID) TABLESPACE MAXDAT_INDX; 
--CREATE INDEX HCODFORMMNLENR_IDX03 ON HCO_D_FORM_MANUAL_ENROLL(OCRRecordID) TABLESPACE MAXDAT_INDX;
CREATE INDEX HCODFORMMNLENR_IDX04 ON HCO_D_FORM_MANUAL_ENROLL(Client_Number) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_FORM_MANUAL_ENROLL" TO "MAXDAT_READ_ONLY";


CREATE OR REPLACE TRIGGER "BUIR_HCO_D_FORM" 
 BEFORE INSERT
 ON hco_d_form
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_FORM.dp_form_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_form_id IS NULL THEN
      SElECT HCO_SEQ_FORMS_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_form_id   := v_seq_id;
    END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
  END IF; 
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_HCO_D_FORM;
/
ALTER TRIGGER "BUIR_HCO_D_FORM" ENABLE;
/

CREATE OR REPLACE VIEW HCO_D_FORM_SV
AS
WITH fmsv
AS (SELECT df.*
          ,cl.out_var sla_days
          ,dr.change_reason reason_code_desc
          ,ss.selection_source
          ,ss.selection_source_id
          ,CASE WHEN reference_type = 'OCRRECORD' THEN df.record_date
                WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
             ELSE processed_date END new_processed_date
          ,CASE WHEN TRUNC(CASE WHEN reference_type = 'OCRRECORD' THEN record_date
                WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
              ELSE processed_date END) >= date_form_received THEN 
                (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                 FROM D_DATES_SV
                 WHERE business_day_flag = 'Y'
                 AND d_date BETWEEN TRUNC(date_form_received) AND TRUNC(CASE WHEN reference_type = 'OCRRECORD' THEN df.record_date
                                                                             WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                                                                             WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
                                                                          ELSE processed_date END) ) ELSE 0 END days_to_process
          ,ROW_NUMBER() OVER (PARTITION BY dcn ORDER BY record_date DESC,processed_date NULLS LAST) frn                  
    FROM hco_d_form df
      JOIN corp_etl_list_lkup cl ON df.form_type = cl.name AND cl.list_type = 'FORM_SLA_DAYS'
      LEFT JOIN emrs_d_change_reason dr ON df.change_reason_code = dr.change_reason_code
      LEFT JOIN emrs_d_selection_source ss ON df.selection_source_code = ss.selection_source_code) 
SELECT reference_id ocr_record_id,
client_number,
date_form_received,
plan_type_a plan_type,
envelope_id,
form_incomplete,
form_manually_entered,
dcn,
form_phone_number,
form_type,
incomplete_reason_code_a incomplete_reason,
form_signed,
file_rcvd_from_hyland,
campaign_completed,
record_date,
record_name,
modified_name,
modified_date,
created_by,
date_created,
updated_by,
date_updated,
dp_form_id,
esr_id,
verifier_id,
new_processed_date processed_date,
CASE WHEN processed_date IS NULL THEN 'Not Processed'
  ELSE CASE WHEN days_to_process <= sla_days THEN 'Timely' ELSE 'Untimely' END END timeliness_status,
days_to_process cycle_time,
sla_days,
days_to_process,
CASE WHEN days_to_process <= sla_days THEN 'Y' ELSE 'N' END meet_sla_flag,
created_by_agent_flag,
date_form_received arrival_date,
plan_id_a plan_id,
plan_originated_flag,
county_code,
change_reason_code reason_code,
reason_code_desc,
notes,
case_number,
enrollment_id,
selection_source,
selection_source_id
FROM fmsv
WHERE frn = 1
  ;

GRANT SELECT ON "HCO_D_FORM_SV" TO "MAXDAT_READ_ONLY";



