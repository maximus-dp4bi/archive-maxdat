alter session set current_schema = MAXDAT;
----  NYHIX-47587/47589
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 3 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  
from corp_etl_mfb_batch
where batch_name in  ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('807316-2/7/2019-8:56:52 AM-146953','809417-2/12/2019-10:00:26 AM-139890');


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('12/15/2018', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-47589' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('12/15/2018', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('12/15/2018', 'mm/dd/yyyy')
where dcn = '17823008';


commit;
