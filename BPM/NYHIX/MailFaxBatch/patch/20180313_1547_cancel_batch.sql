alter session set current_schema = MAXDAT;

update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS'),
 COMPLETE_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_GUID ='{550c0864-e1e6-4e45-94ff-b3bb77a10c4b}';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS') ,
 COMPLETE_DT = to_date('02/27/2018 09:53:24', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_GUID = '{550c0864-e1e6-4e45-94ff-b3bb77a10c4b}';
 commit;
                   
 
