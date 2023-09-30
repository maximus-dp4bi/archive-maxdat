alter session set current_schema = MAXDAT;
---- NYHIX-62050
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ( 'NYSOH_FAX-3/19/2021-1:47:48 PM' );
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ( 'NYSOH_FAX-3/19/2021-1:47:48 PM' );
commit;
