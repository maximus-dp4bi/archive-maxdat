CREATE SEQUENCE  "EMRS_SEQ_PLANSVCTYPE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1061 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_PLANSVCTYPE_ID" TO &role_name;

CREATE TABLE EMRS_D_PLAN_SERVICE_TYPE
   (PLAN_SERVICE_TYPE_ID NUMBER NOT NULL, 
    PLAN_SERVICE_TYPE_CODE VARCHAR2(32),
    PLAN_SERVICE_TYPE VARCHAR2(240)    
	  ) TABLESPACE &tablespace_name ;

 ALTER TABLE "EMRS_D_PLAN_SERVICE_TYPE" ADD CONSTRAINT "PLANSVCTYPE_COMB_UK" UNIQUE ("PLAN_SERVICE_TYPE_CODE") USING INDEX  TABLESPACE &tablespace_name  ENABLE;
 ALTER TABLE "EMRS_D_PLAN_SERVICE_TYPE" ADD CONSTRAINT "PLANSVCTYPEPK" PRIMARY KEY ("PLAN_SERVICE_TYPE_ID") USING INDEX TABLESPACE &tablespace_name  ENABLE;
  
GRANT SELECT ON "EMRS_D_PLAN_SERVICE_TYPE" TO &role_name;

CREATE OR REPLACE TRIGGER "BIR_PLANSVC_TYPE" 
 BEFORE INSERT
 ON emrs_d_plan_service_type
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN_SERVICE_TYPE.plan_service_type_id%TYPE;
BEGIN
  IF :NEW.plan_service_type_id IS NULL THEN
    SElECT EMRS_SEQ_PLANSVCTYPE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.plan_service_type_id       := v_seq_id;
  END IF;
END BIR_PLANSVC_TYPE;
/
ALTER TRIGGER "BIR_PLANSVC_TYPE" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_PLAN_SERVICE_TYPE_SV
AS
SELECT plan_service_type_code plan_service_type_cd
       ,plan_service_type
FROM emrs_d_plan_service_type;

GRANT SELECT ON "EMRS_D_PLAN_SERVICE_TYPE_SV" TO &role_name;
