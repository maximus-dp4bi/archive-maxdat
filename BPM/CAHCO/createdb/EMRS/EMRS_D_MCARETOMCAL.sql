CREATE SEQUENCE  "EMRS_SEQ_MCARE_MCAL_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 2 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_MCARE_MCAL_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_D_MCARETOMCAL(
    MCARE_MCAL_ID NUMBER NOT NULL,
	MCARE_PLAN_COUNTY VARCHAR2(2),
	MCARE_CARRIER_CODE VARCHAR2(4),
	MCARE_PLAN_NAME VARCHAR2(50),
	ALLOW_ENROLLMENTS VARCHAR2(1),
	MCAL_PLAN_ID VARCHAR2(3)) TABLESPACE MAXDAT_DATA ;

-- ALTER TABLE "EMRS_D_MCARETOMCAL" ADD CONSTRAINT "MCARE_PLAN_CNTY_CARRIER_CD_UK" UNIQUE ("MCARE_PLAN_COUNTY", "MCARE_CARRIER_CODE") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE; 
-- ALTER TABLE "EMRS_D_MCARETOMCAL" ADD CONSTRAINT "MCARE_MCAL_ID_PK" PRIMARY KEY ("MCARE_MCAL_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
  
GRANT SELECT ON "EMRS_D_MCARETOMCAL" TO "MAXDAT_READ_ONLY";
GRANT SELECT, INSERT, UPDATE ON EMRS_D_MCARETOMCAL TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON EMRS_D_MCARETOMCAL TO MAXDAT_OLTP_SIUD;

CREATE OR REPLACE TRIGGER "BIR_MCARETOMCAL" 
 BEFORE INSERT
 ON EMRS_D_MCARETOMCAL
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_MCARETOMCAL.MCARE_MCAL_ID%TYPE;
BEGIN
  IF :NEW.MCARE_MCAL_ID IS NULL THEN
    SElECT EMRS_SEQ_MCARE_MCAL_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.MCARE_MCAL_ID       := v_seq_id;
  END IF;
END BIR_MCARETOMCAL;
/
ALTER TRIGGER "BIR_MCARETOMCAL" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_MCARETOMCAL_SV
AS
SELECT  MCARE_MCAL_ID
       ,MCARE_PLAN_COUNTY
       ,MCARE_CARRIER_CODE
       ,MCARE_PLAN_NAME
       ,MCAL_PLAN_ID
       ,ALLOW_ENROLLMENTS
FROM EMRS_D_MCARETOMCAL;

GRANT SELECT ON "EMRS_D_MCARETOMCAL_SV" TO "MAXDAT_READ_ONLY";



