use schema INEO;
create or replace procedure SP_UPDATE_CURRENT_TABLES()  
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */
  var result;
  var strTableSchema = "";    
  var strTgtTableName = ""; 
  var strSrcTableName = "";      
  var strTablePK = "";  
  var strSrcTgtJoin =  "";
  var strWhereCondition =  "";
  var strUpdateFields =  "";
  var strTgtInsertFields =  "";
  var strSrcInsertFields =  "";  
  var strSelectFields =  "";  
  var return_array = [];

   try {
      
      snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
      
      //Get list of tables to synchronize
      strSQLText = `SELECT CONCAT('(SELECT sc.* FROM ',full_load_table_schema,'.',full_load_table_name,' sc QUALIFY RANK() OVER (PARTITION BY ',current_table_primary_key,' ORDER BY filename DESC, ',full_load_table_primary_key,' DESC) = 1)' ) src_table_name,
                       s.current_table_name tgt_table_name, full_load_table_schema table_schema,current_table_primary_key table_primary_key
                    FROM ineo.file_load_lkup s
                    WHERE current_table_name IS NOT NULL` ;       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});      
       var flListTabs = strSQLStmt.execute();    
       
       //Loop through tables to update
       while (flListTabs.next())  {
         try{      
         
           strSrcTableName = flListTabs.getColumnValue('SRC_TABLE_NAME');
           strTgtTableName = flListTabs.getColumnValue('TGT_TABLE_NAME');
           strTableSchema = flListTabs.getColumnValue('TABLE_SCHEMA');
           strTablePK = flListTabs.getColumnValue('TABLE_PRIMARY_KEY');
            
           snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
              
           //Get query components for the merge statement
           strSQLText = `SELECT REPLACE(listagg (DISTINCT ' COALESCE(tgt."'||tt.table_primary_key||'",'  
                            ||CASE WHEN tt.pk_data_type ='FLOAT' THEN '0' 
                                   WHEN tt.pk_data_type ='NUMBER' THEN '0' 
                                   WHEN tt.pk_data_type ='DATE' THEN '''1900-12-01''' 
                                   WHEN tt.pk_data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' 
                                ELSE '-999999' END||') = COALESCE(src."'  
                                ||tt.table_primary_key ||'",' 
                                ||CASE  WHEN tt.pk_data_type ='FLOAT' THEN '0'  
                                        WHEN tt.pk_data_type ='NUMBER' THEN '0' 
                                        WHEN tt.pk_data_type ='DATE' THEN '''1900-12-01''' 
                                        WHEN tt.pk_data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' 
                                   ELSE '-999999' END  ,') AND ') ||')','-999999','''''') AS src_tgt_join 
                               ,REPLACE(where_condition,'-999999','''''') AS where_condition 
                               ,tt.update_fields 
                               ,tt.tgt_insert_fields 
                               ,tt.src_insert_fields    
                               ,tt.select_fields
                            FROM (SELECT intab.table_name, intab.table_name tgt_table_name
                                   ,listagg ( ' src."'  ||intab.column_name,'",') WITHIN GROUP ( ORDER BY intab.ordinal_position asc ) ||'"'  AS select_fields 
                                   ,listagg (' COALESCE(tgt."'  || CASE WHEN intab.CM IS NULL AND intab.column_name != 'FILENAME' THEN intab.column_name ELSE NULL end  || '", ' 
                                     ||CASE  WHEN intab.data_type ='FLOAT' THEN '0' 
                                             WHEN intab.data_type ='NUMBER' THEN '0' 
                                             WHEN intab.data_type ='BOOLEAN' THEN 'FALSE' 
                                             WHEN intab.data_type ='DATE' THEN '''1900-12-01''' 
                                             WHEN intab.data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' ELSE '-999999' END ||') != COALESCE(src."' ||InTab.column_name||'",'|| 
                                      CASE  WHEN intab.data_type ='FLOAT' THEN '0' 
                                            WHEN intab.data_type ='NUMBER' THEN '0' 
                                            WHEN intab.data_type ='BOOLEAN' THEN 'FALSE' 
                                            WHEN intab.data_type ='DATE' THEN '''1900-12-01''' 
                                            WHEN intab.data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' ELSE '-999999' END ,') OR') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||')' AS where_condition                                             
                                    ,CONCAT(listagg (' tgt."'  ||CASE WHEN intab.CM IS NULL THEN intab.column_name ELSE NULL end || '"= src."' ||intab.column_name , '",') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||'"',',sf_update_ts = current_timestamp()') AS update_fields 
                                    ,CONCAT(listagg ( '"'||intab.column_name,'",') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||'"',',sf_create_ts,sf_update_ts' ) AS tgt_insert_fields 
                                    ,CONCAT(listagg ( ' src."'  ||intab.column_name,'",') WITHIN GROUP ( ORDER BY intab.ordinal_position asc ) ||'"',',current_timestamp(),current_timestamp()') AS src_insert_fields  
                                    ,listagg (ordinal_position,',') WITHIN GROUP ( ORDER BY ordinal_position asc ) ordinal_position
                                    ,MAX(intab.pk_data_type) pk_data_type 
                                    ,MAX(intab.cm) table_primary_key
                                    ,MAX(full_load_table_name) source_table_name
                                  FROM (SELECT intab.table_name ,intab.column_name ,intab.ordinal_position ,CASE WHEN intab.data_type = 'TEXT' THEN 'VARCHAR' ELSE intab.data_type END data_type ,cons.current_table_primary_key AS CM 
                                             ,CASE WHEN cons.current_table_primary_key = intab.column_name THEN intab.data_type ELSE NULL END pk_data_type
                                             ,cons.full_load_table_name
                                        FROM INFORMATION_SCHEMA.COLUMNS intab 
                                          LEFT JOIN ineo.file_load_lkup cons ON cons.current_table_name = intab.table_name AND intab.column_name = cons.current_table_primary_key 
                                        WHERE intab.TABLE_SCHEMA = '`+ strTableSchema +`'
                                        AND intab.table_name = '`+ strTgtTableName +`'
                                        AND intab.column_name NOT IN('SF_CREATE_TS','SF_UPDATE_TS')
                                        GROUP BY intab.table_name,intab.column_name,intab.column_name,intab.ordinal_position,intab.data_type,current_table_primary_key,full_load_table_name
                                        ORDER BY intab.table_name,intab.ordinal_position,current_table_primary_key,full_load_table_name ) intab 
                                   GROUP BY table_name
                                   ORDER BY table_name,ordinal_position ) tt                            
                            GROUP BY tt.where_condition,tt.update_fields,tt.tgt_insert_fields,tt.src_insert_fields,tt.select_fields;`;           
              
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              
              var ret_value = strSQLStmt.execute();
              ret_value.next();   
              strSelectFields = ret_value.getColumnValue('SELECT_FIELDS');
              strSrcTgtJoin = ret_value.getColumnValue('SRC_TGT_JOIN');
              strWhereCondition = ret_value.getColumnValue('WHERE_CONDITION');
              strUpdateFields = ret_value.getColumnValue('UPDATE_FIELDS');
              strTgtInsertFields = ret_value.getColumnValue('TGT_INSERT_FIELDS');
              strSrcInsertFields = ret_value.getColumnValue('SRC_INSERT_FIELDS');
              
              //Execute the merge statement
              var strMergeStmt = ` MERGE INTO `+ strTableSchema + `.` + strTgtTableName + ` AS tgt 
                  USING (SELECT ` + strSelectFields + ` FROM ` + strSrcTableName + ` src) AS src ON ( ` + strSrcTgtJoin + `) 
                  WHEN MATCHED AND ` + strWhereCondition + ` THEN 
                    UPDATE SET ` + strUpdateFields + `
                  WHEN NOT MATCHED THEN 
                    INSERT ( ` + strTgtInsertFields + `) VALUES (` + strSrcInsertFields + `);`;              
              strSQLStmt = snowflake.createStatement({sqlText: strMergeStmt});
              ret_value = strSQLStmt.execute();
             
               strSQLText = `INSERT INTO ineo.synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                           SELECT "number of rows inserted","number of rows updated", '` +strTgtTableName+ `' AS synch_table_name  , current_timestamp(), 'Completed' as status 
                           FROM TABLE (RESULT_SCAN(LAST_QUERY_ID()));`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();
              
              snowflake.execute( {sqlText: "COMMIT;"} );    
              
          } 
          catch (err)  {             
             //strErrMsg = err.message.replace(/'/g,"");	             
             snowflake.execute( {sqlText: "ROLLBACK;"} );                  
             strSQLText = `INSERT INTO ineo.synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                       SELECT 0,0, '` +strTgtTableName+ `' AS synch_table_name  , current_timestamp(), 'Failed' as status 
                       FROM dual;`;
                        
          } 
       };   
      } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");       
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     strSQLText = `INSERT INTO ineo.synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                       SELECT 0,0, '` +strTgtTableName+ `' AS synch_table_name  , current_timestamp(), 'Failed' as status 
                       FROM dual;`;
     return_array.push("Synchronization Failed");
     return return_array;
  }
  
  
  snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Synchronization Successful");
  return return_array; /* SUCCESS */  
  $$;
  
--GRANT ALL PRIVILEGES ON PROCEDURE SP_UPDATE_CURRENT_TABLES() TO ROLE MARS_DP4BI_PROD_INEO_ADMIN;
--GRANT ALL PRIVILEGES ON PROCEDURE SP_UPDATE_CURRENT_TABLES() TO ROLE MARS_DP4BI_PROD_ADMIN;    