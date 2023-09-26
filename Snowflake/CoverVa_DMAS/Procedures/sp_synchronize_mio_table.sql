use schema coverva_mio;
create or replace procedure SP_SYNCHRONIZE_MIO_TABLE()
  //returns VARCHAR(32000)
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */
  var result;
  var strTgtTableSchema = "";
  var strTgtTableName = "";
  var strTgtTableNameLog = "";
  var strSrcTableName = "";
  var strDropStmt = "";
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
      
      var strSQLText = `INSERT INTO coverva_mio.cfg_mio_table_primary_keys(pk_created_on,pk_database_name,pk_schema_name,pk_table_name,pk_column_name,pk_key_sequence,pk_data_type,pk_constraint_name) 
                    SELECT current_timestamp() ,current_database(),current_schema(),tbl_name,pk_column,seq
                       ,CASE WHEN UPPER(pk_column) LIKE '%ID' THEN 'NUMBER' 
                             WHEN UPPER(pk_column) LIKE '%DATE' THEN 'TIMESTAMP_NTZ' 
                             WHEN UPPER(pk_column) = 'LOG_CREATED_ON' THEN 'TIMESTAMP_NTZ' 
                         ELSE 'VARCHAR' END data_type
                        ,CONCAT(tbl_name,pk_column,seq)  pk_name
                   FROM (SELECT DISTINCT c.table_schema,UPPER(c.table_name) tbl_name,UPPER(value) pk_column,index seq
                         FROM (SELECT * 
                               FROM coverva_mio.ctl_mio_sf_count_compare c, LATERAL SPLIT_TO_TABLE(primary_key_column, ',')
                               WHERE c.primary_key_column IS NOT NULL) c
                            JOIN (SELECT MAX(timestamp) max_created_on 
                                  FROM coverva_mio.ctl_mio_sf_count_compare) mc ON c.timestamp = mc.max_created_on ) tmp 
                   WHERE NOT EXISTS(SELECT 1 FROM  coverva_mio.cfg_mio_table_primary_keys pks WHERE tmp.tbl_name = pks.pk_table_name AND tmp.pk_column = pks.pk_column_name); `;
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute(); 
      
      snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
      
      strSQLText = "SELECT s.table_schema,s.table_name src_table_name, o.table_name tgt_table_name,TRIM(REPLACE(s.table_name,'_SYNC','')) tgt_table_name_log, CONCAT('drop table ',s.table_schema,'.',s.table_name,';') drop_stmt "
            +"                 ,CASE WHEN o.table_name IS NULL THEN CONCAT('ALTER TABLE ',s.table_schema,'.',s.table_name,' RENAME TO ',s.table_schema,'.',TRIM(REPLACE(s.table_name,'_SYNC','')),';') ELSE NULL END create_tab_stmt "
            +"                 ,CONCAT('ALTER TABLE ',s.table_schema,'.',TRIM(REPLACE(s.table_name,'_SYNC','')),' ADD PRIMARY KEY (',msc.primary_key_column,');') alter_tabpk_stmt "
            +"                 ,CASE WHEN o.table_name IS NULL THEN 'Y' ELSE 'N' END create_table_ind "
            +" FROM information_schema.tables s  "
            +"   LEFT JOIN information_schema.tables o ON  TRIM(REPLACE(s.table_name,'_SYNC','')) = o.table_name "
            +"   LEFT JOIN (SELECT DISTINCT c.table_schema,c.table_name,c.primary_key_column "
            +"              FROM coverva_mio.ctl_mio_sf_count_compare c "
            +"                JOIN (SELECT MAX(timestamp) max_created_on "
            +"                      FROM coverva_mio.ctl_mio_sf_count_compare) mc ON c.timestamp = mc.max_created_on "
            +"               WHERE c.mio_count != c.sf_count) msc ON TRIM(REPLACE(s.table_name,'_SYNC','')) = UPPER(msc.table_name) "
            +" WHERE s.table_schema = 'COVERVA_MIO' "
            +" AND s.table_name LIKE '%SYNC'; " ;            
          
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});      
       var flListTabs = strSQLStmt.execute();       
      
       //loop through tables to synchronize
       while (flListTabs.next())  {
         try{      
         
           strTgtTableSchema = flListTabs.getColumnValue('TABLE_SCHEMA');
           strSrcTableName = flListTabs.getColumnValue('SRC_TABLE_NAME');
           strTgtTableName = flListTabs.getColumnValue('TGT_TABLE_NAME');
           strTgtTableNameLog = flListTabs.getColumnValue('TGT_TABLE_NAME_LOG');
           strDropStmt = flListTabs.getColumnValue('DROP_STMT');
           strCreateTabStmt = flListTabs.getColumnValue('CREATE_TAB_STMT');
           strAlterTabStmt = flListTabs.getColumnValue('ALTER_TABPK_STMT');
           strCreateTabInd = flListTabs.getColumnValue('CREATE_TABLE_IND');
                     
           if (strCreateTabInd == "Y" )
             { 
              //create table and pk if it doesn't exist
              snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
              
              strSQLStmt = snowflake.createStatement({sqlText: strCreateTabStmt});
              ret_value = strSQLStmt.execute();              
              
              strSQLStmt = snowflake.createStatement({sqlText: strAlterTabStmt});
              ret_value = strSQLStmt.execute();
              
              strSQLText = `INSERT INTO coverva_mio.mio_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                       SELECT 0,0, '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Created' as status 
                       FROM dual;`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();         
              
              snowflake.execute( {sqlText: "COMMIT;"} ); 
              } 
           else
             {
            
             snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
              
              //Get query components for adding missing columns
              strSQLText  = `SELECT table_name,CONCAT(SUBSTR(alter_stmt,1,LENGTH(alter_stmt)-1),');') alter_tabadd_stmt
                            FROM(SELECT c.table_name,
                                   CONCAT('ALTER TABLE ',TRIM(REPLACE(c.table_name,'_SYNC','')),' ADD (',LISTAGG (concat('"',c.column_name,'" ',c.data_type,',')) WITHIN GROUP ( ORDER BY c.ordinal_position asc )) alter_stmt   
                                 FROM information_schema.columns  c 
                                   LEFT JOIN information_schema.columns  d ON TRIM(REPLACE(c.table_name,'_SYNC','')) = d.table_name AND c.column_name = d.column_name 
                                 WHERE c.table_schema = '`+ strTgtTableSchema +`'
                                 AND c.table_name = '`+ strSrcTableName +`'
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
                            FROM (SELECT intab.table_name, TRIM(REPLACE(intab.table_name,'_SYNC','')) tgt_table_name
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
                                  FROM (SELECT intab.table_name ,intab.column_name ,intab.ordinal_position ,intab.data_type ,cons.pk_constraint_name AS CM 
                                        FROM INFORMATION_SCHEMA.COLUMNS intab 
                                          JOIN INFORMATION_SCHEMA.COLUMNS intabsync ON intab.table_schema = intabsync.table_schema AND intabsync.table_name = CONCAT(intab.table_name,'_SYNC') AND intab.column_name = intabsync.column_name
                                          LEFT JOIN coverva_mio.cfg_mio_table_primary_keys cons ON cons.pk_table_name = intab.table_name AND intab.column_name = cons.pk_column_name 
                                        WHERE intab.TABLE_SCHEMA = '`+ strTgtTableSchema +`'
                                        AND intab.table_name = '`+ strTgtTableName +`'
                                        GROUP BY intab.table_name,intab.column_name,intab.column_name,intab.ordinal_position,intab.data_type,cons.pk_constraint_name 
                                        ORDER BY intab.table_name,intab.ordinal_position ) intab 
                                   GROUP BY table_name 
                                   ORDER BY table_name,ordinal_position ) tt 
                            LEFT JOIN coverva_mio.cfg_mio_table_primary_keys cons ON cons.pk_table_name = tt.tgt_table_name 
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
              
              var strMergeStmt = ` MERGE INTO `+ strTgtTableSchema + `.` + strTgtTableName + ` AS tgt 
                  USING (SELECT ` + strSrcInsertFields + ` FROM ` + strTgtTableSchema + `.` + strSrcTableName + ` src) AS src ON ( ` + strSrcTgtJoin + `) 
                  WHEN MATCHED AND ` + strWhereCondition + ` THEN 
                    UPDATE SET ` + strUpdateFields + `
                  WHEN NOT MATCHED THEN 
                    INSERT ( ` + strTgtInsertFields + `) VALUES (` + strSrcInsertFields + `);`;
              strSQLStmt = snowflake.createStatement({sqlText: strMergeStmt});
              ret_value = strSQLStmt.execute();
                                      
              //Insert status of synching
              strSQLText = `INSERT INTO coverva_mio.mio_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                           SELECT "number of rows inserted","number of rows updated", '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Completed' as status 
                           FROM TABLE (RESULT_SCAN(LAST_QUERY_ID()));`;
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();   
                           
              //drop the sync table after processing discrepancies
              strSQLStmt = snowflake.createStatement({sqlText: strDropStmt});
              ret_value = strSQLStmt.execute();  
              
              snowflake.execute( {sqlText: "COMMIT;"} ); 
            }   
          } 
          catch (err)  {             
             //strErrMsg = err.message.replace(/'/g,"");	             
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             strSQLText = `INSERT INTO coverva_mio.mio_synchronize_table_log (num_rows_inserted,num_rows_updated,synch_table_name,status_date,synch_status)
                       SELECT 0,0, '` +strTgtTableNameLog+ `' AS synch_table_name  , current_timestamp(), 'Failed' as status 
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
     return_array.push("Synchronization Failed");
     return return_array;
  }
  
  snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Synchronization Successful");
  return return_array; /* SUCCESS */  
  $$;