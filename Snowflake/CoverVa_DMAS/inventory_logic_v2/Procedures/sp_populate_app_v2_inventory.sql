use schema coverva_dmas;
create or replace procedure SP_POPULATE_APP_V2_INVENTORY()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  var vChkCount = 0;
  snowflake.execute( {sqlText: "BEGIN;"} );
   try {  
       
       /* Insert App Inventory data*/         
       
    var strSQLText = `SELECT config_value inventory_v2_switch 
                  FROM coverva_dmas.dmas_config_control 
                  WHERE config_name = 'INVENTORY_V2_SWITCH';`;
    var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    var ret_value = strSQLStmt.execute();   
    ret_value.next();
    var invV2Switch = ret_value.getColumnValue('INVENTORY_V2_SWITCH');       
     
    strSQLText = `SELECT COUNT(fl.file_id) file_count 
                  FROM coverva_dmas.dmas_file_log fl 
                    JOIN coverva_dmas.dmas_file_load_lkup ll ON fl.filename_prefix = ll.filename_prefix 
                  WHERE ll.use_in_inventory = 'Y' AND fl.load_status = 'COMPLETED' AND ((fl.cdc_processed = 'N' AND '`+ invV2Switch + `' = 'N') OR (fl.cdc_v2_processed = 'N' AND '`+ invV2Switch + `' = 'Y')) ;`;
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});                     
    ret_value = strSQLStmt.execute(); 
    ret_value.next();
    var invFileCount = ret_value.getColumnValue('FILE_COUNT'); 
     
     if (invFileCount > vChkCount)
       {
         strSQLText = " TRUNCATE TABLE coverva_dmas.cp_application_inventory;";
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         ret_value = strSQLStmt.execute(); 
   
         strSQLText = `INSERT INTO coverva_dmas.CP_APPLICATION_INVENTORY(migrated, sr_id, sr_type, sr_create_date, sr_status, sr_status_date, app_type, business_unit, tracking_number, my_workspace_date, channel 
                                 ,disposition, action_taken, current_task_id, current_task_type, current_task_status, current_task_status_date, assigned_to_id, assigned_to_name 
                                 ,complete_task_id, complete_task_status, complete_task_date, complete_task_type, completed_by_id, completed_by_name, vcl_due_date, facility_type, facility_name 
                                 ,denial_reason, substatus, sr_hix_disposition, sr_disposition_date_hx, sr_disposition_date_cur, proc_app_task_disposition_hx , proc_app_task_disposition_cur 
                                 ,proc_app_task_disposition_date_hx, proc_app_task_disposition_date_cur,closed_renewal,renewal_due_date )
                     SELECT migrated, sr_id, sr_type, sr_create_date, sr_status, sr_status_date, app_type, business_unit, external_app_id, my_workspace_date, channel 
                          ,disposition, action_taken, current_task_id, current_task_type, current_task_status, current_task_status_date, assigned_to_id, assigned_to_name 
                          ,complete_task_id, complete_task_status, complete_task_date, complete_task_type, completed_by_id, completed_by_name, vcl_due_date, facility_type, facility_name 
                          ,denial_reason, substatus, sr_hix_disposition, sr_disposition_date_hx, sr_disposition_date_cur, proc_app_task_disposition_hx , proc_app_task_disposition_cur 
                          ,proc_app_task_disposition_date_hx, proc_app_task_disposition_date_cur ,closed_renewal,renewal_due_date
                     FROM coverva_dmas.cp_application_inventory_vw;` ;
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         ret_value = strSQLStmt.execute();         
                  
         strSQLText = `INSERT INTO coverva_dmas.CP_APPLICATION_INVENTORY_HIST(migrated, sr_id, sr_type, sr_create_date, sr_status, sr_status_date, app_type, business_unit, tracking_number, my_workspace_date, channel 
                                 ,disposition, action_taken, current_task_id, current_task_type, current_task_status, current_task_status_date, assigned_to_id, assigned_to_name 
                                 ,complete_task_id, complete_task_status, complete_task_date, complete_task_type, completed_by_id, completed_by_name, vcl_due_date, facility_type, facility_name 
                                 ,denial_reason, substatus, sr_hix_disposition, sr_disposition_date_hx, sr_disposition_date_cur, proc_app_task_disposition_hx , proc_app_task_disposition_cur 
                                 ,proc_app_task_disposition_date_hx, proc_app_task_disposition_date_cur,closed_renewal,renewal_due_date )
                     SELECT migrated, sr_id, sr_type, sr_create_date, sr_status, sr_status_date, app_type, business_unit, tracking_number, my_workspace_date, channel 
                          ,disposition, action_taken, current_task_id, current_task_type, current_task_status, current_task_status_date, assigned_to_id, assigned_to_name 
                          ,complete_task_id, complete_task_status, complete_task_date, complete_task_type, completed_by_id, completed_by_name, vcl_due_date, facility_type, facility_name 
                          ,denial_reason, substatus, sr_hix_disposition, sr_disposition_date_hx, sr_disposition_date_cur, proc_app_task_disposition_hx , proc_app_task_disposition_cur 
                          ,proc_app_task_disposition_date_hx, proc_app_task_disposition_date_cur,closed_renewal,renewal_due_date 
                     FROM coverva_dmas.cp_application_inventory;`;                  
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         ret_value = strSQLStmt.execute(); 
       }
    } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     return 1;
  }
    
    snowflake.execute( {sqlText: "COMMIT;"} );   
    return 0; /* SUCCESS */   
  $$;   
