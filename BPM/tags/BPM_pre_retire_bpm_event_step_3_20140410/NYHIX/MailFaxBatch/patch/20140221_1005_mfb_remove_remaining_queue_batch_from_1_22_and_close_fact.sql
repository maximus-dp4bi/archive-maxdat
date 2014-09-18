delete from bpm_update_event_queue where identifier in('{cd1c76b9-5753-4554-ae2c-a258a31547f0}','{1c7f893e-0487-4408-a6f9-090bf6b25615}');
update f_mfb_by_hour set completion_count=1, bucket_end_date=bucket_start_date where mfb_bi_id=1160922;
delete from f_mfb_by_hour where fmfbbh_id in(2293931,2294295);
update BPM_UPDATE_EVENT_QUEUE set PROCESS_BUEQ_ID = null where event_date<trunc(sysdate) and bsl_id=16;
commit;
