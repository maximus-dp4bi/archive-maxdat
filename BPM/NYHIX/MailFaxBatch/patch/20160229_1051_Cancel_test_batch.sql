-- Cancel MFB Test Batch

update CORP_ETL_MFB_BATCH 
set CANCEL_DT = sysdate , 
CANCEL_BY = 'NYHIX-20543', 
CANCEL_REASON = 'Test Batches', 
CANCEL_METHOD = 'Exception', 
INSTANCE_STATUS = 'Complete', 
INSTANCE_STATUS_DT = sysdate , 
COMPLETE_DT = sysdate , 
CURRENT_STEP = 'End - Cancelled', 
STG_LAST_UPDATE_DATE=sysdate, 
STG_DONE_DATE = sysdate  
where BATCH_GUID = '{c069956a-cf07-4333-b346-404ea82a3476}';

Commit;

