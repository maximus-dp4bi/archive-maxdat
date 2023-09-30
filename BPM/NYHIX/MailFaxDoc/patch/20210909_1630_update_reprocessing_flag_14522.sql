alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1602115-139886-8/17/2021-2:54:01 PM','SOH_ML-1602163-313716-8/18/2021-10:08:01 AM','SOH_ML-1603958-307405-8/26/2021-1:42:50 PM');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1602115-139886-8/17/2021-2:54:01 PM','SOH_ML-1602163-313716-8/18/2021-10:08:01 AM','SOH_ML-1603958-307405-8/26/2021-1:42:50 PM');
commit;
