--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_STATUS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_STATUS" 
 BEFORE INSERT
 ON emrs_d_selection_status
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_STATUS.selection_status_id%TYPE;
BEGIN
  IF :NEW.selection_status_id IS NULL THEN
    SElECT EMRS_SEQ_SELECTION_STATUS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_status_id   := v_seq_id;
  END IF;
END BIR_SELECTION_STATUS;
/
ALTER TRIGGER "BIR_SELECTION_STATUS" ENABLE;
/
