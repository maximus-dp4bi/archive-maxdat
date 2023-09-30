----
----NYHIX-58444
---
alter session set current_schema = MAXDAT;

select count(*) as "Before-Number of Rows active batches with closure date corp_etl_mfb_batch"
from corp_etl_mfb_batch 
where instance_status = 'Active'
  and batch_complete_dt is not null;
  
select count(*) as "Before-Number of Rows active batches with closure date corp_etl_mfb_batch_stg"
from corp_etl_mfb_batch_stg
where instance_status = 'Active'
  and batch_complete_dt is not null;

select count(*) as "Before-Number of Rows completed batches without completion date  corp_etl_mfb_batch"
from corp_etl_mfb_batch
where instance_status = 'Complete'
  and complete_dt is null;

select count(*) as "Before-Number of Rows completed batches without completion date  corp_etl_mfb_batch_stg"
from corp_etl_mfb_batch_stg
where instance_status = 'Complete'
  and complete_dt is null;
  

select batch_id, batch_guid, batch_class 
from corp_etl_mfb_batch 
where instance_status = 'Active'
  and batch_complete_dt is not null;
  
select batch_id, batch_guid, batch_class 
from corp_etl_mfb_batch 
where instance_status = 'Complete'
and complete_dt is null;


update corp_etl_mfb_batch
set instance_status = 'Complete', 
REPROCESSED_FLAG='Y',
COMPLETE_DT = BATCH_COMPLETE_DT,
CANCEL_REASON = 'UPDATED BY NYHIX-58444'
where instance_status = 'Active'
  and batch_complete_dt is not null;
commit;

update corp_etl_mfb_batch
set instance_status = 'Complete', 
REPROCESSED_FLAG='Y',
COMPLETE_DT = BATCH_COMPLETE_DT,
CANCEL_REASON = 'UPDATED BY NYHIX-58444'
where instance_status = 'Complete'
and complete_dt is null;
commit;

update corp_etl_mfb_batch_stg
set instance_status = 'Complete', 
REPROCESSED_FLAG='Y',
COMPLETE_DT = BATCH_COMPLETE_DT,
CANCEL_REASON = 'UPDATED BY NYHIX-58444'
where instance_status = 'Active'
  and batch_complete_dt is not null;
commit;


update corp_etl_mfb_batch_stg
set instance_status = 'Complete', 
REPROCESSED_FLAG='Y',
COMPLETE_DT = BATCH_COMPLETE_DT,
CANCEL_REASON = 'UPDATED BY NYHIX-58444'
where instance_status = 'Complete'
and complete_dt is null;
commit;

select count(*) as "After-Number of active batches with closure date  corp_etl_mfb_batch"
from corp_etl_mfb_batch 
where instance_status = 'Active'
  and batch_complete_dt is not null;


select count(*) as "After-Number of active batches with closure date corp_etl_mfb_batch_stg"
from corp_etl_mfb_batch_stg
where instance_status = 'Active'
  and batch_complete_dt is not null;
  
select count(*) as "After-Number of Complete batches with no completion date corp_etl_mfb_batch"
from corp_etl_mfb_batch
where instance_status = 'Complete'
  and complete_dt is null;
  
select count(*) as "After-Number of Complete batches with no completion date corp_etl_mfb_batch_stg"
from corp_etl_mfb_batch_stg
where instance_status = 'Complete'
  and complete_dt is null;

