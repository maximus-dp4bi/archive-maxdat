DROP SEQUENCE SEQ_EEMFDB_ID;

CREATE SEQUENCE MAXDAT.SEQ_EEMFDB_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM seq_EEMFDB_ID FOR seq_EEMFDB_ID;


GRANT SELECT ON SEQ_EEMFDB_ID TO MAXDAT_OLTP_SIU;

GRANT SELECT ON SEQ_EEMFDB_ID TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON SEQ_EEMFDB_ID TO MAXDAT_READ_ONLY;



create or replace 
trigger "TRG_R_corp_etl_mailfaxdoc" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :new.EEMFDB_ID IS NULL THEN
      SELECT SEQ_EEMFDB_ID.Nextval INTO :NEW.EEMFDB_ID FROM Dual;
    END IF;
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DT := SYSDATE;
END;
/

create or replace 
trigger "TRG_R_corp_etl_mailfaxdoc_oltp" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc_oltp FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DT := SYSDATE;
END;
/

create or replace 
trigger "TRG_R_corp_etl_mail_wip_bpm" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc_wip_bpm FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DT := SYSDATE;
END;
/