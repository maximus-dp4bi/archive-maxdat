insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-03-21 00:00:00',
'2014-03-28 00:00:00',
'load_production_planning'
); 

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-03-29 00:00:00',
'2014-04-05 00:00:00',
'load_production_planning'
); 

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.8.2','100','100_INSERT_INTO_CC_A_ADHOC_JOB');

commit;

