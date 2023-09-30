delete from BPM_INSTANCE_ATTRIBUTE
where BI_ID in (select BI_ID from BPM_INSTANCE
where BSL_ID=18);

delete from BPM_UPDATE_EVENT
where BI_ID in (select bi_id from BPM_INSTANCE
where BSL_ID=18);

delete from BPM_INSTANCE
where BSL_ID=18;




delete from D_NYHIX_MFD_CURRENT;

delete from D_NYHIX_MFD_INS_STATUS;

delete from D_NYHIX_MFD_DOC_TYPE;

delete from D_NYHIX_MFD_DOC_STATUS;

delete from D_NYHIX_MFD_ENV_STATUS;

delete from D_NYHIX_MFD_DOC_SUB_TYPE;

delete from D_NYHIX_MFD_FORM_TYPE;

delete from D_NYHIX_MFD_TIME_STATUS;

delete from F_NYHIX_MFD_BY_DATE;



delete from BPM_UPDATE_EVENT_QUEUE
where bsl_id=18;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=18;

commit;