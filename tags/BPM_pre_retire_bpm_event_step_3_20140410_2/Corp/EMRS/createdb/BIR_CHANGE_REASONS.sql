--------------------------------------------------------
--  DDL for Trigger BIR_CHANGE_REASONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_CHANGE_REASONS" 
 BEFORE INSERT
 ON emrs_d_change_reason
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CHANGE_REASON.change_reason_id%TYPE;
BEGIN
  IF :NEW.change_reason_id IS NULL THEN
    SElECT EMRS_SEQ_CHANGE_REASON_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.change_reason_id       := v_seq_id;
  END IF;
END BIR_CHANGE_REASONS;
/
ALTER TRIGGER "BIR_CHANGE_REASONS" ENABLE;
/
