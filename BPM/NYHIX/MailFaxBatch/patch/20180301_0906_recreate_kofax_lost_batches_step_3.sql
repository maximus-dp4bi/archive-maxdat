-- NYHIX-15955 - Close batches missed while Kofax servers were unavailable 02/26/18 (5 p.m.) to 02/27/18 (11 a.m.) including those created during the outage.
-- NOTE: This step can only be run after step 2 has completed and deployed in a separate JIRA.
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
from [kofaxardb]..BATCH 
where 
  CREATIONDTM < '02/27/18' -- Only batches that may have been missed during outage, not batches yet to be processed.
  and CLASSNAME in('NYSOH-MAIL','NYSOH-FAX')
  and BATCHID in (
--  ...{insert list from ETL staging table query from CORP_ETL_MFB_BATCH}
);
*/
    
-- Update ETL staging table to  mark batches as completed that have completed.
-- Divided into sets of 1000 BATCH_GUIDs as required by Oracle.
-- NYHXMXDP DB
update maxdat.CORP_ETL_MFB_BATCH cb
set 
  COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  BATCH_COMPLETE_DT = (select min(v2.create_dt) from d_nyhix_mfd_current_v2 v2 where cb.batch_name = v2.batch_name group by v2.batch_name),
  STG_LAST_UPDATE_DATE = sysdate,
  CURRENT_BATCH_MODULE_ID = 'N/A'
where 
  BATCH_COMPLETE_DT is null 
  and INSTANCE_STATUS = 'Active'
  and BATCH_GUID = '{557706f6-a619-4e37-a339-86463ca86001}';
  
  
  