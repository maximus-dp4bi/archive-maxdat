
--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MI MORS No Agent','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MI MORS RONA','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MI MORS English','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MI MORS No Agent','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MI MORS RONA','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MI MORS English','INBOUND', 1, 'N', 'Seconds', 1, 0);

commit;

-- Contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MI MORS No Agent', project_name = 'MIEB', program_name = 'Multiple – MI Bridges', region_name = 'Eastern', state_name = 'Michigan',  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7924';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MI MORS RONA', project_name = 'MIEB', program_name = 'Multiple – MI Bridges', region_name = 'Eastern', state_name = 'Michigan',  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7925';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'MI MORS English', project_name = 'MIEB', program_name = 'Multiple – MI Bridges', region_name = 'Eastern', state_name = 'Michigan',  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7926';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Multiple – MI Bridges'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MI MORS No Agent'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7924';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Multiple – MI Bridges'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MI MORS RONA'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7925';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Multiple – MI Bridges'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MI MORS English'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7926';


update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple – MI Bridges'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MI MORS No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7924';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple – MI Bridges'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MI MORS RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7925';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), d_program_id = (select program_id from cc_d_program where program_name = 'Multiple – MI Bridges'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MI MORS English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),  interval_minutes = 15, service_seconds = 30, service_percent = 80 where queue_number = '7926';



commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp set project_name = 'MIEB', program_name = 'Multiple – MI Bridges', region_name = 'Eastern', state_name = 'Michigan' where agent_routing_group_number = 5467;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5467);

commit;