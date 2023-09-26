define p_sql_debug_switch = &1
set termout &p_sql_debug_switch

define p_job_run_id = &2

update CLEAR2WORK_JOB_RUN
set
  RUN_STATUS = 'COMPLETED',
  END_RUN_DATE = sysdate
where JOB_RUN_ID = &p_job_run_id;

commit;

exit;