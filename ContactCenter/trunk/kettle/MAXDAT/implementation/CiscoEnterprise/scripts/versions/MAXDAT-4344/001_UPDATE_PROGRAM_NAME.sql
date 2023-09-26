ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set program_name = 'Medi-Cal'
where program_name = 'CHIP';

update cc_c_lookup
set lookup_value = 'Medi-Cal'
where lookup_value = 'CHIP';

update cc_c_project_config
set program_name = 'Medi-Cal'
where program_name = 'CHIP';

update cc_d_program
set program_name = 'Medi-Cal'
where program_name = 'CHIP';

commit;