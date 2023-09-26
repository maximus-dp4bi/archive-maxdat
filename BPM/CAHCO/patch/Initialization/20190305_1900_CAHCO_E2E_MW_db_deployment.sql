update  d_task_types
   set  operations_group    =   'Enrollment Operations'
 where  task_type_id        in  (1,2,3,7,8,9,10,12,14);
 
 update  d_task_types
   set  operations_group    =   'Data Analysis and Special Studies (DASS)'
 where  task_type_id        in  (23);
 
 update  d_task_types
   set  operations_group    =   'Information Systems'
 where  task_type_id        in  (4,5,6,11,15,16,20,21,22); 