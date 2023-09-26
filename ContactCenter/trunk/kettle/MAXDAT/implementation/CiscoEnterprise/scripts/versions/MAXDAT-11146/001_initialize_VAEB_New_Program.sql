alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('VA EB', 'Member Inquiry Helpline', 'Eastern', 'Virginia', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Member Inquiry Helpline', 1 );

commit;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Closed','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Emergency','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR EO','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Error','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Holiday','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Menu Option 0','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Menu Option 1','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Menu Option 2','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Menu Option 3','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Open','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Start','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Timeout','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Weather Clsoed','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH English','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH RONA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH Spanish','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH IVR Main Entry Point','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH Eng No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAEB MIH Spa No Agent','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Closed','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Emergency','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR EO','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Error','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Holiday','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Menu Option 0','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Menu Option 1','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Menu Option 2','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Menu Option 3','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Open','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Start','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Timeout','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Weather Clsoed','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH English','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH RONA','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH Spanish','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH IVR Main Entry Point','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH Eng No Agent','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAEB MIH Spa No Agent','INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Closed', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8259;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Emergency', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8260;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR EO', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8261;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Error', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8262;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Holiday', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8263;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Menu Option 0', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8264;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Menu Option 1', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8265;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Menu Option 2', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8266;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Menu Option 3', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8267;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Open', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8268;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Start', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8269;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Timeout', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8270;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Weather Clsoed', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8271;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAEB MIH English', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8272;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAEB MIH RONA', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8273;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAEB MIH Spanish', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8274;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'VAEB MIH IVR Main Entry Point', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8258;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAEB MIH Eng No Agent', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8275;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'VAEB MIH Spa No Agent', project_name = 'VA EB', program_name = 'Member Inquiry Helpline', region_name = 'Eastern', state_name = 'Virginia', service_seconds = 30, interval_minutes = 15 where queue_number = 8276;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Closed'), service_seconds = 30, interval_minutes = 15 where queue_number =8259;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Emergency'), service_seconds = 30, interval_minutes = 15 where queue_number =8260;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR EO'), service_seconds = 30, interval_minutes = 15 where queue_number =8261;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Error'), service_seconds = 30, interval_minutes = 15 where queue_number =8262;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Holiday'), service_seconds = 30, interval_minutes = 15 where queue_number =8263;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 0'), service_seconds = 30, interval_minutes = 15 where queue_number =8264;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 1'), service_seconds = 30, interval_minutes = 15 where queue_number =8265;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 2'), service_seconds = 30, interval_minutes = 15 where queue_number =8266;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 3'), service_seconds = 30, interval_minutes = 15 where queue_number =8267;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Open'), service_seconds = 30, interval_minutes = 15 where queue_number =8268;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Start'), service_seconds = 30, interval_minutes = 15 where queue_number =8269;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Timeout'), service_seconds = 30, interval_minutes = 15 where queue_number =8270;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Weather Clsoed'), service_seconds = 30, interval_minutes = 15 where queue_number =8271;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH English'), service_seconds = 30, interval_minutes = 15 where queue_number =8272;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH RONA'), service_seconds = 30, interval_minutes = 15 where queue_number =8273;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH Spanish'), service_seconds = 30, interval_minutes = 15 where queue_number =8274;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Main Entry Point'), service_seconds = 30, interval_minutes = 15 where queue_number =8258;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH Eng No Agent'), service_seconds = 30, interval_minutes = 15 where queue_number =8275;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Member Inquiry Helpline'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'VAEB MIH Spa No Agent'), service_seconds = 30, interval_minutes = 15 where queue_number =8276;

update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Closed'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8259;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Emergency'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8260;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR EO'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8261;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Error'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8262;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Holiday'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8263;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 0'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8264;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 1'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8265;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 2'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8266;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Menu Option 3'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8267;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Open'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8268;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Start'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8269;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Timeout'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8270;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Weather Clsoed'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8271;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8272;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8273;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8274;
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH IVR Main Entry Point'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8258;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH Eng No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8275;
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Member Inquiry Helpline'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'VAEB MIH Spa No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = 8276;


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'VA EB', 
program_name = 'Member Inquiry Helpline', 
region_name = 'Eastern', 
state_name = 'Virginia' 
where agent_routing_group_number in (5511, 5512);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5511);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5512);

commit;


	

					