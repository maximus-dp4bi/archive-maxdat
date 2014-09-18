delete from MAXDAT.CORP_ETL_MFB_FORM_STG;
commit;
delete from MAXDAT.CORP_ETL_MFB_BATCH_STG;
commit;
delete from MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG;
commit;
delete from MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG;
commit;

delete from MAXDAT.CORP_ETL_MFB_FORM_WIP;
commit;

delete from MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP;
commit;

delete from MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP;
commit;

delete from MAXDAT.CORP_ETL_MFB_BATCH_WIP;
commit;

delete from MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP;
commit;

delete from MAXDAT.CORP_ETL_MFB_ENVELOPE;
commit;

delete from MAXDAT.CORP_ETL_MFB_DOCUMENT;
commit;

delete from MAXDAT.CORP_ETL_MFB_ENVELOPE_STG;
commit;

delete from MAXDAT.CORP_ETL_MFB_DOCUMENT_STG;
commit;

delete from MAXDAT.CORP_ETL_MFB_FORM;
commit;

delete from MAXDAT.CORP_ETL_MFB_BATCH_EVENTS;
commit;

delete from MAXDAT.CORP_ETL_MFB_BATCH;
commit;

delete from MAXDAT.CORP_ETL_ERROR_LOG where process_name ='PROCESSMAILFAXBATCH';
commit;
delete from MAXDAT.CORP_ETL_JOB_STATISTICS where JOB_NAME like '%MFB%';
commit;

update MAXDAT.CORP_ETL_CONTROL set VALUE=to_date('01-Jan-2013') where name in('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE','MFB_ARS_LAST_UPDATE_DATE');
commit;

delete from PP_D_ACTUAL_DETAILS;
commit;
delete from pp_f_actuals;
commit;

