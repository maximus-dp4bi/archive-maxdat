alter session set current_schema = cisco_enterprise_cc;

update cc_c_agent_rtg_grp
set project_name = 'WC HS', program_name = 'WC HS', region_name = 'Eastern', state_name = 'Michigan'
where agent_routing_Group_number in ('8780','8323');

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '8780');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '8323');

commit;