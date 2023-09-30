insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)
values('load_contact_center','2015-03-10 00:00:00','2015-03-11 00:00:00',1);

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)
values('load_contact_center','2015-03-11 00:00:00','2015-03-12 00:00:00',1);

insert into cc_a_scheduled_job (scheduled_job_type, start_datetime_param, end_datetime_param, job_start_date, job_end_date, is_running, success)
values('load_contact_center','2015-03-10 00:00:00','2015-03-11 00:00:00', sysdate, sysdate, 0, 1);

commit;