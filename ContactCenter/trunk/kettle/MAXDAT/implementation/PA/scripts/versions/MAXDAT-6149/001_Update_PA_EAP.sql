ALTER SESSION SET CURRENT_SCHEMA = MAXDAT_PA;


insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10045');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10046');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10045', 'PA EAP');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10045', 'Enrollment Assistance Program');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10046', 'PA EAP');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10046', 'Enrollment Assistance Program');

commit;
------------------------------------------------

update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'PA EAP', program_name = 'Enrollment Assistance Program', region_name = 'Eastern', state_name = 'Pennsylvania' where queue_number =10054;
update cc_c_contact_queue set unit_of_work_name = 'Spanish', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'PA EAP', program_name = 'Enrollment Assistance Program', region_name = 'Eastern', state_name = 'Pennsylvania' where queue_number =10056;

insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10054');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10056');

commit;

