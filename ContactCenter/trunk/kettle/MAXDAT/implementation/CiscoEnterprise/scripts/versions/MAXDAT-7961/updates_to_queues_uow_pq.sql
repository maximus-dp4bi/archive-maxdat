-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('One Care English','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('One Care No Agent Logged In','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('One Care RONA','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);



insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('One Care English','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('One Care No Agent Logged In','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('One Care RONA','INBOUND', 1, 'N', 'Seconds', 1, 0);


commit;

-- Contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'One Care English', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_seconds = 30, interval_minutes = 15 where queue_number = '7363';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'One Care No Agent Logged In', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_seconds = 30, interval_minutes = 15 where queue_number = '7364';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'One Care RONA', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_seconds = 30, interval_minutes = 15 where queue_number = '7365';




update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Mass Health' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'One Care English'), service_seconds = 30, interval_minutes = 15 where queue_number = '7363';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Mass Health' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'One Care No Agent Logged In'), service_seconds = 30, interval_minutes = 15 where queue_number = '7364';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Mass Health' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'One Care RONA'), service_seconds = 30, interval_minutes = 15 where queue_number = '7365';




update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Mass Health'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'One Care English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Massachusetts'), service_seconds = 30, interval_minutes = 15 where queue_number = '7363';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Mass Health'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'One Care No Agent Logged In'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Massachusetts'), service_seconds = 30, interval_minutes = 15 where queue_number = '7364';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Mass Health'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'One Care RONA'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Massachusetts'), service_seconds = 30, interval_minutes = 15 where queue_number = '7365';


commit;

-- Agent Routing Groups

update cc_c_agent_rtg_grp
set project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where agent_routing_group_number = 5357;
    
commit;    

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5357);


commit;