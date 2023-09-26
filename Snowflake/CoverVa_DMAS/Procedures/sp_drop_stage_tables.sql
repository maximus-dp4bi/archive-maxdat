use schema coverva_dmas;
create or replace procedure SP_DROP_STAGE_TABLES()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */
  var strStgTableName = "";  
  var strDropStmt = "";  
  var stgFileId = 0;
  var strErrMsg = "";
  
   try {
        /* STEP 1: Get stage tables to drop */
       strSQLText = "SELECT stage_file_id,stage_table_name,CONCAT('DROP TABLE IF EXISTS COVERVA_DMAS.',stage_table_name,';') drop_stage_stmt "
                  +" FROM coverva_dmas.dmas_drop_stage_files_list s JOIN information_schema.tables t ON s.stage_table_name = t.table_name "
                  +" WHERE t.table_schema = 'COVERVA_DMAS' AND is_dropped = 'N' ;";  
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var flListTabs = strSQLStmt.execute();       
       
       snowflake.execute( {sqlText: "BEGIN;"} );
       while (flListTabs.next())  {
         try{  
          strDropStmt = flListTabs.getColumnValue('DROP_STAGE_STMT');
          stgFileId = flListTabs.getColumnValue('STAGE_FILE_ID');
          strStgTableName = flListTabs.getColumnValue('STAGE_TABLE_NAME');
          
          /* STEP 2: Execute drop stmt */
          strSQLStmt = snowflake.createStatement({sqlText: strDropStmt});             
          ret_value = strSQLStmt.execute();
          
          /* STEP 3: Update is_dropped */
          strSQLText = "UPDATE coverva_dmas.dmas_drop_stage_files_list SET is_dropped = 'Y',update_dt = current_timestamp() WHERE stage_file_id = " + stgFileId +";";                  
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
          ret_value = strSQLStmt.execute();
             
          }
          catch (err)  {             
             strErrMsg = err.message.replace(/'/g,"");	
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             return 1;
          }
       };       
       
       strSQLText = " UPDATE coverva_dmas.dmas_drop_stage_files_list stg "
                   +" SET update_dt = current_timestamp(),comments = 'Not dropped because stage table does not exist.  Please check if the stage table name is correct.' "
                   +" FROM (SELECT s.stage_table_name "
                   +"       FROM coverva_dmas.dmas_drop_stage_files_list s "
                   +"          LEFT JOIN information_schema.tables t ON s.stage_table_name = t.table_name AND t.table_schema = 'COVERVA_DMAS' "
                   +"       WHERE is_dropped = 'N' "      
                   +"       AND t.table_name IS NULL) f "
                   +" WHERE stg.stage_table_name = f.stage_table_name "
                   +" AND stg.is_dropped = 'N'; ";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});             
       ret_value = strSQLStmt.execute();  
       
      } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");   
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     return 1;
  }
    
    snowflake.execute( {sqlText: "COMMIT;"} );          
    return 0; /* SUCCESS */   
  $$;

GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_DROP_STAGE_TABLES() TO ROLE MARS_DP4BI_PROD_ADMIN; 