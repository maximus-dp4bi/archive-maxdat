alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Voicemail', unit_of_work_name = 'General Voicemail', interval_minutes = 15, service_seconds = 30, project_name = 'Florida Healthy Kids', program_name = 'Florida Healthy Kids', region_name = 'Eastern', state_name = 'Florida'
where 
queue_number = 6666;

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'Closed', interval_minutes = 15, service_seconds = 30, project_name = 'Florida Healthy Kids', program_name = 'Florida Healthy Kids', region_name = 'Eastern', state_name = 'Florida'
where 
queue_number in (6673, 6679, 6685);

update cc_c_contact_queue
set queue_type = 'After Hours', unit_of_work_name = 'Holiday', interval_minutes = 15, service_seconds = 30, project_name = 'Florida Healthy Kids', program_name = 'Florida Healthy Kids', region_name = 'Eastern', state_name = 'Florida'
where 
queue_number in (6675, 6681, 6687);

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('General Voicemail', 'Voicemail', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Closed', 'After Hours', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Holiday', 'After Hours', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('General Voicemail', 'Voicemail', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Closed', 'After Hours', 161, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Holiday', 'After Hours', 161, 'N', 'Seconds');


commit;

----------------------------------------------

