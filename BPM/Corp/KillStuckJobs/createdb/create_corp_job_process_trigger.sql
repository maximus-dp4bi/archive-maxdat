create or replace trigger MAXDAT.TRG_BIU_CORP_JOB_PROCESS_STUCK
BEFORE INSERT OR UPDATE ON CORP_JOB_PROCESS_STUCK
FOR EACH ROW
BEGIN
  IF INSERTING THEN
     :new.CREATE_DT := SYSDATE;
     :new.CREATED_BY := USER;
  END IF;
  :new.UPDATE_DT := SYSDATE;
  :new.UPDATED_BY := USER;
  INSERT INTO CORP_JOB_PROCESS_STUCK_ARCHIVE
  (JOB_NAME, JOB_CHECK_FILE_NAME, JOB_PID, JOB_ACTION_KILL, REMOVE_CHECK_FILE_ONLY, CREATED_BY, CREATE_DT, UPDATED_BY, UPDATE_DT)
  VALUES (:NEW.JOB_NAME, :NEW.JOB_CHECK_FILE_NAME, :NEW.JOB_PID, :NEW.JOB_ACTION_KILL, :NEW.REMOVE_CHECK_FILE_ONLY, :NEW.CREATED_BY, :NEW.CREATE_DT, :NEW.UPDATED_BY, :NEW.UPDATE_DT);
END;
/