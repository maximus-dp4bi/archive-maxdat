create or replace procedure SP_DROP_ADHOC_TABLES()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strAdhocTableName = "";
  var strErrMsg = "";
        	  
  /* STEP 1: Pull list of tables that are out-of-sync */
  var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_DROP_ADHOC_TABLES', 1, 'DROPPING ADHOC TABLES', 'BEGIN', current_timestamp();";
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN WORK;"} );
  
  try {
       strSQLText = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'OHPNM_DP4BI_DEV_ADHOC';";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var rsAdhocTables = strSQLStmt.execute();
    
       while (rsAdhocTables.next())  {
           strAdhocTableName = rsAdhocTables.getColumnValue('TABLE_NAME');
    
           /* STEP 2b: Get the list of columns in the Primary Key for the table  */
           strSQLText = "DROP TABLE OHPNM_DP4BI_DEV_ADHOC." + strAdhocTableName + ";";
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
        
           ret_value = strSQLStmt.execute();
       };
	   snowflake.execute( {sqlText: "COMMIT WORK;"} );

       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                      + "SELECT 'SP_DROP_ADHOC_TABLES', 1, 'DROPPING ADHOC TABLES', 'END', current_timestamp();";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
      }
  catch (err)  {
	   strErrMsg = err.message.replace(/'/g,"");	
       snowflake.execute( {sqlText: "ROLLBACK WORK;"} );

       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, STEP_ERROR, LAST_UPDATED) "
                      + "SELECT 'SP_DROP_ADHOC_TABLES', 1, 'DROPPING ADHOC TABLES', 'ERROR', " + strErrMsg + ", current_timestamp();";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
	   return 1;  /* FAILURE OF STEP #1 */
      }  
	  
  return 0; /* SUCCESS */
  $$;


GRANT ALL PRIVILEGES ON PROCEDURE OHPNM_DP4BI_DEV.SP_DROP_ADHOC_TABLES() TO ROLE OHIO_PROVIDER_DP4BI_DEV_ADMIN;