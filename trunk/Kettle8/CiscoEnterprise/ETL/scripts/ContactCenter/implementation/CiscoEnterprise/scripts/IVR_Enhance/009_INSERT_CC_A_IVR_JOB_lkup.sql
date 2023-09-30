--- truncate table CC_A_IVR_JOB;
INSERT INTO CC_A_IVR_JOB(JOB_NAME, JOB_DESCRIPTION, DAILY_RUN_ENABLED, DAILY_RUN_SCRIPT, ENABLED) VALUES
(
'LOAD_ALL_VCSI'
,'Load Cisco CVP all projects'
,'Y'
,'BEGIN IVR_UTIL_PKG.CREATE_DAILY_IVR_JOBS(:1); END;'
,'Y'
);

UPDATE CC_A_IVR_JOB SET DAILY_RUN_ENABLED = 'N' WHERE JOB_NAME = 'LOAD_VERINTCSI';

commit;

