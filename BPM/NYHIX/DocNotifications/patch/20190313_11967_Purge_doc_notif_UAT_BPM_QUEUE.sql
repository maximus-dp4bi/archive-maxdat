delete from DOCUMENT_NOTIFICATION_STG;
commit;

delete from NYHIX_ETL_DOC_NOTIF_OLTP;
delete from NYHIX_ETL_DOC_NOTIF_WIP_BPM;
delete from NYHIX_ETL_DOC_NOTIFICATIONS;
commit;

delete from MAXDAT.D_NYHIX_DOC_NOTIF_CURRENT;
delete from D_NYHIX_DOC_NOTIF_HISTORY;
commit;

DELETE FROM BPM_UPDATE_EVENT_QUEUE where BSL_ID = 30;

delete from BPM_LOGGING where BSL_ID = 30;

update maxdat.corp_etl_control set value = '2018/10/26 10:21:08' where name = 'DLY_MAX_UPDATE_TS_DOC_NOTIF';
update maxdat.corp_etl_control set value = '2018/10/26 10:21:08' where name = 'MAX_CREATE_DATE_DOCNOTIF';
update maxdat.corp_etl_control set value = '2018/10/26 10:21:08' where name = 'MAX_UPDATE_TS_DOC_NOTIF';
update maxdat.corp_etl_control set value = 120 where name = 'DOCNOTIF_LOOKBACK_DAYS';


commit;

