CREATE SEQUENCE  "EMRS_SEQ_COUNTIES_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 10216 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_COUNTIES_ID" TO &role_name;

CREATE TABLE EMRS_D_COUNTY
  (COUNTY_ID NUMBER NOT NULL, 
   COUNTY_CODE VARCHAR2(32), 
   COUNTY_NAME VARCHAR2(240), 
   COUNTY_FIPS_CODE VARCHAR2(32), 
   DISTRICT_ID VARCHAR2(32),
   STATE VARCHAR2(17), 
   STATUS VARCHAR2(1),
   MODIFIED_DATE DATE,
   MODIFIED_TIME VARCHAR2(6),
   MODIFIED_NAME VARCHAR2(80) ) TABLESPACE &tablespace_name ;

ALTER TABLE "EMRS_D_COUNTY" ADD CONSTRAINT "CNTY_CNTY_COMB_UK" UNIQUE ("COUNTY_CODE") USING INDEX TABLESPACE &tablespace_name  ENABLE; 
ALTER TABLE "EMRS_D_COUNTY" ADD CONSTRAINT "CNTY_PK" PRIMARY KEY ("COUNTY_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_COUNTY" TO &role_name;

  CREATE OR REPLACE TRIGGER "BIR_COUNTIES" 
 BEFORE INSERT
 ON emrs_d_county
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_COUNTY.county_id%TYPE;
BEGIN
  IF :NEW.county_id IS NULL THEN
    SElECT EMRS_SEQ_COUNTIES_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.county_id       := v_seq_id;
  END IF;
END BIR_COUNTIES;
/
ALTER TRIGGER "BIR_COUNTIES" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
SELECT county_code
       ,county_fips_code
       ,county_name       
       ,district_id
       ,state
       ,status
       ,modified_date
       ,modified_time
       ,modified_name
FROM emrs_d_county;

GRANT SELECT ON "EMRS_D_COUNTY_SV" TO &role_name;

