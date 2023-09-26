alter session set current_schema = cisco_enterprise_cc;

EXEC PKG_HCO_V2_CALL.PROC_CREATE_SCHEDULER_JOB;
