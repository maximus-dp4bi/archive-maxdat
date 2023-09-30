update cc_s_contact_queue
set queue_type = 'Inbound',
unit_of_work_id = 82
where queue_name = 'MAXHIHIX_Issuer_vcall';

commit;