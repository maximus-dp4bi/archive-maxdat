CREATE SEQUENCE  "EMRS_SEQ_ENRL_ERROR_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ENRL_ERROR_ID" TO &role_name;

CREATE TABLE EMRS_D_ENROLLMENT_ERROR_CODE
   (ENROLLMENT_ERROR_ID NUMBER NOT NULL, 
    ENROLLMENT_ERROR_CODE VARCHAR2(32),
    ENROLLMENT_ERROR VARCHAR2(240)  
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_ENROLLMENT_ERROR_CODE" ADD CONSTRAINT "ENRLERROR_COMB_UK" UNIQUE ("ENROLLMENT_ERROR_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_ENROLLMENT_ERROR_CODE" ADD CONSTRAINT "ENRLERRORPK" PRIMARY KEY ("ENROLLMENT_ERROR_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_ENROLLMENT_ERROR_CODE" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_ENRLERROR" 
 BEFORE INSERT
 ON emrs_d_enrollment_error_code
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ENROLLMENT_ERROR_CODE.enrollment_error_id%TYPE;
BEGIN
  IF :NEW.enrollment_error_id IS NULL THEN
    SElECT EMRS_SEQ_ENRL_ERROR_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.enrollment_error_id       := v_seq_id;
  END IF;
END BIR_ENRLERROR;
/
ALTER TRIGGER "BIR_ENRLERROR" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
SELECT enrollment_error_code
       ,enrollment_error
FROM emrs_d_enrollment_error_code;

GRANT SELECT ON "EMRS_D_ENROLLMENT_ERROR_CD_SV" TO &role_name;