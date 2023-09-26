alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN where batch_name IN ('SOH_ML-1601479-307405-8/12/2021-2:46:18 PM','SOH_ML-1600639-139886-8/9/2021-12:03:22 PM','NYSOH_FAX-NavCAC2021-08-16-16-35-15-907','NYSOH_FAX-NavCAC2021-08-16-15-13-39-988');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1601479-307405-8/12/2021-2:46:18 PM','SOH_ML-1600639-139886-8/9/2021-12:03:22 PM','NYSOH_FAX-NavCAC2021-08-16-16-35-15-907','NYSOH_FAX-NavCAC2021-08-16-15-13-39-988');
commit;
