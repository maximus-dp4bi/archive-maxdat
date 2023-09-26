alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'CallBack', unit_of_work_name = 'Transfer to CSI Callback', interval_minutes = 15, project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts'
where 
queue_number = 6584;


insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('Transfer to CSI Callback', 'CALLBACK', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('Transfer to CSI Callback', 'CALLBACK', 157, 'N', 'Seconds');

commit;

----------------------------------------------

