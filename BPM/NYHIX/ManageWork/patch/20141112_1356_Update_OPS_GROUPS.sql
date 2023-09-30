/*
Created on 12-Nov-2014 by Raj A. for NYHIX-12018
*/
update bpm_d_ops_group_task
  set ops_group = 'Research'
  where task_type = 'DPR - Other';
  
  update d_task_types
    set operations_group = 'Research'
  where task_name = 'Other';

commit;