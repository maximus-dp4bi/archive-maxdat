DROP SEQUENCE MAXDAT.SEQ_CEMFD_ID;

CREATE SEQUENCE MAXDAT.SEQ_CEMFD_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM seq_CEMFD_ID FOR MAXDAT.seq_CEMFD_ID;


GRANT SELECT ON MAXDAT.SEQ_CEMFD_ID TO MAXDAT_OLTP_SIU;

GRANT SELECT ON MAXDAT.SEQ_CEMFD_ID TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.SEQ_CEMFD_ID TO MAXDAT_READ_ONLY;



create or replace 
trigger "TRG_R_corp_etl_mailfaxdoc" BEFORE
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
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
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
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/