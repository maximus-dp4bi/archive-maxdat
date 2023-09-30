alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set interval_minutes = 15
where interval_minutes = 30;

update cc_s_contact_queue
set interval_minutes = 15
where interval_minutes = 30;

update cc_d_contact_queue
set interval_minutes = 15
where interval_minutes = 30;

commit;