alter session set current_schema = cisco_enterprise_cc;

--IVR DNIS config updates

update cc_a_list_lkup
set out_var = 'Atypical Provider Services', ref_type = 'Atypical Provider Services'
where out_var = 'MI APCC'
and ref_type = 'MI Provider Support'
and name = 'IVR_DATA_FILE_NAMES'
and value = 'MAXMIAPS';

update cc_a_list_lkup
set out_var = 'Atypical Provider Services', ref_type = 'Adult Foster Care'
where out_var = 'MI APCC'
and ref_type = 'MI Provider Support'
and name = 'IVR_DATA_FILE_NAMES'
and value = 'MAXMIAFC';

update cc_a_list_lkup
set out_var = 'Customer Support Services', ref_type = 'Customer Support Services'
where out_var = 'MI CSCC'
and ref_type = 'Customer Support'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'MI Bridges Support Helpdesk', ref_type = 'Michigan Services - Multiple'
where out_var = 'MIEB'
and ref_type = 'Multiple – MI Bridges'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Provider Support Services', ref_type = 'Provider Support Services'
where out_var = 'MIEB'
and ref_type = 'Multiple - Provider Support Services'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Michigan Enrollment Broker Services', ref_type = 'Michigan Services - Multiple'
where out_var = 'MIEB'
and ref_type = 'MIEB'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Work Requirements', ref_type = 'Work Requirements'
where out_var = 'MIWR'
and ref_type = 'Michigan Work Requirements'
and name = 'IVR_DATA_FILE_NAMES';

commit;

--Survey config updates

update cc_a_list_lkup
set out_var = 'Michigan Enrollment Broker Services'
where out_var = 'MIEB'
and name = 'MI_Survey_project_lookup';

update cc_a_list_lkup
set out_var = 'Customer Support Services'
where out_var = 'MI CSCC'
and name = 'MI_Survey_project_lookup';

update cc_a_list_lkup
set out_var = 'Atypical Provider Services'
where out_var = 'MI APCC'
and name = 'MI_Survey_project_lookup';

update cc_a_list_lkup
set out_var = 'Work Requirements'
where out_var = 'MIWR'
and name = 'MI_Survey_project_lookup';

commit;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MI Enrolls', sub_program_name = 'MIEB Satisfaction Survey - Enrolls'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 11;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Beneficiary Helpline', sub_program_name = 'MIEB Satisfaction Survey – Beneficiary Helpline'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 13;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MIChild', sub_program_name = 'MIEB Satisfaction Survey - MIChild'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 14;
					
update cc_c_survey_lkup
set project_name = 'Customer Support Services', program_name = 'Customer Support Services'
where project_name = 'MI CSCC'
and program_name = 'Multiple' 
and sub_program_code = 16;

update cc_c_survey_lkup
set project_name = 'Atypical Provider Services', program_name = 'Atypical Provider Services'
where project_name = 'MI APCC'
and program_name = 'MI Provider Support' 
and sub_program_code = 17;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Provider Support Services'
where project_name = 'MIEB'
and program_name = 'Multiple - Provider Support Services' 
and sub_program_code = 18;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Michigan Services - Multiple'
where project_name = 'MIEB'
and program_name = 'Multiple – MI Bridges' 
and sub_program_code = 19;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Michigan Services - Multiple'
where project_name = 'MIEB'
and program_name = 'Multiple ? MI Bridges' 
and sub_program_code = 19;

update cc_c_survey_lkup
set project_name = 'Work Requirements', program_name = 'Work Requirements'
where project_name = 'MIWR'
and program_name = 'Michigan Work Requirements' 
and sub_program_code = 20;

commit;
					