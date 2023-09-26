insert into cc_a_ivr_job (job_name, job_description, daily_run_enabled, daily_run_script, enabled)
values ('LOAD_CONFIG', 'Load IVR configuration', 'N', 'BEGIN IVR_UTIL_PKG.CREATE_DAILY_IVR_JOBS(:1); END;', 'Y');

COMMIT;
