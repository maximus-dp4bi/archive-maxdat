---- NYHIX-37304
 update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-37304',
 CANCEL_REASON = 'NYHIX-37304', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
 COMPLETE_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where COMPLETE_DT is null and INSTANCE_STATUS='Active' and BATCH_NAME = '12/26/2017';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-37304',
 CANCEL_REASON = 'NYHIX-37304', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS') ,
 COMPLETE_DT = to_date('01/08/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where COMPLETE_DT is null and INSTANCE_STATUS='Active' and BATCH_NAME = BATCH_NAME = '12/26/2017';
 commit;
