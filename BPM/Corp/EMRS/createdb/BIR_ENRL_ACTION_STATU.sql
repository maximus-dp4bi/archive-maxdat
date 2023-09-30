--------------------------------------------------------
--  DDL for Trigger BIR_ENRL_ACTION_STATU
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_ENRL_ACTION_STATU" 
 BEFORE INSERT
 ON emrs_d_enrollment_action_statu
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ENROLLMENT_ACTION_STATU.enrollment_action_status_id%TYPE;
BEGIN
    IF :NEW.enrollment_action_status_id IS NULL THEN
      SElECT EMRS_SEQ_ENROLMT_ACT_STATUS_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.enrollment_action_status_id       := v_seq_id;
    END IF;
END BIR_ENRL_ACTION_STATU;
/
ALTER TRIGGER "BIR_ENRL_ACTION_STATU" ENABLE;
/
