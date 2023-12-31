CREATE SEQUENCE  "EMRS_SEQ_CLNT_PLAN_ELIG_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLNT_PLAN_ELIG_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_D_CLIENT_PLAN_ELIG
(DP_CLIENT_PLAN_ELIG_ID NUMBER NOT NULL, 
CLIENT_ELIG_STATUS_ID NUMBER,
PLAN_TYPE VARCHAR2(32), 
ELIGIBILITY_STATUS_CODE VARCHAR2(80), 
CURRENT_ELIGIBILITY_STATUS_CD VARCHAR2(80), 
DATE_OF_VALIDITY_START DATE, 
DATE_OF_VALIDITY_END DATE, 
CLIENT_NUMBER NUMBER, 
SUB_PROGRAM VARCHAR2(32),
CREATED_BY VARCHAR2(30), 
DATE_CREATED DATE, 
DATE_UPDATED DATE, 
UPDATED_BY VARCHAR2(18), 
CURRENT_FLAG VARCHAR2(1), 
VERSION NUMBER, 
MODIFIED_DATE DATE,
MODIFIED_NAME VARCHAR2(240),
RECORD_NAME VARCHAR2(240),
RECORD_DATE DATE
 ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_D_CLIENT_PLAN_ELIG" ADD CONSTRAINT "ELIGSTAT_ELIGSTATUS_ID" UNIQUE ("CLIENT_ELIG_STATUS_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE; 
ALTER TABLE "EMRS_D_CLIENT_PLAN_ELIG" ADD CONSTRAINT "ELIGTATUS_PLANELIG_ID" PRIMARY KEY ("DP_CLIENT_PLAN_ELIG_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
  
GRANT SELECT ON "EMRS_D_CLIENT_PLAN_ELIG" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_CLIENT_PLAN_ELIGIBILITY" 
 BEFORE INSERT OR UPDATE
 ON emrs_d_client_plan_elig
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_PLAN_ELIG.dp_client_plan_elig_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_client_plan_elig_id IS NULL THEN
      SElECT EMRS_SEQ_CLNT_PLAN_ELIG_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_client_plan_elig_id       := v_seq_id;
    END IF;
    :NEW.created_by := user;
    :NEW.date_created := sysdate;
  END IF;  
  
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

END BUIR_CLIENT_PLAN_ELIGIBILITY;
/
ALTER TRIGGER "BUIR_CLIENT_PLAN_ELIGIBILITY" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
SELECT dp_client_plan_elig_id,
plan_type, 
eligibility_status_code, 
current_eligibility_status_cd, 
date_of_validity_start, 
date_of_validity_end, 
client_number, 
sub_program,
created_by, 
date_created, 
date_updated, 
updated_by, 
current_flag, 
version, 
modified_date,
modified_name,
record_name,
record_date
FROM emrs_d_client_plan_elig;

GRANT SELECT ON "EMRS_D_CLIENT_PLAN_ELIG_SV" TO "MAXDAT_READ_ONLY";

