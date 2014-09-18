--------------------------------------------------------
--  DDL for Trigger BIR_CLIENT_PLAN_ENRL_STATUS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CLIENT_PLAN_ENRL_STATUS" 
 BEFORE INSERT
 ON emrs_d_client_plan_enrl_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_PLAN_ENRL_STATUS.client_enroll_status_id%TYPE;
BEGIN
  IF :NEW.client_enroll_status_id IS NULL THEN
    SElECT EMRS_SEQ_CLIENT_ENRL_STATUS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.client_enroll_status_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
 
 /* IF :NEW.current_flag = 'Y' THEN
    :NEW.current_enrollment_status_id := :NEW.enrollment_status_id;
  END IF; */
END BIR_CLIENT_PLAN_ENRL_STATUS;
/
ALTER TRIGGER "BIR_CLIENT_PLAN_ENRL_STATUS" ENABLE;
/

CREATE OR REPLACE TRIGGER "BUR_CLIENT_PLAN_ENRL_STATUS" 
 BEFORE UPDATE
 ON emrs_d_client_plan_enrl_status
 FOR EACH ROW
BEGIN
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUR_CLIENT_PLAN_ENRL_STATUS;
/
ALTER TRIGGER "BUR_CLIENT_PLAN_ENRL_STATUS" ENABLE;