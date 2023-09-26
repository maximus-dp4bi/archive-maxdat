alter session set current_schema = MAXDAT;
---- NYHIX-62006
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN 
( 'NYSOH_FAX-3/16/2021-4:14:10 PM' );
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN
( 'NYSOH_FAX-3/16/2021-4:14:10 PM' );
commit;
