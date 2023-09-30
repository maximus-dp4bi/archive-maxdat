update BPM_D_OPS_GROUP_TASK
   set task_type = 'TPHI Manual Task'
 where task_type = 'THPI Manual Task';
 commit;
