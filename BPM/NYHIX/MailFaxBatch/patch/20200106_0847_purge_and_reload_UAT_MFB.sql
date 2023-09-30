Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (2962,'MFB_BATCH_CLASS_LIST11','MFB_BATCH_CLASS_LIST','These are the NYHIX UAT Batch Classes','NYSOH_UAT_FAX_NavCAC’',null,null,to_date('25-NOV-19','DD-MON-RR'),to_date('31-DEC-22','DD-MON-RR'),null,to_date('25-NOV-19','DD-MON-RR'),to_date('25-NOV-19','DD-MON-RR'));
commit;

update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_CENTRAL_LAST_UPDATE_DATE';
update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_ARS_LAST_UPDATE_DATE';
update maxdat.corp_etl_control set value='01-DEC-19' where name ='MFB_REMOTE_LAST_UPDATE_DATE';
commit;


execute MAXDAT_ADMIN.SHUTDOWN_JOBS;


delete from CORP_ETL_MFB_BATCH_EVENTS_STG;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_STG;
commit;

delete from CORP_ETL_MFB_BATCH_WIP;
commit;

delete from CORP_ETL_MFB_BATCH_ARS_STG;
commit;

delete from CORP_ETL_MFB_DOCUMENT_STG;
commit;

delete from CORP_ETL_MFB_ENVELOPE_STG;
commit;

delete from CORP_ETL_MFB_ENVELOPE_WIP;
commit;

delete from CORP_ETL_MFB_FORM_STG;
commit;

delete from CORP_ETL_MFB_FORM_WIP;
commit;

delete from CORP_ETL_MFB_DOCUMENT;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS;
commit;

delete from CORP_ETL_MFB_ENVELOPE;
commit;

delete from CORP_ETL_MFB_FORM;
commit;

delete from CORP_ETL_MFB_SML_OLTP;
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
