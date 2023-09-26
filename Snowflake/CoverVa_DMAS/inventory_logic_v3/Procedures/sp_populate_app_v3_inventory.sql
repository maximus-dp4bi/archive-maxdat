use schema coverva_dmas;
create or replace procedure SP_POPULATE_APP_V3_INVENTORY()
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
    var strSQLText = `SELECT COUNT(file_id) file_count
                      FROM(SELECT fl.file_id,
                             CASE WHEN ll.inv_v3_switch = 'Y' THEN fl.cdc_v3_processed
                                  WHEN ll.inv_v2_switch = 'Y' THEN fl.cdc_v2_processed
                              ELSE fl.cdc_processed END cdc_processed_drv
                           FROM coverva_dmas.dmas_file_log fl 
                             JOIN (SELECT ll.filename_prefix,cc3.config_value inv_v3_switch,cc.config_value inv_v2_switch
                                   FROM coverva_dmas.dmas_file_load_lkup ll
                                     JOIN coverva_dmas.dmas_config_control cc ON cc.config_name = 'INVENTORY_V2_SWITCH'
                                     JOIN coverva_dmas.dmas_config_control cc3 ON cc3.config_name = 'INVENTORY_V3_SWITCH'
                                   WHERE CASE WHEN cc3.config_value = 'Y' THEN ll.use_in_v3_inventory WHEN cc.config_value = 'Y' THEN ll.use_in_v2_inventory ELSE ll.use_in_inventory END = 'Y') ll
                               ON fl.filename_prefix = ll.filename_prefix 
                           WHERE  fl.load_status = 'COMPLETED')
                      WHERE cdc_processed_drv = 'N';`;
    var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});                     
    var ret_value = strSQLStmt.execute(); 
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
