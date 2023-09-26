alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('HSN Inbound Assist - Spanish','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('HSN Assist Transfer - Spanish','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PhoneAPP Callback','CALLBACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Homeless Inbound','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Homeless Callback','CALLBACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('HSN Inbound Assist - Spanish','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('HSN Assist Transfer - Spanish','TRANSFER',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PhoneAPP Callback','CALLBACK',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Homeless Inbound','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Homeless Callback','CALLBACK',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'HSN Inbound Assist - Spanish', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8803;
update cc_c_contact_queue set queue_type = 'Transfer', Unit_of_work_name = 'HSN Assist Transfer - Spanish', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8804;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'PhoneAPP Callback', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8822;
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Homeless Inbound', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8846;
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'Homeless Callback', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number = 8847;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'Mass Health', 
program_name = 'Customer Service Center', 
region_name = 'Eastern', 
state_name = 'Massachusetts' 
where agent_routing_group_number in 
(5574,
5575,
5554,
5565
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5574);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5575);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5554);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5565);

commit;

