
update cc_a_adhoc_job
set is_pending = 1, job_start_date = null, job_end_date = null, success = null
where adhoc_job_id = 941
;

COMMIT;