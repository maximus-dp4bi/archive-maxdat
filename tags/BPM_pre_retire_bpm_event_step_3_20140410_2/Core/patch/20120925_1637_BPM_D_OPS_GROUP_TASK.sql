update BPM_D_OPS_GROUP_TASK set TASK_TYPE = substr(TASK_TYPE,1,100);
commit;

alter table BPM_D_OPS_GROUP_TASK modify ( TASK_TYPE varchar2(100));

create or replace view D_OPS_GROUP_TASK as
select 
  OPS_GROUP, 
  TASK_TYPE "Task Type"
from BPM_D_OPS_GROUP_TASK
with read only;