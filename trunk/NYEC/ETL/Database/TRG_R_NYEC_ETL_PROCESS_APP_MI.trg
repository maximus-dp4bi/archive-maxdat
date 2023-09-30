
CREATE OR REPLACE TRIGGER TRG_R_NYEC_ETL_PROCESS_APP_MI 
  BEFORE INSERT OR
  UPDATE ON NYEC_ETL_PROCESS_APP_MI FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :new.cepam_id IS NULL THEN
      SELECT seq_cepam.NEXTVAL 
        INTO :new.cepam_Id 
        FROM DUAL;
    END IF;
  --
    IF :new.stg_extract_date IS NULL THEN
      :new.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :new.stg_last_update_date := SYSDATE;
END;

/
