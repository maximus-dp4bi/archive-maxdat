create or replace force view d_ops_group_task as
select 
  OPS_GROUP, 
  TASK_TYPE "Task Type"
from BPM_D_OPS_GROUP_TASK
with read only;
grant select, insert, update on D_OPS_GROUP_TASK to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on D_OPS_GROUP_TASK to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_OPS_GROUP_TASK to MAXDAT_MITRAN_READ_ONLY;


