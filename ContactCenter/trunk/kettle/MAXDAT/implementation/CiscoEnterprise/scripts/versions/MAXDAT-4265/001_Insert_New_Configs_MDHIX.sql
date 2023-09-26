alter session set current_schema = cisco_enterprise_cc;

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Inbound', Service_Percent = 0, Service_seconds = 60, Interval_Minutes = 15, Unit_of_work_name = 'DENTAL', Project_Name = 'MD HIX', Program_Name = 'MD HIX', Region_name = 'Eastern', State_name = 'Maryland'
WHERE QUEUE_NUMBER IN (6332,
6334,
6341,
6342,
6343,
6344,
6346
);

UPDATE CC_C_CONTACT_QUEUE
SET QUEUE_TYPE = 'Transfer', Service_Percent = 0, Service_seconds = 60, Interval_Minutes = 15, Unit_of_work_name = 'QHP', Project_Name = 'MD HIX', Program_Name = 'MD HIX', Region_name = 'Eastern', State_name = 'Maryland'
WHERE QUEUE_NUMBER IN (6333,
6335,
6336,
6337,
6338,
6339,
6340,
6345
);

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr)
values ('DENTAL','INBOUND_CALL',TO_DATE('01/01/1900','MM/DD/YYYY'), TO_DATE('12/31/2199','MM/DD/YYYY'), 1,0);

INSERT INTO CC_D_UNIT_OF_WORK(UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR)
VALUES ('DENTAL', 'INBOUND_CALL',  11, 'N', 'Seconds', 1,0);

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6332');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6333');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6334');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6335');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6336');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6337');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6338');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6339');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6340');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6341');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6342');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6343');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6344');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6345');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '6346');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5179');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5180');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5179', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '51780', 'MD HIX');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5179', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5180', 'MD HIX');

commit;