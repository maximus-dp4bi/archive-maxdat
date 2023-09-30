alter session set current_schema = MAXDAT;
----  NYHIX-51260
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name IN ('NYSOH_FAX-NavCAC2019-07-13-13-30-25-660','NYSOH_FAX-NavCAC2019-07-13-20-07-39-728');

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('18298938','18298939','18299147','18299148');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('07/22/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-51260' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('07/22/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('07/22/2019', 'mm/dd/yyyy')
where dcn IN ('18298938','18298939','18299147','18299148');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('18298938','18298939','18299147','18299148');
