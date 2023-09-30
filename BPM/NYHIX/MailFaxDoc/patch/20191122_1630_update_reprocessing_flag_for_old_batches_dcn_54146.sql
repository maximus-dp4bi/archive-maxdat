alter session set current_schema = MAXDAT;
----  NYHIX-54146
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

commit;

select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = 'NYSOH_FAX-11/8/2019-8:53:22 AM';

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('18662892');

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('10/07/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-54146' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('11/22/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('11/22/2019', 'mm/dd/yyyy')
where dcn IN ('18662892');

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn IN ('18662892');
