-- NYHIX-18421 - Close batches.

-- Get list of uncompleted batches in ETL staging table.
-- NYHXMXDP DB
/*
select '    ''' || BATCH_GUID || ''',' 
from CORP_ETL_MFB_BATCH 
where 
  BATCH_COMPLETE_DT is null 
  and COMPLETE_DT is null 
  and CANCEL_DT is null;
*/

-- Get list of batches completed on source Kofax table that show as uncompleted on ETL staging table.
-- KOFAX Central DB

/*
select '    ''' + BATCHID + ''','
from [STATISTICS]..BATCH 
where 
  CREATIONDTM < '07/02/2015' -- Only batches that may have been missed during outage, not batches yet to be processed.
  and CLASSNAME in('NYSOH-MAIL','NYSOH-FAX')
  and BATCHID in (
--  ...{insert list from ETL staging table query from CORP_ETL_MFB_BATCH}
);
*/
    
-- Update ETL staging table to  mark batches as completed that have completed.
-- Divided into sets of 1000 BATCH_GUIDs as required by Oracle.
-- NYHXMXDP DB

update CORP_ETL_MFB_BATCH cb
set 
  COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  BATCH_COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  STG_LAST_UPDATE_DATE = sysdate,
  INSTANCE_STATUS = (case when (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name) is not null then 'Complete' else 'Active' end),
  CURRENT_BATCH_MODULE_ID = 'N/A'
where 
  COMPLETE_DT is null 
  and INSTANCE_STATUS = 'Active'
  and BATCH_GUID in (
'{e52aeb29-ae97-4972-954d-d148a5d634a7}',
'{ff396484-f172-409f-ae6b-c918d955ae9a}',
'{1144d495-503a-4554-afc3-9f49704cda07}',
'{4d6cf13f-0c21-4c33-be7d-4ab68d796638}');

-- Verify 4 rows updated and then commit.