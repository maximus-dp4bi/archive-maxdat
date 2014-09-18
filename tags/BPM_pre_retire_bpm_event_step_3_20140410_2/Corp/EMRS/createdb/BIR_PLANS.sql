--------------------------------------------------------
--  DDL for Trigger BIR_PLANS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PLANS" 
 BEFORE INSERT
 ON emrs_d_plan
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN.plan_id%TYPE;
BEGIN
  IF :NEW.plan_id IS NULL THEN
    SElECT EMRS_SEQ_PLANS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.plan_id       := v_seq_id;
  END IF;
END BIR_PLANS;
/
ALTER TRIGGER "BIR_PLANS" ENABLE;
/
