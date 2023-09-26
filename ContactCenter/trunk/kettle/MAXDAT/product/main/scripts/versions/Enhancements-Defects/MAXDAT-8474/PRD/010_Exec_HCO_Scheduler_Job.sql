alter session set current_schema = maxdat;

EXEC PKG_HCO_V2_CALL_UPDATE.PROC_CREATE_SCHEDULER_JOB;
