insert into cc_c_unit_of_work(unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) values ('Concierge',to_date('1900/01/01','yyyy/mm/dd'), to_date('2999/12/31','yyyy/mm/dd'), 'INBOUND_CALL');

commit;


insert into cc_d_unit_of_work(unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category) values ('Concierge', 0, 'N', 'Seconds', 'INBOUND_CALL');

commit;


insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10114', 'Health Connect English Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10115', 'Health Connect Spanish Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10116', 'ICP English Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10117', 'ICP Spanish Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10118', 'MAI English Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10119', 'MAI Spanish Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10120', 'MMC English Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10121', 'MMC Spanish Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10122', 'VMC English Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

insert into cc_c_contact_queue(queue_number, queue_name, queue_type, service_percent, service_seconds, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt, interval_minutes) values ('10123', 'VMC Spanish Concierge', 'Inbound', 0, 0, 'Concierge', 'IL EB', 'EB', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd') ,to_date('2999/12/31', 'yyyy/mm/dd'), 15 );

commit;

insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10114', 'HC_EN_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10115', 'HC_SP_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10116', 'ICP_EN_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10117', 'ICP_SP_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10118', 'MAI_EN_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10119', 'MAI_SP_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10120', 'MMC_EN_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10121', 'MMC_SP_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10122', 'VMC_EN_CON_s', 0, 'Inbound', 0, 1);
insert into cc_d_contact_queue(queue_number, queue_name, source_queue, queue_type, queue_group, version) values ('10123', 'VMC_SP_CON_s', 0, 'Inbound', 0, 1);

commit;

insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10114');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10115');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10118');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10119');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10120');
insert into cc_c_filter(filter_type, value) values ('ACD_SKILL_GROUP_INC', '10121');

commit;

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10114', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10115', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10118', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10119', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10120', 'IL EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10121', 'IL EB');


insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10114', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10115', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10118', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10119', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10120', 'EB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10121', 'EB');

commit;

update cc_c_lookup
set lookup_value = 'EB'
where lookup_key in ('10116','10117')
and lookup_type = 'ACD_SKILLSET_PROGRAM';

update cc_c_lookup
set lookup_value = 'IL EB'
where lookup_key in ('10116','10117')
and lookup_type = 'ACD_SKILLSET_PROJECT';

commit;
