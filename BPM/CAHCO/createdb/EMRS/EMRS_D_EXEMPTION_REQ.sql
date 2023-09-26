CREATE SEQUENCE  "EMRS_SEQ_EXEMPTION_REQ_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 341 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_EXEMPTION_REQ_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_D_EXEMPTION_REQ
(
  exemption_id            NUMBER,
  client_number           NUMBER,
  plan_type               VARCHAR2(32),
  selection_source_code   VARCHAR2(32),
  exemption_end_date      DATE,
  county_code             VARCHAR2(32),
  zip_code                VARCHAR2(10),
  aid_category_code       VARCHAR2(32),
  dcn                     VARCHAR2(64),
  enrollment_status       VARCHAR2(32),
  maximus_status          VARCHAR2(32),
  exemption_reason_code   VARCHAR2(32),
  eder_ind                VARCHAR2(10),
  record_date             DATE,
  record_name             VARCHAR2(240),
  modified_by             VARCHAR2(240),
  modified_date           DATE,
  diagnosis_code          VARCHAR2(32),
  disposition_date        DATE,
  pregnancy_due_date      DATE,
  provider_signed         VARCHAR2(10),
  provider_dated          VARCHAR2(10),
  beneficiary_signed      VARCHAR2(10),
  beneficiary_dated       VARCHAR2(10),
  treatment_start_date    DATE,
  treatment_end_date      DATE,
 -- eligibility_status_key  VARCHAR2(32),
 -- enrollment_status_key   VARCHAR2(32),
  fax_number              VARCHAR2(20),
  phone_number            VARCHAR2(20),
  form_filled_by_other    VARCHAR2(10),
  form_filled_by_name     VARCHAR2(10),
  form_filled_by_relation VARCHAR2(10),
  form_filled_by_phone    VARCHAR2(10),
  state_fair_hearing_date DATE,
  tar_attached            VARCHAR2(10),
  new_doc_attached        VARCHAR2(10),
  dflt_path_ext_iamail_id VARCHAR2(10),
  icd_codes               VARCHAR2(32),
  provider_phone          VARCHAR2(20),
  provider_fax            VARCHAR2(20),
  provider_address        VARCHAR2(240),
  provider_affiliation    VARCHAR2(240),
  provider_license        VARCHAR2(32),
  provider_npi            VARCHAR2(32),
  notes                   VARCHAR2(4000),
  change_reason_code      VARCHAR2(32),
  created_by              VARCHAR2(80),
  date_created            DATE,
  updated_by              VARCHAR2(80),
  date_updated            DATE,
  dp_exemption_req_id     NUMBER not null,
  new_status_date         DATE,
  pending_status_date     DATE,
  approved_status_date    DATE,
  denial_status_date      DATE,
  exemption_status_code   VARCHAR2(2),
  disenrollment_id        NUMBER(10)
) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_D_EXEMPTION_REQ" ADD CONSTRAINT "EXEMPT_EXEMPTID_UK" UNIQUE ("EXEMPTION_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE; 
ALTER TABLE "EMRS_D_EXEMPTION_REQ" ADD CONSTRAINT "EXEMPT_EXEMPTREQID_PK" PRIMARY KEY ("DP_EXEMPTION_REQ_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;

CREATE INDEX IDX01_EMRSDEXEMPT ON EMRS_D_EXEMPTION_REQ(exemption_status_code) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_EMRSDEXEMPT ON EMRS_D_EXEMPTION_REQ(plan_type) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX03_EMRSDEXEMPT ON EMRS_D_EXEMPTION_REQ(TRUNC(record_date)) TABLESPACE MAXDAT_INDX;
  
GRANT SELECT ON "EMRS_D_EXEMPTION_REQ" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_EXEMPTION_REQ" 
 BEFORE INSERT OR UPDATE
 ON emrs_d_exemption_req
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_EXEMPTION_REQ.dp_exemption_req_id%TYPE;
BEGIN
  IF INSERTING THEN  
    IF :NEW.dp_exemption_req_id IS NULL THEN
      SElECT EMRS_SEQ_EXEMPTION_REQ_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_exemption_req_id       := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUIR_EXEMPTION_REQ;
/
ALTER TRIGGER "BUIR_EXEMPTION_REQ" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_EXEMPTION_REQ_SV
AS
SELECT exemption_id,
client_number,
plan_type,
selection_source_code,
exemption_end_date,
county_code,
zip_code,
aid_category_code,
dcn,
exemption_status_code,
enrollment_status,
maximus_status,
exemption_reason_code,
eder_ind,
record_date,
record_name,
modified_by,
modified_date,
diagnosis_code,
disposition_date,
pregnancy_due_date,
provider_signed,
provider_dated,
beneficiary_signed,
beneficiary_dated,
treatment_start_date,
treatment_end_date,
--eligibility_status_key,
--enrollment_status_key,
fax_number,
phone_number,
form_filled_by_other,
form_filled_by_name,
form_filled_by_relation,
form_filled_by_phone,
state_fair_hearing_date,
tar_attached,
new_doc_attached,
dflt_path_ext_iamail_id,
icd_codes,
provider_phone,
provider_fax,
provider_address,
provider_affiliation,
provider_license,
provider_npi,
notes,
change_reason_code,
created_by,
date_created,
updated_by,
date_updated,
new_status_date,
pending_status_date,
approved_status_date,
denial_status_date,
dp_exemption_req_id,
disenrollment_id,
CASE WHEN approved_status_date IS NOT NULL THEN approved_status_date
     WHEN denial_status_date IS NOT NULL THEN denial_status_date
ELSE null END final_status_date
FROM emrs_d_exemption_req;

GRANT SELECT ON "EMRS_D_EXEMPTION_REQ_SV" TO "MAXDAT_READ_ONLY";
