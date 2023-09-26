insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10483, 'MH_HC_1095B_s', 'Inbound', 0, 55, 15, 'Inbound English', 'MassHealth', 'MassHealth', 'East', 'Massachusetts', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2199', 'mm/dd/yyyy'));

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, service_percent, service_seconds, interval_minutes, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
(10484, 'MH_HC_1095B_Spanish_s', 'Inbound', 0, 55, 15, 'Inbound Spanish', 'MassHealth', 'MassHealth', 'East', 'Massachusetts', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2199', 'mm/dd/yyyy'));

commit;

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10483, 'MH_HC_1095B_s', 'Inbound', 0, 55, 15, to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2199', 'mm/dd/yyyy'), 0, 0, 1);

insert into cc_d_contact_queue(QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,INTERVAL_MINUTES,RECORD_EFF_DT,RECORD_END_DT,SOURCE_QUEUE,QUEUE_GROUP,
VERSION) values (10484, 'MH_HC_1095B_Spanish_s', 'Inbound', 0, 55, 15, to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2199', 'mm/dd/yyyy'), 0, 0, 1);

commit;

Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10483');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_APPLICATION_ID_INC','10484');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10433');
Insert into CC_C_FILTER (FILTER_TYPE,VALUE) values ('ACD_SKILL_GROUP_INC','10434');

commit;

Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10433','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROGRAM','10434','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10433','MassHealth');
Insert into CC_C_LOOKUP (LOOKUP_TYPE,LOOKUP_KEY,LOOKUP_VALUE) values ('ACD_SKILLSET_PROJECT','10434','MassHealth');

commit;