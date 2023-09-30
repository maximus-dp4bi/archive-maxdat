update CORP_ETL_MFB_BATCH 
set CANCEL_DT = to_date('05-MAY-16','dd-MON-yy') , 
CANCEL_BY = 'NYHIX-22092', 
CANCEL_REASON = 'Batch exported without any documents', 
CANCEL_METHOD = 'Exception', 
INSTANCE_STATUS = 'Complete', 
INSTANCE_STATUS_DT = to_date('05-MAY-16','dd-MON-yy') , 
COMPLETE_DT = to_date('05-MAY-16','dd-MON-yy') , 
CURRENT_STEP = 'End - Cancelled', 
STG_LAST_UPDATE_DATE=sysdate, 
STG_DONE_DATE = sysdate  
where BATCH_GUID = '{ba85913a-16ab-4114-9321-14c792c236ea}';

Commit;