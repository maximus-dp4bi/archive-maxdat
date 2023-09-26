alter session set current_schema = cisco_enterprise_cc;

update cc_c_project_config
set project_name = 'New Jersey State Based Exchange'
where project_name = 'New Jersey State-Based Exchange';

update cc_d_project
set project_name = 'New Jersey State Based Exchange'
where project_name = 'New Jersey State-Based Exchange';

update cc_c_contact_queue
set project_name = 'New Jersey State Based Exchange'
where project_name = 'New Jersey State-Based Exchange';

update cc_c_agent_rtg_grp
set project_name = 'New Jersey State Based Exchange'
where project_name = 'New Jersey State-Based Exchange';

update cc_c_lookup
set lookup_value = 'New Jersey State Based Exchange'
where lookup_value = 'New Jersey State-Based Exchange';

update cc_a_list_lkup
set value = 'New Jersey State Based Exchange'
where value = 'New Jersey State-Based Exchange';

commit;

--PAXTECH-467

update cc_a_list_lkup
set out_var = 'New Jersey State Based Exchange'
where out_var = 'New Jersey State-Based Exchange';

update cc_c_survey_lkup
set project_name = 'New Jersey State Based Exchange'
where project_name = 'New Jersey State-Based Exchange';

commit;