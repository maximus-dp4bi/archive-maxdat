alter session set current_schema = maxdat_cc;

update cc_c_project_config
set program_name = 'Multiple'
where project_name = 'IL EB'
and program_name = 'EB';

update cc_c_contact_queue
set program_name = 'Multiple'
where project_name = 'IL EB'
and program_name = 'EB';

update cc_c_lookup
set lookup_value = 'Multiple'
where lookup_value = 'EB'
and lookup_type like '%PROGRAM';

update cc_d_program
set program_name = 'Multiple'
where program_name = 'EB';

update cc_a_list_lkup
set out_var = 'Multiple'
where out_var = 'EB' 
and name = 'Agent_Program'
and list_type = 'AGENT_PROGRAM'
and value like 'IL%';

commit;