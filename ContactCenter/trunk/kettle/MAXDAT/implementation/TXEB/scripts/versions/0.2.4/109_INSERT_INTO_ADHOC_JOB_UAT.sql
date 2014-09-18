update CC_A_SCHEDULED_JOB
set is_running=0,
start_datetime_param='2014-06-18 00:00:00'
where scheduled_job_id=888;

commit;


insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-12 00:00:00',
'2014-06-13 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-13 00:00:00',
'2014-06-14 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-14 00:00:00',
'2014-06-15 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-16 00:00:00',
'2014-06-17 00:00:00',
'load_production_planning'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-06-17 00:00:00',
'2014-06-18 00:00:00',
'load_production_planning'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','109','109_INSERT_INTO_ADHOC_JOB_UAT');

commit;


commit;