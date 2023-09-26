-- alter table ETL_JOB_CONFIG to add back JOB_DEBUG column
ALTER TABLE ETL_JOB_CONFIG ADD (JOB_DEBUG VARCHAR2(1) DEFAULT 'N');
ALTER TABLE ETL_JOB_CONFIG ADD CONSTRAINT ETL_JOB_CONFIG_JOB_DEBUG_CHECK CHECK (JOB_DEBUG IN ('Y','N'));

-- create table ETL_JOB_CONFIG_AUDIT
ALTER TABLE ETL_JOB_CONFIG_AUDIT ADD (JOB_DEBUG VARCHAR2(1) DEFAULT 'N');

-- create table ETL_JOB_LIST
ALTER TABLE ETL_JOB_LIST ADD (JOB_DEBUG VARCHAR2(1) DEFAULT 'N');

-- create view for ETL_JOB_CONFIG
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
    JOB_DEBUG,
    JOB_LOG_PATH,
    JOB_TIMEOUT_SEC,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_CONFIG
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_CONFIG_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_CONFIG_AUDIT
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
    JOB_DEBUG,
    JOB_LOG_PATH,
    JOB_TIMEOUT_SEC,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_CONFIG_AUDIT
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_CONFIG_AUDIT_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_LIST
CREATE OR REPLACE VIEW ETL_JOB_LIST_SV AS 
SELECT
    JOB_ID,
    PROJECT_NAME,
    JOB_NAME,
    JOB_TYPE,
    PARENT_JOB_ID,
    JOB_SCRIPT_NAME,
    JOB_DEBUG,
    JOB_LOG_PATH,
    JOB_NEXT_EXEC_DT,    
    JOB_STUCK
FROM ETL_JOB_LIST
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_LIST_SV to MAXDAT_READ_ONLY;

-- create trigger
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
         JOB_DEBUG,
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
         :old.JOB_DEBUG,
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
         JOB_DEBUG,
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
         :old.JOB_DEBUG,
         :old.JOB_LOG_PATH,
         :old.JOB_TIMEOUT_SEC,
         :old.LAST_UPD_DT,
         :old.LAST_UPD_USER
       );
	   
   END IF;
END;
/
