update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Inbound-English', project_name = 'KSLW', program_name = 'KSLW', region_name = 'Central', state_name = 'Kansas' where queue_number = '5545';

commit;