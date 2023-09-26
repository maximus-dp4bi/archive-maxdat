insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2013-09-29 00:00:00',
'2013-10-31 00:00:00',
'load_production_planning'
); 

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2013-11-01 00:00:00',
'2013-12-01 00:00:00',
'load_production_planning'
); 

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2013-12-01 00:00:00',
'2014-01-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-01-01 00:00:00',
'2014-02-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-02-01 00:00:00',
'2014-03-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-03-01 00:00:00',
'2014-04-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-04-01 00:00:00',
'2014-05-02 00:00:00',
'load_production_planning'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.8.3','100','100_INSERT_INTO_CC_A_ADHOC_JOB');

commit;

