--NYSOH-16372 -- NYSOH-16373 -- NYSOH-16206 -- NYSOH-16271 -- NYSOH-15565

alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_FAX-10/8/2021-5:14:04 PM','NYSOH_FAX-NavCAC2021-10-08-14-16-51-113','SOH_ML-1612862-414016-10/5/2021-2:18:00 PM','SOH_ML-1613174-414016-10/6/2021-1:16:09 PM','SOH_RM-1613019-414016-10/6/2021-9:16:15 AM','NYSOH_FAX-9/27/2021-4:25:15 PM','SOH_ML-1611312-313716-9/29/2021-9:02:09 AM');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_FAX-10/8/2021-5:14:04 PM','NYSOH_FAX-NavCAC2021-10-08-14-16-51-113','SOH_ML-1612862-414016-10/5/2021-2:18:00 PM','SOH_ML-1613174-414016-10/6/2021-1:16:09 PM','SOH_RM-1613019-414016-10/6/2021-9:16:15 AM','NYSOH_FAX-9/27/2021-4:25:15 PM','SOH_ML-1611312-313716-9/29/2021-9:02:09 AM');
commit;


