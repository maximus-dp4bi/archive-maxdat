use schema ineo;
create or replace procedure SP_PROCESS_FILES()
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  var vChkErr = 0;
  var return_array = [];
   try {  
   
    var strSQLText = `SELECT CASE WHEN current_timestamp >= TO_TIMESTAMP(CONCAT(current_date(),' ',ist.config_value))
                          AND current_timestamp <= TO_TIMESTAMP(CONCAT(current_date(),' ',iet.config_value)) THEN 'Y' ELSE 'N' END time_to_run 
                 FROM ineo.file_load_config_control ist
                  JOIN ineo.file_load_config_control iet ON iet.config_name = 'FILE_LOAD_END_TIME'
                 WHERE ist.config_name = 'FILE_LOAD_START_TIME';`;
    var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    var ret_value = strSQLStmt.execute();   
    ret_value.next();
    var timeToRun = ret_value.getColumnValue('TIME_TO_RUN');
    
    
     /* STEP 3: Validate stage tables */
    if (timeToRun == "Y")
      {
        strSQLText = `CALL SP_LOAD_FILES_TO_TABLES();`;                     
        strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
        ret_value = strSQLStmt.execute();
        
        strSQLText = `CALL SP_UPDATE_CURRENT_TABLES();`;                     
        strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
        ret_value = strSQLStmt.execute();
      } 
     } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");      
     strSQLText = "INSERT INTO ineo.file_load_error_log (error_message) VALUES (" + strErrMsg + "); ";
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();
     
     return_array.push("File Process Failed");
     return return_array;
  } 
    return_array.push("File Process Successful");
    return return_array; /* SUCCESS */   
  $$;
  
--GRANT ALL PRIVILEGES ON PROCEDURE SP_PROCESS_FILES() TO ROLE MARS_DP4BI_PROD_INEO_ADMIN;
--GRANT ALL PRIVILEGES ON PROCEDURE SP_PROCESS_FILES() TO ROLE MARS_DP4BI_PROD_ADMIN;    