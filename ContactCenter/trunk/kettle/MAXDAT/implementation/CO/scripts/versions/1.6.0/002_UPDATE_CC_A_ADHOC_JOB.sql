update cc_a_adhoc_job
set is_running = 0,
job_end_date = sysdate
where adhoc_job_id = 101;

commit;