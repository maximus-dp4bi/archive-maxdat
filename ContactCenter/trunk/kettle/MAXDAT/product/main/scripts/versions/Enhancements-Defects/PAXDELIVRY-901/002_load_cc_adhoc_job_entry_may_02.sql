delete from cc_f_acd_agent_activity_detail
where d_date_id = (select d_date_id from cc_d_dates where d_date ='02-may-20');
commit;

delete from cc_s_acd_agent_activity_detail
where activity_dt between '02-may-20' and '02-may-20';
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2020-05-02 00:00:00','2020-05-03 00:00:00',1, 'CISCO', 'NA');
commit;