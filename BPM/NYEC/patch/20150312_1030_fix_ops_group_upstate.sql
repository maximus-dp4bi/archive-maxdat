-- Fix typo in NYEC Ops Group.
-- 6 rows affected

update BPM_D_OPS_GROUP_TASK 
set OPS_GROUP = 'FPBP Research - Upstate'
where OPS_GROUP = 'FPBP Research - Update';

commit;
