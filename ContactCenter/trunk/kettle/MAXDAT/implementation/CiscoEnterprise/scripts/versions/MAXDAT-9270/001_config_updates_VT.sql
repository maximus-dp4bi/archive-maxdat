alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAHM_VTHX_SEADV_RONA','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Calls routed to No Staff treatment','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Calls routed to queue and service levels','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Calls routed to Spanish Queue script','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('VAHM VTHX SEADV Error calls','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAHM_VTHX_SEADV_RONA','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Calls routed to No Staff treatment','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Calls routed to queue and service levels','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Calls routed to Spanish Queue script','Inbound', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('VAHM VTHX SEADV Error calls','Inbound', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Inbound', interval_minutes = 15, service_seconds = 24, project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont' 
where queue_number in (
7787,
7788,
7779,
7790,
7789
);

update cc_c_contact_queue set unit_of_work_name = 'VAHM_VTHX_SEADV_RONA' where queue_number = 7787;
update cc_c_contact_queue set unit_of_work_name = 'Calls routed to No Staff treatment' where queue_number = 7788;
update cc_c_contact_queue set unit_of_work_name = 'Calls routed to queue and service levels' where queue_number = 7779;
update cc_c_contact_queue set unit_of_work_name = 'Calls routed to Spanish Queue script' where queue_number = 7790;
update cc_c_contact_queue set unit_of_work_name = 'VAHM VTHX SEADV Error calls' where queue_number = 7789;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'VT HIX', program_name = 'Multiple', region_name = 'Eastern', state_name = 'Vermont'
where agent_routing_Group_number = 5439;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5439);

commit;