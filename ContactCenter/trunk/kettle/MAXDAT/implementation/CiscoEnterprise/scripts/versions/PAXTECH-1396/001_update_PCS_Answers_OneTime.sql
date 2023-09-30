alter session set current_schema = cisco_enterprise_cc;

update cc_s_caller_survey_data
set answer = 'Completely Satisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Completely';

update cc_s_caller_survey_data
set answer = 'Completely Dissatisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Completely Dis';

update cc_s_caller_survey_data
set answer = 'Mostly Satisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Mostly';

update cc_s_caller_survey_data
set answer = 'Mostly Dissatisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Mostly Dis';

update cc_f_caller_survey_data
set answer = 'Completely Satisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Completely';

update cc_f_caller_survey_data
set answer = 'Completely Dissatisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Completely Dis';

update cc_f_caller_survey_data
set answer = 'Mostly Satisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Mostly';

update cc_f_caller_survey_data
set answer = 'Mostly Dissatisfied'
where project_name like 'New Jersey%'
and survey_question = 'Customer Satisfaction'
and answer = 'Mostly Dis';

update cc_s_caller_survey_data
set answer = 'Mail'
where project_name like 'New Jersey%'
and survey_question = 'Source of Number'
and answer = 'Get Cov NJ';

update cc_f_caller_survey_data
set answer = 'Mail'
where project_name like 'New Jersey%'
and survey_question = 'Source of Number'
and answer = 'Get Cov NJ';

update cc_s_caller_survey_data
set answer = 'Multiple Reasons'
where project_name like 'New Jersey%'
and survey_question = 'Dissatisfied Reason'
and answer = 'Different Reason';

update cc_f_caller_survey_data
set answer = 'Multiple Reasons'
where project_name like 'New Jersey%'
and survey_question = 'Dissatisfied Reason'
and answer = 'Different Reason';

commit;

/* Update for spelling error in the PCS file */

update cc_f_caller_survey_data
set answer = 'Completely Dissatisfied'
where answer = 'Completely Dissatisified'
and project_name like 'New Jersey%';

update cc_s_caller_survey_data
set answer = 'Completely Dissatisfied'
where answer = 'Completely Dissatisified'
and project_name like 'New Jersey%';

commit;