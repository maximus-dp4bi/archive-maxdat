alter session set current_schema = MAXDAT;


update maxdat.CORP_ETL_MFB_BATCH cb
set 
  COMPLETE_DT = to_date('27-FEB-2018 09:01:33', 'DD-MON-YYYY HH24:MI:SS'),
  BATCH_COMPLETE_DT = to_date('27-FEB-2018 09:01:33', 'DD-MON-YYYY HH24:MI:SS'),
  STG_LAST_UPDATE_DATE = to_date('27-FEB-2018 09:01:33', 'DD-MON-YYYY HH24:MI:SS'),
  INSTANCE_STATUS = 'Complete',
  CURRENT_BATCH_MODULE_ID = 'N/A'
where INSTANCE_STATUS = 'Active'
  and BATCH_GUID in
('{03037dd3-9a33-4d29-b71c-e661ca86cfa1}');
commit;

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
 where BATCH_NAME = 'NYSOH-FAX-2/27/2018-9:43:40 AM';
 
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
 where BATCH_NAME ='NYSOH-FAX-2/27/2018-9:43:40 AM';
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
 where BATCH_NAME = 'NYSOH-FAX-2/27/2018-9:41:06 AM 2/27/2018 9:41:06 AM';
 
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
 where BATCH_NAME ='NYSOH-FAX-2/27/2018-9:41:06 AM 2/27/2018 9:41:06 AM';
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
 where BATCH_NAME = 'NYSOH-FAX-2/27/2018-9:51:05 AM';
 
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
 where BATCH_NAME ='NYSOH-FAX-2/27/2018-9:51:05 AM';
 commit;
 
 