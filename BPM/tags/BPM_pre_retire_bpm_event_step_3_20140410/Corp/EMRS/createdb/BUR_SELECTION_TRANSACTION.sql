--------------------------------------------------------
--  DDL for Trigger BUR_SELECTION_TRANSACTION
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "BUR_SELECTION_TRANSACTION" 
 BEFORE UPDATE
 ON emrs_d_selection_transaction
 FOR EACH ROW
BEGIN
  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
END BUR_SELECTION_TRANSACTION;
/
ALTER TRIGGER "BUR_SELECTION_TRANSACTION" ENABLE;
/
