use schema INEO;
create or replace procedure SP_LOAD_FILES_TO_TABLES()
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strColumnName = "";  
  var strInsertStmt = ""; 
  var strSelectStmt = ""; 
  var strWhereStmt = ""; 
  var strErrMsg = "";
  var strMsgCountMismatch = "";
  var strFromTableName = "";
  var strIntoTableName = "";
  var strTableSchema = "";
  var strDrvTSStmt = "";
  var fileCount = 0;
  var fileID = 0;
  var flTabCount = 0;
  var return_array = [];
  
  /* STEP 1a: Drop any staged files with file format issues */
  var strSQLText = `CALL SP_DROP_STAGE_TABLES();`;                     
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();
  
  /* STEP 1b: Remove any records in the log where load status is Started */
  strSQLText = `DELETE FROM file_load_log WHERE load_status IN('NOT PROCESSED','STARTED'); `;                 
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  ret_value = strSQLStmt.execute();
  
  /* STEP 2: Insert new files to load into the Logs table */
  strSQLText = `INSERT INTO file_load_log (filename_prefix,filename,row_count,load_status) 
                SELECT filename_prefix,filename,row_count,load_status 
                FROM(SELECT f.filename_prefix,s.table_name filename,'STARTED' load_status, s.row_count
                FROM file_load_lkup f 
                 JOIN information_schema.tables s ON (f.filename_prefix = REGEXP_REPLACE(s.table_name,'[^A-Za-z_]') 
                     OR f.filename_prefix = 'QUALITY_SCORES' and s.table_name LIKE 'QUALITY_SCORES%')                       
                WHERE f.load_file = 'Y' )              
                ORDER BY filename;`;
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN;"} );
   try {
      
       strSQLText = `SELECT full_load_table_schema, t.file_id,t.filename, t.row_count, f.full_load_table_name,f.insert_fields,f.select_fields,
                         f.where_clause,REGEXP_REPLACE(f.derive_timestamp_stmt,'<filename>',CONCAT('''',t.filename,'''')) derive_timestamp_stmt
                     FROM file_load_log t JOIN file_load_lkup f ON  t.filename_prefix = f.filename_prefix 
                     WHERE t.load_status = 'STARTED';`;  
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var flListTabs = strSQLStmt.execute();       
       
       while (flListTabs.next())  {
         try{         
          /* STEP 3: Insert data into permanent tables */
          strInsertStmt = flListTabs.getColumnValue('INSERT_FIELDS');
          strSelectStmt = flListTabs.getColumnValue('SELECT_FIELDS');
          strWhereStmt = flListTabs.getColumnValue('WHERE_CLAUSE');
          strIntoTableName = flListTabs.getColumnValue('FULL_LOAD_TABLE_NAME');
          strFromTableName = flListTabs.getColumnValue('FILENAME');
          strTableSchema = flListTabs.getColumnValue('FULL_LOAD_TABLE_SCHEMA');
          strDrvTSStmt = flListTabs.getColumnValue('DERIVE_TIMESTAMP_STMT');
          fileCount = flListTabs.getColumnValue('ROW_COUNT');
          fileID = flListTabs.getColumnValue('FILE_ID');
          
          strSQLStmt = snowflake.createStatement({sqlText: strDrvTSStmt});
          ret_value = strSQLStmt.execute();
          ret_value.next();
          var dtFileDate = ret_value.getColumnValue('FILE_DATE');
          var strwithTS = ret_value.getColumnValue('WITH_TIMESTAMP');
          
          strSQLText = `UPDATE file_load_log SET file_date = CASE WHEN '` + strwithTS + `' ='Y' THEN TO_TIMESTAMP('` + dtFileDate + `','mm/dd/yyyy hh24:mi:ss') ELSE TO_DATE('`+ dtFileDate +`','mm/dd/yyyy') END WHERE file_id = ` + fileID +`;`; 
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          ret_value = strSQLStmt.execute();
          
          strSQLText = `INSERT INTO ` +strTableSchema + `.` + strIntoTableName + `(` + strInsertStmt + `) SELECT ` + strSelectStmt + ` FROM ` + strTableSchema + `.` + strFromTableName + ` ` + strWhereStmt +`;` ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          ret_value = strSQLStmt.execute();
          
          flTabCount = 0;
          strSQLText = `SELECT COUNT(*) fl_table_count FROM ` + strTableSchema + `.` + strIntoTableName +` WHERE UPPER(filename) = '` + strFromTableName + `' ;` ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          var tabCount = strSQLStmt.execute();
          tabCount.next();
          flTabCount = tabCount.getColumnValue('FL_TABLE_COUNT');
          
          /* STEP 4: Update load status to Complete if file is successfully loaded, otherwise update to Error */
          if (flTabCount == fileCount || strWhereStmt !== null) {
            strSQLText = `UPDATE file_load_log SET load_status = 'COMPLETED' WHERE file_id = ` + fileID +`;`;                 
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
            
            /* STEP 5: Drop Staging Table when file is successfully loaded*/
            strSQLText = `DROP TABLE ` + strTableSchema + `.` + strFromTableName +`;` ;          
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
          }
          else
          {
             strMsgCountMismatch = "'Counts not matching for File ID " + fileID + "'";	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             strSQLText = `INSERT INTO file_load_error_log (file_id, filename,error_message) 
                      VALUES (` + fileID + `, '` + strFromTableName + `', ` + strMsgCountMismatch + `); `;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();
       
             strSQLText = `UPDATE file_load_log SET load_status = 'ERROR' WHERE file_id = ` + fileID +`;`;                 
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
             ret_value = strSQLStmt.execute();
             
             }
          }
          catch (err)  {             
             strErrMsg = err.message.replace(/'/g,"");	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             strSQLText = `INSERT INTO file_load_error_log (file_id, filename,error_message) 
                           VALUES (` + fileID + `, '` + strFromTableName + `', ` + strErrMsg + `); `;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();
            
             strSQLText = `UPDATE file_load_log SET load_status = 'ERROR' WHERE file_id = ` + fileID +`;`;                  
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
             ret_value = strSQLStmt.execute(); 
             
             return_array.push("Load Failed");
             return return_array;
          }
       };       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");       
     snowflake.execute( {sqlText: "ROLLBACK;"} );
             
     strSQLText = `INSERT INTO file_load_error_log (file_id, filename,error_message) VALUES (` + fileID + `, '` + strFromTableName + `', ` + strErrMsg + `); `;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();
             
     return_array.push("Load Failed");
     return return_array;
  }
  
    snowflake.execute( {sqlText: "COMMIT;"} );          
    return_array.push("Load Successful");
    return return_array; /* SUCCESS */   
  $$;
  
--GRANT ALL PRIVILEGES ON PROCEDURE SP_LOAD_FILES_TO_TABLES() TO ROLE MARS_DP4BI_PROD_INEO_ADMIN;
--GRANT ALL PRIVILEGES ON PROCEDURE SP_LOAD_FILES_TO_TABLES() TO ROLE MARS_DP4BI_PROD_ADMIN;    