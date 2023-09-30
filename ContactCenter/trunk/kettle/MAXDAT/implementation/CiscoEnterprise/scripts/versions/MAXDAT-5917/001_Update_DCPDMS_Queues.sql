alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '1 - Extremely Dissatisfied', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number in (6854, 6860, 6866, 6872, 6878, 6884);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '2 - Very Dissatisfied', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number in (6855, 6861, 6867, 6873, 6879, 6885);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '3 - Somewhat Satisfied', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number in (6856, 6862, 6868, 6874, 6880, 6886);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '4 - Very Satisfied', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number in (6857, 6863, 6869, 6875, 6881, 6887);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '5 - Extremely Satisfied', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number in (6858, 6864, 6870, 6876, 6882, 6888);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Time to reach CSR', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6853;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'CSR ability to answer questions', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6859;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Technical Resolution', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6865;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Web portal for enrollment / re-enrollment', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6871;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Web portal for making updates', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6877;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Overall support received', interval_minutes = 15, service_seconds = 30, project_name = 'DC PDMS', program_name = 'Provider Support', region_name = 'Eastern', state_name = 'District of Columbia'
where 
queue_number = 6883;


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Technical Resolution', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1 - Extremely Dissatisfied', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('2 - Very Dissatisfied', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('3 - Somewhat Satisfied', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('4 - Very Satisfied', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('5 - Extremely Satisfied', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Time to reach CSR', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CSR ability to answer questions', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Web portal for enrollment / re-enrollment', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Web portal for making updates', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Overall support received', 'IVR SURVEY', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Technical Resolution', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1 - Extremely Dissatisfied', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('2 - Very Dissatisfied', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('3 - Somewhat Satisfied', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('4 - Very Satisfied', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('5 - Extremely Satisfied', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Time to reach CSR', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CSR ability to answer questions', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Web portal for enrollment / re-enrollment', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Web portal for making updates', 'IVR SURVEY', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Overall support received', 'IVR SURVEY', 161, 'N', 'Seconds');

commit;

----------------------------------------------

