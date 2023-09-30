delete from F_MFB_BY_HOUR
where FMFBBH_ID = 665 and MFB_BI_ID = 537;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 626 and MFB_BI_ID = 537;

commit;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where BSL_ID = 16 and IDENTIFIER in ('64');

commit;
