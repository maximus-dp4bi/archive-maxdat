update cc_a_scheduled_job
set is_running = 0,
success = 0,
job_end_date = sysdate
where scheduled_job_id = 41601;

commit;