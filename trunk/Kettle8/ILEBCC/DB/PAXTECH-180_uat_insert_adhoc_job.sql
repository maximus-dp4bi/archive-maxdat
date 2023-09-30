alter session set current_schema = maxdat_cc;
alter session set nls_date_format="dd-mon-yy hh24:mi:ss";


insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2021-03-08 00:00:00','2021-03-09 00:00:00',1, 'AVAYA', 'NA');
commit;