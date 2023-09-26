alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 1',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7258);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '1 - Strongly Agree',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7259, 7265, 7271, 7277, 7303, 7308);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '2 - Agree',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7260, 7266, 7272, 7278, 7304, 7309);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '3 - Neutral',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7261, 7267, 7273, 7279, 7305, 7310);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '4 - Disagree',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7262, 7268, 7274, 7280, 7306, 7311);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = '5 - Strongly Disagree',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7263, 7269, 7275, 7281, 7307, 7312);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 2',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7264);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 3',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7270);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 4',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7276);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 5',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7282);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Question 6',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7283);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Survey End',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7284);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'English Survey',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7285);

update cc_c_contact_queue
set queue_type = 'IVR Survey', unit_of_work_name = 'Spanish Survey',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7286);

update cc_c_contact_queue
set queue_type = 'IVR FAQ', unit_of_work_name = 'English FAQ',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7313,7314,7315,7316,7317);

update cc_c_contact_queue
set queue_type = 'IVR FAQ', unit_of_work_name = 'Spanish FAQ',service_percent = 0, service_seconds = 180, interval_minutes = 15, project_name = 'Health Colorado', program_name = 'Health Colorado', region_name = 'West', state_name = 'Colorado'
where 
queue_number in (7318,7319,7320,7321,7322);

commit;
