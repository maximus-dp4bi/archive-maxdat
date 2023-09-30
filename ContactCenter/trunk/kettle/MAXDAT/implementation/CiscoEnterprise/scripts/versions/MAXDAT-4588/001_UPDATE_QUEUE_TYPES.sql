alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'After Hours'
where queue_number in (5312, 6226);

update cc_c_unit_of_work
set unit_of_work_category = 'AFTER_HOURS'
where unit_of_work_name = 'After Hours';

update cc_d_unit_of_work
set unit_of_work_category = 'AFTER_HOURS'
where unit_of_work_name = 'After Hours';

commit;