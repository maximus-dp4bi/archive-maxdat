-- Create job control entry for CES_Login 
INSERT INTO MAXDAT.ETL_JOB_CONFIG (
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
	'Illinois Enrollment',
	'IL RUN CES_Login',
	'STANDALONE',
	'0,30 * * * *',
	'Y',
	'il_run_ces_login.sh',
	'/u01/maximus/maxdat/IL8/logs/ETLJobControl',
	SYSDATE,
	USER
);
commit;
