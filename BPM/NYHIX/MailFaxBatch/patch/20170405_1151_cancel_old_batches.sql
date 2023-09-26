alter session set current_schema = MAXDAT;
---- NYHIX-29743

update corp_etl_mfb_batch_stg
set CANCEL_DT = to_date('03-MAR-2017 23:33:10', 'dd-MON-yyyy HH24:MI:SS') 
,CANCEL_BY = 'NYHIX-29743' 
,CANCEL_REASON = 'Attempted Reprocessing, Batch not found' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
, STG_DONE_DATE = to_date('03-MAR-2017 23:33:10', 'dd-MON-yyyy HH24:MI:SS')  
where batch_name in 
('486372-2/14/2017-2:16:56 PM-127635');
commit;


update corp_etl_mfb_batch
set CANCEL_DT = to_date('03-MAR-2017 23:33:10', 'dd-MON-yyyy HH24:MI:SS') 
,CANCEL_BY = 'NYHIX-29743' 
,CANCEL_REASON = 'Attempted Reprocessing, Batch not found' 
,CANCEL_METHOD = 'Exception' 
,INSTANCE_STATUS = 'Complete' 
, STG_DONE_DATE = to_date('03-MAR-2017 23:33:10', 'dd-MON-yyyy HH24:MI:SS')  
where batch_name in 
('486372-2/14/2017-2:16:56 PM-127635');
commit;
