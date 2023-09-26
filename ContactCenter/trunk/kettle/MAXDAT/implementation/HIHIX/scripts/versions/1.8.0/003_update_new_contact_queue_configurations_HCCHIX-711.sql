update cc_c_contact_queue
set queue_type = 'Inbound'
, unit_of_work_name = 'SHOP'
where queue_name = 'MAXHIHIX_Broker_vcall';

update cc_c_contact_queue
set queue_type = 'Vmail '
, unit_of_work_name = 'Voice Mail'
where queue_name = 'MAXHIHIX_English_Individual_Application_vmail';

update cc_c_contact_queue
set queue_type = 'Vmail'
, unit_of_work_name = 'Voice Mail'
where queue_name = 'MAXHIHIX_Medicaid_vmail';

update cc_c_contact_queue
set queue_type = 'Vmail'
, unit_of_work_name = 'Voice Mail'
where queue_name = 'MAXHIHIX_English_Shop_Application_vmail';

commit;


update cc_s_contact_queue
set queue_type = 'Inbound'
, unit_of_work_id = 5
where queue_name = 'MAXHIHIX_Broker_vcall';

update cc_s_contact_queue
set queue_type = 'Vmail '
, unit_of_work_id = 42
where queue_name = 'MAXHIHIX_English_Individual_Application_vmail';

update cc_s_contact_queue
set queue_type = 'Vmail'
, unit_of_work_id = 42
where queue_name = 'MAXHIHIX_Medicaid_vmail';

update cc_s_contact_queue
set queue_type = 'Vmail'
, unit_of_work_id = 42
where queue_name = 'MAXHIHIX_English_Shop_Application_vmail';

commit;


update cc_d_contact_queue
set queue_type = 'Inbound'
where queue_name = 'MAXHIHIX_Broker_vcall';

update cc_d_contact_queue
set queue_type = 'Vmail '
where queue_name = 'MAXHIHIX_English_Individual_Application_vmail';

update cc_d_contact_queue
set queue_type = 'Vmail'
where queue_name = 'MAXHIHIX_Medicaid_vmail';

update cc_d_contact_queue
set queue_type = 'Vmail'
where queue_name = 'MAXHIHIX_English_Shop_Application_vmail';

commit;