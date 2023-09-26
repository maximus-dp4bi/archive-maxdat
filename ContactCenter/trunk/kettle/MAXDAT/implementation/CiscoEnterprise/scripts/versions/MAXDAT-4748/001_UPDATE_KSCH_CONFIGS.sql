update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = null, interval_minutes = 15, unit_of_work_name = 'Liaison 1', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6455';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = null, interval_minutes = 15, unit_of_work_name = 'Liaison 2', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6456';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = null, interval_minutes = 15, unit_of_work_name = 'Liaison 3', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6457';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = null, interval_minutes = 15, unit_of_work_name = 'Liaison 4', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6458';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 0, interval_minutes = 15, unit_of_work_name = 'Liaison 1', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6460';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 0, interval_minutes = 15, unit_of_work_name = 'Liaison 2', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6461';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 0, interval_minutes = 15, unit_of_work_name = 'Liaison 3', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6462';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 0, interval_minutes = 15, unit_of_work_name = 'Liaison 4', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6463';
update cc_c_contact_queue set queue_type = 'Voicemail' , service_seconds = 0, interval_minutes = 15, unit_of_work_name = 'Voicemail', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6464';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = null, interval_minutes = 15, unit_of_work_name = 'IVR', project_name = 'KS CH', program_name = 'KS CH', region_name = 'Central', state_name = 'Kansas' where queue_number = '6459';

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC',5196 );
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC',5197 );
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC',5198 );
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC',5199 );

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5196', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5197', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5198', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5199', 'KS CH');

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5196', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5197', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5198', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5199', 'KS CH');

commit;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Liaison 1', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Liaison 2', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Liaison 3', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Liaison 4', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Liaison 1', 'INBOUND_CALL', 154, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Liaison 2', 'INBOUND_CALL', 154, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Liaison 3', 'INBOUND_CALL', 154, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Liaison 4', 'INBOUND_CALL', 154, 'N', 'Seconds');

commit;