delete from F_MFB_BY_HOUR
where FMFBBH_ID = 645 and MFB_BI_ID = 537;

delete from F_MFB_BY_HOUR
where FMFBBH_ID = 603 and MFB_BI_ID = 538;

delete from F_MFB_BY_HOUR
where FMFBBH_ID = 597 and MFB_BI_ID = 540;

delete from F_MFB_BY_HOUR
where FMFBBH_ID = 599 and MFB_BI_ID = 541;

commit;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where BSL_ID = 16 and IDENTIFIER in ('64','65','67','68');

commit;
