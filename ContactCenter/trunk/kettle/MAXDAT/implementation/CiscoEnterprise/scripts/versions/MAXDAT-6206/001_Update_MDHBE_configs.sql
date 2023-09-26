alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Callback', unit_of_work_name = 'CALLBACK - MCO', interval_minutes = 15, service_seconds = 30, project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where 
queue_number = 7076;

update cc_c_contact_queue
set queue_type = 'Callback', unit_of_work_name = 'CALLBACK - MEDICAID', interval_minutes = 15, service_seconds = 30, project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where 
queue_number = 7077;

update cc_c_contact_queue
set queue_type = 'Callback', unit_of_work_name = 'CALLBACK - QHP', interval_minutes = 15, service_seconds = 30, project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland'
where 
queue_number = 7078;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CALLBACK - MCO', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CALLBACK - MEDICAID', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('CALLBACK - QHP', 'Callback', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CALLBACK - MCO', 'Callback', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CALLBACK - MEDICAID', 'Callback', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('CALLBACK - QHP', 'Callback', 161, 'N', 'Seconds');

commit;