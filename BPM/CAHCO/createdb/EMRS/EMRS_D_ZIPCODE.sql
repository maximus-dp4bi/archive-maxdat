CREATE SEQUENCE "EMRS_SEQ_ZIPCODE_ID" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 86401 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ZIPCODE_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_D_ZIPCODE
  (ZIPCODE_ID NUMBER NOT NULL, 
	 ZIP_CODE VARCHAR2(32), 
	 ZIP_CITY VARCHAR2(64), 	
   ZIP_COUNTY VARCHAR2(64),
	 ZIP_STATE VARCHAR2(32),
   COVERS_MULTIPLE_COUNTY VARCHAR2(1)
   ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_D_ZIPCODE" ADD CONSTRAINT "ZIP_CODE_UK" UNIQUE ("ZIP_CODE","ZIP_COUNTY") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE; 
ALTER TABLE "EMRS_D_ZIPCODE" ADD CONSTRAINT "ZIPCODEPK" PRIMARY KEY ("ZIPCODE_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
  
GRANT SELECT ON "EMRS_D_ZIPCODE" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_ZIPCODE" 
 BEFORE INSERT
 ON emrs_d_zipcode
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ZIPCODE.zipcode_id%TYPE;
BEGIN
  IF :NEW.zipcode_id IS NULL THEN
    SElECT EMRS_SEQ_ZIPCODE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.zipcode_id   := v_seq_id;
  END IF;
END BIR_ZIPCODE;
/
ALTER TRIGGER "BIR_ZIPCODE" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_ZIPCODE_SV
AS
SELECT zipcode_id
       ,zip_code
       ,zip_city
       ,zip_county
       ,zip_state
       ,covers_multiple_county
FROM emrs_d_zipcode;

GRANT SELECT ON "EMRS_D_ZIPCODE_SV" TO "MAXDAT_READ_ONLY";