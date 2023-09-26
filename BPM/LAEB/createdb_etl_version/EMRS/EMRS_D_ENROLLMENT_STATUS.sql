CREATE SEQUENCE  "EMRS_SEQ_ENROLLMENT_STATUS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 92481 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ENROLLMENT_STATUS_ID" TO &role_name;

CREATE TABLE EMRS_D_ENROLLMENT_STATUS
 (ENROLLMENT_STATUS_ID NUMBER(22,0), 
	ENROLLMENT_STATUS_CODE VARCHAR2(32), 
	ENROLLMENT_STATUS_DESC VARCHAR2(256), 
	IS_AA_PCE_IND NUMBER(2,0), 
	IS_MANDATORY_UNASSIGN_IND NUMBER(2,0) 
   ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_ENROLLMENT_STATUS" ADD CONSTRAINT "ENRLSTATUS_UK" UNIQUE ("ENROLLMENT_STATUS_CODE") USING INDEX TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_ENROLLMENT_STATUS" ADD CONSTRAINT "ENRLSTATUSPK" PRIMARY KEY ("ENROLLMENT_STATUS_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_ENROLLMENT_STATUS" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_ENROLLMENT_STATUS" 
 BEFORE INSERT
 ON emrs_d_enrollment_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ENROLLMENT_STATUS.enrollment_status_id%TYPE;
BEGIN
  IF :NEW.enrollment_status_id IS NULL THEN
    SElECT EMRS_SEQ_ENROLLMENT_STATUS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.enrollment_status_id   := v_seq_id;
  END IF;
END BIR_ENROLLMENT_STATUS;
/
ALTER TRIGGER "BIR_ENROLLMENT_STATUS" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_STATUS_SV
AS
SELECT enrollment_status_code
       ,enrollment_status_desc
       ,is_aa_pce_ind
       ,is_mandatory_unassign_ind
FROM emrs_d_enrollment_status;

GRANT SELECT ON "EMRS_D_ENROLLMENT_STATUS_SV" TO &role_name;

