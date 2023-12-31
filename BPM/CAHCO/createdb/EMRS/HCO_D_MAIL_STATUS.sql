CREATE SEQUENCE  "HCO_SEQ_MAILSTAT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_MAILSTAT_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_D_MAIL_STATUS
  (MAIL_STATUS_ID NUMBER, 	 
	 MAIL_STATUS_CODE VARCHAR2(64), 	
   MAIL_STATUS VARCHAR2(240),   
   DP_MAIL_STATUS_ID NUMBER NOT NULL
   ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "HCO_D_MAIL_STATUS" ADD CONSTRAINT "MAILSTAT_MLSTATUSID_UK" UNIQUE ("MAIL_STATUS_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE; 
ALTER TABLE "HCO_D_MAIL_STATUS" ADD CONSTRAINT "MAILSTATUS_PK" PRIMARY KEY ("DP_MAIL_STATUS_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
  
GRANT SELECT ON "HCO_D_MAIL_STATUS" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_MAILSTATUS" 
 BEFORE INSERT
 ON hco_d_mail_status
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_MAIL_STATUS.dp_mail_status_id%TYPE;
BEGIN
  IF :NEW.dp_mail_status_id IS NULL THEN
    SElECT HCO_SEQ_MAILSTAT_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.dp_mail_status_id       := v_seq_id;
  END IF;
END BIR_MAILSTATUS;
/
ALTER TRIGGER "BIR_MAILSTATUS" ENABLE;
/

CREATE OR REPLACE VIEW HCO_D_MAIL_STATUS_SV
AS
SELECT mail_status_id
       ,mail_status_code
       ,mail_status       
FROM hco_d_mail_status;

GRANT SELECT ON "HCO_D_MAIL_STATUS_SV" TO "MAXDAT_READ_ONLY";
