update f_mfb_by_hour set fmfbbh_id=525501 where fmfbbh_id=1525501;


update bpm_update_event_queue
set process_bueq_id=null,
bue_id=null,
wrote_bpm_event_date=null
where bsl_id=16;

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(16,2,'ENABLED','Y');

commit;