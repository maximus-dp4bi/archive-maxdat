alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue set queue_type = 'Escalation' where queue_number = '6382';
update cc_c_contact_queue set queue_type = 'Escalation' where queue_number = '6388';
update cc_c_contact_queue set queue_name = 'FLFP_1095_7842_SECSR_Q', unit_of_work_name = '1095 - English - CSR - Q' where queue_number = '6620';
update cc_c_contact_queue set queue_name = 'FLFP_1095_7842_SECSR2_Q', unit_of_work_name = '1095 - English - CSR 2 - Q' where queue_number = '6621';
update cc_c_contact_queue set queue_name = 'FLFP_1095_7842_SEESC_Q', unit_of_work_name = '1095 - English - Escalation - Q', queue_type = 'Escalation' where queue_number = '6622';
update cc_c_contact_queue set queue_name = 'FLFP_1095_7842_SSCSR_Q', unit_of_work_name = '1095 - Spanish - CSR - Q' where queue_number = '6623';
update cc_c_contact_queue set queue_name = 'FLFP_1095_7842_SSCSR2_Q', unit_of_work_name = '1095 - Spanish - CSR 2 - Q' where queue_number = '6624';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_Spanish_Transfer', unit_of_work_name = 'SCEB - Spanish - Transfer', service_percent = '30',  interval_minutes = '15', queue_type = 'Transfer', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6650';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_English_Transfer', unit_of_work_name = 'SCEB - English - Transfer', service_percent = '30',  interval_minutes = '15', queue_type = 'Transfer', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6651';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_English_CSR_Q', unit_of_work_name = 'SCEB - English - CSR - Q', service_percent = '30',  interval_minutes = '15', queue_type = 'Inbound', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6652';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_Spanish_CSR_Q', unit_of_work_name = 'SCEB - Spanish - CSR - Q', service_percent = '30',  interval_minutes = '15', queue_type = 'Inbound', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6653';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_English_NO_CSR', unit_of_work_name = 'SCEB - English - No CSR', service_percent = '30',  interval_minutes = '15', queue_type = 'Inbound', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6654';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_Escalation_NO_CSR', unit_of_work_name = 'SCEB - Escalation - No CSR', service_percent = '30',  interval_minutes = '15', queue_type = 'Escalation', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6655';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_Escalation_Q', unit_of_work_name = 'SCEB - Escalation - Q', service_percent = '30',  interval_minutes = '15', queue_type = 'Escalation', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6656';
update cc_c_contact_queue set queue_name = 'FLFP_SCEB_4642_Spanish_NO_CSR', unit_of_work_name = 'SCEB - Spanish - No CSR', service_percent = '30',  interval_minutes = '15', queue_type = 'Inbound', project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina' where queue_number = '6657';


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - CSR 2 - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English - Escalation - Q','ESCALATION',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish - CSR 2 - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - Transfer','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - Transfer','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - CSR - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - CSR - Q','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English - No CSR','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Escalation - No CSR','ESCALATION',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Escalation - Q','ESCALATION',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish - No CSR','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - CSR 2 - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English - Escalation - Q','ESCALATION','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish - CSR 2 - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - Transfer','TRANSFER','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - Transfer','TRANSFER','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - CSR - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - CSR - Q','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English - No CSR','INBOUND_CALL','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Escalation - No CSR','ESCALATION','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Escalation - Q','ESCALATION','15','N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish - No CSR','INBOUND_CALL','15','N','Seconds');


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5185);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5185, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5185, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5186);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5186, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5186, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5187);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5187, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5187, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5214);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5214, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5214, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5215);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5215, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5215, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5216);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5216, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5216, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5217);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5217, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5217, 'Managed Care');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5218);
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', 5218, 'SCEB');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', 5218, 'Managed Care');

commit;

