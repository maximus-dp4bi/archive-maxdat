use schema coverva_dmas;
create or replace procedure SP_PROCESS_APPLICATION_CDC()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  var vChkErr = 0;
   try {  
   
     /* STEP 0: Validate stage tables */
    var strSQLText = "CALL SP_VALIDATE_STAGE_TABLE();";                     
    var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    var ret_value = strSQLStmt.execute();
           
    strSQLText = " SELECT COUNT(alert_message) count_err_tables "
                +" FROM coverva_dmas.dmas_alert_log l "
                +" WHERE l.is_active = 'Y' "
                +" AND l.alert_type = 'ERROR';";                 
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var errTabCount = ret_value.getColumnValue('COUNT_ERR_TABLES');          
    
    strSQLText = " SELECT COUNT(alert_message) count_warning "
                +" FROM coverva_dmas.dmas_alert_log l "
                +" WHERE l.is_active = 'Y' "
                +" AND l.alert_type = 'WARNING';";                 
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var warnTabCount = ret_value.getColumnValue('COUNT_WARNING'); 
    
    strSQLText = " SELECT business_day_flag, CASE WHEN current_timestamp >= TO_TIMESTAMP(CONCAT(current_date(),' ',config_value)) THEN 'Y' ELSE 'N' END time_to_run "
                +" FROM coverva_dmas.dmas_config_control "
                +"  JOIN public.d_dates dd ON dd.d_date = current_date() AND dd.project_id = 117 "
                +" WHERE config_name = 'INVENTORY_CDC_TIME';";
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var timeToRun = ret_value.getColumnValue('TIME_TO_RUN');
    var busDay = ret_value.getColumnValue('BUSINESS_DAY_FLAG');
   
    if ( (busDay == "Y") && ((errTabCount == vChkErr && warnTabCount == vChkErr) || (errTabCount == vChkErr && timeToRun == "Y")) )
       { 
         /* STEP 1: Load files into permanent tables */
           strSQLText = "CALL SP_POPULATE_FULL_LOAD_TABLE();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 2: Populate CPU RunDate */
           strSQLText = "CALL SP_UPDATE_CPU_RUN_DATE();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 3: Load CP App Inventory */
           strSQLText = "CALL SP_POPULATE_APP_INVENTORY();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 4: Load CP Initial Review App */
           strSQLText = "CALL SP_POPULATE_INITIAL_APPLICATION_REVIEW();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 5: Process CDC logic */
           strSQLText = "CALL SP_POPULATE_CDC_TABLE();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
       }    
     } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");      
     strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (error_message) VALUES (" + strErrMsg + "); ";
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();
     
     return 1;
  } 
    return 0; /* SUCCESS */   
  $$;
  
  GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.sp_process_application_cdc() TO ROLE MARS_DP4BI_PROD_ADMIN;