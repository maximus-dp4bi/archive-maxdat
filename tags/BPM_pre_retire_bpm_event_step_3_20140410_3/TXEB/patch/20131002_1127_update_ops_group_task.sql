update BPM_D_OPS_GROUP_TASK 
set OPS_GROUP = 'Special Services Unit Admin' 
where 
  TASK_TYPE = 'UNKNOWN' 
  and OPS_GROUP = 'Special Escalation Unit';
  
commit;