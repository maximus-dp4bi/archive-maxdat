
TRUNCATE TABLE ETL_JOB_GLOBAL_CONFIG;
TRUNCATE TABLE ETL_JOB_CONFIG;

-- INSERT GLOBAL PARAMETERS - SHOULD RETAIN THESE 5 PARAMETERS FOR EACH PROJECT
-- Change PROJECT_NAME and PARAM_VALUE fied values only 

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('California Workers Compensation', 'ETL_AUDIT_DATA_RETENTION_DAYS', 365);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('California Workers Compensation', 'ETL_RUN_DATA_RETENTION_DAYS', 365);
        
INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('California Workers Compensation', 'ETL_LOG_DATA_RETENTION_DAYS', 365);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('California Workers Compensation', 'MAX_PARALLEL_JOBS_ALLOWED', 7);

INSERT INTO ETL_JOB_GLOBAL_CONFIG (PROJECT_NAME, PARAM_KEY, PARAM_VALUE)
VALUES ('California Workers Compensation', 'JOB_TIMEOUT_SEC', 3000);

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
	'California Workers Compensation',
	'CRON CADIR RUN BMP',
	'STANDALONE',
	'0 4-22 * * *',
	'Y',
	'cron_cadir_run_bpm.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN CRS IMR RUNALL',
	'STANDALONE',
	'0 10,14,23 * * *',
	'Y',
	'run_crs_imr_runall.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN CRS IMR ER RUNALL',
	'STANDALONE',
	'0 11,15,21 * * *',
	'Y',
	'run_crs_imr_er_runall.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN CADIR TRENDING',
	'STANDALONE',
	'30 11,15,21,23 * * * ',
	'Y',
	'run_cadir_trending.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'CRON CADIR RUN PLANNING',
	'STANDALONE',
	'15 4-22 * * *',
	'Y',
	'cron_cadir_run_planning.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN GENERATE DWC FILE',
	'STANDALONE',
	'15 15,19 * * *',
	'Y',
	'run_generate_dwc_file.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN GENERATE M DWC FILE',
	'STANDALONE',
	'0 16 * * *',
	'Y',
	'run_generate_m_dwc_file.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN DELTEK RUNALL',
	'STANDALONE',
	'0 12-18 * * *',
	'Y',
	'run_deltek_runall.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

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
	'California Workers Compensation',
	'RUN ADHOC CADIR TRENDING',
	'STANDALONE',
	'15 1,3,5,7,9,11,13,15 * * *',
	'Y',
	'run_adhoc_cadir_trending.sh',
	'/u01/maximus/maxdat-dev/CADIR8/logs',
	SYSDATE,
	USER
);

COMMIT;
