alter session set current_schema = MAXDAT;
----  NYHIX-42650
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-NavCAC2018-07-31-17-08-22-796');

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn in ('17198832','17198833','17198848','17198849');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('08/06/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-42650' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('08/06/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('08/06/2018', 'mm/dd/yyyy')
where dcn in ('17198832','17198833','17198848','17198849');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn in ('17198832','17198833','17198848','17198849');
