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
 where Batch_GUID = '550c0864-e1e6-4e45-94ff-b3bb77a10c4b}';
 
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
 where Batch_GUID = '550c0864-e1e6-4e45-94ff-b3bb77a10c4b}';
 commit;

update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS'),
 COMPLETE_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_GUID = '{6c92e7c1-3d35-40a1-b651-ae070e9a8974}';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS') ,
 COMPLETE_DT = to_date('02/27/2018 09:51:05', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where Batch_GUID ='{6c92e7c1-3d35-40a1-b651-ae070e9a8974}';
 commit;

 
 update CORP_ETL_MFB_BATCH 
 set CANCEL_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS'),
 COMPLETE_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where BATCH_GUID = '{e805775e-6360-4433-ad08-f0db60bcb78a}';
 
 update CORP_ETL_MFB_BATCH_STG 
 set CANCEL_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS'),
 CANCEL_BY = 'NYHIX-38626',
 CANCEL_REASON = 'NYHIX-38626', 
 CANCEL_METHOD = 'Exception',
 INSTANCE_STATUS = 'Complete', 
 INSTANCE_STATUS_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS') ,
 COMPLETE_DT = to_date('02/27/2018 09:57:24', 'MM/DD/YYYY HH24:MI:SS'),
 CURRENT_STEP = 'End - Cancelled', 
 STG_LAST_UPDATE_DATE=sysdate,
 STG_DONE_DATE = sysdate  
 where BATCH_GUID ='{e805775e-6360-4433-ad08-f0db60bcb78a}';
 commit;
 
 