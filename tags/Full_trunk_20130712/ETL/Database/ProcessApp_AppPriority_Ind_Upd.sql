update process_app_stg 
   set app_priority_ind = 0 
 where app_priority_ind = 1;

 COMMIT;
/