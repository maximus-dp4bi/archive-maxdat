
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'IVR Child Support', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5739';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'IVR New Hire', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5740';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Employer', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5814';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5815';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'New Hire', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5816';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5817';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MO CS', program_name = 'MO Child Support', region_name = 'Central', state_name = 'Missouri' where queue_number = '5818';


update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5827';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5828';
update cc_c_contact_queue set queue_type = 'Inbound' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'GENERAL', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5829';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'LEAD', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5830';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'SUPERVISOR', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5831';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Tier 2', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5832';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Provider Enrollment', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5833';
update cc_c_contact_queue set queue_type = 'Transfer' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'Tier 2', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5854';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'IVR', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5855';
update cc_c_contact_queue set queue_type = 'IVR' , service_seconds = 30, interval_minutes = 15, unit_of_work_name = 'IVR Tier 2', project_name = 'MI APCC', program_name = 'MI Provider Support', region_name = 'Eastern', state_name = 'Michigan' where queue_number = '5856';


commit;