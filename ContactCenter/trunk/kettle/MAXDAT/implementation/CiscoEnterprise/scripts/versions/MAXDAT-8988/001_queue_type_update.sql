alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'English'
where queue_number = 7725;

update cc_s_contact_queue 
set queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'English')
where queue_number = '7725';

update cc_d_contact_queue 
set queue_type = 'Inbound', 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'English')
where queue_number = '7725';

commit;



