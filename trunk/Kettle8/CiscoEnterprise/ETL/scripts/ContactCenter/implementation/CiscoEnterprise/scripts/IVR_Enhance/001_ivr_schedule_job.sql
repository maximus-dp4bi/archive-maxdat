alter session set plsql_code_type = native;

begin
  ivr_util_pkg.PROC_CREATE_SCHEDULER_JOB;
end;
/

begin
  ivr_util_pkg.CREATE_DAILY_IVR_JOBS;
end;
/

alter session set plsql_code_type = interpreted;
