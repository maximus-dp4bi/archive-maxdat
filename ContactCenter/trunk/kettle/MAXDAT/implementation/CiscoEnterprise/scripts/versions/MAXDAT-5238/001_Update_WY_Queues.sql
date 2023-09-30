alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'English Survey Decline', interval_minutes = 15, project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming'
where 
queue_number = 6570;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Spanish Survey Decline', interval_minutes = 15, project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming'
where 
queue_number = 6571;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('English Survey Decline', 'IVR Survey', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Spanish Survey Decline', 'IVR Survey', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('English Survey Decline', 'IVR Survey', 159, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Survey Decline', 'IVR Survey', 159, 'N', 'Seconds', 0, 1);

commit;