alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = 'Provider Specialist Transfer'
where queue_number = 5852;

commit;