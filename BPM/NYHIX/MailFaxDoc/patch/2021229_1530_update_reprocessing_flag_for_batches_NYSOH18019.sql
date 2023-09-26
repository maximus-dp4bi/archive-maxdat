--NYSOH-18272 -- NYSOH-18019 

alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1627962-139886-12/2/2021-3:20:11 PM','SOH_ML-1626847-313716-11/29/2021-9:40:15 AM','NYSOH_FAX-NavCAC2021-12-07-11-11-36-965');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('SOH_ML-1627962-139886-12/2/2021-3:20:11 PM','SOH_ML-1626847-313716-11/29/2021-9:40:15 AM','NYSOH_FAX-NavCAC2021-12-07-11-11-36-965');
commit;


