alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6374';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6375';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6377';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6378';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6380';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6381';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Transfer' where queue_number = '6382';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6383';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6384';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6386';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6387';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Transfer' where queue_number = '6388';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6389';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6390';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6391';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6392';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6393';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Inbound' where queue_number = '6394';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'IVR' where queue_number = '6400';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Voicemail' where queue_number = '6401';
update cc_c_contact_queue set unit_of_work_name = 'SCEB - '||unit_of_work_name, queue_type = 'Survey' where queue_number = '6402';


update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - No Agent', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6618';
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - RONA', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6619';
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6620';
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - English - CSR 2', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6621';
update cc_c_contact_queue set queue_type = 'Transfer', unit_of_work_name = '1095 - English - Escalation', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6622';
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6623';
update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish - CSR 2', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6624';
update cc_c_contact_queue set queue_type = 'IVR', unit_of_work_name = '1095 - IVR', interval_minutes = '15', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6625';


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Benefits','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Benefits','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Eligibility','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Eligibility','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Enrollment','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Enrollment','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Escalation','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - General','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - General','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Provider','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Provider','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Services','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Services','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Status','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Status','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - IVR','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),0,1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Voicemail','VOICEMAIL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Survey','SURVEY',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR 2','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - Escalation','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR 2','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - IVR','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),0,1);


insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Benefits','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Benefits','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Eligibility','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Eligibility','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Enrollment','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Enrollment','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Escalation','TRANSFER',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - General','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - General','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Provider','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Provider','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Services','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Services','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Status','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Status','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - IVR','IVR',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Voicemail','VOICEMAIL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Survey','SURVEY',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - No Agent','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - RONA','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR 2','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - Escalation','TRANSFER',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR 2','INBOUND_CALL',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - IVR','IVR',15,'N','Seconds');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE','5082','Fort Pierce');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT','5082','SCEB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM','5082','Managed Care');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE','5083','Fort Pierce');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT','5083','SCEB');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM','5083','Managed Care');


update cc_a_list_lkup set out_var = '5082,'||out_var where name like 'Desk_settings_ids%';
update cc_a_list_lkup set out_var = '5083,'||out_var where name like 'Desk_settings_ids%';


commit;