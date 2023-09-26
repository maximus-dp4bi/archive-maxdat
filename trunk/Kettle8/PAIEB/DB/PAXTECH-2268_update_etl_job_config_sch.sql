update pa_ieb.etl_job_config
 set job_schedule='1 * * * *'
where job_id = 1;

update pa_ieb.etl_job_config
 set job_schedule='12 * * * *'
where job_id = 2;

update pa_ieb.etl_job_config
 set job_schedule='16 * * * *'
where job_id = 3;

commit;