CREATE SEQUENCE  "EMRS_SEQ_PLANS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 92481 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PLANS_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE EMRS_D_PLAN
   (DP_PLAN_ID NUMBER NOT NULL,
    PLAN_ID VARCHAR2(32), 		  
	  PLAN_CODE VARCHAR2(32), 
	  PLAN_NAME VARCHAR2(240), 
	  PLAN_ABBREVIATION VARCHAR2(64), 
	  PLAN_EFFECTIVE_DATE DATE, 
	  ADDRESS1 VARCHAR2(55), 
	  ADDRESS2 VARCHAR2(55), 
	  CITY VARCHAR2(20), 
	  STATE VARCHAR2(2), 
	  ZIP VARCHAR2(9), 
	  ACTIVE VARCHAR2(1), 	
	  ENROLLOK VARCHAR2(1), 
	  PLAN_ASSIGN VARCHAR2(1), 
	  RECORD_DATE DATE, 	  
    PLAN_TYPE VARCHAR2(32),  
    PLAN_SERVICE_TYPE VARCHAR2(20),
    CURRENT_CAPITATED_ENROLL NUMBER,
    CURRENT_CAPITATED_ENROLL_DATE DATE,
    PLAN_SUB_TYPE VARCHAR2(10),
    COUNTY_GROUP VARCHAR2(10),
    COUNTY_CODE VARCHAR2(32),
    CPLI_PLAN_TYPE VARCHAR2(1),
    IS_GMC_PLAN_COUNTY VARCHAR2(1)
   ) TABLESPACE MAXDAT_DATA ;

 ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLAN_ID_UK" UNIQUE ("PLAN_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
 ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "DPPLANID_PK" PRIMARY KEY ("DP_PLAN_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
 
 CREATE INDEX EMRSDPLAN_IDX01 ON EMRS_D_PLAN (COUNTY_CODE) TABLESPACE MAXDAT_INDX;    
 CREATE INDEX EMRSDPLAN_IDX02 ON EMRS_D_PLAN (CPLI_PLAN_TYPE) TABLESPACE MAXDAT_INDX;    
  
GRANT SELECT ON "EMRS_D_PLAN" TO "MAXDAT_READ_ONLY";


CREATE OR REPLACE TRIGGER "BIR_PLANS" 
 BEFORE INSERT
 ON emrs_d_plan
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN.dp_plan_id%TYPE;
BEGIN
  IF :NEW.dp_plan_id IS NULL THEN
    SElECT EMRS_SEQ_PLANS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.dp_plan_id       := v_seq_id;
  END IF;
  
  INSERT INTO emrs_d_plan_history(date_of_validity_start
       ,date_of_validity_end
       ,current_plan_id
       ,capitated_enroll
       ,capitated_enroll_date)
  VALUES(:new.record_date,TO_DATE('12/31/2050','mm/dd/yyyy'),:new.plan_id,:new.current_capitated_enroll,:new.current_capitated_enroll_date)       ;
  
END BIR_PLANS;
/
ALTER TRIGGER "BIR_PLANS" ENABLE;
/


CREATE OR REPLACE TRIGGER "BUR_PLAN" 
 BEFORE UPDATE
 ON emrs_d_plan
 FOR EACH ROW
DECLARE
    
BEGIN
  
  IF COALESCE(:new.current_capitated_enroll,0) != COALESCE(:old.current_capitated_enroll,0)
     OR COALESCE(:new.current_capitated_enroll_date,TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(:old.current_capitated_enroll_date,TO_DATE('07/07/7777','mm/dd/yyyy')) THEN
  
    UPDATE emrs_d_plan_history
    SET date_of_validity_end = TRUNC(sysdate)-1
    WHERE current_plan_id = :new.plan_id
    AND date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy');
  
    INSERT INTO emrs_d_plan_history(date_of_validity_start
         ,date_of_validity_end
         ,current_plan_id
         ,capitated_enroll
         ,capitated_enroll_date)
    VALUES(TRUNC(sysdate),TO_DATE('12/31/2050','mm/dd/yyyy'),:new.plan_id,:new.current_capitated_enroll,:new.current_capitated_enroll_date)       ;
 END IF; 
END BUR_PLAN;
/
ALTER TRIGGER "BUR_PLAN" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
SELECT p.*
      ,CASE WHEN cpli_plan_type = 'C' AND plan_type = 'M' 
        AND is_gmc_plan_county = 'N' AND is_two_plan_county = 'N' THEN 'Y' ELSE 'N' END is_commercial_plan_county
FROM(      
SELECT plan_id, 		  
       plan_code, 
       plan_name, 
       plan_abbreviation, 
       plan_effective_date, 
       address1, 
       address2, 
       city, 
       state, 
       zip, 
       active, 	
       enrollok, 
       plan_assign, 
       record_date, 	  
       plan_type,  
       plan_service_type,
       current_capitated_enroll,
       current_capitated_enroll_date,
       plan_sub_type,
       county_group,
       county_code,
       cpli_plan_type,
       is_gmc_plan_county,
       CASE WHEN is_gmc_plan_county = 'N' AND plan_type = 'M' 
         AND EXISTS(SELECT 1 FROM emrs_d_plan p WHERE p.county_code = dp.county_code AND p.plan_type = 'M' AND p.cpli_plan_type = 'C')
         AND EXISTS(SELECT 1 FROM emrs_d_plan p WHERE p.county_code = dp.county_code AND p.plan_type = 'M' AND p.cpli_plan_type = 'L')
       THEN 'Y' ELSE 'N' END is_two_plan_county       
FROM emrs_d_plan dp ) p;

GRANT SELECT ON "EMRS_D_PLAN_SV" TO "MAXDAT_READ_ONLY";
