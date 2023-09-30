-- The below script is ONLY for removing JOB_DEBUG column from all objects of ETL JOB Management process for ILEB. Not required for any new implementations.
-- create/alter trigger by removing JOB_DEBUG column
CREATE OR REPLACE TRIGGER AUD_TR_ETL_JOB_CONFIG
  AFTER UPDATE OR DELETE ON ETL_JOB_CONFIG 
  FOR EACH ROW 
BEGIN
   
   -- Audit when record is DELETED     
   IF DELETING THEN
	  INSERT INTO ETL_JOB_CONFIG_AUDIT(
         JOB_ID,
         AUDIT_TYPE,
         AUDIT_UPD_DT,	
         PROJECT_NAME,
         JOB_NAME,
         JOB_TYPE,
         PARENT_JOB_ID,
         JOB_SCHEDULE,
         JOB_ENABLED,
         JOB_SCRIPT_NAME,
         JOB_LOG_PATH,
         JOB_TIMEOUT_SEC,
         LAST_UPD_DT,
         LAST_UPD_USER
       ) 
	   VALUES (
	     :old.JOB_ID,  
         'DELETE',
         SYSDATE,	
         :old.PROJECT_NAME,
         :old.JOB_NAME,
         :old.JOB_TYPE,
         :old.PARENT_JOB_ID,
         :old.JOB_SCHEDULE,
         :old.JOB_ENABLED,
         :old.JOB_SCRIPT_NAME,
         :old.JOB_LOG_PATH,
         :old.JOB_TIMEOUT_SEC,
         :old.LAST_UPD_DT,
         :old.LAST_UPD_USER
       );
	   
   END IF;

   -- Audit when record is UPDATED     
   IF UPDATING THEN
	  INSERT INTO ETL_JOB_CONFIG_AUDIT(
         JOB_ID,
         AUDIT_TYPE,
         AUDIT_UPD_DT,	
         PROJECT_NAME,
         JOB_NAME,
         JOB_TYPE,
         PARENT_JOB_ID,
         JOB_SCHEDULE,
         JOB_ENABLED,
         JOB_SCRIPT_NAME,
         JOB_LOG_PATH,
         JOB_TIMEOUT_SEC,
         LAST_UPD_DT,
         LAST_UPD_USER
       ) 
	   VALUES (
	     :old.JOB_ID,  
         'UPDATE',
         SYSDATE,	
         :old.PROJECT_NAME,
         :old.JOB_NAME,
         :old.JOB_TYPE,
         :old.PARENT_JOB_ID,
         :old.JOB_SCHEDULE,
         :old.JOB_ENABLED,
         :old.JOB_SCRIPT_NAME,
         :old.JOB_LOG_PATH,
         :old.JOB_TIMEOUT_SEC,
         :old.LAST_UPD_DT,
         :old.LAST_UPD_USER
       );
	   
   END IF;
END;
/

-- create/alter view for ETL_JOB_CONFIG by removing JOB_DEBUG column
CREATE OR REPLACE VIEW ETL_JOB_CONFIG_SV AS 
SELECT
    JOB_ID,
    PROJECT_NAME,
    JOB_NAME,
    JOB_TYPE,
    PARENT_JOB_ID,
    JOB_SCHEDULE,
    JOB_ENABLED,
    JOB_SCRIPT_NAME,
    JOB_LOG_PATH,
    JOB_TIMEOUT_SEC,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_CONFIG
WITH READ ONLY;


-- grant select on the view 
GRANT SELECT ON ETL_JOB_CONFIG_SV to MAXDAT_READ_ONLY;


-- create/alter view for ETL_JOB_CONFIG_AUDIT by removing JOB_DEBUG column
CREATE OR REPLACE VIEW ETL_JOB_CONFIG_AUDIT_SV AS 
SELECT
    JOB_ID,
    AUDIT_TYPE,
    AUDIT_UPD_DT,	
    PROJECT_NAME,
    JOB_NAME,
    JOB_TYPE,
    PARENT_JOB_ID,
    JOB_SCHEDULE,
    JOB_ENABLED,
    JOB_SCRIPT_NAME,
    JOB_LOG_PATH,
    JOB_TIMEOUT_SEC,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_CONFIG_AUDIT
WITH READ ONLY;


-- grant select on the view 
GRANT SELECT ON ETL_JOB_CONFIG_AUDIT_SV to MAXDAT_READ_ONLY;


-- create/alter view for ETL_JOB_LIST by removing JOB_DEBUG column
CREATE OR REPLACE VIEW ETL_JOB_LIST_SV AS 
SELECT
    JOB_ID,
    PROJECT_NAME,
    JOB_NAME,
    JOB_TYPE,
    PARENT_JOB_ID,
    JOB_SCRIPT_NAME,
    JOB_LOG_PATH,
    JOB_NEXT_EXEC_DT,    
    JOB_STUCK
FROM ETL_JOB_LIST
WITH READ ONLY;


-- grant select on the view 
GRANT SELECT ON ETL_JOB_LIST_SV to MAXDAT_READ_ONLY;


-- remove JOB_DEBUG column from ETL_JOB_CONFIG_AUDIT table
ALTER TABLE ETL_JOB_CONFIG_AUDIT DROP COLUMN JOB_DEBUG;


-- remove JOB_DEBUG column from ETL_JOB_CONFIG table
ALTER TABLE ETL_JOB_CONFIG DROP COLUMN JOB_DEBUG;


-- remove JOB_DEBUG column from ETL_JOB_LIST table
ALTER TABLE ETL_JOB_LIST DROP COLUMN JOB_DEBUG;

