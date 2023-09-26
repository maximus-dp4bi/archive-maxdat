
-- Contact queues

update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'CALLBACK', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland',  interval_minutes = 15, service_seconds = 30 where queue_number = '7927';
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'CALLBACK', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland',  interval_minutes = 15, service_seconds = 30 where queue_number = '7928';
update cc_c_contact_queue set queue_type = 'Callback', Unit_of_work_name = 'CALLBACK', project_name = 'MD HBE', program_name = 'CSC', region_name = 'Eastern', state_name = 'Maryland',  interval_minutes = 15, service_seconds = 30 where queue_number = '7929';



update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Callback', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CALLBACK'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7927';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Callback', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CALLBACK'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7928';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MD HBE' and program_name = 'CSC'), queue_type = 'Callback', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CALLBACK'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7929';



update cc_d_contact_queue set queue_type = 'Callback', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CALLBACK'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7927';
update cc_d_contact_queue set queue_type = 'Callback', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CALLBACK'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7928';
update cc_d_contact_queue set queue_type = 'Callback', d_project_id = (select project_id from cc_d_project where project_name = 'MD HBE'), d_program_id = (select program_id from cc_d_program where program_name = 'CSC'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CALLBACK'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Maryland'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7929';


commit;


