-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Predictive Dialer','Outbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('IN EB No Agent','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Predictive Dialer','Outbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('IN EB No Agent','Inbound', 1, 'N', 'Seconds', 1, 0);


commit;

-- Contact queues

update cc_c_contact_queue set queue_type = 'Outbound', Unit_of_work_name = 'Predictive Dialer', project_name = 'IN EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Indiana',  interval_minutes = 15 where queue_number = '7301';
update cc_c_contact_queue set queue_type = 'Inbound',  Unit_of_work_name = 'IN EB No Agent', project_name = 'IN EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Indiana',  interval_minutes = 15 where queue_number = '7361';


update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'Medicaid'), queue_type = 'Outbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Predictive Dialer'),  interval_minutes = 15 where queue_number = '7301';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'IN EB' and program_name = 'Medicaid'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'IN EB No Agent'),  interval_minutes = 15 where queue_number = '7361';


update cc_d_contact_queue set queue_type = 'Outbound', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Predictive Dialer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'),  interval_minutes = 15 where queue_number = '7301';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'IN EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'IN EB No Agent'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Indiana'), interval_minutes = 15 where queue_number = '7361';



commit;


-- Agent Routing Groups

update cc_c_agent_rtg_grp set project_name = 'IN EB', program_name = 'Medicaid', region_name = 'Eastern', state_name = 'Indiana' where agent_routing_group_number = 5351;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5351);