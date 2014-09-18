insert into CC_A_SCHEDULED_JOB (scheduled_job_type, start_datetime_param, end_datetime_param, job_start_date, job_end_date, is_running, success)
values ('flatten_project_facts', to_char(sysdate - 1, 'yyyy/mm/dd'), to_char(sysdate - 1, 'yyyy/mm/dd'), sysdate - 1, sysdate - 1, 0, 1);

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('1.3.0',001,'001_SEED_FLATTEN_SCHEDULED_JOB');

commit;