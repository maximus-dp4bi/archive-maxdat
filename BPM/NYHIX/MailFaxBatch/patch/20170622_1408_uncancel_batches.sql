alter session set current_schema = MAXDAT;
---- NYHIX-32032

update corp_etl_mfb_batch_stg
set CANCEL_DT = null
,CANCEL_REASON = null
,CANCEL_METHOD = null
,INSTANCE_STATUS = 'Active' 
, STG_DONE_DATE = null  
, CANCEL_BY = null
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
commit;

update corp_etl_mfb_batch
set CANCEL_DT = null
,CANCEL_REASON = null
,CANCEL_METHOD = null
,INSTANCE_STATUS = 'Active' 
, STG_DONE_DATE = null 
, CANCEL_BY = null
where batch_name in 
('545584-6/2/2017-1:54:50 PM-134010');
commit;