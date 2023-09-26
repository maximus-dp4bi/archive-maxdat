update cc_a_scheduled_job
 set is_running=0
where scheduled_job_id = 87536;
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2020-08-30 00:00:00','2020-08-31 00:00:00',1, 'CISCO', 'NA');
commit;
