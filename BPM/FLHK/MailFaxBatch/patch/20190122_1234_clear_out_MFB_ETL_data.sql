delete from CORP_ETL_MFB_FORM_STG;
commit;

delete from CORP_ETL_MFB_BATCH_STG;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS_STG;
commit;

delete from CORP_ETL_MFB_BATCH_ARS_STG;
commit;

delete from CORP_ETL_MFB_FORM_WIP;
commit;

delete from CORP_ETL_MFB_ENVELOPE_WIP;
commit;

delete from CORP_ETL_MFB_DOCUMENT_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS_WIP;
commit;

delete from CORP_ETL_MFB_ENVELOPE;
commit;

delete from CORP_ETL_MFB_DOCUMENT;
commit;

delete from CORP_ETL_MFB_ENVELOPE_STG;
commit;

delete from CORP_ETL_MFB_DOCUMENT_STG;
commit;

delete from CORP_ETL_MFB_FORM;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS;
commit;

delete from CORP_ETL_MFB_BATCH;
commit;

delete from CORP_ETL_ERROR_LOG where process_name ='PROCESSMAILFAXBATCH';
commit;

delete from CORP_ETL_JOB_STATISTICS where JOB_NAME like '%MFB%';
commit;

delete from corp_etl_mfb_sb_oltp;
commit;

delete from corp_etl_mfb_sbm_oltp;
commit;

delete from corp_etl_mfb_sml_oltp;
commit;

update CORP_ETL_CONTROL set VALUE=to_date('29-JAN-2019') where name in('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE','MFB_ARS_LAST_UPDATE_DATE');
commit;

update corp_etl_control set value = 1 where name = 'MFB_LAST_CNTR_ID';
commit;

delete from bpm_update_event_queue where bsl_id=16;
commit;
delete from bpm_update_event_queue_archive where bsl_id=16;
commit;
delete from bpm_logging where bsl_id=16;
commit;
truncate table F_MFB_BY_HOUR;
commit;
delete from d_mfb_current;
commit;

