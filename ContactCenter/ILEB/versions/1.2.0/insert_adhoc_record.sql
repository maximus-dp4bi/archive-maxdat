insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending)
values ('load_contact_center', to_date('2014/06/26', 'yyyy/mm/dd'), to_date('2014/06/27', 'yyyy/mm/dd'), to_date('2014/06/27', 'yyyy/mm/dd'), 1);

commit;