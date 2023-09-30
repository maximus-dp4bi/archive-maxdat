create or replace view D_OPS_GROUP_TASK as
select 
  OPS_GROUP, 
  TASK_TYPE "Task Type"
from BPM_D_OPS_GROUP_TASK
with read only;
