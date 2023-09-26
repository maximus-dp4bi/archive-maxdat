create or replace procedure SP_SYNC_CDC_OUTOFSYNC_TABLE("argSchemaName" string, "argTableName" string, "argSourceRecCt" variant, "argSFRecCt" variant)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strColumnName = "";
  var strDeleteSQLSelect = "";
  var strDeleteSQLJoin = ""; 
  var strDeleteSQLWhere = "";
  var strDeleteSQLOtherJoin = "";
  var strInsertSQLSelect = "";
  var strInsertSQLJoin = ""; 
  var strInsertSQLWhere = "";	
  var strInsertSQLOtherJoin = "";
  var strDeleteSQLText = "";
  var strInsertSQLText = "";
  var strErrMsg = "";

  /* STEP 1: Insert data into OHPNM_DP4BI_DEV._CDC_PROCESS_RECORD_COUNTS */
  var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 1, '_CDC_PROCESS_RECORD_COUNTS - INSERT', 'BEGIN', current_timestamp()";
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN WORK;"} );
  
  try {
       strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_RECORD_COUNTS SELECT '" + argSchemaName + "','" + argTableName + "'," + argSourceRecCt
                  + "," + argSFRecCt + ",0,current_timestamp(),current_timestamp();";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});

       var retValue = strSQLStmt.execute();
	   snowflake.execute( {sqlText: "COMMIT WORK;"} );
       
       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 1, '_CDC_PROCESS_RECORD_COUNTS - INSERT', 'END', current_timestamp()";
	   var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();	   
      } 
  catch (err)  {
       strErrMsg = err.message.replace(/'/g,"");
       snowflake.execute( {sqlText: "ROLLBACK WORK;"} );

       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, STEP_ERROR, LAST_UPDATED) "
                      + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 1, '_CDC_PROCESS_RECORD_COUNTS - INSERT', 'ERROR', '" + strErrMsg + "', current_timestamp()";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();

	   return 1;
      }

  /* STEP 2a: Execute show primary key */

  var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 2, 'SYNC TABLE DATA', 'BEGIN', current_timestamp()";
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN WORK;"} );
  
  try {
	  strSQLText = "show primary keys in database OHIO_PROVIDER_DP4BI_DEV_DB;";
	  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});

	  var rsPrimaryKeys = strSQLStmt.execute();

	  /* STEP 2b: Get the list of columns in the Primary Key for the table  */
	  strSQLText = "select \"column_name\" as COLUMN_NAME from table(result_scan(last_query_id())) where \"table_name\" = '" + argTableName + "' order by \"key_sequence\";";
	  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});

	  var rsPrimaryKeyColumns = strSQLStmt.execute();

	  /* STEP 2c: Extract the first column for the Primary Key */
	  rsPrimaryKeyColumns.next();
	  strColumnName = rsPrimaryKeyColumns.getColumnValue('COLUMN_NAME');

	  /* STEP 2d: Prepare the SELECT, JOIN, & WHERE lines for DELETE STATEMENT
		 This statement is to delete the rows from DEV schema table (SnowFlake) that no longer exist in ADHOC schema table (Source) */
	  strDeleteSQLSelect = "DELETE FROM OHPNM_DP4BI_DEV." + argTableName + " USING OHPNM_DP4BI_DEV." + argTableName + " D";
	  strDeleteSQLJoin = " LEFT JOIN OHPNM_DP4BI_DEV_ADHOC." + argTableName + " A ON D." + strColumnName + " = A." + strColumnName; 
	  strDeleteSQLWhere = " WHERE A." + strColumnName + " IS NULL;"
	  strDeleteSQLOtherJoin = "";

	  /* STEP 2e: Prepare the SELECT, JOIN, & WHERE lines for INSERT STATEMENT
		 This statement is to insert the rows into DEV schema table (SnowFlake) that are missing from the ADHOC schema table (Source) */ 
	  strInsertSQLSelect = "INSERT INTO OHPNM_DP4BI_DEV." + argTableName + " SELECT A.* FROM OHPNM_DP4BI_DEV_ADHOC." + argTableName + " A";
	  strInsertSQLJoin = " LEFT JOIN OHPNM_DP4BI_DEV." + argTableName + " D ON D." + strColumnName + " = A." + strColumnName; 
	  strInsertSQLWhere = " WHERE D." + strColumnName + " IS NULL;"
	  strInsertSQLOtherJoin = "";

	  /* STEP 2f: Prepare the joins for the additional columns in the Primary Key, if exists.. This is for tables having composite primary key */
	  while (rsPrimaryKeyColumns.next())  {  
		  strColumnName = rsPrimaryKeyColumns.getColumnValue('COLUMN_NAME');
		  strDeleteSQLOtherJoin += " AND D." + strColumnName + " = A." + strColumnName;
		  strInsertSQLOtherJoin += " AND D." + strColumnName + " = A." + strColumnName;
	  };

	  /* STEP 2g: Prepare the complete DELETE and INSERT statements (to delete extra records & insert the missing records accordingly) */
	  strDeleteSQLText = strDeleteSQLSelect + strDeleteSQLJoin + strDeleteSQLOtherJoin + strDeleteSQLWhere;
	  strInsertSQLText = strInsertSQLSelect + strInsertSQLJoin + strInsertSQLOtherJoin + strInsertSQLWhere;

	  strDeleteSQLStmt = snowflake.createStatement({sqlText: strDeleteSQLText});
	  strInsertSQLStmt = snowflake.createStatement({sqlText: strInsertSQLText});

	  /* STEP 2h: Execute both statements */
	  var retvalue = strDeleteSQLStmt.execute();
	  var retvalue = strInsertSQLStmt.execute();
	   snowflake.execute( {sqlText: "COMMIT WORK;"} );
       
       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 2, 'SYNC TABLE DATA', 'END', current_timestamp()";
	   var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
      } 
  catch (err)  {
	   strErrMsg = err.message.replace(/'/g,"");
	   snowflake.execute( {sqlText: "ROLLBACK WORK;"} );

       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, STEP_ERROR, LAST_UPDATED) "
                      + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 2, 'SYNC TABLE DATA', 'ERROR', '" + strErrMsg + "', current_timestamp()";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();

	   return 2;
      }

  /* STEP 3: Update record count and timestamp in OHPNM_DP4BI_DEV._CDC_PROCESS_RECORD_COUNTS */
  var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
                 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 3, '_CDC_PROCESS_RECORD_COUNTS - UPDATE', 'BEGIN', current_timestamp()";
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN WORK;"} );
  
  try {
	   strSQLText = "UPDATE OHPNM_DP4BI_DEV._CDC_PROCESS_RECORD_COUNTS "
		  		  + "SET TIMESTAMP_UPDATED = current_timestamp(), "
		 		  + "SF_REC_COUNT_AFTER = (SELECT COUNT(*) FROM OHPNM_DP4BI_DEV." + argTableName + ") "
		 		  + "WHERE TABLE_SCHEMA = '" + argSchemaName + "' AND TABLE_NAME = '" + argTableName + "';";
	   strSQLStmt = snowflake.createStatement({sqlText: strSQLText});

	   var retValue = strSQLStmt.execute();
	  
	   snowflake.execute( {sqlText: "COMMIT WORK;"} );
       
	   try {
		   var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, LAST_UPDATED) "
					 + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 3, '_CDC_PROCESS_RECORD_COUNTS - UPDATE', 'END', current_timestamp()";
		   var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
		   var ret_value = strSQLStmt.execute();
           } 
       catch (err)  {
	                 return 3;
                    }

      } 
  catch (err)  {
       strErrMsg = err.message.replace(/'/g,"");	
       snowflake.execute( {sqlText: "ROLLBACK WORK;"} );

       var strSQLText = "INSERT INTO OHPNM_DP4BI_DEV._CDC_PROCESS_LOG (SP_NAME, EXECUTION_INFO, STEP_ID, STEP_DESCRIPTION, STEP_STATUS, STEP_ERROR, LAST_UPDATED) "
                      + "SELECT 'SP_SYNC_CDC_OUTOFSYNC_TABLE', '" + argSchemaName + "_" + argTableName + "', 3, '_CDC_PROCESS_RECORD_COUNTS - UPDATE', 'ERROR', '" + strErrMsg + "', current_timestamp()";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();

	   return 3;
      }

  return 0;
  $$;
GO;

GRANT ALL PRIVILEGES ON PROCEDURE OHPNM_DP4BI_DEV.SP_SYNC_CDC_OUTOFSYNC_TABLE(string, string, variant, variant) TO ROLE OHIO_PROVIDER_DP4BI_DEV_ADMIN;
GO;
