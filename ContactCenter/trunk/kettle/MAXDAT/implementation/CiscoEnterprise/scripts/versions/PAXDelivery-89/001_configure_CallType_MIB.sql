alter session set current_schema = cisco_enterprise_cc;

-- contact queues

update cc_c_contact_queue 
set queue_type = 'Inbound', 
Unit_of_work_name = 'MI PSS English', 
project_name = 'MIEB', 
program_name = 'Multiple - Provider Support Services', 
region_name = 'Eastern', 
state_name = 'Michigan', 
service_seconds = 0, 
interval_minutes = 15 
where queue_number in (7966, 7967, 7968);

update cc_c_contact_queue 
set queue_type = 'Inbound', 
Unit_of_work_name = 'MI PSS English', 
project_name = 'MIEB', 
program_name = 'Multiple - Provider Support Services', 
region_name = 'Eastern', 
state_name = 'Michigan', 
service_seconds = 30, 
interval_minutes = 15 
where queue_number = 8006;


update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Multiple - Provider Support Services'), 
queue_type = 'Inbound', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MI PSS English'), 
service_seconds = 0, 
interval_minutes = 15 
where queue_number in (7966, 7967, 7968);

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'MIEB' and program_name = 'Multiple - Provider Support Services'), 
queue_type = 'Inbound', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'MI PSS English'), 
service_seconds = 30, 
interval_minutes = 15 
where queue_number = 8006;


update cc_d_contact_queue 
set queue_type = 'Inbound', 
d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Multiple - Provider Support Services'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MI PSS English'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),
service_seconds= 0, 
interval_minutes = 15 
where queue_number in (7966, 7967, 7968);

update cc_d_contact_queue 
set queue_type = 'Inbound', 
d_project_id = (select project_id from cc_d_project where project_name = 'MIEB'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Multiple - Provider Support Services'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'MI PSS English'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'Michigan'),
service_seconds= 30, 
interval_minutes = 15 
where queue_number = 8006;

commit;


