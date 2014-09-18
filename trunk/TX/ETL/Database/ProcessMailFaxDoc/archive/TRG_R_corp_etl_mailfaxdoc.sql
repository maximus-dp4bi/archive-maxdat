--------------------------------------------------------
--  DDL for Trigger TRG_R_corp_etl_mailfaxdoc
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_R_corp_etl_mailfaxdoc" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :new.CEMFD_ID IS NULL THEN
      SELECT SEQ_CEMFD_ID.Nextval INTO :NEW.CEMFD_ID FROM Dual;
    END IF;
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/
ALTER TRIGGER "TRG_R_corp_etl_mailfaxdoc" ENABLE;