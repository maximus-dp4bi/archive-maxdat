-- establish a control count for the undo

select count(*) from
( select batch_guid, 'Deleted' as instance_status
from maxdat.nyhix_mfb_v2_batch_summary
intersect
select batch_guid, instance_status
from maxdat.nyhix_mfb_v2_batch_summary_Deleted_BAK
);

update maxdat.nyhix_mfb_v2_batch_summary
set instance_status = 'Deleted'
where batch_guid 
in ( select batch_guid from maxdat.nyhix_mfb_v2_batch_summary_Deleted_BAK);

-- commit control count matches 
