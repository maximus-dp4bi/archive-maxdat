alter session set current_schema = MAXDAT;
---- NYHIX-32032

update corp_etl_mfb_batch_stg
set CANCEL_DT = to_date('22-JUN-2017', 'dd-MON-yyyy') 
,CANCEL_BY = 'NYHIX-32032' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
, STG_DONE_DATE = to_date('22-JUN-2017', 'dd-MON-yyyy')  
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
commit;

update corp_etl_mfb_batch
set CANCEL_DT = to_date('22-JUN-2017', 'dd-MON-yyyy') 
,CANCEL_BY = 'NYHIX-32032' 
,CANCEL_REASON = 'Inactivated' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
, STG_DONE_DATE = to_date('22-JUN-2017', 'dd-MON-yyyy')  
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
commit;

select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in ('545584-6/2/2017-1:54:50 PM-134010');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
