update CORP_ETL_MFB_BATCH 
set REPROCESSED_FLAG = 'Y'
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2635726;
commit;

update CORP_ETL_MFB_BATCH_STG 
set REPROCESSED_FLAG = 'Y' 
,STG_LAST_UPDATE_DATE = current_date
where BATCH_ID=2635726;
commit;