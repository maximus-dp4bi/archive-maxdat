-- establish the control count

select count(*)  -- expect 1297
from maxdat.nyhix_mfb_v2_batch_summary
where instance_status = 'Deleted'
and batch_deleted = 'Y';

-- create a batckup
create table maxdat.nyhix_mfb_v2_batch_summary_Deleted_BAK
as select batch_guid, instance_status
from maxdat.nyhix_mfb_v2_batch_summary
where instance_status = 'Deleted'
and batch_deleted = 'Y';

-- perform the update
update maxdat.nyhix_mfb_v2_batch_summary
set instance_status = 'Complete'
where instance_status = 'Deleted'
and batch_deleted = 'Y';

