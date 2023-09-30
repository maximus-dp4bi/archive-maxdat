CREATE SEQUENCE  "EMRS_SEQ_PLAN_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PLAN_ID" TO &role_name;

CREATE TABLE EMRS_D_PLAN
   (DP_PLAN_ID NUMBER NOT NULL,      
    PLAN_ID	NUMBER(18,0),
    PLAN_CODE	VARCHAR2(32),
    PLAN_ID_EXT	VARCHAR2(30),
    PLAN_NAME	VARCHAR2(64),
    PLAN_ABBREVIATION	VARCHAR2(64),
    MANAGED_CARE_PROGRAM	VARCHAR2(32),
    PLAN_SERVICE_TYPE_CD	VARCHAR2(32),
    PLAN_EFFECTIVE_DATE	DATE,
    CONTACT_FIRST_NAME	VARCHAR2(64),
    CONTACT_MIDDLE_NAME	VARCHAR2(64),
    CONTACT_LAST_NAME	VARCHAR2(64),
    CONTACT_FULL_NAME	VARCHAR2(200),
    ADDRESS1	VARCHAR2(64),
    ADDRESS2	VARCHAR2(55),
    CITY	VARCHAR2(64),
    STATE	VARCHAR2(2),
    ZIP	VARCHAR2(32),
    CONTACT_PHONE	VARCHAR2(15),
    ACTIVE	VARCHAR2(2),
    ENROLLOK	VARCHAR2(2),
    PLAN_ASSIGN	VARCHAR2(2),
    PLAN_TYPE	VARCHAR2(32),
    RECORD_DATE	DATE,
    RECORD_TIME	VARCHAR2(10),
    RECORD_NAME	VARCHAR2(80)
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLANS_COMB_UK" UNIQUE ("PLAN_ID") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLANSPK" PRIMARY KEY ("DP_PLAN_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_PLAN" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_PLANS"
 BEFORE INSERT
 ON emrs_d_plan
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN.dp_plan_id%TYPE;
BEGIN
  IF :NEW.dp_plan_id IS NULL THEN
    SElECT EMRS_SEQ_PLAN_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.dp_plan_id       := v_seq_id;
  END IF;
END BIR_PLANS;
/
ALTER TRIGGER "BIR_PLANS" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
SELECT plan_id
      ,plan_code
      ,plan_name
      ,plan_abbreviation
      ,managed_care_program
      ,plan_service_type_cd
      ,plan_effective_date
      ,contact_first_name
      ,contact_middle_name
      ,contact_last_name
      ,contact_full_name
      ,address1
      ,address2
      ,city
      ,state
      ,zip
      ,contact_phone
      ,active
      ,enrollok
      ,plan_assign
      ,plan_type
      ,record_date
      ,record_time
      ,record_name
FROM emrs_d_plan;

GRANT SELECT ON "EMRS_D_PLAN_SV" TO &role_name;
