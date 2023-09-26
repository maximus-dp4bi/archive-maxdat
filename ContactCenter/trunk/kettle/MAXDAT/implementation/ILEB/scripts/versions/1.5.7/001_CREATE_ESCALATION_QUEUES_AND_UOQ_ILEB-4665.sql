insert into cc_c_unit_of_work(unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) values ('EB Escalation English',to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd') , 'ESCALATED_CALL');
insert into cc_c_unit_of_work(unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) values ('EB Escalation Spanish',to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd') , 'ESCALATED_CALL');
insert into cc_c_unit_of_work(unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) values ('EEV Escalation English',to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd') , 'ESCALATED_CALL');
insert into cc_c_unit_of_work(unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) values ('EEV Escalation Spanish',to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd') , 'ESCALATED_CALL');


insert into cc_d_unit_of_work(unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category) values ('EB Escalation English', 0, 'N', 'Seconds', 'ESCALATED_CALL');
insert into cc_d_unit_of_work(unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category) values ('EB Escalation Spanish', 0, 'N', 'Seconds', 'ESCALATED_CALL');
insert into cc_d_unit_of_work(unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category) values ('EEV Escalation English', 0, 'N', 'Seconds', 'ESCALATED_CALL');
insert into cc_d_unit_of_work(unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category) values ('EEV Escalation Spanish', 0, 'N', 'Seconds', 'ESCALATED_CALL');

commit;

update cc_c_filter
set filter_type = 'ACD_APPLICATION_ID_INC'
where filter_type = 'ACD_APPLICATION_ID_IGNORE'
and value in ('10102','10105','10106');

commit;

insert into cc_c_filter(filter_type, value) values ('ACD_APPLICATION_ID_INC', '10103');

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10105', 'EB Escalation English', 'Escalation', 0, 0, 'EB Escalation English', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );
insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10106', 'EB Escalation Spanish', 'Escalation', 0, 0, 'EB Escalation Spanish', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );
insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10102', 'EEV Escalation Spanish', 'Escalation', 0, 0, 'EEV Escalation Spanish', 'IL EEV', 'EEV', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );
insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10103', 'EEV Escalation English', 'Escalation', 0, 0, 'EEV Escalation English', 'IL EEV', 'EEV', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10116');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10117');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10122');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10123');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10116', 'IL EEV');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10117', 'IL EEV');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10122', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10123', 'IL EB');


insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10116', 'EEV');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10117', 'EEV');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10122', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10123', 'EB');


commit;
