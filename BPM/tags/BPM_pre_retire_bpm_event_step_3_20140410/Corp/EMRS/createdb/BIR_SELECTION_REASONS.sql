--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_REASONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_REASONS" 
 BEFORE INSERT
 ON emrs_d_selection_reason
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_REASON.selection_reason_id%TYPE;
BEGIN
  IF :NEW.selection_reason_id IS NULL THEN
    SElECT EMRS_SEQ_SELECTION_REASON_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_reason_id       := v_seq_id;
  END IF;
END BIR_SELECTION_REASONS;
/
ALTER TRIGGER "BIR_SELECTION_REASONS" ENABLE;
/
