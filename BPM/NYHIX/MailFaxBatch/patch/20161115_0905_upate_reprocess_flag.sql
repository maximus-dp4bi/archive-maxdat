update CORP_ETL_MFB_BATCH 
set REPROCESSED_FLAG = 'Y'
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2649625;
commit;

update CORP_ETL_MFB_BATCH_STG 
set REPROCESSED_FLAG = 'Y' 
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2649625;
commit;

update CORP_ETL_MFB_BATCH 
set REPROCESSED_FLAG = 'Y'
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2649859;
commit;

update CORP_ETL_MFB_BATCH_STG 
set REPROCESSED_FLAG = 'Y' 
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2649859;
commit;

update CORP_ETL_MFB_BATCH 
set REPROCESSED_FLAG = 'Y'
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2651050;
commit;

update CORP_ETL_MFB_BATCH_STG 
set REPROCESSED_FLAG = 'Y' 
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2651050;
commit;