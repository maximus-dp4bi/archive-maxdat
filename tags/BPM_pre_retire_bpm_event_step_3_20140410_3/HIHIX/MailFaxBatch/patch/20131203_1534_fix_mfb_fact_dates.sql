update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2013-11-22 21:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 645 and MFB_BI_ID = 537;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 626 and MFB_BI_ID = 537;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2013-11-22 21:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 603 and MFB_BI_ID = 538;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 560 and MFB_BI_ID = 538;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2013-11-22 21:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 597 and MFB_BI_ID = 540;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 576 and MFB_BI_ID = 540;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2013-11-22 19:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 599 and MFB_BI_ID = 541;

update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS')
where FMFBBH_ID = 591 and MFB_BI_ID = 541;

commit;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where BSL_ID = 16 and IDENTIFIER in ('64','65','67','68');

commit;
