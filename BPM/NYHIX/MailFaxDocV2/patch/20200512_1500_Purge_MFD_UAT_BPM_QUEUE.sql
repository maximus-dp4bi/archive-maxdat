delete from NYHIX_ETL_MAIL_FAX_DOC_V2;
commit;

delete from NYHIX_ETL_MAIL_FAX_DOC_APP_V2
where APP_DOC_DATA_ID in (select APP_DOC_DATA_ID from NYHIX_ETL_MAIL_FAX_DOC_V2);

delete from NYHIX_ETL_MAIL_FAX_DOC_CSC_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2;
delete from NYHIX_ETL_MAIL_FAX_DOC_WIP_V2;
commit;

delete from MAXDAT.F_NYHIX_MFD_BY_DATE;
delete from D_NYHIX_MFD_HISTORY_V2;
delete from D_NYHIX_MFD_CURRENT_V2;
commit;

delete from D_BATCHES;
delete from D_DOCUMENTS;
delete from document_stg;
delete from DOC_LINK_STG;
delete from DOCUMENT_SET_STG;
delete from APP_DOC_DATA_EXT_STG;
delete from APP_DOC_TRACKER_STG;
delete from app_doc_data_stg;
commit;

DELETE FROM BPM_UPDATE_EVENT_QUEUE where BSL_ID = 24;

delete from BPM_LOGGING where BSL_ID = 24;

update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_DOC_LINK_HIST_STG';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_CREATE_DATE_DOCNOTIF';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_CREATE_DATE_MAXE';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_CREATE_DATE_DMS';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_CREATE_DATE_APP';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_DATE_APP';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_DOC_NOTIF';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_DOCUMENT';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_APP_DOC_EXT';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_DOC_SET';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_DOC_LINK';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_APP_DOC_TRACKER';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_DMS_DOCUMENTS';
update maxdat.corp_etl_control set value =  440863		 where name = 'MAX_APP_DOC_INDV_ID';
update maxdat.corp_etl_control set value = '2019/01/01 10:21:08' where name = 'MAX_UPDATE_TS_APP_DOC';
update maxdat.corp_etl_control set value = 456924		 where name = 'MAX_DCN_DETAIL_ID';
update maxdat.corp_etl_control set value = 496                   where name = 'MAX_APP_DOC_INDV_LOOKBACK';
UPDATE maxdat.corp_etl_control set VALUE = 496                   where name = 'MFD_DOC_LOOK_BACK_DAYS';

commit;

