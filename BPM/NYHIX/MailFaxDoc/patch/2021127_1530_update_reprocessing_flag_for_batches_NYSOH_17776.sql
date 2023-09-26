alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_FAX-HRA2021-11-12-12-05-49-414','SOH_ML-1624801-139886-11/18/2021-3:23:43 PM');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_FAX-HRA2021-11-12-12-05-49-414','SOH_ML-1625569-120307-11/22/2021-1:33:45 PM');
commit;

