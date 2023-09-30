UPDATE BPM_D_OPS_GROUP_TASK
   SET OPS_GROUP='State Data Entry' 
 WHERE TASK_TYPE = 'Returned Mail Notice Request';

COMMIT;
