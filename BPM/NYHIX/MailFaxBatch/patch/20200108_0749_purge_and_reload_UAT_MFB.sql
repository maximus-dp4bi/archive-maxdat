delete from maxdat.corp_etl_list_lkup where cell_id in (1943,1949,2961,2964, 2965);

update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_CENTRAL_LAST_UPDATE_DATE';
update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_ARS_LAST_UPDATE_DATE';
update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_REMOTE_LAST_UPDATE_DATE';
commit;


execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from CORP_ETL_MFB_BATCH_EVENTS_STG;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS_OLTP;
commit;

delete from CORP_ETL_MFB_BATCH_STG;
commit;

delete from CORP_ETL_MFB_BATCH;
commit;

delete from CORP_ETL_MFB_BATCH_TEMP;
commit;

delete from CORP_ETL_MFB_BATCH_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_OLTP;
commit;

delete from CORP_ETL_MFB_BATCH_ARS_STG;
commit;

delete from CORP_ETL_MFB_BATCH_ARS_OLTP;
commit;

delete from CORP_ETL_MFB_DOCUMENT_STG;
commit;

delete from CORP_ETL_MFB_ENVELOPE_STG;
commit;

delete from CORP_ETL_MFB_ENVELOPE_WIP;
commit;

delete from CORP_ETL_MFB_ENVELOPE_OLTP;
commit;


delete from CORP_ETL_MFB_ECN_STG;
commit;

delete from CORP_ETL_MFB_FORM_STG;
commit;

delete from CORP_ETL_MFB_FORM_WIP;
commit;

delete from CORP_ETL_MFB_DOCUMENT;
commit;

delete from CORP_ETL_MFB_DOCUMENT_OLTP;
commit;

delete from CORP_ETL_MFB_DOCUMENT_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS;
commit;

delete from CORP_ETL_MFB_ENVELOPE;
commit;

delete from CORP_ETL_MFB_FORM;
commit;

delete from CORP_ETL_MFB_FORM_OLTP;
commit;

delete from CORP_ETL_MFB_SML_OLTP;
commit;
delete from CORP_ETL_MFB_SB_OLTP;
commit;
delete from CORP_ETL_MFB_SBM_OLTP;
commit;

delete from bpm_update_event_queue where bsl_id=16;
commit;
delete from bpm_update_event_queue_archive where bsl_id=16;
commit;
delete from bpm_logging where bsl_id=16;
commit;
delete from F_MFB_BY_HOUR;
commit;
delete from d_mfb_current;
commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;
