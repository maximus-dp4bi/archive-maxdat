alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set program_name = 'Medicaid Application Assistance'
where program_name = 'Medical Application Assistance'
and project_name = 'LA LARA';

update cc_d_program 
set program_name = 'Medicaid Application Assistance'
where program_name = 'Medical Application Assistance';

-- contact queues

update cc_c_contact_queue
set program_name = 'Medicaid Application Assistance'
where program_name = 'Medical Application Assistance'
and project_name = 'LA LARA';

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp 
set program_name = 'Medicaid Application Assistance'
where project_name = 'LA LARA' 
and program_name = 'Medical Application Assistance';

commit;

-- cc_c_lookup agent desk settings

update cc_c_lookup 
set lookup_value = 'Medicaid Application Assistance'
where lookup_value = 'Medical Application Assistance'
and lookup_key in (5104,
5105,
5143,
5144);

commit;
