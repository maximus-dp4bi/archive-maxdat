CREATE OR REPLACE TRIGGER MAXDAT."TRG_NYEC_ETL_STRW_STG" BEFORE
       INSERT OR
       UPDATE ON NYEC_ETL_STATE_REVIEW FOR EACH ROW
BEGIN
  IF Inserting THEN            

       if :NEW.NESR_ID IS NULL THEN
         SELECT seq_nesr.Nextval INTO :NEW.NESR_ID FROM Dual;
       end if;

      :NEW.stg_extract_date := SYSDATE;      
  END IF;
  
  :NEW.stg_last_update_date := SYSDATE;
  
END;

CREATE OR REPLACE TRIGGER MAXDAT."TRG_STATE_REVIEW_STG" BEFORE
       INSERT OR
       UPDATE ON STATE_REVIEW_STG FOR EACH ROW
BEGIN
  IF Inserting THEN            
      :NEW.itm_INSERT_TS := to_date(SYSDATE);      
  END IF;
  
  :NEW.itm_UPDATE_TS := SYSDATE;
  
END;


CREATE OR REPLACE TRIGGER MAXDAT."TRG_STATE_REVIEW_STG_TMP" BEFORE
       INSERT OR
       UPDATE ON STATE_REVIEW_STG_TMP FOR EACH ROW
BEGIN
  IF Inserting THEN       
      :NEW.itm_INSERT_TS := to_date(SYSDATE);
  END IF;
  
  :NEW.itm_UPDATE_TS := SYSDATE;
END;
