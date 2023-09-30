alter session set current_schema = MAXDAT;
---- NYHIX-58153
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-986773-150812-5/11/2020-1:00:36 PM');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-986773-150812-5/11/2020-1:00:36 PM');
commit;

