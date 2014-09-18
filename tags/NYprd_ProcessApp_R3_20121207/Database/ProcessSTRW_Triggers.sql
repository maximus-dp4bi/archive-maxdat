CREATE OR REPLACE TRIGGER MAXDAT."TRG_STATE_REVIEW_STG" BEFORE
       INSERT OR
       UPDATE ON STATE_REVIEW_STG FOR EACH ROW
BEGIN
  IF Inserting THEN
      
      if :NEW.NESR_ID IS NULL THEN
         SELECT seq_nesr_stg.Nextval INTO :NEW.NESR_ID FROM Dual;
      end if;
         
      :NEW.itm_INSERT_TS := to_date(SYSDATE);
      
  END IF;
  
  :NEW.itm_UPDATE_TS := SYSDATE;
  
END;


CREATE OR REPLACE TRIGGER MAXDAT."TRG_STATE_REVIEW_STG_TMP" BEFORE
       INSERT OR
       UPDATE ON STATE_REVIEW_STG_TMP FOR EACH ROW
BEGIN
  IF Inserting THEN
    if :new.nesr_id is null
    then
       SELECT seq_nesr_stg_tmp.Nextval 
         INTO :NEW.NESR_ID 
         FROM Dual;
    end if;
       
      :NEW.itm_INSERT_TS := to_date(SYSDATE);
  END IF;
  
  :NEW.itm_UPDATE_TS := SYSDATE;
END;
