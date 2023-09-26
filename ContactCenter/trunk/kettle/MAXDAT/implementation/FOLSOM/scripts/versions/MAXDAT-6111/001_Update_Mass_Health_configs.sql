ALTER SESSION SET CURRENT_SCHEMA = FOLSOM_SHARED_CC;

/* CONTACT QUEUE */

update cc_c_contact_queue set unit_of_work_name = 'Boston MA Pay Reform', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'MassHealth', program_name = 'MassHealth', region_name = 'East', state_name = 'Massachusetts' where queue_number =10488;
update cc_c_contact_queue set unit_of_work_name = 'Boston MBR Pay Reform', service_seconds = '30', interval_minutes = '15', queue_type = 'Inbound', project_name = 'MassHealth', program_name = 'MassHealth', region_name = 'East', state_name = 'Massachusetts' where queue_number =10485;

/* SKILL SET */
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10444');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10435');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10439');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10440');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10441');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '10442');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10444', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10435', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10439', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10440', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10441', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10442', 'MassHealth');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10444', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10435', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10439', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10440', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10441', 'MassHealth');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10442', 'MassHealth');

/* UOW */
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Boston MA Pay Reform','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Boston MA Pay Reform','INBOUND_CALL',1,'N','Seconds');

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('Boston MBR Pay Reform','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Boston MBR Pay Reform','INBOUND_CALL',1,'N','Seconds');



COMMIT;