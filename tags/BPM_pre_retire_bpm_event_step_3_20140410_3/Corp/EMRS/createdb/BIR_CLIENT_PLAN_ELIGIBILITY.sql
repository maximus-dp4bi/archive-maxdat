--------------------------------------------------------
--  DDL for Trigger BIR_CLIENT_PLAN_ELIGIBILITY
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CLIENT_PLAN_ELIGIBILITY" 
 BEFORE INSERT
 ON emrs_d_client_plan_eligibility
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_PLAN_ELIGIBILITY.client_plan_eligibility_id%TYPE;
BEGIN
  IF :NEW.client_plan_eligibility_id IS NULL THEN
    SElECT EMRS_SEQ_CLNT_PLAN_ELIG_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.client_plan_eligibility_id       := v_seq_id;
  END IF;

  :NEW.created_by := user;
  :NEW.date_created := sysdate;
  
  /*IF :NEW.current_flag = 'Y' THEN
    :NEW.current_eligibility_status_cd := :NEW.eligibility_status_code;
  END IF;*/
END BIR_CLIENT_PLAN_ELIGIBILITY;
/
ALTER TRIGGER "BIR_CLIENT_PLAN_ELIGIBILITY" ENABLE;
/

  CREATE OR REPLACE TRIGGER "BUR_CLIENT_PLAN_ELIGIBILITY" 
 BEFORE UPDATE
 ON emrs_d_client_plan_eligibility
 FOR EACH ROW
BEGIN
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUR_CLIENT_PLAN_ELIGIBILITY;
/
ALTER TRIGGER "BUR_CLIENT_PLAN_ELIGIBILITY" ENABLE;
/