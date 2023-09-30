alter session set current_schema = MAXDAT;

/*Staging tables*/
TRUNCATE TABLE CORP_ETL_PROCESS_INCIDENTS;
TRUNCATE TABLE PROCESS_INCIDENTS_OLTP;
TRUNCATE TABLE PROCESS_INCIDENTS_WIP_BPM;


/*Semantic tables*/
TRUNCATE TABLE F_PI_BY_DATE;
ALTER TABLE F_PI_BY_DATE DISABLE CONSTRAINT FPIBD_DPICUR_FK;
TRUNCATE TABLE D_PI_CURRENT;
ALTER TABLE F_PI_BY_DATE ENABLE CONSTRAINT FPIBD_DPICUR_FK;

DELETE FROM D_PI_ENROLLMENT_STATUS;

DELETE FROM D_PI_INCIDENT_ABOUT;

DELETE FROM D_PI_INSTANCE_STATUS;

DELETE FROM D_PI_JEOPARDY_STATUS;

DELETE FROM D_PI_LAST_UPDATE_BY;

DELETE FROM D_PI_INCIDENT_REASON;

DELETE FROM D_PI_TASK_ID;

DELETE FROM D_PI_INCIDENT_DESC;

DELETE FROM D_PI_INCIDENT_STATUS;


/*Update global controls*/
update corp_etl_control
set value = '1'
where name = 'INC_NUM_ETL_RUNS_LOOK_BACK';

update corp_etl_control
set value = '302'
where name = 'LAST_INCIDENT_ID';

INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'Process_Incidents_RUN_ALL', 'COMPLETED', 0, 0, 0, 0, 0, 0, to_date('17-FEB-13','DD-MON-YY'), to_date('17-FEB-13','DD-MON-YY'));


commit;
