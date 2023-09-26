use schema coverva_dmas;
create or replace procedure SP_POPULATE_FULL_LOAD_TABLE()
  returns variant not null
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
  var fileCount = 0;
  var fileID = 0;
  var flTabCount = 0;
  
  /* STEP 1: Remove any records in the log where load status is Started */
  var strSQLText = "DELETE FROM COVERVA_DMAS.DMAS_FILE_LOG WHERE load_status IN('NOT PROCESSED','STARTED');";                 
  var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  var ret_value = strSQLStmt.execute();
  
  /* STEP 2: Insert new files to load into the Logs table */
  strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_LOG (filename_prefix,filename,row_count,file_date,load_status) "
              +" SELECT filename_prefix,filename,row_count "
              +"  ,CASE WHEN SUBSTR(filedate_char,1,2) = '20' THEN "
              +"     CASE WHEN with_timestamp = 'Y' THEN TO_TIMESTAMP(filedate_char,'yyyymmddhh24miss') ELSE TO_DATE(filedate_char,'yyyymmdd') END "
              +"   ELSE CASE WHEN with_timestamp = 'Y' THEN TO_TIMESTAMP(filedate_char,'mmddyyyyhh24miss') ELSE TO_DATE(filedate_char,'mmddyyyy') END END file_date "
              +"  ,load_status "
              +" FROM(SELECT f.filename_prefix,s.table_name filename,'STARTED' load_status, with_timestamp, s.row_count, "
              +"         CASE WHEN with_timestamp = 'Y' THEN "
              +"           CASE WHEN regexp_like(SUBSTR(s.table_name,LENGTH(s.table_name)-14),'.*[0-9].*') THEN REPLACE(SUBSTR(s.table_name,LENGTH(s.table_name)-14),'_','') ELSE TO_CHAR(current_timestamp(),'yyyymmddhh24miss') END "
              +"           ELSE CASE WHEN regexp_like(SUBSTR(s.table_name,LENGTH(s.table_name)-7),'.*[0-9].*') THEN SUBSTR(s.table_name,LENGTH(s.table_name)-7) ELSE TO_CHAR(current_date(),'yyyymmdd') END "
              +"         END filedate_char "
              +"      FROM coverva_dmas.dmas_file_load_lkup f "
              +"         JOIN information_schema.tables s ON f.filename_prefix = CASE WHEN with_timestamp = 'Y' THEN SUBSTR(s.table_name,1,LENGTH(s.table_name)-16) ELSE SUBSTR(s.table_name,1,LENGTH(s.table_name)-9) END "
              +" WHERE f.load_file = 'Y') "
              +" ORDER BY file_date; ";
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  ret_value = strSQLStmt.execute();

  snowflake.execute( {sqlText: "BEGIN;"} );
   try {
      
       strSQLText = "SELECT full_load_table_schema, t.file_id,t.filename, t.row_count, f.full_load_table_name,f.insert_fields,f.select_fields,f.where_clause FROM COVERVA_DMAS.DMAS_FILE_LOG t JOIN COVERVA_DMAS.DMAS_FILE_LOAD_LKUP f ON  t.filename_prefix = f.filename_prefix WHERE t.load_status = 'STARTED';";  
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
          fileCount = flListTabs.getColumnValue('ROW_COUNT');
          fileID = flListTabs.getColumnValue('FILE_ID');
                              
          strSQLText = "INSERT INTO " +strTableSchema + "." + strIntoTableName + "(" + strInsertStmt + ") SELECT " + strSelectStmt + " FROM " + strTableSchema + "." + strFromTableName + " " + strWhereStmt +";" ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          ret_value = strSQLStmt.execute();
          
          flTabCount = 0;
          strSQLText = "SELECT COUNT(*) fl_table_count FROM " + strTableSchema + "." + strIntoTableName +" WHERE UPPER(filename) = '" + strFromTableName + "' ;" ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          var tabCount = strSQLStmt.execute();
          tabCount.next();
          flTabCount = tabCount.getColumnValue('FL_TABLE_COUNT');
          
          /* STEP 4: Update load status to Complete if file is successfully loaded, otherwise update to Error */
          if (flTabCount == fileCount || strWhereStmt !== null) {
            strSQLText = "UPDATE COVERVA_DMAS.DMAS_FILE_LOG SET load_status = 'COMPLETED' WHERE file_id = " + fileID +";";                 
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
            
            /* STEP 5: Drop Staging Table when file is successfully loaded*/
            strSQLText = "DROP TABLE " + strTableSchema + "." + strFromTableName +";" ;          
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            ret_value = strSQLStmt.execute();
          }
          else
          {
             strMsgCountMismatch = "'Counts not matching for File ID " + fileID + "'";	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (file_id, filename,error_message) "
                      + "VALUES (" + fileID + ", '" + strFromTableName + "', " + strMsgCountMismatch + "); ";
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();
       
             strSQLText = "UPDATE COVERVA_DMAS.DMAS_FILE_LOG SET load_status = 'ERROR' WHERE file_id = " + fileID +";";                 
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
             ret_value = strSQLStmt.execute();
             
             }
          }
          catch (err)  {             
             strErrMsg = err.message.replace(/'/g,"");	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (file_id, filename,error_message) "
                      + "VALUES (" + fileID + ", '" + strFromTableName + "', " + strErrMsg + "); ";
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();
            
             strSQLText = "UPDATE COVERVA_DMAS.DMAS_FILE_LOG SET load_status = 'ERROR' WHERE file_id = " + fileID +";";                  
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
             ret_value = strSQLStmt.execute(); 
             
             return 1;
          }
       };       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");       
     snowflake.execute( {sqlText: "ROLLBACK;"} );
             
     strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (file_id, filename,error_message) VALUES (" + fileID + ", '" + strFromTableName + "', " + strErrMsg + "); ";
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();
             
     return 1;
  }
  
    snowflake.execute( {sqlText: "COMMIT;"} );          
    return 0; /* SUCCESS */   
  $$;
  
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_POPULATE_FULL_LOAD_TABLE() TO ROLE MARS_DP4BI_PROD_COVERVA_DMAS_ADMIN;
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_POPULATE_FULL_LOAD_TABLE() TO ROLE MARS_DP4BI_PROD_ADMIN;  