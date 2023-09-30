ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '0', interval_minutes = '15', queue_type = 'Transfer', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6791;
update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '0', interval_minutes = '15', queue_type = 'Transfer', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6792;
update cc_c_contact_queue set unit_of_work_name = 'English', service_seconds = '0', interval_minutes = '15', queue_type = 'Transfer', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6793;
update cc_c_contact_queue set unit_of_work_name = 'Spanish', service_seconds = '0', interval_minutes = '15', queue_type = 'Transfer', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6794;
update cc_c_contact_queue set unit_of_work_name = 'Spanish', service_seconds = '0', interval_minutes = '15', queue_type = 'Transfer', project_name = 'Wyoming Dept of Health', program_name = 'Medicaid / CHIP', region_name = 'West', state_name = 'Wyoming' where queue_number =6795;

COMMIT;