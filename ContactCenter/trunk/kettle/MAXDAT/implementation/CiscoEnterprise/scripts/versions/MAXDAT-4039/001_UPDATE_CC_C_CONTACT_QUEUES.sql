alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue 
set queue_type = 'Inbound' , service_seconds = 60, interval_minutes = 15, unit_of_work_name = 'GENERAL - CALL BACK', 
project_name = 'WC HS', program_name = 'WC HS', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '6243';

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC',8780);
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC',6243);

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT',8780,'WC HS' );
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM',8780,'WC HS' );

commit;