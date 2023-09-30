update process_app_Stg 
set app_priority_ind = 0
where app_priority_ind = 1;

commit;
