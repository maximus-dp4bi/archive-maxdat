/* Update the app_priority_ind to 1 and the app_in_process to 'Y' for all the apps with MI */
BEGIN
  UPDATE process_app_stg
     SET app_priority_ind = 1
       , app_in_process = 'Y'
   WHERE pending_mi_type IS NOT NULL;
  COMMIT;
END;  
/ 