/* MAXDAT-3370 */

alter session set current_schema = CISCO_ENTERPRISE_CC;

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5488');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5489');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5490');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5491');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5492');

commit;

update cc_a_list_lkup
set out_var = out_var || ',5021,5022'
where list_type = 'DESK_SETTINGS';

commit;

update cc_c_contact_queue
set region_name = 'Eastern'
where queue_name like 'MI%';

UPDATE CC_C_PROJECT_CONFIG
SET REGION_NAME = 'Eastern'
WHERE PROJECT_NAME = 'MIEB';

update CC_D_GEOGRAPHY_MASTER
SET REGION_ID = 2
WHERE GEOGRAPHY_NAME = 'Michigan';

COMMIT;