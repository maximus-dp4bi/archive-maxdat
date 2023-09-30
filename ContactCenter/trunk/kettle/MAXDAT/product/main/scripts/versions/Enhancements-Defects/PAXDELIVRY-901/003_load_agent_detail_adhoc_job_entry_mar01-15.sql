delete from cc_f_acd_agent_activity_detail
where d_date_id in (select d_date_id from cc_d_dates where d_date between '01-mar-20' and '15-mar-20');
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_agent_detail','2020-03-01 00:00:00','2020-03-16 00:00:00',1, 'CISCO', 'NA');
commit;