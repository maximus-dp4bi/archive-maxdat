alter session set current_schema = cisco_enterprise_cc;


insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MD HBE', 'MD Medical Cannabis Commission', 'Eastern', 'Maryland', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'MD Medical Cannabis Commission', 1 );

commit;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MMCC','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MMCC No Agent','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MMCC Rona','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MMCC','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MMCC No Agent','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MMCC Rona','Inbound', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MMCC', project_name = 'MD HBE', program_name = 'MD Medical Cannabis Commission', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 0, interval_minutes = 15 where queue_number = '7886';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MMCC No Agent', project_name = 'MD HBE', program_name = 'MD Medical Cannabis Commission', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 0, interval_minutes = 15 where queue_number = '7890';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MMCC Rona', project_name = 'MD HBE', program_name = 'MD Medical Cannabis Commission', region_name = 'Eastern', state_name = 'Maryland', service_seconds = 0, interval_minutes = 15 where queue_number = '7891';

update cc_c_contact_queue 
set unit_of_work_name = 'CALLBACK'
where queue_number in (7076, 7077, 7078, 7529, 7530);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'MD Medical Cannabis Commission'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MMCC'), service_seconds = 0, interval_minutes = 15 where queue_number = '7886';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'MD Medical Cannabis Commission'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MMCC No Agent'), service_seconds = 0, interval_minutes = 15 where queue_number = '7890';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'MD Medical Cannabis Commission'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MMCC Rona'), service_seconds = 0, interval_minutes = 15 where queue_number = '7891';

update cc_s_contact_queue 
set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CALLBACK')
where queue_number in (7076, 7077, 7078, 7529, 7530);


update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'MD Medical Cannabis Commission'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MMCC'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),service_seconds= 0, interval_minutes = 15 where queue_number = '7886';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'MD Medical Cannabis Commission'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MMCC No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),service_seconds= 0, interval_minutes = 15 where queue_number = '7890';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'MD Medical Cannabis Commission'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MMCC Rona'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),service_seconds= 0, interval_minutes = 15 where queue_number = '7891';

update cc_d_contact_queue 
set d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CALLBACK')
where queue_number in (7076, 7077, 7078, 7529, 7530);

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp set project_name = 'MD HBE', program_name = 'MD Medical Cannabis Commission', region_name = 'Eastern', state_name = 'Maryland' 
where agent_routing_group_number = 5466;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5466);

commit;

