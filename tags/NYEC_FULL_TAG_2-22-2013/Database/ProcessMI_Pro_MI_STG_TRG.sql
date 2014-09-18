CREATE OR REPLACE TRIGGER MAXDAT.Pro_MI_STG_TRG
 BEFORE INSERT OR UPDATE
 ON Process_MI_STG
 FOR EACH ROW
BEGIN
  IF INSERTING THEN
      IF :NEW.pms_id IS NULL THEN
         SELECT seq_pms_id.NEXTVAL
           INTO :NEW.pms_id
           FROM DUAL;
       END IF;

	  :NEW.STG_EXTRACT_DATE := SYSDATE;
  END IF;

  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/
