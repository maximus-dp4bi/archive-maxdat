update CORP_ETL_MFB_BATCH SET ASF_RELEASE_DMS='N',ASED_RELEASE_DMS=null,CANCEL_DT=null, CANCEL_BY=NULL, CANCEL_REASON=NULL, CANCEL_METHOD=NULL,COMPLETE_DT=null, BATCH_DELETED='N',INSTANCE_STATUS='Active', STG_DONE_DATE=NULL;
commit;
alter package MAIL_FAX_BATCH compile;


