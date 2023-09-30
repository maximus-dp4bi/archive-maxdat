alter session set current_schema = MAXDAT;
---- NYHIX-62005
update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN 
( 'NYSOH_FAX-3/3/2021-10:50:35 AM' );
commit;
update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN
( 'NYSOH_FAX-3/3/2021-10:50:35 AM' );
commit;
update NYHIX_ETL_MAIL_FAX_DOC_V2
set CANCEL_DT  = to_date('03/29/2021', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-62005' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('03/29/2021', 'mm/dd/yyyy'),
STG_DONE_DATE = to_date('03/29/2021', 'mm/dd/yyyy')
where ECN IN ('2021030310530015159511');
commit;