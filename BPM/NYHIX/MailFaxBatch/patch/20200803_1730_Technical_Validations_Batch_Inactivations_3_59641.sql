alter session set current_schema = MAXDAT;
----  NYHIX-59641

update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'
where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605');

commit;


