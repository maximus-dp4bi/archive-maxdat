alter session set current_schema = cisco_enterprise_cc;


--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL XFER','Internal Transfer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL XFER','Internal Transfer', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Internal Transfer', interval_minutes = 15, service_seconds = 30, project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California', unit_of_work_name = 'CALL XFER'
where queue_number = 7820;

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA Lifeline' and program_name = 'Customer Service Center'), 
queue_type = 'Internal Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CALL XFER'), 
service_seconds = 30, interval_minutes = 15 where queue_number = '7820';

update cc_d_contact_queue 
set queue_type = 'Internal Transfer', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA Lifeline'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CALL XFER'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 30, interval_minutes = 15 
where queue_number = 7820;

commit;
