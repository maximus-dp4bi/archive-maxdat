 CREATE OR REPLACE TRIGGER "MAXDAT"."CORP_ETL_CLEAN_TABLE" 
 BEFORE INSERT OR UPDATE
 ON corp_etl_clean_table
 FOR EACH ROW
BEGIN
  IF INSERTING THEN
      IF  :NEW.cect_id IS NULL THEN
            SELECT seq_cect_id.NEXTVAL
            INTO :NEW.cect_id
            FROM DUAL;
       END IF;

    :NEW.created_ts := SYSDATE;
       END IF;

           :NEW.last_update_ts := SYSDATE;
       END;

/
ALTER TRIGGER "MAXDAT"."CORP_ETL_CLEAN_TABLE" ENABLE;