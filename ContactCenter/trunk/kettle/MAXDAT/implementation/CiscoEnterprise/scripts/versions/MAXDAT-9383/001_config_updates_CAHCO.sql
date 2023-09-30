alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CMAC PDD','Outbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CMAC PDD','Outbound', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Predictive Dialer', interval_minutes = 15, service_seconds = 20, project_name = 'CA HCO', program_name = 'Medi-Cal', 
region_name = 'West', state_name = 'California', unit_of_work_name = 'CMAC PDD'
where queue_number = 7532;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California'
where agent_routing_Group_number in (15939, 16185);

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '15939');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '16185');

commit;