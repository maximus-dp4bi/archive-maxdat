ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6775;
update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6776;
update cc_c_contact_queue set unit_of_work_name = 'Spanish', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6777;
update cc_c_contact_queue set unit_of_work_name = 'Spanish', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6778;


/* SKILL SET */
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5181');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5182');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5229');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5230');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5181', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5181', 'Medicaid / CHIP');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5182', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5182', 'Medicaid / CHIP');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5229', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5229', 'Medicaid / CHIP');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5230', 'Wyoming Dept of Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5230', 'Medicaid / CHIP');



COMMIT;