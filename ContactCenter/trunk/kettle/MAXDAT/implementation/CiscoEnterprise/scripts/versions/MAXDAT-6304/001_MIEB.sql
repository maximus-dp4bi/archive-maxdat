alter session set current_schema = cisco_enterprise_cc;

/* CONTACT QUEUE */
update 
	cc_c_contact_queue 
set 
	unit_of_work_name='Beneficiary Helpline', 
	service_percent='80', 
	service_seconds='30', 
	interval_minutes='15', 
	queue_type='After Hours', 
	project_name='MIEB', 
	program_name='MIEB', 
	region_name='Eastern', 
	state_name='Michigan'  
where 
	queue_number='5281';

/* AGENT ROUTING GROUP */
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5033' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5034' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5035' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5036' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5037' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';
update cc_c_agent_rtg_grp set program_name='MIEB', project_name = 'MIEB', region_name = 'Eastern', state_name = 'Michigan' where AGENT_ROUTING_GROUP_NUMBER='5038' and AGENT_ROUTING_GROUP_TYPE='Precision Queue';

commit;
