--------------------------------------------------------
--  DDL for Trigger BIR_PLAN_TYPES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_PLAN_TYPES" 
 BEFORE INSERT
 ON emrs_d_plan_type
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN_TYPE.plan_type_id%TYPE;
BEGIN
  IF :NEW.plan_type_id IS NULL THEN
    SElECT EMRS_SEQ_PLAN_TYPE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.plan_type_id       := v_seq_id;
  END IF;
END BIR_PLAN_TYPES;
/
ALTER TRIGGER "BIR_PLAN_TYPES" ENABLE;
/
