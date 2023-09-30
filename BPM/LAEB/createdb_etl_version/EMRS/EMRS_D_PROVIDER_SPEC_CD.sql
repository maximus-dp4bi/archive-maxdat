CREATE SEQUENCE  "EMRS_SEQ_PROVSPEC_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PROVSPEC_ID" TO &role_name;

CREATE TABLE EMRS_D_PROVIDER_SPECIALTY_CODE
   (PROVIDER_SPECIALTY_ID NUMBER NOT NULL, 
    PROVIDER_SPECIALTY_CODE VARCHAR2(32),
    PROVIDER_SPECIALTY VARCHAR2(240),
    EFFECTIVE_START_DATE DATE,
    EFFECTIVE_END_DATE DATE
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_PROVIDER_SPECIALTY_CODE" ADD CONSTRAINT "PROVSPEC_COMB_UK" UNIQUE ("PROVIDER_SPECIALTY_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_PROVIDER_SPECIALTY_CODE" ADD CONSTRAINT "PROVSPECPK" PRIMARY KEY ("PROVIDER_SPECIALTY_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_PROVIDER_SPECIALTY_CODE" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_PROVSPECID" 
 BEFORE INSERT
 ON emrs_d_provider_specialty_code
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PROVIDER_SPECIALTY_CODE.provider_specialty_id%TYPE;
BEGIN
  IF :NEW.provider_specialty_id IS NULL THEN
    SElECT EMRS_SEQ_PROVSPEC_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.provider_specialty_id       := v_seq_id;
  END IF;
END BIR_PROVSPECID;
/
ALTER TRIGGER "BIR_PROVSPECID" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPEC_CD_SV
AS
SELECT provider_specialty_code
       ,provider_specialty
       ,effective_start_date
       ,effective_end_date
FROM emrs_d_provider_specialty_code;

GRANT SELECT ON "EMRS_D_PROVIDER_SPEC_CD_SV" TO &role_name;