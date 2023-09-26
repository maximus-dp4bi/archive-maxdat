alter session set current_schema = MAXDAT;
---- NYHIX-59683
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'  where batch_name in ( 'NYSOH_Mail-975447-150812-4/6/2020-10:34:44 AM');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name in ( 'NYSOH_Mail-975447-150812-4/6/2020-10:34:44 AM');
commit;
