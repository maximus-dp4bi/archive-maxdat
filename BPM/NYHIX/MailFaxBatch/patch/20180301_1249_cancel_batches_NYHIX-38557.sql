update CORP_ETL_MFB_BATCH 
set CANCEL_DT = to_date('/1/2015 00:00:00', 'MM/DD/YYYY HH24:MI:SS') , 
CANCEL_BY = 'NYHIX-16051', 
CANCEL_REASON = 'Batch was cancelled/deleted during User Tracking Outage', 
CANCEL_METHOD = 'Exception', 
INSTANCE_STATUS = 'Complete', 
INSTANCE_STATUS_DT = to_date('7/1/2015 00:00:00', 'MM/DD/YYYY HH24:MI:SS') , 
COMPLETE_DT = to_date('7/1/2015 00:00:00', 'MM/DD/YYYY HH24:MI:SS') , 
CURRENT_STEP = 'End - Cancelled', STG_LAST_UPDATE_DATE=sysdate, 
STG_DONE_DATE = sysdate  
where COMPLETE_DT is null 
and INSTANCE_STATUS='Active' 
and BATCH_NAME = 'NYSOH-FAX2015-06-30-17-06-24-5' ;	

