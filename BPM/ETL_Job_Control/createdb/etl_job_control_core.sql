
-- create sequences
CREATE SEQUENCE SEQ_ETL_JOB_CONFIG_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_ETL_JOB_RUN_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_ETL_LOG_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_ETL_JOB_HOLD_SKIP_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;

-- create table ETL_JOB_CONFIG
CREATE TABLE ETL_JOB_CONFIG(
    JOB_ID              NUMBER          NOT NULL,
    PROJECT_NAME        VARCHAR2(35)    NULL,
    JOB_NAME            VARCHAR2(50)    NOT NULL,
    JOB_TYPE            VARCHAR2(10)    NOT NULL,
    PARENT_JOB_ID       NUMBER          NULL,
    JOB_SCHEDULE        VARCHAR2(200)   NULL,
    JOB_ENABLED         VARCHAR2(1)     NOT NULL,
    JOB_SCRIPT_NAME     VARCHAR2(30)    NOT NULL,
    JOB_LOG_PATH        VARCHAR2(150)   NOT NULL,
    JOB_TIMEOUT_SEC     NUMBER          NULL,
    LAST_UPD_DT         DATE            NULL,
    LAST_UPD_USER       VARCHAR2(20)    NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_CONFIG
ALTER TABLE ETL_JOB_CONFIG ADD CONSTRAINT ETL_JOB_CONFIG_PK PRIMARY KEY (JOB_ID) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_CONFIG MODIFY JOB_ID DEFAULT SEQ_ETL_JOB_CONFIG_ID.NEXTVAL;
ALTER TABLE ETL_JOB_CONFIG ADD CONSTRAINT ETL_JOB_CONFIG_PROJECT_NAME_FK FOREIGN KEY (PROJECT_NAME) REFERENCES MAXDAT.BPM_PROJECT_LKUP (NAME); 
ALTER TABLE ETL_JOB_CONFIG ADD CONSTRAINT ETL_JOB_CONFIG_JOB_TYPE_CHECK CHECK (JOB_TYPE IN ('STANDALONE','PARENT','CHILD','ADHOC'));
ALTER TABLE ETL_JOB_CONFIG ADD CONSTRAINT ETL_JOB_CONFIG_JOB_ENABLED_CHECK CHECK (JOB_ENABLED IN ('Y','N'));

-- grant select on the table
GRANT SELECT ON ETL_JOB_CONFIG TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_CONFIG_AUDIT
CREATE TABLE ETL_JOB_CONFIG_AUDIT(
    JOB_ID              NUMBER          NOT NULL,
    AUDIT_TYPE          VARCHAR2(6)     NOT NULL,
    AUDIT_UPD_DT        DATE            NOT NULL,	
    PROJECT_NAME        VARCHAR2(35)    NULL,
    JOB_NAME            VARCHAR2(50)    NOT NULL,
    JOB_TYPE            VARCHAR2(10)    NOT NULL,
    PARENT_JOB_ID       NUMBER          NULL,
    JOB_SCHEDULE        VARCHAR2(200)   NULL,
    JOB_ENABLED         VARCHAR2(1)     NOT NULL,
    JOB_SCRIPT_NAME     VARCHAR2(30)    NOT NULL,
    JOB_LOG_PATH        VARCHAR2(150)   NOT NULL,
    JOB_TIMEOUT_SEC     NUMBER          NULL,
    LAST_UPD_DT         DATE            NULL,
    LAST_UPD_USER       VARCHAR2(20)    NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_CONFIG_AUDIT
ALTER TABLE ETL_JOB_CONFIG_AUDIT ADD CONSTRAINT ETL_JOB_CONFIG_AUDIT_PK PRIMARY KEY (JOB_ID, AUDIT_TYPE, AUDIT_UPD_DT) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_CONFIG_AUDIT ADD CONSTRAINT ETL_JOB_CONFIG_AUDIT_TYPE_CHECK CHECK (AUDIT_TYPE IN ('DELETE','UPDATE'));

-- grant select on the table
GRANT SELECT ON ETL_JOB_CONFIG_AUDIT TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_STATUS
CREATE TABLE ETL_JOB_STATUS(
    JOB_ID              NUMBER          NOT NULL,
    JOB_STATUS          VARCHAR2(9)     NOT NULL,
    JOB_RUNNABLE        VARCHAR2(1)     NOT NULL,
    JOB_NEXT_EXEC_DT    DATE            NULL,
    JOB_RUN_ID          NUMBER          NULL,
    LAST_UPD_DT         DATE            NULL,
    LAST_UPD_USER       VARCHAR2(20)    NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_STATUS
ALTER TABLE ETL_JOB_STATUS ADD CONSTRAINT ETL_JOB_STATUS_PK PRIMARY KEY (JOB_ID) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_STATUS ADD CONSTRAINT ETL_JOB_STATUS_JOB_ID_FK FOREIGN KEY (JOB_ID) REFERENCES ETL_JOB_CONFIG (JOB_ID);
ALTER TABLE ETL_JOB_STATUS ADD CONSTRAINT ETL_JOB_STATUS_JOB_STATUS_CHECK CHECK (JOB_STATUS IN ('STARTED','COMPLETED','FAILED','CANCELLED','RESET','WAITING','NEW'));
ALTER TABLE ETL_JOB_STATUS ADD CONSTRAINT ETL_JOB_STATUS_JOB_RUNNABLE_CHECK CHECK (JOB_RUNNABLE IN ('Y','N'));

-- grant select on the table
GRANT SELECT ON ETL_JOB_STATUS TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_LIST
CREATE TABLE ETL_JOB_LIST(
    JOB_ID              NUMBER          NOT NULL,
    PROJECT_NAME        VARCHAR2(35)    NULL,
    JOB_NAME            VARCHAR2(50)    NOT NULL,
    JOB_TYPE            VARCHAR2(10)    NOT NULL,
    PARENT_JOB_ID       NUMBER          NULL,
    JOB_SCRIPT_NAME     VARCHAR2(30)    NOT NULL,
    JOB_LOG_PATH        VARCHAR2(150)   NOT NULL,
    JOB_NEXT_EXEC_DT    DATE            NULL,    
    JOB_STUCK           VARCHAR2(1)     NOT NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_LIST
ALTER TABLE ETL_JOB_LIST ADD CONSTRAINT ETL_JOB_LIST_PK PRIMARY KEY (JOB_ID) USING INDEX TABLESPACE MAXDAT_INDX;

-- grant select on the table
GRANT SELECT ON ETL_JOB_LIST TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_RUN
CREATE TABLE ETL_JOB_RUN(
    RUN_ID              NUMBER          NOT NULL,
    JOB_ID              NUMBER          NOT NULL,
    RUN_STATUS          VARCHAR2(9)     NOT NULL,
    RUN_START_DT        DATE            NOT NULL,
    RUN_END_DT          DATE            NULL,
    LAST_UPD_DT         DATE            NULL,
    LAST_UPD_USER       VARCHAR2(20)    NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_RUN
ALTER TABLE ETL_JOB_RUN ADD CONSTRAINT ETL_JOB_RUN_PK PRIMARY KEY (RUN_ID) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_RUN ADD CONSTRAINT ETL_JOB_RUN_JOB_ID_FK FOREIGN KEY (JOB_ID) REFERENCES ETL_JOB_CONFIG (JOB_ID);
ALTER TABLE ETL_JOB_RUN MODIFY RUN_ID DEFAULT SEQ_ETL_JOB_RUN_ID.NEXTVAL;
ALTER TABLE ETL_JOB_RUN ADD CONSTRAINT ETL_JOB_RUN_STATUS_CHECK CHECK (RUN_STATUS IN ('STARTED','COMPLETED','FAILED','CANCELLED','RESET','WAITING'));

-- grant select on the table
GRANT SELECT ON ETL_JOB_RUN TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_GLOBAL_CONFIG
CREATE TABLE ETL_JOB_GLOBAL_CONFIG(
    PROJECT_NAME        VARCHAR2(35)    NOT NULL,
    PARAM_KEY           VARCHAR2(50)    NOT NULL,
	PARAM_VALUE         VARCHAR2(100)   NOT NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_GLOBAL_CONFIG
ALTER TABLE ETL_JOB_GLOBAL_CONFIG ADD CONSTRAINT ETL_JOB_GLOBAL_CONFIG_PK PRIMARY KEY (PROJECT_NAME, PARAM_KEY) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_GLOBAL_CONFIG ADD CONSTRAINT ETL_JOB_GLOBAL_CONFIG_PROJECT_NAME_FK FOREIGN KEY (PROJECT_NAME) REFERENCES MAXDAT.BPM_PROJECT_LKUP (NAME); 

-- grant select on the table
GRANT SELECT ON ETL_JOB_GLOBAL_CONFIG TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_LOG
CREATE TABLE ETL_JOB_LOG(
    LOG_ID              NUMBER          NOT NULL,
    LOG_DESC            VARCHAR2(250)   NOT NULL,
    LOG_UPD_DT          DATE            NOT NULL,
    LOG_SEVERITY_LEVEL  VARCHAR2(9)     NULL,
    LOG_CODE            NUMBER          NULL,
    JOB_ID              NUMBER          NULL,
    RUN_ID              NUMBER          NULL,
    STEP_ID             NUMBER          NULL,
    STEP_DESC           VARCHAR2(100)   NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_LOG
ALTER TABLE ETL_JOB_LOG ADD CONSTRAINT ETL_JOB_LOG_PK PRIMARY KEY (LOG_ID, LOG_DESC, LOG_UPD_DT) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_LOG MODIFY LOG_ID DEFAULT SEQ_ETL_LOG_ID.NEXTVAL;
ALTER TABLE ETL_JOB_LOG ADD CONSTRAINT ETL_JOB_LOG_JOB_ID_FK FOREIGN KEY (JOB_ID) REFERENCES ETL_JOB_CONFIG (JOB_ID);
ALTER TABLE ETL_JOB_LOG ADD CONSTRAINT ETL_JOB_LOG_RUN_ID_FK FOREIGN KEY (RUN_ID) REFERENCES ETL_JOB_RUN (RUN_ID);
ALTER TABLE ETL_JOB_LOG ADD CONSTRAINT ETL_JOB_LOG_SEVERITY_CHECK CHECK (LOG_SEVERITY_LEVEL IN ('FATAL','ERROR','WARNING','INFO','DEBUG'));
ALTER TABLE ETL_JOB_LOG DROP CONSTRAINT ETL_JOB_LOG_SEVERITY_CHECK;

-- grant select on the table
GRANT SELECT ON ETL_JOB_LOG TO MAXDAT_READ_ONLY;

-- create table ETL_JOB_HOLD_SKIP
CREATE TABLE ETL_JOB_HOLD_SKIP(
    SEQ_ID               NUMBER          NOT NULL, 
	JOB_ID_TO_HOLD       NUMBER          NOT NULL,
    JOB_ID_RUNNING       NUMBER          NOT NULL,
    SKIP_RUN             VARCHAR2(1)     NOT NULL,
    LAST_UPD_DT          DATE            NULL,
    LAST_UPD_USER        VARCHAR2(20)    NULL)
TABLESPACE MAXDAT_DATA;

-- add constraints to table ETL_JOB_CONFIG
ALTER TABLE ETL_JOB_HOLD_SKIP ADD CONSTRAINT ETL_JOB_HOLD_SKIP_PK PRIMARY KEY (SEQ_ID) USING INDEX TABLESPACE MAXDAT_INDX;
ALTER TABLE ETL_JOB_HOLD_SKIP MODIFY SEQ_ID DEFAULT SEQ_ETL_JOB_HOLD_SKIP_ID.NEXTVAL;
ALTER TABLE ETL_JOB_HOLD_SKIP ADD CONSTRAINT ETL_JOB_HOLD_SKIP_TO_HOLD_JOB_FK FOREIGN KEY (JOB_ID_TO_HOLD) REFERENCES ETL_JOB_CONFIG (JOB_ID);
ALTER TABLE ETL_JOB_HOLD_SKIP ADD CONSTRAINT ETL_JOB_HOLD_SKIP_RUNNING_JOB_FK FOREIGN KEY (JOB_ID_RUNNING) REFERENCES ETL_JOB_CONFIG (JOB_ID);
ALTER TABLE ETL_JOB_HOLD_SKIP ADD CONSTRAINT ETL_JOB_HOLD_SKIP_RUN_CHECK CHECK (SKIP_RUN IN ('Y','N'));

-- grant select on the table
GRANT SELECT ON ETL_JOB_HOLD_SKIP TO MAXDAT_READ_ONLY;

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
    JOB_LOG_PATH,
    JOB_TIMEOUT_SEC,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_CONFIG_AUDIT
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_CONFIG_AUDIT_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_STATUS
CREATE OR REPLACE VIEW ETL_JOB_STATUS_SV AS 
SELECT
    JOB_ID,
    JOB_STATUS,
    JOB_RUNNABLE,
    JOB_NEXT_EXEC_DT,
    JOB_RUN_ID,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_STATUS
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_STATUS_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_LIST
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

-- create view for ETL_JOB_RUN
CREATE OR REPLACE VIEW ETL_JOB_RUN_SV AS 
SELECT
    RUN_ID,
    JOB_ID,
    RUN_STATUS,
    RUN_START_DT,
    RUN_END_DT,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_RUN
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_RUN_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_GLOBAL_CONFIG
CREATE OR REPLACE VIEW ETL_JOB_GLOBAL_CONFIG_SV AS 
SELECT
    PROJECT_NAME,
    PARAM_KEY,
	PARAM_VALUE
FROM ETL_JOB_GLOBAL_CONFIG
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_GLOBAL_CONFIG_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_LOG
CREATE OR REPLACE VIEW ETL_JOB_LOG_SV AS 
SELECT
    LOG_ID,
    LOG_DESC,
    LOG_UPD_DT,
    LOG_SEVERITY_LEVEL,
    LOG_CODE,
    JOB_ID,
    RUN_ID,
    STEP_ID,
    STEP_DESC
FROM ETL_JOB_LOG
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_LOG_SV to MAXDAT_READ_ONLY;

-- create view for ETL_JOB_HOLD_SKIP 
CREATE OR REPLACE VIEW ETL_JOB_HOLD_SKIP_SV AS 
SELECT
    SEQ_ID,
    JOB_ID_TO_HOLD,
    JOB_ID_RUNNING,
    SKIP_RUN,
    LAST_UPD_DT,
    LAST_UPD_USER
FROM ETL_JOB_HOLD_SKIP
WITH READ ONLY;

-- grant select on the view 
GRANT SELECT ON ETL_JOB_HOLD_SKIP_SV to MAXDAT_READ_ONLY;

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
