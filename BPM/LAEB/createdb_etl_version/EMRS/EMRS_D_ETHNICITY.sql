CREATE SEQUENCE  "EMRS_SEQ_ETHNICITY_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ETHNICITY_ID" TO &role_name;

CREATE TABLE EMRS_D_ETHNICITY
   (ETHNICITY_ID NUMBER NOT NULL, 
    ETHNICITY_CODE VARCHAR2(32),
    ETHNICITY VARCHAR2(240),
    EFFECTIVE_START_DATE DATE,
    EFFECTIVE_END_DATE DATE
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_ETHNICITY" ADD CONSTRAINT "ETHNICITY_COMB_UK" UNIQUE ("ETHNICITY_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_ETHNICITY" ADD CONSTRAINT "ETHNICITYPK" PRIMARY KEY ("ETHNICITY_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_ETHNICITY" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_ETHNICITY" 
 BEFORE INSERT
 ON emrs_d_ethnicity
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ETHNICITY.ethnicity_id%TYPE;
BEGIN
  IF :NEW.ethnicity_id IS NULL THEN
    SElECT EMRS_SEQ_ETHNICITY_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.ethnicity_id       := v_seq_id;
  END IF;
END BIR_ETHNICITY;
/
ALTER TRIGGER "BIR_ETHNICITY" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_ETHNICITY_SV
AS
SELECT ethnicity_code client_ethnicity
       ,ethnicity
       ,effective_start_date
       ,effective_end_date
FROM emrs_d_ethnicity;

GRANT SELECT ON "EMRS_D_ETHNICITY_SV" TO &role_name;
