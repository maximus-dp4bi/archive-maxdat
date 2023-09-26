
insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, is_pending) values ('WEEKLY', '2015/09/13', '2015/09/19', 1);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','004','004_INSERT_CC_A_ADHOC_JOB');

commit;