CREATE OR REPLACE TRIGGER step_instance_stg_TRG
/*
Created on 11-Apr-2013 by Raj A.
Description:
This trigger populates stage_create_ts(in case :NEW.stage_create_ts is null) and stage_update_ts although the Stage_create_ts gets 
populated by the KTR, ManageWork_Capture_OLTP.ktr
*/
 BEFORE INSERT OR UPDATE
 ON step_instance_stg
 FOR EACH ROW
BEGIN
  IF INSERTING and :NEW.stage_create_ts IS NULL THEN
	     :NEW.stage_create_ts := SYSDATE;    
  END IF;

  :NEW.stage_update_ts := SYSDATE;
END;