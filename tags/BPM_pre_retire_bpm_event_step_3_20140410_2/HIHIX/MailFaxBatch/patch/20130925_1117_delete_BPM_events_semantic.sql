delete from bpm_instance_attribute where bi_id in (select bi_id from bpm_instance where bsl_id=16);

delete from bpm_update_event_queue where bsl_id=16;

delete from bpm_update_event_queue_archive where bsl_id=16;

delete from bpm_update_event where bi_id in (select bi_id from bpm_instance where bsl_id=16);

delete from bpm_instance where bsl_id=16;

truncate table F_MFB_BY_HOUR;

delete from d_mfb_current;

commit;