alter session set current_schema = cisco_enterprise_cc;

-- Agent Routing groups

update cc_c_agent_rtg_grp 
set project_name = 'CA Lifeline', 
program_name = 'Customer Service Center', 
region_name = 'West', 
state_name = 'California' 
where agent_routing_group_number in (5490,5500);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5490);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5500);

commit;


	

					