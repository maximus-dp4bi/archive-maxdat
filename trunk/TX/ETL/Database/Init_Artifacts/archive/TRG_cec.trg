CREATE OR REPLACE TRIGGER "TRG_cec" BEFORE
       INSERT OR
       UPDATE ON CORP_ETL_CONTROL FOR EACH ROW
BEGIN
  IF Inserting THEN
--      SELECT seq_cec.Nextval INTO :NEW.NESR_ID FROM Dual;
      :NEW.created_ts := SYSDATE;
  END IF;

  :NEW.updated_ts := SYSDATE;
END;
/
