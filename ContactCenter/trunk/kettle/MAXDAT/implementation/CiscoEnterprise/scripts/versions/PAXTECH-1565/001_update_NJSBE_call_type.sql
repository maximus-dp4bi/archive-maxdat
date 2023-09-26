alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Callback Offered'
where queue_number in (8732, 8715);

update cc_s_contact_queue
set queue_type = 'Callback Offered'
where queue_number in (8732, 8715);

update cc_d_contact_queue
set queue_type = 'Callback Offered'
where queue_number in (8732, 8715);

update cc_c_contact_queue
set service_seconds = 30
where queue_number = 8799;

update cc_s_contact_queue
set service_seconds = 30
where queue_number = 8799;

update cc_d_contact_queue
set service_seconds = 30
where queue_number = 8799;


commit;