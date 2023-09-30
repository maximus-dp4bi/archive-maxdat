alter session set current_schema = cisco_enterprise_cc;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Inbound Assist', 'INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Inbound Assist', 'INBOUND', 1, 'N', 'Seconds', 1, 0);


--Contact Queues

update cc_c_contact_queue set queue_type = 'Inbound', unit_of_work_name = 'Inbound Assist', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_seconds= 30, interval_minutes = 15 where queue_number = 8741;
update cc_c_contact_queue set queue_type = 'Transfer', unit_of_work_name = 'Assist Transfer', project_name = 'Mass Health', program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_seconds= 30, interval_minutes = 15 where queue_number = 8742;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Mass Health' and program_name = 'Customer Service Center'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Inbound Assist'), service_seconds= 30, interval_minutes = 15 where queue_number = 8741;
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Mass Health' and program_name = 'Customer Service Center'), queue_type = 'Transfer', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Assist Transfer'), service_seconds= 30, interval_minutes = 15 where queue_number = 8742;

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'Mass Health'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Inbound Assist'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Massachusetts'),service_seconds= 30, interval_minutes = 15 where queue_number = 8741;
update cc_d_contact_queue set queue_type = 'Transfer', d_project_id = (select project_id from cc_d_project where project_name = 'Mass Health'), d_program_id = (select program_id from cc_d_program where program_name = 'Customer Service Center'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Assist Transfer'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Massachusetts'),service_seconds= 30, interval_minutes = 15 where queue_number = 8742;


commit;