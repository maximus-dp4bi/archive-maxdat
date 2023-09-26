update cc_c_unit_of_work set unit_of_work_category = 'INBOUND_CALL' where  unit_of_work_name = 'Tier 2 Transfer' ;

update cc_d_unit_of_work set unit_of_work_category = 'INBOUND_CALL' where  unit_of_work_name = 'Tier 2 Transfer' ;

update cc_c_contact_queue set queue_type = 'Inbound' where queue_name = 'MIEL_CSCC_6060_TIER2';

update cc_d_contact_queue set queue_type = 'Inbound' where queue_name = 'MIEL_CSCC_9833_TIER2';

commit;

