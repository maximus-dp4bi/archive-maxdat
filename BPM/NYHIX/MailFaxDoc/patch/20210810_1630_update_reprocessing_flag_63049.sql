alter session set current_schema = MAXDAT;
---- NYHIX-63049
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'  where BATCH_NAME IN ('SOH_ML-1599282-2_84552-7/31/2021-12:38:36 PM','NYSOH_FAX-7/31/2021-9:44:33 AM','NYSOH_Mail-1599094-307405-7/29/2021-3:28:06 PM');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y'      where BATCH_NAME IN ('SOH_ML-1599282-2_84552-7/31/2021-12:38:36 PM','NYSOH_FAX-7/31/2021-9:44:33 AM','NYSOH_Mail-1599094-307405-7/29/2021-3:28:06 PM');
commit;
