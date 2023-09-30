--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound NO Agent','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound RONA','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound NO Agent','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound RONA','Inbound', 1, 'N', 'Seconds', 1, 0);

commit;

-- Contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Inbound NO Agent', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '7856';
update cc_c_contact_queue set queue_type = 'Escalation', Unit_of_work_name = 'Escalation', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '7857';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Inbound RONA', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '7858';
update cc_c_contact_queue set queue_type = 'Escalation Transfer', Unit_of_work_name = 'Escalation Transfer', project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California',  interval_minutes = 15, service_seconds = 30 where queue_number = '7859';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound NO Agent'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7856';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Escalation', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Escalation'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7857';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound RONA'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7858';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), queue_type = 'Escalation Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Escalation Transfer'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7859';



update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound NO Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7856';
update cc_d_contact_queue set queue_type = 'Escalation', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Escalation'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7857';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7858';
update cc_d_contact_queue set queue_type = 'Escalation Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Escalation Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7859';


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California'
where agent_routing_Group_number = 5452;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5452);

commit;

