ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set project_name = 'NE PSE'
where project_name = 'NEPE';

update cc_c_contact_queue
set program_name = 'Medicaid'
where program_name = 'NEPE';

update cc_c_contact_queue
set project_name = 'TN New Hire'
where project_name = 'TN NewHire';

update cc_c_contact_queue
set program_name = 'New Hire Reporting'
where program_name = 'TN NewHire';

update cc_c_lookup
set lookup_value = 'NE PSE'
where lookup_value = 'NEPE'
and lookup_type like '%PROJECT';

update cc_c_lookup
set lookup_value = 'Medicaid'
where lookup_value = 'NEPE'
and lookup_type like '%PROGRAM';

update cc_c_lookup
set lookup_value = 'TN New Hire'
where lookup_value = 'TN NewHire'
and lookup_type like '%PROJECT';

update cc_c_lookup
set lookup_value = 'New Hire Reporting'
where lookup_value = 'TN NewHire'
and lookup_type like '%PROGRAM';

update cc_c_project_config
set project_name = 'NE PSE'
where project_name = 'NEPE';

update cc_c_project_config
set program_name = 'Medicaid'
where program_name = 'NEPE';

update cc_c_project_config
set project_name = 'TN New Hire'
where project_name = 'TN NewHire';

update cc_c_project_config
set program_name = 'New Hire Reporting'
where program_name = 'TN NewHire';

update cc_d_project
set project_name = 'NE PSE'
where project_name = 'NEPE';

update cc_d_project
set project_name = 'TN New Hire'
where project_name = 'TN NewHire';

update cc_d_program
set program_name = 'Medicaid'
where program_name = 'NEPE';

update cc_d_program
set program_name = 'New Hire Reporting'
where program_name = 'TN NewHire';

update cc_a_list_lkup
set value = 'TN New Hire'
where value = 'TN NewHire'
and name = 'TN_NewHire_CALLS_OFFERED_FORMULA';

update cc_a_list_lkup
set value = 'NE PSE'
where value = 'NEPE'
and name = 'NEPE_CALLS_OFFERED_FORMULA';

commit;



