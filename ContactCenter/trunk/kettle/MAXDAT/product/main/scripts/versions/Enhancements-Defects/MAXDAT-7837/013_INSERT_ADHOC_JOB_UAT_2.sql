insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_agent_detail','2018-10-01 00:00:00','2018-11-04 00:00:00',1, 'CISCO', 'NA');
commit;

update cc_a_adhoc_job 
set is_pending=0
where adhoc_job_id = 3705;
commit;
