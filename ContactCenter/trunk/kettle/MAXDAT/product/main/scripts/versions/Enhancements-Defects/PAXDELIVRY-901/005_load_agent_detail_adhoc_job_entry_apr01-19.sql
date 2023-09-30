-- deletes 436222 rows
delete from cc_f_acd_agent_activity_detail
where d_date_id in (select d_date_id from cc_d_dates where d_date between '01-apr-20' and '19-apr-20');
commit;

--deletes 685019 rows
delete from cc_s_acd_agent_activity_detail
where activity_dt between '01-apr-20' and '19-apr-20';
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_agent_detail','2020-04-01 00:00:00','2020-04-20 00:00:00',1, 'CISCO', 'NA');
commit;