insert into cc_a_scheduled_job (scheduled_job_type, start_datetime_param, end_datetime_param, job_start_date, job_end_date, is_running, success)
values('load_production_planning','2015-02-23 00:00:00','2015-02-23 00:00:00', sysdate, sysdate, 0, 1);

commit;