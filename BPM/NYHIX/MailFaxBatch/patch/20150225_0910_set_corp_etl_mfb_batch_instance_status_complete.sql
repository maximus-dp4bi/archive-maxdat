select count(*) as "Before-Number of Invalid Rows"
from corp_etl_mfb_batch 
where instance_status = 'Active'
  and batch_complete_dt is not null
;

update corp_etl_mfb_batch
set instance_status = 'Complete'
where instance_status = 'Active'
  and batch_complete_dt is not null
;
commit;

select count(*) as "After-Number of Invalid Rows"
from corp_etl_mfb_batch 
where instance_status = 'Active'
  and batch_complete_dt is not null
;
