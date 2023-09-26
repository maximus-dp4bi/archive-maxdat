-- cc_c_contact_queue

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Medallion English', project_name = 'VA EB', program_name = 'Medallion', region_name = 'Eastern', state_name = 'Virginia',  interval_minutes = 15, service_seconds=30 where queue_number = '7596';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'Medallion Spanish', project_name = 'VA EB', program_name = 'Medallion', region_name = 'Eastern', state_name = 'Virginia',  interval_minutes = 15, service_seconds=30 where queue_number = '7597';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CCC PLUS English', project_name = 'VA EB', program_name = 'CCC PLUS', region_name = 'Eastern', state_name = 'Virginia',  interval_minutes = 15, service_seconds=30 where queue_number = '7598';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CCC PLUS Spanish', project_name = 'VA EB', program_name = 'CCC PLUS', region_name = 'Eastern', state_name = 'Virginia',  interval_minutes = 15, service_seconds=30 where queue_number = '7599';



-- cc_s_contact_queue

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Medallion'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Medallion English'),  interval_minutes = 15, service_seconds= 30 where queue_number = '7596';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'Medallion'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Medallion Spanish'),  interval_minutes = 15, service_seconds= 30 where queue_number = '7597';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'CCC PLUS'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CCC PLUS English'),  interval_minutes = 15, service_seconds= 30 where queue_number = '7598';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'VA EB' and program_name = 'CCC PLUS'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CCC PLUS Spanish'),  interval_minutes = 15, service_seconds= 30 where queue_number = '7599';


-- cc_d_contact_queue

update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medallion'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Medallion English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7596';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'Medallion'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Medallion Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7597';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'CCC PLUS'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CCC PLUS English'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7598';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'VA EB'), d_program_id = (select program_id from cc_d_program where program_name = 'CCC PLUS'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CCC PLUS Spanish'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Virginia'),  interval_minutes = 15, service_seconds = 30 where queue_number = '7599';

commit;