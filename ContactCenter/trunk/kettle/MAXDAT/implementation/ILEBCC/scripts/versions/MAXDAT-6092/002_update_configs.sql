alter session set current_schema = maxdat_cc;

update cc_c_contact_queue
set queue_name = 'MMCP Inbound English', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'MMCP English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10156;

update cc_c_contact_queue
set queue_name = 'MMCP Inbound Spanish', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'MMCP Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10157;

update cc_c_contact_queue
set queue_name = 'MMCP Outbound English', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'MMCP English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10158;

update cc_c_contact_queue
set queue_name = 'MMCP Outbound Spanish', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'MMCP Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10159;

update cc_c_contact_queue
set queue_name = 'MMCP English Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10160;

update cc_c_contact_queue
set queue_name = 'MMCP Spanish Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10161;

update cc_c_contact_queue
set queue_name = 'LMMCP Inbound English', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMMCP English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10162;

update cc_c_contact_queue
set queue_name = 'LMMCP Inbound Spanish', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMMCP Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10163;

update cc_c_contact_queue
set queue_name = 'LMMCP Outbound English', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMMCP English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10164;

update cc_c_contact_queue
set queue_name = 'LMMCP Outbound Spanish', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMMCP Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10165;

update cc_c_contact_queue
set queue_name = 'LMMCP English Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10166;

update cc_c_contact_queue
set queue_name = 'LMMCP Spanish Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10167;

update cc_c_contact_queue
set queue_name = 'LMAI Inbound English', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMAI English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10168;

update cc_c_contact_queue
set queue_name = 'LMAI Inbound Spanish', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMAI Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10169;

update cc_c_contact_queue
set queue_name = 'LMAI Outbound English', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMAI English', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10170;

update cc_c_contact_queue
set queue_name = 'LMAI Outbound Spanish', queue_type = 'Outbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'LMAI Spanish', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10171;

update cc_c_contact_queue
set queue_name = 'LMAI English Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10172;

update cc_c_contact_queue
set queue_name = 'LMAI Spanish Concierge', queue_type = 'Inbound', service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'Concierge', project_name = 'IL EB', program_name = 'Multiple', region_name = 'Central', state_name = 'Illinois'
where queue_number = 10173;

commit;

alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('MMCP English', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('MMCP Spanish', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('LMMCP English', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('LMMCP Spanish', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('LMAI English', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values  ('LMAI Spanish', 'INBOUND', '1900-01-01 00:00:00', '2999-12-31 00:00:00');

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MMCP English', 'INBOUND', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('MMCP Spanish', 'INBOUND', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('LMMCP English', 'INBOUND', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('LMMCP Spanish', 'INBOUND', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('LMAI English', 'INBOUND', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('LMAI Spanish', 'INBOUND', 0, 'N', 'Seconds');

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10171');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10172');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10173');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10174');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10175');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10176');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10177');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10178');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10179');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10180');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10181');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10182');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10183');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10184');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10185');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10186');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10187');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC','10188');

INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10156);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10157);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10158);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10159);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10160);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10161);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10162);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10163);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10164);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10165);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10166);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10167);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10168);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10169);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10170);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10171);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10172);
INSERT INTO CC_C_FILTER (FILTER_TYPE, VALUE) VALUES ('ACD_APPLICATION_ID_INC', 10173);


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10171', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10171', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10172', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10172', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10173', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10173', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10174', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10174', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10175', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10175', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10176', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10176', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10177', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10177', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10178', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10178', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10179', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10179', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10180', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10180', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10181', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10181', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10182', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10182', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10183', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10183', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10184', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10184', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10185', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10185', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10186', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10186', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10187', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10187', 'Multiple');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '10188', 'IL EB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '10188', 'Multiple');

commit;