alter session set current_schema = MAXDAT;
---- NYHIX-62049
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-1571051-84552-3/20/2021-8:56:28 PM','NYSOH_FAX-3/20/2021-8:56:34 PM');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-1571051-84552-3/20/2021-8:56:28 PM','NYSOH_FAX-3/20/2021-8:56:34 PM');
commit;
