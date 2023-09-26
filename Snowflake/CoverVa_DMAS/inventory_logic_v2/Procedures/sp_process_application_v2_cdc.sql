use schema coverva_dmas;
create or replace procedure SP_PROCESS_APPLICATION_V2_CDC()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  var vChkErr = 0;
  
   try {  
   
    var strSQLText = `SELECT business_day_flag, CASE WHEN current_timestamp >= TO_TIMESTAMP(CONCAT(current_date(),' ',config_value)) THEN 'Y' ELSE 'N' END time_to_run 
                   FROM coverva_dmas.dmas_config_control 
                    JOIN public.d_dates dd ON dd.d_date = current_date() AND dd.project_id = 117 
                   WHERE config_name = 'INVENTORY_CDC_TIME';`;
    var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    var ret_value = strSQLStmt.execute();   
    ret_value.next();
    var timeToRun = ret_value.getColumnValue('TIME_TO_RUN');
    var busDay = ret_value.getColumnValue('BUSINESS_DAY_FLAG');
    
    strSQLText = `SELECT CASE WHEN current_timestamp >= TO_TIMESTAMP(CONCAT(current_date(),' ',config_value)) THEN 'Y' ELSE 'N' END time_to_start, 'Y' use_in_inventory 
                   FROM coverva_dmas.dmas_config_control                 
                   WHERE config_name = 'INVENTORY_CDC_START_TIME';`;
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var timeToStart = ret_value.getColumnValue('TIME_TO_START');
    var invUseInInventory = ret_value.getColumnValue('USE_IN_INVENTORY');
    
    snowflake.execute( {sqlText: "BEGIN;"} );
    /* bypass missing files day after weekend/holiday */
    strSQLText = `UPDATE coverva_dmas.dmas_config_control cc
                  SET config_value = dd.bypass_flag
                  FROM(SELECT set_bypass_date,'Y' bypass_flag
                       FROM(SELECT dd.d_date set_bypass_date,business_day_flag,prev_d_date,prev_ddate_busday_flag
                            FROM d_dates dd
                              JOIN(SELECT d_date, LAG(d_date) OVER(ORDER BY d_date) prev_d_date, LAG(business_day_flag) OVER (ORDER BY d_date) prev_ddate_busday_flag
                                   FROM d_dates
                                   WHERE project_id  = 117) prevdd ON dd.d_date = prevdd.d_date
                            WHERE project_id  = 117                            
                            AND business_day_flag = 'Y' 
                            AND prev_ddate_busday_flag = 'N')
                       WHERE set_bypass_date = current_date() ) dd
                  WHERE cc.config_name = 'INVENTORY_BYPASS_MISSING_FILES';`;
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    snowflake.execute( {sqlText: "COMMIT;"} );
    
    strSQLText = `SELECT config_value bypass_missing_files 
                  FROM coverva_dmas.dmas_config_control 
                  WHERE config_name = 'INVENTORY_BYPASS_MISSING_FILES';`;
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var byPassMissingFiles = ret_value.getColumnValue('BYPASS_MISSING_FILES');
    
    strSQLText = `SELECT config_value inventory_v2_switch 
                  FROM coverva_dmas.dmas_config_control 
                  WHERE config_name = 'INVENTORY_V2_SWITCH';`;
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var invV2Switch = ret_value.getColumnValue('INVENTORY_V2_SWITCH');
   
   /* STEP 1: Load files into permanent tables */
    strSQLText = "CALL SP_POPULATE_FULL_LOAD_V2_TABLE(:1);";                     
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invUseInInventory]});
    ret_value = strSQLStmt.execute();
           
    /* STEP 2: Populate CPU RunDate */
    strSQLText = "CALL SP_UPDATE_CPU_RUN_DATE();";                     
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();
   
     /* STEP 3: Validate stage tables */
    if (busDay == "Y" && timeToStart == "Y")
      {
        strSQLText = "CALL SP_VALIDATE_STAGE_TABLE();";                     
        strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
        ret_value = strSQLStmt.execute();
      } 
      
    strSQLText = `SELECT COUNT(alert_message) count_err_tables 
                   FROM coverva_dmas.dmas_alert_log l 
                   WHERE l.is_active = 'Y' 
                   AND l.alert_type = 'ERROR';`;                 
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var errTabCount = ret_value.getColumnValue('COUNT_ERR_TABLES');          
    
    strSQLText = `SELECT COUNT(alert_message) count_warning 
                  FROM coverva_dmas.dmas_alert_log l 
                  WHERE l.is_active = 'Y' 
                  AND l.alert_type = 'WARNING';`;                 
    strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();   
    ret_value.next();
    var warnTabCount = ret_value.getColumnValue('COUNT_WARNING'); 
       
    if ( (busDay == "Y" && timeToStart == "Y") && ((errTabCount == vChkErr && warnTabCount == vChkErr) || (errTabCount == vChkErr && timeToRun == "Y") || (errTabCount == vChkErr && byPassMissingFiles == "Y") ) )
       { 
                    
         /* STEP 4: Load CP App Inventory */
           strSQLText = "CALL SP_POPULATE_APP_V2_INVENTORY();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 5: Load CP Initial Review App */
           strSQLText = "CALL SP_POPULATE_INITIAL_APPLICATION_V2_REVIEW();";                     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
         /* STEP 6: Process CDC logic */
         if ( invV2Switch == "Y") 
          {
            strSQLText = "CALL SP_POPULATE_CDC_V2_TABLE();";                     
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
           }
         else
          {
            strSQLText = "CALL SP_POPULATE_CDC_TABLE();";                     
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
           }         
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
  
  GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.sp_process_application_v2_cdc() TO ROLE MARS_DP4BI_PROD_ADMIN;