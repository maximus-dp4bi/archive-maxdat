update f_mfb_by_hour set fmfbbh_id=421431,bucket_end_date= to_date('01/18/2014 03:01:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=506014;
update f_mfb_by_hour set fmfbbh_id=506014, bucket_end_date=to_date('07/07/2077 12:07:00 AM','MM/DD/YYYY HH:MI:SS AM') where fmfbbh_id=1421496;
commit;


update bpm_update_event_queue
set process_bueq_id=null,
bue_id=null,
wrote_bpm_event_date=null
where bsl_id=16;

commit;