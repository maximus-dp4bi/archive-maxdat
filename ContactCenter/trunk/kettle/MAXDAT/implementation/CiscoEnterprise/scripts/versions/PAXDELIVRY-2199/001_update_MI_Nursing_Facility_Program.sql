alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set program_name = 'Community Transition Services'
where project_name = 'Atypical Provider Services'
and program_name = 'Nursing Facility Transition Services';

update cc_d_program
set program_name = 'Community Transition Services'
where program_name = 'Nursing Facility Transition Services';

update cc_c_contact_queue
set program_name = 'Community Transition Services'
where program_name = 'Nursing Facility Transition Services';

update cc_c_agent_rtg_grp
set program_name = 'Community Transition Services'
where program_name = 'Nursing Facility Transition Services';

commit;