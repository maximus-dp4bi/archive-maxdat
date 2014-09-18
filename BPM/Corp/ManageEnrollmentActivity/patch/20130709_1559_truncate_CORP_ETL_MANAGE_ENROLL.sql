delete from BPM_INSTANCE_ATTRIBUTE
where BI_ID in (select BI_ID from BPM_INSTANCE
where BSL_ID=14);

delete from BPM_UPDATE_EVENT
where BI_ID in (select bi_id from BPM_INSTANCE
where BSL_ID=14);

delete from BPM_INSTANCE
where BSL_ID=14;

delete from F_ME_BY_DATE;

delete from D_ME_CURRENT;

delete from D_ME_ENRL_STATUS_CODE;

delete from BPM_UPDATE_EVENT_QUEUE
where bsl_id=14;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=14;

commit;