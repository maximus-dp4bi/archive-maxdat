update cc_a_adhoc_job
 set is_running=0
where adhoc_job_id = 881;


insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2020-03-01 00:00:00','2020-03-15 00:00:00',1, 'AVAYA', 'NA');
commit;

