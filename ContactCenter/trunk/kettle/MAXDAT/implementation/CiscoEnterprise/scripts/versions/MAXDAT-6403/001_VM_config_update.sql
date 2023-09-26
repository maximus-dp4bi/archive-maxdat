update cc_a_list_lkup
set out_var = ''''||'Voicemail'||''''||',''VOICEMAIL'||''''||',''Voice Mail'||''''||',''VOICE MAIL'||''''||',''Voicemail from IVR'||''''||',''VOICEMAIL FROM IVR'||''''||',''Voicemail from Queue'||''''||',''VOICEMAIL FROM QUEUE'||''''
where name = 'VM_call_types'
and value = 'VM_call_types';

update cc_c_contact_queue
set queue_type = 'Voicemail'
where queue_type = 'Voice Mail';

update cc_s_contact_queue
set queue_type = 'Voicemail'
where queue_type = 'Voice Mail';

update cc_d_contact_queue
set queue_type = 'Voicemail'
where queue_type = 'Voice Mail';

commit;