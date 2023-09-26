
insert into cc_a_adhoc_job (adhoc_job_type, start_datetime_param, end_datetime_param, is_pending)
values('MAX_NUMBER_OF_AGENTS_IN_TRAINING', '2014/04/01', '2015/10/01', 1);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','002','002_INSERT_CC_A_ADHOC_JOB');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('3.1','003','003_INSERT_CC_A_ADHOC_JOB');

commit;