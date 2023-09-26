alter session set current_schema = MAXDAT_CC;

update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 20, interval_minutes = 15, unit_of_work_name = 'MI MSS English', project_name = 'MI MSS', program_name = 'MI MSS', region_name = 'Central', state_name = 'Illinois' where queue_number = '10136';

commit;