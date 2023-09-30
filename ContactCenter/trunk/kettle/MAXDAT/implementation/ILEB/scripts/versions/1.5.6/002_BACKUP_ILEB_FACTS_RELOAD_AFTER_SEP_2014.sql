create table CC_F_ABD_JJH_20141104 as select * from CC_F_AGENT_BY_DATE where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
create table CC_F_AABD_JJH_20141104 as select * from CC_F_AGENT_ACTIVITY_BY_DATE where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
create table CC_F_AQI_JJH_20141104 as select * from CC_F_ACTUALS_QUEUE_INTERVAL where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
create table CC_S_AI_JJH_20141104 as select * from CC_S_ACD_INTERVAL where TRUNC(INTERVAL_DATE)>='01-Sep-2014';
create table CC_S_AAA_JJH_20141104 as select * from CC_S_ACD_AGENT_ACTIVITY where TRUNC(AGENT_CALLS_DT)>='01-Sep-2014';

delete from CC_F_AGENT_BY_DATE where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
commit;
delete from CC_F_AGENT_ACTIVITY_BY_DATE where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
commit;
delete from CC_F_ACTUALS_QUEUE_INTERVAL where D_DATE_ID>=(select d_date_id from cc_d_dates where d_date='01-Sep-2014');
commit;
delete from CC_S_ACD_INTERVAL where TRUNC(INTERVAL_DATE)>='01-Sep-2014';
commit;
delete from CC_S_ACD_AGENT_ACTIVITY where TRUNC(AGENT_CALLS_DT)>='01-Sep-2014';
commit;

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-01 00:00:00','2014-09-02 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-02 00:00:00','2014-09-03 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-03 00:00:00','2014-09-04 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-04 00:00:00','2014-09-05 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-05 00:00:00','2014-09-06 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-06 00:00:00','2014-09-07 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-07 00:00:00','2014-09-08 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-08 00:00:00','2014-09-09 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-09 00:00:00','2014-09-10 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-10 00:00:00','2014-09-11 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-11 00:00:00','2014-09-12 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-12 00:00:00','2014-09-13 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-13 00:00:00','2014-09-14 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-14 00:00:00','2014-09-15 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-15 00:00:00','2014-09-16 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-16 00:00:00','2014-09-17 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-17 00:00:00','2014-09-18 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-18 00:00:00','2014-09-19 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-19 00:00:00','2014-09-20 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-20 00:00:00','2014-09-21 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-21 00:00:00','2014-09-22 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-22 00:00:00','2014-09-23 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-23 00:00:00','2014-09-24 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-24 00:00:00','2014-09-25 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-25 00:00:00','2014-09-26 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-26 00:00:00','2014-09-27 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-27 00:00:00','2014-09-28 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-28 00:00:00','2014-09-29 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-29 00:00:00','2014-09-30 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-09-30 00:00:00','2014-10-01 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-01 00:00:00','2014-10-02 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-02 00:00:00','2014-10-03 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-03 00:00:00','2014-10-04 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-04 00:00:00','2014-10-05 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-05 00:00:00','2014-10-06 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-06 00:00:00','2014-10-07 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-07 00:00:00','2014-10-08 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-08 00:00:00','2014-10-09 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-09 00:00:00','2014-10-10 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-10 00:00:00','2014-10-11 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-11 00:00:00','2014-10-12 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-12 00:00:00','2014-10-13 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-13 00:00:00','2014-10-14 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-14 00:00:00','2014-10-15 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-15 00:00:00','2014-10-16 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-16 00:00:00','2014-10-17 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-17 00:00:00','2014-10-18 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-18 00:00:00','2014-10-19 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-19 00:00:00','2014-10-20 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-20 00:00:00','2014-10-21 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-21 00:00:00','2014-10-22 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-22 00:00:00','2014-10-23 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-23 00:00:00','2014-10-24 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-24 00:00:00','2014-10-25 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-25 00:00:00','2014-10-26 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-26 00:00:00','2014-10-27 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-27 00:00:00','2014-10-28 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-28 00:00:00','2014-10-29 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-29 00:00:00','2014-10-30 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-30 00:00:00','2014-10-31 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-10-31 00:00:00','2014-11-01 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-01 00:00:00','2014-11-02 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-02 00:00:00','2014-11-03 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-03 00:00:00','2014-11-04 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-04 00:00:00','2014-11-05 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-05 00:00:00','2014-11-06 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-11-06 00:00:00','2014-11-07 00:00:00','05-NOV-2014',1);
commit;
insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_production_planning','2014-11-07 00:00:00','2014-11-08 00:00:00','05-NOV-2014',1);
commit;



