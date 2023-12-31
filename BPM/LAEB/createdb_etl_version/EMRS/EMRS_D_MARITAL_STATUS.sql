CREATE SEQUENCE  "EMRS_SEQ_MARITALSTATUS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_MARITALSTATUS_ID" TO &role_name;

CREATE TABLE EMRS_D_MARITAL_STATUS
   (MARITAL_STATUS_ID NUMBER NOT NULL, 
    MARITAL_STATUS_CODE VARCHAR2(32),
    MARITAL_STATUS VARCHAR2(240),
    EFFECTIVE_START_DATE DATE,
    EFFECTIVE_END_DATE DATE
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_MARITAL_STATUS" ADD CONSTRAINT "MARITALSTAT_COMB_UK" UNIQUE ("MARITAL_STATUS_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_MARITAL_STATUS" ADD CONSTRAINT "MARITALSTATPK" PRIMARY KEY ("MARITAL_STATUS_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_MARITAL_STATUS" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_MARITAL_STATUS" 
 BEFORE INSERT
 ON emrs_d_marital_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_MARITAL_STATUS.marital_status_id%TYPE;
BEGIN
  IF :NEW.marital_status_id IS NULL THEN
    SElECT EMRS_SEQ_MARITALSTATUS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.marital_status_id       := v_seq_id;
  END IF;
END BIR_MARITAL_STATUS;
/
ALTER TRIGGER "BIR_MARITAL_STATUS" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_MARITAL_STATUS_SV
AS
SELECT marital_status_code marital_status_cd
       ,marital_status
       ,effective_start_date
       ,effective_end_date
FROM emrs_d_marital_status;

GRANT SELECT ON "EMRS_D_MARITAL_STATUS_SV" TO &role_name;
