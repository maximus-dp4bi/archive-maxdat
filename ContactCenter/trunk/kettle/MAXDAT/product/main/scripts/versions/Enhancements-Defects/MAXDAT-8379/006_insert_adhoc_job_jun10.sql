update cc_a_adhoc_job
set is_pending=0 
where adhoc_job_id=4444;
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2019-06-10 00:00:00','2019-06-11 00:00:00',1, 'CISCO', 'NA');
commit;