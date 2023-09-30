delete from cc_c_lookup
where lookup_id in (83
,92
,368
,377);


commit;

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-03-31 00:00:00',
'2014-04-01 00:00:00',
'load_contact_center'
);

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-04-01 00:00:00',
'2014-04-02 00:00:00',
'load_contact_center'
);

insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','Austin');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.7','100','100_DELETE_DUPLICATES_IN_CC_C_LOOKUP_PRD');

commit;

