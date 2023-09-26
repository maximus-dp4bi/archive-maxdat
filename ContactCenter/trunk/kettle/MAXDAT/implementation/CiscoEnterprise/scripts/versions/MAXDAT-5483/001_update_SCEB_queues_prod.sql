alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'SCEB - After Hours'
where queue_number = 6376;

update cc_c_contact_queue
set service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6376;

update cc_c_contact_queue
set service_seconds = 500
where queue_number in (6620, 6621, 6623, 6624)
and project_name = 'SCEB';

update cc_c_contact_queue
set service_seconds = 30, queue_type = 'Inbound'
where queue_number in (6622, 6656)
and project_name = 'SCEB';

update cc_c_contact_queue
set service_seconds = 20
where queue_number in (6652, 6653)
and project_name = 'SCEB';

update cc_c_contact_queue
set queue_type = 'IVR', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number in (6734,
6735,
6736,
6737,
6738,
6739,
6740,
6741
);

update cc_c_contact_queue
set queue_type = 'Inbound'
where queue_number in (6388, 6655);

update cc_c_contact_queue
set queue_type = 'Voicemail'
where queue_number = 6402;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'SCEB - After Hours', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6385;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = '1095 - After Hours', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number in (6613, 6616); 

update cc_c_contact_queue
set unit_of_work_name = 'SCEB - IVR'
where queue_number in (6734,
6735,
6736
);

update cc_c_contact_queue
set unit_of_work_name = '1095 - IVR'
where queue_number in (6737,
6738,
6739,
6740,
6741
);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR 2 - No Agent', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6704;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR - No Agent', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6707;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR - RONA', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6708;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR 2 - RONA', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6705;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR 2 - No Agent', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6711;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR 2 - RONA', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6712;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR - No Agent', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6715;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR - RONA', service_seconds = 30, interval_minutes = 15, project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number = 6716;

update cc_c_contact_queue
set service_seconds = 30
where queue_number in (6618,
6619,
6625,
6650,
6651,
6654,
6655,
6657
);

update cc_c_contact_queue
set queue_type = 'Unknown'
where project_name = 'SCEB'
and queue_number in (6374,
6375,
6377,
6378,
6380,
6381,
6382,
6383,
6384,
6386,
6387,
6391,
6392,
6393,
6394,
6650,
6651
);

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_AFTR'
where queue_name = 'FLSC_1095_7842_AFTR'
and queue_number = 6613;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_HLDY'
where queue_name = 'FLSC_1095_7842_HLDY'
and queue_number = 6616;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_NOAGT'
where queue_name = 'FLSC_1095_7842_NOAGT'
and queue_number = 6618;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_RONA'
where queue_name = 'FLSC_1095_7842_RONA'
and queue_number = 6619;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_SM1_024802'
where queue_name = 'FLSC_1095_SM1_024802'
and queue_number = 6625;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - After Hours','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - After Hours','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR 2 - No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR 2 - RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR - No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR - RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR 2 - No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR 2 - RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR - No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR - RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);


insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - After Hours','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - After Hours','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR 2 - No Agent','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR 2 - RONA','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR - No Agent','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR - RONA','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR 2 - No Agent','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR 2 - RONA','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR - No Agent','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR - RONA','INBOUND_CALL',15,'N','Seconds');

commit;

