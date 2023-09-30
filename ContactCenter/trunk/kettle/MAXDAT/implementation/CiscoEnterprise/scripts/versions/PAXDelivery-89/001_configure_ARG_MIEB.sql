alter session set current_schema = cisco_enterprise_cc;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'MIEB', 
program_name = 'Multiple - Provider Support Services', 
region_name = 'Eastern', 
state_name = 'Michigan' 
where agent_routing_group_number =5472;


insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5472);

commit;


					