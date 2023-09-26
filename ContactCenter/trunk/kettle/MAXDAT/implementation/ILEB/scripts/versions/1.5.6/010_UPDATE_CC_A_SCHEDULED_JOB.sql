update cc_a_scheduled_job
set job_end_date = sysdate
,is_running = 0
,success = 0
where scheduled_job_id = 13962
and is_running = 1;

commit;