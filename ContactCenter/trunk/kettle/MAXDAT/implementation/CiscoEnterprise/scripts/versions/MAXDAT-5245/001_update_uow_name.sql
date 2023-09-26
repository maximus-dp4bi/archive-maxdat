alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set unit_of_work_name = 'Hmong'
where queue_number in (6110, 6139, 6591);

update cc_c_unit_of_work
set unit_of_work_name = 'Hmong'
where unit_of_work_name = 'Hamong';

update cc_d_unit_of_work
set unit_of_work_name = 'Hmong'
where unit_of_work_name = 'Hamong';

commit;