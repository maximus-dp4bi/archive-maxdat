alter session set current_schema = cisco_enterprise_cc;

/*insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2019-11-16 00:00:00','2019-11-17 00:00:00',1, 'CISCO', 'NA');
commit;
*/

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2019-11-30 00:00:00','2019-12-01 00:00:00',1, 'CISCO', 'NA');

commit;