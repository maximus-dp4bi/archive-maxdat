alter session set current_schema = MAXDAT;
----  NYHIX-47414
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('806178-2/5/2019-9:25:58 AM-149078');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('806178-2/5/2019-9:25:58 AM-149078');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('806178-2/5/2019-9:25:58 AM-149078');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('806178-2/5/2019-9:25:58 AM-149078');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('806178-2/5/2019-9:25:58 AM-149078');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('806178-2/5/2019-9:25:58 AM-149078');


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('02/13/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47555' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('02/13/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('02/13/2019', 'mm/dd/yyyy')
where dcn = '17804133';

update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('02/13/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47555' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('02/13/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('02/13/2019', 'mm/dd/yyyy')
 where dcn = '17804134';

commit;
