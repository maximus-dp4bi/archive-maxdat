update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_INTERVAL-CALLS_OFFERED'
and value = 'VA EB';


update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
and value = 'VA EB';

commit;
