alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1607389-313716-9/9/2021-1:43:58 PM');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1607389-313716-9/9/2021-1:43:58 PM');
commit;
