CREATE SEQUENCE  "EMRS_SEQ_COA_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_COA_ID" TO &role_name;

CREATE TABLE EMRS_D_CATEGORY_OF_ASSISTANCE
   (COA_ID NUMBER NOT NULL, 
    COA_CODE VARCHAR2(32),
    COA_DESCRIPTION VARCHAR2(240)  
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_CATEGORY_OF_ASSISTANCE" ADD CONSTRAINT "COA_COMB_UK" UNIQUE ("COA_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_CATEGORY_OF_ASSISTANCE" ADD CONSTRAINT "COAPK" PRIMARY KEY ("COA_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_CATEGORY_OF_ASSISTANCE" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_COA" 
 BEFORE INSERT
 ON emrs_d_category_of_assistance
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CATEGORY_OF_ASSISTANCE.coa_id%TYPE;
BEGIN
  IF :NEW.coa_id IS NULL THEN
    SElECT EMRS_SEQ_COA_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.coa_id       := v_seq_id;
  END IF;
END BIR_COA;
/
ALTER TRIGGER "BIR_COA" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_COA_SV
AS
SELECT coa_code coa_cd
       ,coa_description
FROM emrs_d_category_of_assistance;

GRANT SELECT ON "EMRS_D_COA_SV" TO &role_name;
