update cc_c_lookup set lookup_values='SWCC' where lookup_type='WFM_GROUP_PROGRAM' and lookup_key='1001';

insert into cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values('load_contact_center','2014-07-15 00:00:00','2014-07-16 00:00:00','07-AUG-2014',1);

commit;
