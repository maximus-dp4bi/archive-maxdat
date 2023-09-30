alter session set current_schema = cisco_enterprise_cc;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('WV EB SDH Line', 'INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('WV EB SDH Line', 'INBOUND_CALL', 1, 'N', 'Seconds', 1, 0);


commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'WV EB SDH Line', project_name = 'WV EB', program_name = 'WV EB', region_name = 'Eastern', state_name = 'West Virginia', service_seconds= 30, interval_minutes = 15 where queue_number = 8530;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'WV EB' and program_name = 'WV EB'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'WV EB SDH Line'), service_seconds= 30, interval_minutes = 15 where queue_number = '8530';

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'WV EB'), d_program_id = (select program_id from cc_d_program where program_name = 'WV EB'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'WV EB SDH Line'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'West Virginia'),service_seconds= 30, interval_minutes = 15 where queue_number = '8530';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'WV EB', 
program_name = 'WV EB', 
region_name = 'Eastern', 
state_name = 'West Virginia' 
where agent_routing_group_number in (5544);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5544);

commit;


					