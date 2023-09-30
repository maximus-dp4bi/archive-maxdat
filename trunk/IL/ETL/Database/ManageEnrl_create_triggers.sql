/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.


*/
CREATE OR REPLACE TRIGGER TRG_CORP_ETL_MANAGE_ENRL BEFORE
       INSERT OR
       UPDATE ON corp_etl_Manage_enroll FOR EACH ROW
BEGIN
  IF Inserting THEN            

       if :NEW.CEME_ID IS NULL THEN
         SELECT seq_ceme.Nextval INTO :NEW.CEME_ID FROM Dual;
       end if;

      :NEW.stg_extract_date := SYSDATE;      
  END IF;
  
  :NEW.stg_last_update_date := SYSDATE;
  
END;