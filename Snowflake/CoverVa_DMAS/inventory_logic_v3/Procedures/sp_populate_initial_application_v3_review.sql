use schema coverva_dmas;
create or replace procedure SP_POPULATE_INITIAL_APPLICATION_V3_REVIEW()
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
