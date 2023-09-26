alter session set current_schema = MAXDAT;
----  NYHIX-46123
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

commit;

select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
where batch_name = ('NYSOH-FAX-12/6/2018-2:35:42 PM 12/6/2018 2:35:42 PM');

------------
SELECT 'Before NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn = '17606988';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('12/13/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-44019' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_STATUS = 'Complete' ,
INSTANCE_END_DATE = to_date('12/13/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('12/13/2018', 'mm/dd/yyyy')
where dcn = '17606988';

commit;

SELECT 'After NYHIX_ETL_MAIL_FAX_DOC_V2', dcn, cancel_dt, cancel_by, asf_cancel_doc, cancel_reason, cancel_method,
       instance_status, instance_end_date, stg_done_date
FROM   NYHIX_ETL_MAIL_FAX_DOC_V2
WHERE  dcn = '17606988';
