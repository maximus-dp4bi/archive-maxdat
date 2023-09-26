use schema coverva_dmas;
create or replace procedure SP_POPULATE_INITIAL_APPLICATION_V2_REVIEW()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  vChkCount = 0;
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
         strSQLText = " TRUNCATE TABLE coverva_dmas.cp_initial_application_review;";
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         ret_value = strSQLStmt.execute(); 
   
         strSQLText = ` INSERT INTO coverva_dmas.cp_initial_application_review(task_type_name,task_id,created_on,task_status,status_date,updated_by,completed_by_name,tracking_number,disposition,action_taken ) 
                        SELECT task_type_name,task_id,created_on,task_status,status_date,updated_by,completed_by_name,external_app_id,disposition,action_taken
                        FROM coverva_dmas.cp_application_initial_review_vw;`;
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
