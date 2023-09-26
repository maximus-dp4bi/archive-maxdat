alter session set current_schema = cisco_enterprise_cc;


insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Medi-Cal For Families', q'[County Children's Health Initiative - CCHIP]', 'West', 'California', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, q'[County Children's Health Initiative - CCHIP]', 1 );

--insert into cc_d_state (state_id, state_name) values (SEQ_CC_D_STATE.nextval, 'Vermont');

commit;

--insert into cc_d_geography_master (geography_master_id, geography_name, country_id, state_id, province_id, district_id, region_id) values (SEQ_CC_D_GEOGRAPHY_MASTER.nextval, 'Vermont', 1,(select state_id from cc_d_state where state_name = 'Vermont') ,0, 0, 2);

commit;

/*insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'))

commit;
*/

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Other Language','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Other Language Voicemail','Voicemail',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Internal Transfers (Other Language)','Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Other Language','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Other Language Voicemail','Voicemail', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Internal Transfers (Other Language)','Transfer', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Emergency Closed IVR', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7950';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Holiday Closed IVR', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7951';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'After Hours Closed IVR', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7952';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Main IVR', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7953';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'No Agent', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7954';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'RONA', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7955';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'English', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7956';
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'English Voicemail', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7957';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Spanish', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7958';
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'Spanish Voicemail', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7959';
update cc_c_contact_queue set queue_type = 'IVR', Unit_of_work_name = 'Error IVR', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7960';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Other Language', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7961';
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'Other Language Voicemail', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7962';
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'English Transfer', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7963';
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'Spanish Transfer', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7964';
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'Internal Transfers (Other Language)', project_name = 'Medi-Cal For Families', program_name = q'[County Children's Health Initiative - CCHIP]', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7965';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Emergency Closed IVR'), service_seconds = 20, interval_minutes = 15 where queue_number = '7950';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Holiday Closed IVR'), service_seconds = 20, interval_minutes = 15 where queue_number = '7951';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'After Hours Closed IVR'), service_seconds = 20, interval_minutes = 15 where queue_number = '7952';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Main IVR'), service_seconds = 20, interval_minutes = 15 where queue_number = '7953';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'No Agent'), service_seconds = 20, interval_minutes = 15 where queue_number = '7954';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'RONA'), service_seconds = 20, interval_minutes = 15 where queue_number = '7955';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English'), service_seconds = 20, interval_minutes = 15 where queue_number = '7956';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Voicemail', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English Voicemail'), service_seconds = 20, interval_minutes = 15 where queue_number = '7957';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish'), service_seconds = 20, interval_minutes = 15 where queue_number = '7958';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Voicemail', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish Voicemail'), service_seconds = 20, interval_minutes = 15 where queue_number = '7959';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'IVR', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Error IVR'), service_seconds = 20, interval_minutes = 15 where queue_number = '7960';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Other Language'), service_seconds = 20, interval_minutes = 15 where queue_number = '7961';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Voicemail', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Other Language Voicemail'), service_seconds = 20, interval_minutes = 15 where queue_number = '7962';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English Transfer'), service_seconds = 20, interval_minutes = 15 where queue_number = '7963';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Spanish Transfer'), service_seconds = 20, interval_minutes = 15 where queue_number = '7964';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Medi-Cal For Families' and program_name = q'[County Children's Health Initiative - CCHIP]'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Internal Transfers (Other Language)'), service_seconds = 20, interval_minutes = 15 where queue_number = '7965';


update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Emergency Closed IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7950';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Holiday Closed IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7951';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'After Hours Closed IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7952';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Main IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7953';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7954';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7955';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7956';
update cc_d_contact_queue set queue_type = 'Voicemail', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English Voicemail'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7957';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7958';
update cc_d_contact_queue set queue_type = 'Voicemail', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish Voicemail'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7959';
update cc_d_contact_queue set queue_type = 'IVR', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Error IVR'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7960';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Other Language'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7961';
update cc_d_contact_queue set queue_type = 'Voicemail', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Other Language Voicemail'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7962';
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7963';
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Spanish Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7964';
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Medi-Cal For Families'), d_program_id = (select program_id from cc_d_program where program_name = q'[County Children's Health Initiative - CCHIP]'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Internal Transfers (Other Language)'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 24, interval_minutes = 15 where queue_number = '7965';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'Medi-Cal For Families', 
program_name = q'[County Children's Health Initiative - CCHIP]', 
region_name = 'West', 
state_name = 'California' 
where agent_routing_group_number in (5469, 5470, 5471);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5469);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5470);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5471);

commit;

-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5155', 'Folsom');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5155', 'Medi-Cal For Families');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5155', q'[County Children's Health Initiative - CCHIP]');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5156', 'Folsom');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5156', 'Medi-Cal For Families');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5156', q'[County Children's Health Initiative - CCHIP]');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5155');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5156');

commit;

-- Calls offered formula 
/*
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
					,'VTHIX CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Medi-Cal For Families'
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
					,'VTHIX CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Medi-Cal For Families'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS ) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
*/
        
commit;		

--Updates to correct queue and ARG names in config tables

update cc_c_contact_queue a
set a.queue_name = (select queue_name from cc_s_contact_queue
where queue_number = a.queue_number)
where a.queue_number in (7950,
7951,
7952,
7953,
7954,
7955,
7956,
7957,
7958,
7959,
7960,
7961,
7962,
7963,
7964,
7965);

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'CAFM_CHIP_ENG'
where agent_routing_group_number = 5469
and agent_routing_Group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'CAFM_CHIP_SPA'
where agent_routing_group_number = 5470
and agent_routing_Group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'CAFM_CHIP_OTH'
where agent_routing_group_number = 5471
and agent_routing_Group_type = 'Precision Queue';

commit;


					