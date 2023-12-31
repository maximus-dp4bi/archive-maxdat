CREATE SEQUENCE  "EMRS_SEQ_CHANGE_REASON_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 92481 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CHANGE_REASON_ID" TO &role_name;

CREATE TABLE EMRS_D_CHANGE_REASON
   (CHANGE_REASON_ID NUMBER NOT NULL, 	
    CHANGE_REASON_CODE VARCHAR2(80), 	  
    CHANGE_REASON VARCHAR2(500)	,
    CHANGE_REASON_CODE_PLAN VARCHAR2(240)    
   ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_CHANGE_REASON" ADD CONSTRAINT "CHGREASON_PLAN_REASON_UK" UNIQUE ("CHANGE_REASON_CODE", "CHANGE_REASON_CODE_PLAN") USING INDEX TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_CHANGE_REASON" ADD CONSTRAINT "CHGREASON_PK" PRIMARY KEY ("CHANGE_REASON_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_CHANGE_REASON" TO &role_name;

 CREATE OR REPLACE TRIGGER "BIR_CHANGE_REASONS" 
 BEFORE INSERT
 ON emrs_d_change_reason
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CHANGE_REASON.change_reason_id%TYPE;
BEGIN
  IF :NEW.change_reason_id IS NULL THEN
    SElECT EMRS_SEQ_CHANGE_REASON_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.change_reason_id       := v_seq_id;
  END IF;
END BIR_CHANGE_REASONS;
/
ALTER TRIGGER "BIR_CHANGE_REASONS" ENABLE;
/


CREATE OR REPLACE VIEW EMRS_D_CHANGE_REASON_SV
AS
SELECT change_reason_code
       ,change_reason
       ,change_reason_code_plan   
FROM emrs_d_change_reason;

GRANT SELECT ON "EMRS_D_CHANGE_REASON_SV" TO &role_name;

