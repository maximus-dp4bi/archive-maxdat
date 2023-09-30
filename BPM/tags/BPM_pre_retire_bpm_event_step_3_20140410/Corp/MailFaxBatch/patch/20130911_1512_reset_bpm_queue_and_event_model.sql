delete from bpm_logging
where bsl_id=16;

update bpm_update_event_queue
set process_bueq_id=null,
bue_id=null,
wrote_bpm_event_date=null
where bsl_id=16;

delete from bpm_instance_attribute
where bi_id in (select bi_id from bpm_instance where bsl_id=16);

delete from bpm_update_event
where bi_id in (select bi_id from bpm_instance where bsl_id=16);

delete from bpm_instance
where bsl_id=16;

commit;