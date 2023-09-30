alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set bucketintervalid = 5064, service_seconds = 180
where queue_number in (7890, 7886, 7891);

update cc_s_contact_queue
set service_seconds = 180
where queue_number in (7890, 7886, 7891);

update cc_d_contact_queue
set service_seconds = 180
where queue_number in (7890, 7886, 7891);

commit;