
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
'2014-03-08 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-03-10 00:00:00',
'2014-04-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-04-01 00:00:00',
'2014-05-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-05-01 00:00:00',
'2014-06-01 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-01 00:00:00',
'2014-06-19 00:00:00',
'load_production_planning'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','108','108_INSERT_INTO_CC_A_ADHOC_JOB');

commit;

