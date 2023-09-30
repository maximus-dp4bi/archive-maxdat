delete from NYHIX_ETL_MAIL_FAX_DOC_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_WIP_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_CSC_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_APP_V2;

commit;

-- Remove from queue.
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 24;

--delete from Archive
delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE where BSL_ID = 24;

commit;

delete from MAXDAT.D_NYHIX_MFD_HISTORY_V2;
delete from MAXDAT.D_NYHIX_MFD_DOC_TYPE_V2;
delete from MAXDAT.D_NYHIX_MFD_DOC_STATUS_V2;
delete from MAXDAT.D_NYHIX_MFD_ENV_STATUS_V2;
delete from MAXDAT.D_NYHIX_MFD_FORM_TYPE_V2;
delete from MAXDAT.D_NYHIX_MFD_INS_STATUS_V2;
delete from MAXDAT.D_NYHIX_MFD_TIME_STATUS_V2;
delete from MAXDAT.D_NYHIX_MFD_CURRENT_V2;
commit;


update maxdat.corp_etl_control set value = '2018/05/01 12:00:00' where name='MAX_CREATE_DATE_DMS';
update maxdat.corp_etl_control set value = '2018/05/01 12:00:00' where name='MAX_CREATE_DATE_APP';
update maxdat.corp_etl_control set value = '2018/05/01 12:00:00' where name='MAX_UPDATE_TS_DOCUMENT';
commit;