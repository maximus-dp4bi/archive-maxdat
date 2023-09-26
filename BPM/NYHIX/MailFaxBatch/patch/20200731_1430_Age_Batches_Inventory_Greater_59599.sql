alter session set current_schema = MAXDAT;
---- NYHIX-59599
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
 where batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
 where  batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
commit;
select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
 where batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
 where batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
  where batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
commit;
select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
  where batch_name IN ('NYSOH_RM-1508166-149459-7/15/2020-3:14:46 PM');
