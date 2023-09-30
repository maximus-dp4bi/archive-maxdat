alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEL_MIEB_0854_SEAPPLICATION','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MIEL_MIEB_0853_SEENROLL','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEL_MIEB_0854_SEAPPLICATION','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MIEL_MIEB_0853_SEENROLL','Inbound', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Inbound', interval_minutes = 15, project_name = 'MIEB', Program_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' 
where queue_number in (8254, 8253);

update cc_c_contact_queue
set unit_of_work_name = 'MIEL_MIEB_0854_SEAPPLICATION'
where queue_number = 8254;

update cc_c_contact_queue
set unit_of_work_name = 'MIEL_MIEB_0853_SEENROLL'
where queue_number = 8253;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'MIEB'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEL_MIEB_0853_SEENROLL'), interval_minutes = 15 where queue_number = '8253';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'MIEB'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MIEL_MIEB_0854_SEAPPLICATION'), interval_minutes = 15 where queue_number = '8254';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'MIEB'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEL_MIEB_0853_SEENROLL'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),interval_minutes = 15 where queue_number = '8253';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'MIEB'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MIEL_MIEB_0854_SEAPPLICATION'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),interval_minutes = 15 where queue_number = '8254';


commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'MIEB', Program_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan'
where agent_routing_Group_number in (5441, 5440);

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'MIEL_MIEB_0005_SEHELPLINE'
where agent_routing_Group_number = 5033
and agent_routing_group_type = 'Precision Queue';


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5441);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5440);

commit;