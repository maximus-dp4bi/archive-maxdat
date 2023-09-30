insert into cc_d_region (region_id, region_name) values (2, 'Health Ops');
commit;

insert into cc_d_state (state_id, state_name) values (2, 'Tennessee');
commit;

insert into cc_d_program values (2, 'TN ERPC', 1);
commit;

insert into cc_d_project values (2, 'TN ERPC', 2, 1);
commit;

insert into cc_d_geography_master (geography_master_id, geography_name, country_id, state_id, province_id, district_id, region_id)
values
(2, 'Tennessee', 1, 2, 0, 0, 2);
commit;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
('TN ERPC', 'TN ERPC', 'Health Ops', 'Tenesse', 'Unknown', 'Unknown', 'USA', '01-JAN-00', '31-DEC-99');

commit;

insert into CC_D_SITE (site_name, site_description, version, record_eff_dt, record_end_dt)
values ('Folsom', 'Folsom Shared', 1, to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2099', 'mm/dd/yyyy'));

commit;

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt)
values
('Medicaid', 'INBOUND_CALL', '01-JAN-00', '31-DEC-99');

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit)
values
('Medicaid', 'INBOUND_CALL', 3, 'N', 'Seconds');

commit;

Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10478');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10479');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10480');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10481');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10402');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10403');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10407');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10408');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10409');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10410');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10411');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10412');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10413');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10414');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10415');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10416');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10417');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10418');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10419');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10420');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10421');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10422');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10423');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10424');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10425');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10426');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10427');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10428');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10429');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10430');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10431');

commit;


Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10402','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10403','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10407','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10408','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10409','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10410','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10411','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10412','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10413','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10414','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10415','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10416','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10417','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10418','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10419','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10420','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10421','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10422','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10423','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10424','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10425','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10426','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10427','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10428','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10429','TN ERPC');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10430','TN ERPC');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10431','TN ERPC');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10402','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10403','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10407','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10408','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10409','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10410','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10411','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10412','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10413','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10414','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10415','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10416','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10417','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10418','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10419','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10420','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10421','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10422','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10423','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10424','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10425','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10426','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10427','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10428','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10429','TN ERPC');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10430','TN ERPC');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10431','TN ERPC');

commit;

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10478, 'TN_ENG_s', 'Inbound', 0, 55, 15, 'Medicaid', 'TN ERPC', 'TN ERPC', 'East', 'Tennessee', 'Unknown', 'Unknown', 'USA', '01-JAN-00', '31-DEC-99');

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10479, 'MH_Mbr_CustSvc_s', 'Inbound', 0, 55, 15, 'Inbound English', 'MassHealth', 'MassHealth', 'East', 'Massachusetts', 'Unknown', 'Unknown', 'USA', '01-JAN-00', '31-DEC-99');

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10480, 'TN_SPAN_s', 'Inbound', 0, 55, 15, 'Medicaid', 'TN ERPC', 'TN ERPC', 'East', 'Tennessee', 'Unknown', 'Unknown', 'USA', '01-JAN-00', '31-DEC-99');

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10481, 'TN_OTHLANG_s', 'Inbound', 0, 55, 15, 'Medicaid', 'TN ERPC', 'TN ERPC', 'East', 'Tennessee', 'Unknown', 'Unknown', 'USA', '01-JAN-00', '31-DEC-99');

commit;

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10478, 'TN_ENG_s', 'Inbound', 0, 55, 15, '01-JAN-00', '31-DEC-99', 0, 0, 1);

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10479, 'MH_Mbr_CustSvc_s', 'Inbound', 0, 55, 15, '01-JAN-00', '31-DEC-99', 0, 0, 1);

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10480, 'TN_SPAN_s', 'Inbound', 0, 55, 15, '01-JAN-00', '31-DEC-99', 0, 0, 1);

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10481, 'TN_OTHLANG_s', 'Inbound', 0, 55, 15, '01-JAN-00', '31-DEC-99', 0, 0, 1);

commit;
