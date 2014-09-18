-- insert a record to load contact center

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '07/29/2014 00:00:00', '07/30/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '07/30/2014 00:00:00', '07/31/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '07/31/2014 00:00:00', '08/01/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/01/2014 00:00:00', '08/02/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/02/2014 00:00:00', '08/03/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/03/2014 00:00:00', '08/04/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/04/2014 00:00:00', '08/05/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/05/2014 00:00:00', '08/06/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/06/2014 00:00:00', '08/07/2014 00:00:00', sysdate, 1, 0, 0);

insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, creation_date, is_pending, is_running, success)
values ('load_contact_center', '08/07/2014 00:00:00', '08/08/2014 00:00:00', sysdate, 1, 0, 0);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.2','004','004_INSERT_ADHOC_RECORDS');

commit;