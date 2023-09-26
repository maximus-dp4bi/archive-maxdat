-- Add index to corp_etl_mfb_batch_events_stg

create index CORP_ETL_MFB_BES_IX1 on CORP_ETL_MFB_BATCH_EVENTS_STG (BATCH_MODULE_ID) online tablespace MAXDAT_INDX parallel compute statistics;

