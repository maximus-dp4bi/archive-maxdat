alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set queue_type = 'Inbound'
where queue_name like 'WADC_DCEB%'
and queue_type = 'INBOUND';

update cc_d_contact_queue
set queue_type = 'Inbound'
where queue_name like 'WADC_DCEB%'
and queue_type = 'INBOUND';

update cc_c_contact_queue
set queue_type = 'After Hours'
where queue_name like 'WADC_DCEB%'
and queue_type = 'AFTER HOURS';

update cc_d_contact_queue
set queue_type = 'After Hours'
where queue_name like 'WADC_DCEB%'
and queue_type = 'AFTER HOURS';

commit;

