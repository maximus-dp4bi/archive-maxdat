alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set service_seconds = 40
where queue_number in (6246,
6247,
6256,
6261,
6263,
6264,
6268,
6509,
6775,
6776,
6777,
6778);

update cc_s_contact_queue
set service_seconds = 40
where queue_number in (6246,
6247,
6256,
6261,
6263,
6264,
6268,
6509,
6775,
6776,
6777,
6778);

update cc_d_contact_queue
set service_seconds = 40
where queue_number in (6246,
6247,
6256,
6261,
6263,
6264,
6268,
6509,
6775,
6776,
6777,
6778);

commit;