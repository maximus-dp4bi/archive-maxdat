--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_TRANS_HISTORY
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_TRANS_HISTORY" 
 BEFORE INSERT
 ON emrs_d_selection_trans_history
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_TRANS_HISTORY.selection_trans_history_id%TYPE;
BEGIN
  IF :NEW.selection_trans_history_id IS NULL THEN
    SElECT EMRS_SEQ_SELECT_TRANS_HIST_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_trans_history_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
END BIR_SELECTION_TRANS_HISTORY;
/
ALTER TRIGGER "BIR_SELECTION_TRANS_HISTORY" ENABLE;
/
