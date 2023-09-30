--------------------------------------------------------
--  DDL for Trigger BIR_SELECTION_TRANSACTION
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BIR_SELECTION_TRANSACTION" 
 BEFORE INSERT
 ON emrs_d_selection_transaction
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_SELECTION_TRANSACTION.selection_transaction_id%TYPE;
BEGIN
  IF :NEW.selection_transaction_id IS NULL THEN
    SElECT EMRS_SEQ_SELECTION_TRANS_ID.NEXTVAL
    INTO v_seq_id
    FROM dual;

    :NEW.selection_transaction_id   := v_seq_id;
  END IF;
  :NEW.created_by := user;
  :NEW.date_created := sysdate;
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BIR_SELECTION_TRANSACTION;
/
ALTER TRIGGER "BIR_SELECTION_TRANSACTION" ENABLE;
/
