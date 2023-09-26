alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIEB', 'MIEB', 11, 'MIEB Satisfaction Survey - Enrolls');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIEB', 'MIEB', 13, 'MIEB Satisfaction Survey – Beneficiary Helpline');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIEB', 'MIEB', 14, 'MIEB Satisfaction Survey - MIChild');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MI CSCC', 'Multiple', 16, 'CSCC Satisfaction Survey');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MI APCC', 'MI Provider Support', 17, 'APCC Satisfaction Survey');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIEB', 'Multiple - Provider Support Services', 18, 'PSS Satisfaction Survey');
										
insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIEB', 'Multiple – MI Bridges', 19, 'MBSH Satisfaction Survey');

insert into cc_c_survey_lkup
(project_name, program_name, sub_program_code, sub_program_name)
values ('MIWR', 'Michigan Work Requirements', 20, 'Work Requirements Satisfaction Survey');

commit;
