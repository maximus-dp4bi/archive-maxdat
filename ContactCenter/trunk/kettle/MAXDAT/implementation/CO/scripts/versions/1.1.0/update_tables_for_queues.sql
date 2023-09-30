DELETE FROM CC_F_ACTUALS_QUEUE_INTERVAL; 
DELETE FROM CC_F_AGENT_BY_DATE; 


update cc_a_adhoc_job set is_pending=1, job_start_date=null,job_end_date=null, success=0;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-09 00:00:00','2014-10-15 00:00:00','04-NOV-2014',1);
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-15 00:00:00','2014-10-20 00:00:00','04-NOV-2014',1);
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-20 00:00:00','2014-10-25 00:00:00','04-NOV-2014',1);
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-25 00:00:00','2014-10-27 00:00:00','04-NOV-2014',1);
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-29 00:00:00','2014-10-30 00:00:00','04-NOV-2014',1);
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param,creation_date, is_pending)
values('load_contact_center','2014-10-31 00:00:00','2014-11-04 00:00:00','04-NOV-2014',1);

commit;