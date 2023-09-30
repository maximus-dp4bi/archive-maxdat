--------------------------------------------------------
--  DDL for Trigger BIR_AA_PLAN_PERCENTAGE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_AA_PLAN_PERCENTAGE" 
 BEFORE INSERT
 ON emrs_d_plan_percentage
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_PLAN_PERCENTAGE.plan_percentage_id%TYPE;
BEGIN
  IF :NEW.plan_percentage_id IS NULL THEN
    SElECT EMRS_SEQ_PLAN_PERCENTAGE_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;
  
    :NEW.plan_percentage_id   := v_seq_id;    
  END IF;
 :NEW.created_by := user;
 :NEW.date_created := sysdate;  
 :NEW.updated_by := user;
 :NEW.date_updated := sysdate;  
END BIR_AA_PLAN_PERCENTAGE; 
/
ALTER TRIGGER "BIR_AA_PLAN_PERCENTAGE" ENABLE;
/
