update cc_a_adhoc_job
set is_running = 0
,is_pending =1
,job_start_date = null
where is_running =1
and adhoc_job_id = 763;

commit;