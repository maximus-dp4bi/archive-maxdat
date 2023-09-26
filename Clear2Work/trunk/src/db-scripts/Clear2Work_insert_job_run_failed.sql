define p_sql_debug_switch = &1
set termout &p_sql_debug_switch

define p_debug_flag = &2
define p_preserve_files_flag = &3
define p_job_run_file_suffix = &4
define p_run_by = &5

insert into CLEAR2WORK_JOB_RUN
  (JOB_RUN_ID,ENABLED_FLAG,DEBUG_FLAG,PRESERVE_FILES_FLAG,JOB_RUN_FILE_SUFFIX,RUN_BY,RUN_STATUS,START_RUN_DATE,END_RUN_DATE)
values 
  (SEQ_CLEAR2WORK_JOB_RUN_ID.nextval,'N','&p_debug_flag','&p_preserve_files_flag','&p_job_run_file_suffix','&p_run_by','FAILED',sysdate,sysdate);

commit;

exit;