update cc_s_contact_queue
set unit_of_work_id = 22
where queue_number in (10013
,10014
,10043
,10044
);

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)
values('load_contact_center','2014-11-07 00:00:00','2014-11-08 00:00:00',1);

commit;