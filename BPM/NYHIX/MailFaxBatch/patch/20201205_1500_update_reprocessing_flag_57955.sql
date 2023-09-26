alter session set current_schema = MAXDAT;
---- NYHIX-57955

update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y' where batch_name IN ('NYHO-FAX-FPBP-2019-07-19-14-27-27-883', 'NYSOH_FAX-8/30/2019-8:28:20 AM');

commit;

update corp_etl_mfb_batch set reprocessed_flag = 'Y' where batch_name IN ('NYHO-FAX-FPBP-2019-07-19-14-27-27-883', 'NYSOH_FAX-8/30/2019-8:28:20 AM');

commit;

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('04/07/2020', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-57282' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' 
where dcn IN ('19167309','19167310');

commit;