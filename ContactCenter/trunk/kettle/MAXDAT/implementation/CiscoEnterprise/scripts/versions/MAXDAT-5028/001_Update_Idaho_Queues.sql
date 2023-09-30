alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Call Back', unit_of_work_name = 'Call Back', service_percent = null, service_seconds = null, interval_minutes = 15, project_name = 'IDHW ET', program_name = 'Idaho Employment - Training Services', region_name = 'Eastern', state_name = 'Idaho'
where queue_number = 6546;

commit;

