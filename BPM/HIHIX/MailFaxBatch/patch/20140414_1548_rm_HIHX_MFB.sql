drop trigger TRG_AI_CORP_ETL_MFB_BATCH_Q;
drop trigger TRG_AU_CORP_ETL_MFB_BATCH_Q;

drop package MAIL_FAX_BATCH;

--

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 6;

delete from PROCESS_BPM_QUEUE_JOB_CONFIG 
where BSL_ID = 16;

alter table BPM_ATTRIBUTE_STAGING_TABLE drop constraint BAST_BSL_FK;

delete from BPM_SOURCE_LKUP 
where 
  BSL_ID = 16
  and NAME = 'CORP_ETL_MFB_BATCH';

commit;