alter session set current_schema = MAXDAT;
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN  ('NYSOH_FAX-NavCAC2021-09-08-13-21-17-485','NYSOH_FAX-9/9/2021-1:02:17 PM','FPBP_ML-1608194-278416-9/14/2021-12:55:59 PM','NYSOH_FAX-NavCAC2021-09-13-18-32-18-523','NYSOH_FAX-NavCAC2021-09-14-17-25-04-038','SOH_ML-1608356-134007-9/14/2021-4:53:42 PM','SOH_ML-1607223-313716-9/8/2021-12:37:48 PM','NYSOH_FAX-NavCAC2021-09-09-09-22-56-229','SOH_ML-1607557-307405-9/10/2021-10:05:33 AM','SOH_ML-1603958-307405-8/26/2021-1:42:50 PM');
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_FAX-NavCAC2021-09-08-13-21-17-485','NYSOH_FAX-9/9/2021-1:02:17 PM','FPBP_ML-1608194-278416-9/14/2021-12:55:59 PM','NYSOH_FAX-NavCAC2021-09-13-18-32-18-523','NYSOH_FAX-NavCAC2021-09-14-17-25-04-038','SOH_ML-1608356-134007-9/14/2021-4:53:42 PM','SOH_ML-1607223-313716-9/8/2021-12:37:48 PM','NYSOH_FAX-NavCAC2021-09-09-09-22-56-229','SOH_ML-1607557-307405-9/10/2021-10:05:33 AM','SOH_ML-1603958-307405-8/26/2021-1:42:50 PM');

commit;
