alter session set current_schema = MAXDAT;
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from corp_etl_mfb_batch;
commit;

delete from CORP_ETL_MFB_DOCUMENT;
commit;

delete from CORP_ETL_MFB_BATCH_EVENTS;
commit;

delete from CORP_ETL_MFB_ENVELOPE;
commit;


delete from CORP_ETL_MFB_FORM;
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
