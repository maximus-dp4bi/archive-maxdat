alter session set current_schema = MAXDAT;
----  NYHIX-59641
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')


update CORP_ETL_MFB_BATCH_STG set reprocessed_flag = 'Y'
where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')


------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')


commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch where batch_name in ( 'FPBP_Mail-1512456-84552-8/1/2020-12:32:03 PM','NYHO-FAX-Research-2020-08-01-12-46-53-721','NYHO-FAX-Research-2020-08-01-12-57-44-435','NYSOH_FAX-NavCAC2020-08-01-11-58-09-771','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_Mail-1512453-84552-8/1/2020-12:27:59 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_RM-1512460-84552-8/1/2020-12:41:48 PM','NYSOH_FAX-8/1/2020-12:39:55 PM','NYSOH_FAX-NavCAC2020-08-01-12-58-25-605')


------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('08/03/2020', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-59641' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('16760843','16760844','16760845','16760846','16760847','16760848','16760849');





