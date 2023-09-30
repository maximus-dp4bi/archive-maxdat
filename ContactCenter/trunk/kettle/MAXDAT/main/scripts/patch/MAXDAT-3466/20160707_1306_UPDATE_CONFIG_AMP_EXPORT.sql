update cc_a_list_lkup
set list_type = 'ACD,IVR'
, out_var = 'IVR'
where name = 'AMPEXP_METRIC_SOURCE_LIST'
and value = 'Calls Arriving';

commit;


delete from cc_a_list_lkup
where name = 'AMPEXP_METRIC_SOURCE_LIST'
and value in ('VOICE_MAILS_CREATED', 'VOICE_MAILS_HANDLED');

commit;