update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'P4HB English', project_name = 'GA IES', program_name = 'GA Healthy Babies', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6063';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'PeachCare IVR', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6087';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'P4HB IVR', project_name = 'GA IES', program_name = 'GA Healthy Babies', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6088';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GA IES Supervisor Transfer', project_name = 'GA IES', program_name = 'GA PeachCare CHIP', region_name = 'Eastern', state_name = 'Georgia' where queue_number = '6089';

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 5147);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 5148);

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5147', 'GA IES');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5148', 'GA IES');

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5147', 'GA PeachCare CHIP');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5148', 'GA PeachCare CHIP');

commit;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('PeachCare IVR', 'CONTACTS_CREATED', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('P4HB IVR', 'CONTACTS_CREATED', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('GA IES Supervisor Transfer', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('PeachCare IVR', 'CONTACTS_CREATED', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('P4HB IVR', 'CONTACTS_CREATED', 145, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('GA IES Supervisor Transfer', 'TRANSFER', 145, 'N', 'Seconds');

commit;

-- update the wrong queue back to unknown

update cc_c_contact_queue set queue_type = 'Unknown' , service_seconds = 0, interval_minutes = null, unit_of_work_name = 'Unknown', project_name = 'Unknown', program_name = 'Unknown', region_name = 'Unknown', state_name = 'Unknown' where queue_number = '6033';

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6071 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6072 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6073 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6074 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6075 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6076 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6077 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6078 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6079 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6080 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6081 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6082 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6083 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6084 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6085 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6086 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6090 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6091 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6092 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6093 );
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE',6094 );

commit;


