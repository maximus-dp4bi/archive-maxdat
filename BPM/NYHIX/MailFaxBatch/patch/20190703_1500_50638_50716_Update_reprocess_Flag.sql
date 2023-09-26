alter session set current_schema = MAXDAT;


alter session set current_schema = MAXDAT;
----  NYHIX-50638/50719/50716
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 2 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');
--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 1 records
from corp_etl_mfb_batch
where batch_name in  ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('865491-6/20/2019-10:30:51 AM-89436','865994-6/21/2019-9:15:26 AM-146953','866719-6/24/2019-11:29:43 AM-146953');


update NYHIX_ETL_MAIL_FAX_DOC_V2 
set CANCEL_DT  = to_date('06/27/2019', 'mm/dd/yyyy') ,
CANCEL_BY = 'NYHIX-50719' ,
ASF_CANCEL_DOC = 'Y' ,
CANCEL_REASON = 'Inactivated' ,
CANCEL_METHOD = 'Exception' ,
INSTANCE_END_DATE = to_date('06/27/2019', 'mm/dd/yyyy'), 
STG_DONE_DATE = to_date('06/27/2019', 'mm/dd/yyyy')
where dcn  in ('18240390');

commit;




