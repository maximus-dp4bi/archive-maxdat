alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('GENERAL - ENFORCEMENT','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('GENERAL - ENFORCEMENT','INBOUND_CALL',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue 
set queue_type = 'Inbound', 
Unit_of_work_name = 'GENERAL - ENFORCEMENT', 
project_name = 'WC HS', 
program_name = 'WC HS', 
region_name = 'Eastern', 
state_name = 'Michigan', 
service_seconds = 60, 
interval_minutes = 15 
where queue_number in (8963, 8976);

update cc_c_contact_queue
set bucketintervalid = 5014
where queue_number = 8963;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'WC HS', 
program_name = 'WC HS', 
region_name = 'Eastern', 
state_name = 'Michigan' 
where agent_routing_group_number in 
(5578
);


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5578);

commit;				