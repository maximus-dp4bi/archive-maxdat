use schema coverva_dmas;
create or replace procedure SP_VALIDATE_STAGE_TABLE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strColumnName = "";  
  var strErrMessage = ""; 
  var strMiColErrMessage = ""; 
  var strMiColFileName = "";
  strMiFileErrMessage  = "";  
  var strFileName = ""; 
  var strSelectStmt = "";   
  var strErrMsg = "";  
  var chkFile = 0;  
  var flChkIndicator = 0;
  
  snowflake.execute( {sqlText: "BEGIN;"} );
   try {
      /* inactive prior alert messages */
      var strSQLText = "UPDATE coverva_dmas.dmas_alert_log SET is_active = 'N' WHERE is_active = 'Y' AND CAST(create_dt AS DATE) <= current_date();";      
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute();       
      
      /* Check for missing files */
      strSQLText = " SELECT filename_prefix,CONCAT('Missing ',filename_prefix,' file for ',TO_CHAR(d_date,'mm/dd/yyyy')) error_message "
                  +" FROM coverva_dmas.dmas_missing_files_vw; ";
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var miFile = strSQLStmt.execute(); 
      
      while (miFile.next())  {
         try{ 
            strMiFileErrMessage = miFile.getColumnValue('ERROR_MESSAGE');            
            strSQLText = "INSERT INTO coverva_dmas.dmas_alert_log(alert_message,create_dt,update_dt,is_active,alert_type) "
                        +" VALUES('" + strMiFileErrMessage +"', current_timestamp(),current_timestamp(),'Y','WARNING');";                       
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
           }
          catch (err)  {             
             strErrMsg = err.message.replace(/'/g,"");	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             return 1;
          }  
        };
      
        
       /* Get system check queries and execute one by one */  
       strSQLText = "SELECT LEFT(s.table_name,LENGTH(s.table_name)-16) filename_prefix, s.table_name filename,s.row_count, CAST(s.created AS DATE) table_create_dt, "
              +"       CASE WHEN LEFT(RIGHT(s.table_name,15),2) = '20' THEN TO_TIMESTAMP(REPLACE(RIGHT(s.table_name,15),'_','') ,'yyyymmddhh24miss') ELSE to_timestamp(REPLACE(RIGHT(s.table_name,15),'_','') ,'mmddyyyyhh24miss') END file_date, "
              +"        REPLACE(c.file_check_query,'<table_name>',CONCAT(f.full_load_table_schema,'.',s.table_name)) file_check_query, c.error_message "
              +"     FROM coverva_dmas.dmas_file_load_lkup f "
              +"       JOIN coverva_dmas.dmas_file_check_lkup c ON f.filename_prefix = c.filename_prefix "
              +"       JOIN information_schema.tables s ON LEFT(table_name,LENGTH(s.table_name)-16) = f.filename_prefix "
              +"     WHERE f.load_file = 'Y';";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var flListTabs = strSQLStmt.execute();       
       
       while (flListTabs.next())  {
         try{                           
          strSelectStmt = flListTabs.getColumnValue('FILE_CHECK_QUERY');
          strErrMessage = flListTabs.getColumnValue('ERROR_MESSAGE');                    
          strFileName = flListTabs.getColumnValue('FILENAME');                    
          
          strSQLText = strSelectStmt +";" ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          var chkInd = strSQLStmt.execute();
          
          flChkIndicator = 0;          
          chkInd.next();
          flChkIndicator = chkInd.getColumnValue('CHECK_FILE_INDICATOR');
          
          
          /* Log to the alert table if any of the queries return a 1 */
          if (flChkIndicator != chkFile) {
            strSQLText = "INSERT INTO coverva_dmas.dmas_alert_log(filename,alert_message,create_dt,update_dt,is_active,alert_type) "
                        +" VALUES('" + strFileName +"','"+ strErrMessage +"', current_timestamp(),current_timestamp(),'Y','ERROR');";                       
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
            }          
          }
          catch (err)  {             
             strErrMsg = err.message.replace(/'/g,"");	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             return 1;
          }
       };       
      } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");       
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     
     return 1;
  }
  
    snowflake.execute( {sqlText: "COMMIT;"} );          
    
    return 0; /* SUCCESS */   
  $$;
  
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_VALIDATE_STAGE_TABLE() TO ROLE MARS_DP4BI_PROD_COVERVA_DMAS_ADMIN;
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_VALIDATE_STAGE_TABLE() TO ROLE MARS_DP4BI_PROD_ADMIN;  