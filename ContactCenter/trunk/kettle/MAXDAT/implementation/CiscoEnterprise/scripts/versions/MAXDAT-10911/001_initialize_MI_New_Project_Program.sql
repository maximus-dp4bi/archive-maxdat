alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MIWR', 'Michigan Work Requirements', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'MIWR', 2, 1 );

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Michigan Work Requirements', 1 );

commit;

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'MIWR'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('General Main','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR After Hours','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Emergency','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Holiday','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Maintenance','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Ring No answer','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR General Arabic','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR General English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR General Remind','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR General Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Voicemail','Voicemail',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR VRU Aborted - Value = 3','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR VRU Dialog Failed - Value = 4','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR VRU Error - Value = 1','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR VRU No Script Found - Value = 5','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR VRU Timeout - Value = 2','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIFL_MIWR Weather','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Michigan Work Requirements IVR','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('General Main','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR After Hours','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Emergency','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Holiday','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Maintenance','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Ring No answer','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR General Arabic','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR General English','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR General Remind','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR General Spanish','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Voicemail','Voicemail', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR VRU Aborted - Value = 3','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR VRU Dialog Failed - Value = 4','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR VRU Error - Value = 1','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR VRU No Script Found - Value = 5','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR VRU Timeout - Value = 2','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIFL_MIWR Weather','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Michigan Work Requirements IVR','IVR', 1, 'N', 'Seconds', 0, 1);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'General Main', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8137;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR After Hours', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8199;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR Emergency', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8200;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR Holiday', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8201;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR Maintenance', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8202;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR Ring No answer', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8203;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIFL_MIWR General Arabic', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8204;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIFL_MIWR General English', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8205;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIFL_MIWR General Remind', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8206;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MIFL_MIWR General Spanish', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8207;
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'MIFL_MIWR Voicemail', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8208;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR VRU Aborted - Value = 3', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8209;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR VRU Dialog Failed - Value = 4', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8210;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR VRU Error - Value = 1', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8211;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR VRU No Script Found - Value = 5', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8212;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR VRU Timeout - Value = 2', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8213;
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'MIFL_MIWR Weather', project_name = 'MIWR', program_name = 'Michigan Work Requirements', region_name = 'Eastern', state_name = 'Michigan', service_seconds = 30, interval_minutes = 15 where queue_number = 8214;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'General Main'), service_seconds = 30, interval_minutes = 15 where queue_number = '8137';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR After Hours'), service_seconds = 30, interval_minutes = 15 where queue_number = '8199';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Emergency'), service_seconds = 30, interval_minutes = 15 where queue_number = '8200';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Holiday'), service_seconds = 30, interval_minutes = 15 where queue_number = '8201';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Maintenance'), service_seconds = 30, interval_minutes = 15 where queue_number = '8202';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Ring No answer'), service_seconds = 30, interval_minutes = 15 where queue_number = '8203';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Arabic'), service_seconds = 30, interval_minutes = 15 where queue_number = '8204';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR General English'), service_seconds = 30, interval_minutes = 15 where queue_number = '8205';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Remind'), service_seconds = 30, interval_minutes = 15 where queue_number = '8206';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Spanish'), service_seconds = 30, interval_minutes = 15 where queue_number = '8207';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'Voicemail', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Voicemail'), service_seconds = 30, interval_minutes = 15 where queue_number = '8208';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Aborted - Value = 3'), service_seconds = 30, interval_minutes = 15 where queue_number = '8209';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Dialog Failed - Value = 4'), service_seconds = 30, interval_minutes = 15 where queue_number = '8210';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Error - Value = 1'), service_seconds = 30, interval_minutes = 15 where queue_number = '8211';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU No Script Found - Value = 5'), service_seconds = 30, interval_minutes = 15 where queue_number = '8212';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Timeout - Value = 2'), service_seconds = 30, interval_minutes = 15 where queue_number = '8213';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIWR' and program_name = 'Michigan Work Requirements'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIFL_MIWR Weather'), service_seconds = 30, interval_minutes = 15 where queue_number = '8214';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'General Main'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8137';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR After Hours'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8199';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Emergency'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8200';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Holiday'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8201';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Maintenance'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8202';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Ring No answer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8203';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Arabic'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8204';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR General English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8205';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Remind'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8206';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR General Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8207';
update cc_d_contact_queue set queue_type = 'Voicemail', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Voicemail'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8208';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Aborted - Value = 3'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8209';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Dialog Failed - Value = 4'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8210';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Error - Value = 1'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8211';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU No Script Found - Value = 5'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8212';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR VRU Timeout - Value = 2'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8213';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'MIWR'), d_program_id = (select program_id from cc_d_program where program_name = 'Michigan Work Requirements'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIFL_MIWR Weather'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),service_seconds= 20, interval_minutes = 15 where queue_number = '8214';

update cc_c_contact_queue
set bucketintervalid = 5082
where queue_number = 8137;

update cc_s_contact_queue
set bucketintervalid = 5082
where queue_number = 8137;

update cc_d_contact_queue
set bucketintervalid = 5082
where queue_number = 8137;

update cc_d_contact_queue
set speed_answer_period_1_bound = 10,
speed_answer_period_2_bound = 30,
speed_answer_period_3_bound = 60,
speed_answer_period_4_bound = 90,
speed_answer_period_5_bound = 120,
speed_answer_period_6_bound = 180,
speed_answer_period_7_bound = 240,
speed_answer_period_8_bound = 300,
speed_answer_period_9_bound = 360,
speed_answer_period_10_bound = 0,
calls_abndoned_period_1_bound = 10,
calls_abndoned_period_2_bound = 30,
calls_abndoned_period_3_bound = 60,
calls_abndoned_period_4_bound = 90,
calls_abndoned_period_5_bound = 120,
calls_abndoned_period_6_bound = 180,
calls_abndoned_period_7_bound = 240,
calls_abndoned_period_8_bound = 300,
calls_abndoned_period_9_bound = 360,
calls_abndoned_period_10_bound = 0
where queue_number = 8137;

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'MIWR', 
program_name = 'Michigan Work Requirements', 
region_name = 'Eastern', 
state_name = 'Michigan' 
where agent_routing_group_number in (5493, 5494, 5495, 5496);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5493);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5494);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5495);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5496);

commit;

-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5167,5168,5163,5164,5165,5166,5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5167', 'Flint');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5167', 'MIWR');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5167', 'Michigan Work Requirements');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5168', 'Flint');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5168', 'MIWR');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5168', 'Michigan Work Requirements');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5167');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5168');

commit;

-- Calls offered formula 

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MIWR CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'MIWR'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MIWR CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'MIWR'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
        
commit;		

					