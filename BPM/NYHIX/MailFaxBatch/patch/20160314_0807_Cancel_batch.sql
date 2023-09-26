update CORP_ETL_MFB_BATCH 
set CANCEL_DT = to_date('8-MAR-16','dd-MON-yy') , 
CANCEL_BY = 'NYHIX-20740', 
CANCEL_REASON = 'Batch exported without any documents', 
CANCEL_METHOD = 'Exception', 
INSTANCE_STATUS = 'Complete', 
INSTANCE_STATUS_DT = to_date('8-MAR-16','dd-MON-yy') , 
COMPLETE_DT = to_date('8-MAR-16','dd-MON-yy') , 
CURRENT_STEP = 'End - Cancelled', 
STG_LAST_UPDATE_DATE=sysdate, 
STG_DONE_DATE = sysdate  
where BATCH_GUID = '{d8f2e63c-65d5-4e71-b2ff-4b378d2db79b}';

Commit;