---- NYHIX-40674

alter session set current_schema = MAXDAT;

update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 CANCEL_BY = 'NYHIX-40674',
 CANCEL_REASON = 'Reprocessed', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 COMPLETE_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_name ='NYSOH-FAX-5/4/2018-2:18:57 PM';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 CANCEL_BY = 'NYHIX-40674',
 CANCEL_REASON = 'Reprocessed', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 COMPLETE_DT = to_date('05/17/2018', 'MM/DD/YYYY'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_name ='NYSOH-FAX-5/4/2018-2:18:57 PM';
 commit;
                   
 
