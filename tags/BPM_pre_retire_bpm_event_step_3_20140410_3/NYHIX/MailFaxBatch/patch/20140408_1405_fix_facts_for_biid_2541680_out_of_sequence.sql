alter table f_mfb_by_hour enable row movement;

update f_mfb_by_hour set d_date=to_date('04/07/2014 07:04:44 AM','MM/DD/YYYY HH:MI:SS AM'),
bucket_start_date=to_date('04/07/2014 07:04:44 AM','MM/DD/YYYY HH:MI:SS AM'),
bucket_end_date=to_date('04/07/2014 08:04:00 AM','MM/DD/YYYY HH:MI:SS AM')
where fmfbbh_id=2477301;

update f_mfb_by_hour set d_date=to_date('04/07/2014 08:04:28 AM','MM/DD/YYYY HH:MI:SS AM'),
bucket_start_date=to_date('04/07/2014 08:04:00 AM','MM/DD/YYYY HH:MI:SS AM')
where fmfbbh_id=2477327;

update BPM_UPDATE_EVENT_QUEUE set PROCESS_BUEQ_ID = null where event_date<trunc(sysdate) and bsl_id=16;

commit;


alter table f_mfb_by_hour disable row movement;