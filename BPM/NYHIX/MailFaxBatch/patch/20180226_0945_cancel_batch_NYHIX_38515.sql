---- NYHIX-38515
 update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38515',
 CANCEL_REASON = 'NYHIX-38515', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS'),
 COMPLETE_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where BATCH_NAME = '667807-2/25/2018-11:04:24 AM-84552';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-37304',
 CANCEL_REASON = 'NYHIX-37304', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS') ,
 COMPLETE_DT = to_date('02/25/2018 11:20:07', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where BATCH_NAME ='667807-2/25/2018-11:04:24 AM-84552';
 commit;