alter session set current_schema = MAXDAT;
---- NYHIX-58943
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-1500180-149459-6/8/2020-10:41:48 AM', 'NYSOH_Mail-1501085-120307-6/10/2020-4:02:07 PM','NYSOH_Mail-1500516-149459-6/9/2020-10:36:06 AM','NYSOH_Mail-1502372-150812-6/16/2020-12:49:05 PM','NYSOH_Mail-1500849-150812-6/10/2020-11:03:45 AM');
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYSOH_Mail-1500180-149459-6/8/2020-10:41:48 AM', 'NYSOH_Mail-1501085-120307-6/10/2020-4:02:07 PM','NYSOH_Mail-1500516-149459-6/9/2020-10:36:06 AM','NYSOH_Mail-1502372-150812-6/16/2020-12:49:05 PM','NYSOH_Mail-1500849-150812-6/10/2020-11:03:45 AM');

commit;