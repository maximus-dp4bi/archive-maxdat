
TRUNCATE TABLE ETL_JOB_GLOBAL_CONFIG;
TRUNCATE TABLE ETL_JOB_CONFIG;

-- INSERT GLOBAL PARAMETERS - SHOULD RETAIN THESE 5 PARAMETERS FOR EACH PROJECT
-- Change PROJECT_NAME and PARAM_VALUE fied values only 

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('NCUI', 'ETL_AUDIT_DATA_RETENTION_DAYS', 365);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('NCUI', 'ETL_RUN_DATA_RETENTION_DAYS', 365);
        
INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('NCUI', 'ETL_LOG_DATA_RETENTION_DAYS', 365);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('NCUI', 'MAX_PARALLEL_JOBS_ALLOWED', 7);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('NCUI', 'JOB_TIMEOUT_SEC', 3000);

INSERT INTO ETL_JOB_CONFIG (
    PROJECT_NAME,
    JOB_NAME,
    JOB_TYPE,
    JOB_SCHEDULE,
    JOB_ENABLED,
    JOB_SCRIPT_NAME,
	JOB_LOG_PATH,
    LAST_UPD_DT,
    LAST_UPD_USER)
VALUES (
	'NCUI',
	'Daily MedChat Report',
	'STANDALONE',
	'00 8 * * *',
	'Y',
	'run_medchat_report.sh',
	'/u01/maximus/maxdat/NCUI/ETLJobControl/logs',
	SYSDATE,
	USER
);

COMMIT;

--SELECT * FROM ETL_JOB_GLOBAL_CONFIG;
--SELECT * FROM ETL_JOB_CONFIG;

