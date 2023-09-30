//make sure to deploy the procedure in correct schema - e.g use schema PAIEB_DEV;
create or replace procedure SP_SYNCHRONIZE_PAIEB_LOOKUP_TABLES()
  //returns VARCHAR(32000)
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */
  var result;
  var strTgtTableSchema = "";  
  var strSrcTableSchema = "";
  var strCtlTableSchema = "";
  var strTgtTableName = "";  
  var strTgtTableNameLog = "";
  var strSrcTableName = "";  
  var strCreateTabStmt = "";
  var strAlterTabStmt = "";
  var strCreateTabInd = "";
  var strSelectFields =  "";
  var strSrcTgtJoin =  "";
  var strWhereCondition =  "";
  var strUpdateFields =  "";
  var strTgtInsertFields =  "";
  var strSrcInsertFields =  "";
  var strAddColsStmt = "";
  var return_array = [];

   try {
      
      //Get target and source schema
      var strSQLText = `SELECT table_schema target_table_schema,'RAW' source_table_schema, 'CONTROL' control_table_schema
                    FROM information_schema.tables WHERE table_name = '_PAIEB_TABLE_LIST' AND table_schema LIKE 'PAIEB%'; `;
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute(); 
      ret_value.next();
      
      strTgtTableSchema = ret_value.getColumnValue('TARGET_TABLE_SCHEMA');
      strSrcTableSchema = ret_value.getColumnValue('SOURCE_TABLE_SCHEMA');
      strCtlTableSchema = ret_value.getColumnValue('CONTROL_TABLE_SCHEMA');
      
      //Insert Job info
      strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_job_ctrl(jobid,jobname,status,starttime) VALUES(CONTROL.PAIEB_JOB_SEQ.NEXTVAL,'REFRESH_LOOKUP_TABLES','STARTED',current_timestamp());`;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute();  
      
      //Get JobId
      strSQLText = `SELECT MAX(jobid) refresh_job_id
                    FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                    WHERE jobname = 'REFRESH_LOOKUP_TABLES'
                    AND status = 'STARTED';` ;       
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
      ret_value = strSQLStmt.execute();
      ret_value.next();      
      var numMaxJobId = ret_value.getColumnValue('REFRESH_JOB_ID');
      
      //Insert pk information to pk config table to be used for the merge statement later            
      strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `cfg_paieb_table_primary_keys(pk_created_on,pk_database_name,pk_schema_name,pk_table_name,pk_column_name,pk_key_sequence,pk_data_type,pk_constraint_name) 
                        SELECT current_timestamp() current_dt,current_database() current_db,'` + strTgtTableSchema + `' current_schema,tbl_name,pk_column,seq
                          ,CASE WHEN UPPER(pk_column) LIKE '%ID' THEN 'NUMBER' 
                                WHEN UPPER(pk_column) LIKE '%DATE' THEN 'TIMESTAMP_NTZ' 
                                WHEN UPPER(pk_column) = 'LOG_CREATED_ON' THEN 'TIMESTAMP_NTZ'
                                 WHEN UPPER(pk_column) = 'D_MONTH' THEN 'NUMBER'
                             ELSE 'VARCHAR' END data_type
                          ,CONCAT(tbl_name,pk_column,seq)  pk_name
                        FROM (SELECT DISTINCT UPPER(c.table_name) tbl_name,UPPER(value) pk_column,index seq
                              FROM (SELECT * 
                               FROM ` + strTgtTableSchema + `.` + `_PAIEB_TABLE_LIST c, LATERAL SPLIT_TO_TABLE(table_primary_key, ',')
                               WHERE c.table_primary_key IS NOT NULL) c ) tmp 
                        WHERE NOT EXISTS(SELECT 1 FROM ` + strCtlTableSchema + `.` + `cfg_paieb_table_primary_keys pks WHERE tmp.tbl_name = pks.pk_table_name AND tmp.pk_column = pks.pk_column_name);` ;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute(); 
      
      snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
      
      //Get list of tables to synchronzie
      strSQLText = `SELECT r.table_name src_table_name, o.table_name tgt_table_name,TRIM(REPLACE(r.table_name,'_RAW','')) tgt_table_name_log
                             ,CASE WHEN o.table_name IS NULL THEN CONCAT('CREATE TABLE ','` + strTgtTableSchema + `','.',s.table_name,' AS SELECT * FROM RAW.',r.table_name,';') ELSE NULL END create_tab_stmt 
                             ,CONCAT('ALTER TABLE ','` + strTgtTableSchema + `','.',s.table_name,' ADD PRIMARY KEY (',s.table_primary_key,');') alter_tabpk_stmt 
                             ,CASE WHEN o.table_name IS NULL THEN 'Y' ELSE 'N' END create_table_ind 
             FROM ` + strTgtTableSchema + `.` + `_PAIEB_TABLE_LIST s  
               JOIN information_schema.tables r ON s.table_name = TRIM(REPLACE(r.table_name,'_RAW','')) AND r.table_schema = '` + strSrcTableSchema + `'
               LEFT JOIN information_schema.tables o ON  s.table_name = o.table_name AND o.table_schema = '` + strTgtTableSchema + `';` ;       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});      
       var flListTabs = strSQLStmt.execute();    
       
       //Loop through tables to synchronize
       while (flListTabs.next())  {
         try{      
         
           strSrcTableName = flListTabs.getColumnValue('SRC_TABLE_NAME');
           strTgtTableName = flListTabs.getColumnValue('TGT_TABLE_NAME');
           strCreateTabStmt = flListTabs.getColumnValue('CREATE_TAB_STMT');
           strAlterTabStmt = flListTabs.getColumnValue('ALTER_TABPK_STMT');
           strCreateTabInd = flListTabs.getColumnValue('CREATE_TABLE_IND');
           strTgtTableNameLog = flListTabs.getColumnValue('TGT_TABLE_NAME_LOG');
                     
           if (strCreateTabInd == "Y" )
             { 
              //create table and pk if it doesn't exist
              snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
              
              strSQLStmt = snowflake.createStatement({sqlText: strCreateTabStmt});
              ret_value = strSQLStmt.execute();              
              
              strSQLStmt = snowflake.createStatement({sqlText: strAlterTabStmt});
              ret_value = strSQLStmt.execute();
              
              strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status,job_id)
                       SELECT 0,0, '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Created' as status, ` + numMaxJobId + `
                       FROM dual;`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();         
              
              snowflake.execute( {sqlText: "COMMIT;"} ); 
              } 
           else
             {
            
             snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
              
              //Get query components for adding columns if they are missing
              strSQLText  = `SELECT table_name,CONCAT(SUBSTR(alter_stmt,1,LENGTH(alter_stmt)-1),');') alter_tabadd_stmt
                            FROM(SELECT c.table_name,
                                   CONCAT('ALTER TABLE ',TRIM(REPLACE(c.table_name,'_RAW','')),' ADD (',LISTAGG (concat('"',c.column_name,'" ',CASE WHEN c.data_type = 'TEXT' THEN 'VARCHAR' ELSE c.data_type END,',')) WITHIN GROUP ( ORDER BY c.ordinal_position asc )) alter_stmt   
                                 FROM ` + strTgtTableSchema + `.` + `_PAIEB_TABLE_LIST l
                                   JOIN information_schema.columns c ON l.table_name = TRIM(REPLACE(c.table_name,'_RAW','')) AND c.table_schema = '` + strSrcTableSchema + `'
                                   LEFT JOIN information_schema.columns  d ON l.table_name = d.table_name AND c.column_name = d.column_name AND d.table_schema = '`+ strTgtTableSchema +`'
                                 WHERE c.table_name = '`+ strSrcTableName +`'
                                 AND d.column_name is null
                                 GROUP BY c.table_name);`; 
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              var colAddStmt = strSQLStmt.execute();
            
              if (strSQLStmt.getRowCount() > 0) 
              {                                
                colAddStmt.next();
                strAddColsStmt = colAddStmt.getColumnValue('ALTER_TABADD_STMT');
                
                //Add missing columns                   
                strSQLStmt = snowflake.createStatement({sqlText: strAddColsStmt});
                var ret_value = strSQLStmt.execute();
              }
              
               //Check if pk exists and create it if needed
              strSQLText = `SELECT COUNT(*) pk_count FROM information_schema.table_constraints WHERE constraint_type = 'PRIMARY KEY' AND table_schema = '`+ strTgtTableSchema +`' AND table_name = '`+ strTgtTableName +`' ;`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute(); 
              ret_value.next();
              var cntPk = ret_value.getColumnValue('PK_COUNT');
              
              if (cntPk == 0)
                {                 
                strSQLStmt = snowflake.createStatement({sqlText: strAlterTabStmt});
                ret_value = strSQLStmt.execute();                 
                 }
              
              //Get query components for the merge statement
              strSQLText = `SELECT select_fields, REPLACE(listagg (DISTINCT ' COALESCE(tgt."'||cons.pk_column_name||'",'  
                            ||CASE WHEN cons.pk_data_type ='FLOAT' THEN '0' 
                                   WHEN cons.pk_data_type ='NUMBER' THEN '0' 
                                   WHEN cons.pk_data_type ='DATE' THEN '''1900-12-01''' 
                                   WHEN cons.pk_data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' 
                                ELSE '-999999' END||') = COALESCE(src."'  
                                ||cons.pk_column_name ||'",' 
                                ||CASE  WHEN cons.pk_data_type ='FLOAT' THEN '0'  
                                        WHEN cons.pk_data_type ='NUMBER' THEN '0' 
                                        WHEN cons.pk_data_type ='DATE' THEN '''1900-12-01''' 
                                        WHEN cons.pk_data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' 
                                   ELSE '-999999' END  ,') AND ') ||')','-999999','''''') AS src_tgt_join 
                               ,REPLACE(where_condition,'-999999','''''') AS where_condition 
                               ,update_fields 
                               ,tgt_insert_fields 
                              ,src_insert_fields 
                              ,'`+ strTgtTableSchema +`' AS table_schema
                              ,'`+ strTgtTableName +`' AS tgt_table_name
                              ,'`+ strSrcTableName +`' AS src_table_name
                            FROM (SELECT intab.table_name, TRIM(REPLACE(intab.table_name,'_RAW','')) tgt_table_name
                                   ,listagg (' CAST($'   ||intab.ordinal_position || ' AS ' || intab.data_type || ') AS "' ||intab.column_name,'", ') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||'"'  AS select_fields 
                                   ,listagg (' COALESCE(tgt."'  || CASE WHEN intab.CM IS NULL THEN intab.column_name ELSE NULL end  || '", ' 
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
                                    ,listagg (' tgt."'  ||CASE WHEN intab.CM IS NULL THEN intab.column_name ELSE NULL end || '"= src."' ||intab.column_name , '",') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||'"' AS update_fields 
                                    ,listagg ( '"'||intab.column_name,'",') WITHIN GROUP ( ORDER BY ordinal_position asc ) ||'"' AS tgt_insert_fields 
                                    ,listagg ( ' src."'  ||intab.column_name,'",') WITHIN GROUP ( ORDER BY intab.ordinal_position asc ) ||'"' AS src_insert_fields  
                                    ,listagg (ordinal_position,',') WITHIN GROUP ( ORDER BY ordinal_position asc ) ordinal_position 
                                  FROM (SELECT intab.table_name ,intab.column_name ,intab.ordinal_position ,CASE WHEN intab.data_type = 'TEXT' THEN 'VARCHAR' ELSE intab.data_type END data_type ,cons.pk_constraint_name AS CM 
                                        FROM INFORMATION_SCHEMA.COLUMNS intab 
                                          LEFT JOIN ` + strCtlTableSchema + `.` + `cfg_paieb_table_primary_keys cons ON cons.pk_table_name = TRIM(REPLACE(intab.table_name,'_RAW','')) AND intab.column_name = cons.pk_column_name 
                                        WHERE intab.TABLE_SCHEMA = '` + strSrcTableSchema + `'
                                        AND intab.table_name = '`+ strSrcTableName +`'
                                        GROUP BY intab.table_name,intab.column_name,intab.column_name,intab.ordinal_position,intab.data_type,cons.pk_constraint_name 
                                        ORDER BY intab.table_name,intab.ordinal_position ) intab 
                                   GROUP BY table_name 
                                   ORDER BY table_name,ordinal_position ) tt 
                            LEFT JOIN ` + strCtlTableSchema + `.` + `cfg_paieb_table_primary_keys cons ON cons.pk_table_name = tt.tgt_table_name 
                            GROUP BY select_fields,where_condition,update_fields,tgt_insert_fields,src_insert_fields;`;           
              
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              
              var ret_value = strSQLStmt.execute();
              ret_value.next();
              strSelectFields = ret_value.getColumnValue('SELECT_FIELDS');
              strSrcTgtJoin = ret_value.getColumnValue('SRC_TGT_JOIN');
              strWhereCondition = ret_value.getColumnValue('WHERE_CONDITION');
              strUpdateFields = ret_value.getColumnValue('UPDATE_FIELDS');
              strTgtInsertFields = ret_value.getColumnValue('TGT_INSERT_FIELDS');
              strSrcInsertFields = ret_value.getColumnValue('SRC_INSERT_FIELDS');
              
              //Perform merge to update or insert only
              //Deletes will be handled manually to make sure no records are deleted unnecessarily
              
              //Execute the merge statement
              var strMergeStmt = ` MERGE INTO `+ strTgtTableSchema + `.` + strTgtTableName + ` AS tgt 
                  USING (SELECT ` + strSrcInsertFields + ` FROM ` + strSrcTableSchema + `.` + strSrcTableName + ` src) AS src ON ( ` + strSrcTgtJoin + `) 
                  WHEN MATCHED AND ` + strWhereCondition + ` THEN 
                    UPDATE SET ` + strUpdateFields + `
                  WHEN NOT MATCHED THEN 
                    INSERT ( ` + strTgtInsertFields + `) VALUES (` + strSrcInsertFields + `);`;              
              strSQLStmt = snowflake.createStatement({sqlText: strMergeStmt});
              ret_value = strSQLStmt.execute();
                                      
              //Insert status of synching
              strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status,job_id)
                           SELECT "number of rows inserted","number of rows updated", '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Completed' as status, ` + numMaxJobId + `
                           FROM TABLE (RESULT_SCAN(LAST_QUERY_ID()))
                           WHERE "number of rows inserted" != 0 OR "number of rows updated" != 0;`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();   
              
              snowflake.execute( {sqlText: "COMMIT;"} ); 
            }   
          } 
          catch (err)  {             
             //strErrMsg = err.message.replace(/'/g,"");	             
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status,job_id)
                       SELECT 0,0, '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Failed' as status, ` + numMaxJobId + `
                       FROM dual;`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();
             //return_array.push("Synchronization Failed");
             //return return_array;             
          } 
       };   
      } 
  catch (err)  {     
	 strErrMsg = err.message.replace(/'/g,"");       
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     
     //Update job info
     strSQLText = `UPDATE ` + strCtlTableSchema + `.` + `paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();  
     
     strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                VALUES(` + numMaxJobId +`,'REFRESH_LOOKUP_TABLES','Lookup tables refresh failed.',1,current_timestamp());`;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();     
     
     return_array.push("Synchronization Failed");
     return return_array;
  }
  
  //Update job info
  strSQLText = `UPDATE ` + strCtlTableSchema + `.` + `paieb_job_ctrl SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  ret_value = strSQLStmt.execute();  
  
  strSQLText = `INSERT INTO ` + strCtlTableSchema + `.` + `paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                VALUES(` + numMaxJobId +`,'REFRESH_LOOKUP_TABLES','Lookup tables refresh completed. Check PAIEB_SYNCHRONIZE_TABLE_LOG for more details.',1,current_timestamp());`;
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
  ret_value = strSQLStmt.execute();  
  
  snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Synchronization Successful");
  return return_array; /* SUCCESS */  
  $$;