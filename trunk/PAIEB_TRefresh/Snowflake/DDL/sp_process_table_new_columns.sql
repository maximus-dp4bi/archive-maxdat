//make sure to deploy the procedure in correct schema - e.g use schema PAIEB_DEV;
create or replace procedure SP_PROCESS_TABLE_NEW_COLUMNS()
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */  
  var strTargetTableName = "";  
  var strTargetTableSchema = "";  
  var strPQTableSchema = "";
  var strProcessName = "";  
  var strAlterTabColStmt = ""; 
  var return_array = [];
  var tablist_array = [];
  var strJobComments = "";    
  var strColsAddComment = "";
  var strAddColsStmt = "";
    
  try {
      //Need to get schema where permanent tables reside
      var strSQLText = `SELECT table_schema target_table_schema,'SP_PROCESS_TABLE_NEW_COLUMNS' process_name
                        FROM information_schema.tables WHERE table_name = '_PAIEB_TABLE_LIST' AND table_schema LIKE 'PAIEB%'; `; 
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute(); 
      ret_value.next();
      strTargetTableSchema = ret_value.getColumnValue('TARGET_TABLE_SCHEMA');
      strProcessName = ret_value.getColumnValue('PROCESS_NAME');
     
      //get schema where _PQ tables were created
      strSQLText = `SELECT parse_json(params):"PQ_SCHEMA_NAME" pq_table_schema
                    FROM control.paieb_job_ctrl
                    WHERE jobname = 'FULL_LOAD'
                    AND status = 'COMPLETED'
                    AND jobid = (SELECT MAX(jobid) FROM control.paieb_job_ctrl WHERE jobname = 'FULL_LOAD' AND status = 'COMPLETED');`;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute(); 
      
       if (strSQLStmt.getRowCount() > 0)       
        { ret_value.next();                    
          strPQTableSchema = ret_value.getColumnValue('PQ_TABLE_SCHEMA'); 
         }
      else {
        strPQTableSchema = 'FULL1';
         }
      
      //Insert Job info
      strSQLText = `INSERT INTO CONTROL.paieb_job_ctrl(jobid,jobname,status,starttime) VALUES(CONTROL.PAIEB_JOB_SEQ.NEXTVAL,'`+ strProcessName +`','STARTED',current_timestamp());`;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute();  
      
       //Get JobId
       strSQLText = `SELECT MAX(jobid) tabcomp_job_id
                     FROM CONTROL.paieb_job_ctrl s  
                     WHERE jobname = '`+ strProcessName +`'
                     AND status = 'STARTED';` ;       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
       ret_value = strSQLStmt.execute();
       ret_value.next();      
       var numMaxJobId = ret_value.getColumnValue('TABCOMP_JOB_ID');      
       
       strSQLText = `SELECT DISTINCT source_table_name FROM CONTROL.paieb_awsdms_tables_list ORDER BY source_table_name;`;   
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
       var cdcTabList = strSQLStmt.execute();
       
       //snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
       
       while (cdcTabList.next())  {
         try {
           strTargetTableName = cdcTabList.getColumnValue('SOURCE_TABLE_NAME');
           
           //get missing columns
           strSQLText = `SELECT  CONCAT('ALTER TABLE ','`+ strTargetTableSchema +`','.',TRIM(REPLACE(p.table_name,'_PQ','')), 
                            ' ADD (',LISTAGG (CONCAT(p.column_name,' ',CASE WHEN data_type IN('TEXT','VARCHAR') THEN CONCAT('VARCHAR(',character_maximum_length,')')
                                                                             WHEN data_type = 'NUMBER' THEN CONCAT('NUMBER(',numeric_precision,',',numeric_scale,')')
                                                                             WHEN data_type = 'TIMESTAMP_NTZ' THEN CONCAT('TIMESTAMP_NTZ(',datetime_precision,')')
                                                                       ELSE data_type END),', ') WITHIN GROUP ( ORDER BY p.ordinal_position asc ),');') alter_tabadd_stmt  
                            ,CONCAT('Columns added to ',TRIM(REPLACE(p.table_name,'_PQ','')),' - ',LISTAGG(p.column_name,',') WITHIN GROUP(ORDER BY p.ordinal_position asc),chr(13) ) cols_added_comment                                           
                          FROM information_schema.columns p
                            LEFT JOIN (SELECT table_name,column_name 
                                       FROM information_schema.columns
                                       WHERE  table_schema = '`+ strTargetTableSchema +`'
                                       AND table_name = '`+ strTargetTableName +`')  h ON TRIM(REPLACE(p.table_name,'_PQ','')) = h.table_name AND p.column_name = h.column_name
                          WHERE p.table_schema = '`+ strPQTableSchema +`' 
                          AND h.column_name IS NULL
                          AND p.table_name = '`+ strTargetTableName +`_PQ'
                          AND NOT EXISTS(SELECT x.column_name FROM control.paieb_awsdms_column_compare_exclude x WHERE TRIM(REPLACE(p.table_name,'_PQ','')) = x.source_table_name AND p.column_name = x.column_name)
                          GROUP BY p.table_name;`;
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
           var colAddStmt = strSQLStmt.execute();
           
           if (strSQLStmt.getRowCount() > 0) 
              {                                
                colAddStmt.next();
                strAddColsStmt = colAddStmt.getColumnValue('ALTER_TABADD_STMT');
                strColsAddComment = colAddStmt.getColumnValue('COLS_ADDED_COMMENT');
                
                //Add missing columns                   
                strSQLStmt = snowflake.createStatement({sqlText: strAddColsStmt});
                ret_value = strSQLStmt.execute();
                
                //update config
                strSQLText =  `UPDATE control.paieb_awsdms_tables_list awsdms 
                               SET merge_full_insert_str = (SELECT REPLACE('INSERT (' || listagg(s1.column_name,',') || ') VALUES (' || listagg('src.'|| s1.column_name,',') || ')','src.COMMITTIMESTAMP','try_to_timestamp(substr(src.COMMITTIMESTAMP,1,19),''YYYY-MM-DD HH24:MI:SS'')')
                                                            FROM control.paieb_awsdms_tables_list a
                                                              LEFT JOIN information_schema.columns s1 ON s1.table_schema = '`+ strTargetTableSchema+`' AND s1.table_name = a.source_table_name 
                                                            WHERE EXISTS (SELECT 'x' FROM information_schema.columns s2 WHERE s2.table_schema = '`+strPQTableSchema+`' AND s2.table_name = a.source_table_name || '_PQ' AND s2.column_name = s1.column_name)
                                                            AND a.source_table_name = awsdms.source_table_name )
                               WHERE awsdms.source_table_name = '`+ strTargetTableName +`';` ;
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText}); 
                ret_value = strSQLStmt.execute();
                
                
                strSQLText =  `UPDATE control.paieb_Awsdms_tables_list awsdms 
                               SET md5_compare_str = (SELECT 'md5(array_to_string(array_construct_compact(' || listagg(case when s1.column_name = a.primary_key_column or s1.column_name = 'COMMITTIMESTAMP' then '0' else 'src.' || s1.column_name end ,',') || '),'',''))'  || ' <> ' || 
                                                         'md5(array_to_string(array_construct_compact(' || listagg(case when s1.column_name = a.primary_key_column or s1.column_name = 'COMMITTIMESTAMP' then '0' else 'tgt.'|| s1.column_name end,',') || '),'',''))' md5_compare_str
                                                      FROM control.paieb_awsdms_tables_list a
                                                         LEFT JOIN information_schema.columns s1 ON s1.table_schema = '`+ strTargetTableSchema+`' AND s1.table_name = a.source_table_name 
                                                      WHERE EXISTS (SELECT 'x' FROM information_schema.columns s2 WHERE s2.table_schema = '`+strPQTableSchema+`' 
                                                                      AND s2.table_name = a.source_table_name || '_PQ' AND s2.column_name = s1.column_name)
                                                      AND a.source_table_name = awsdms.source_table_name)
                               WHERE awsdms.source_table_name = '`+ strTargetTableName +`';` ;
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText}); 
                ret_value = strSQLStmt.execute();                               

                strSQLText =  `UPDATE control.paieb_Awsdms_tables_list awsdms 
                               SET merge_full_update_str = (SELECT replace(replace(replace(listagg((case when s1.column_name = a.primary_key_column then 'PKCOLUMN' else 'tgt.' || s1.column_name || ' = src.' || s1.column_name end) ,','),'PKCOLUMN',''),',,',','),'src.COMMITTIMESTAMP','try_to_timestamp(substr(src.COMMITTIMESTAMP,1,19),''YYYY-MM-DD HH24:MI:SS'')')  merge_full_update_str
                                                            FROM control.paieb_awsdms_tables_list a
                                                               LEFT JOIN information_schema.columns s1 on s1.table_schema = '`+ strTargetTableSchema+`' AND s1.table_name = a.source_table_name 
                                                                 AND s1.column_name <> a.primary_key_column
                                                            WHERE EXISTS (SELECT 'x' FROM information_schema.columns s2 WHERE s2.table_schema = '`+strPQTableSchema+`' AND s2.table_name = a.source_table_name || '_PQ' 
                                                                            AND s2.column_name = s1.column_name)
                                                            AND a.source_table_name = awsdms.source_table_name)
                               WHERE awsdms.source_table_name = '`+ strTargetTableName +`';` ;
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText}); 
                ret_value = strSQLStmt.execute(); 

                strSQLText =  `UPDATE control.paieb_Awsdms_tables_list a 
                               SET merge_str = CONCAT('Merge into TGT_SCHEMANAME.',a.source_table_name,' tgt using (select * from SRC_SCHEMANAME.',a.source_table_name,'_pq) src on src.',a.primary_key_column,' = tgt.',a.primary_key_column,
                                                 chr(13),' when matched and ',a.md5_compare_str,chr(13),' then update set ',a.merge_full_update_str,chr(13),' when not matched then ', a.merge_full_insert_str,';')
                               WHERE a.source_table_name = '`+ strTargetTableName +`';` ;
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText}); 
                ret_value = strSQLStmt.execute();
                
                strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz)                              
                         SELECT `+ numMaxJobId +`,'`+ strProcessName +`', '`+ strColsAddComment +`',1, current_timestamp()
                         FROM dual;`;                                      
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                ret_value = strSQLStmt.execute();  
                
                tablist_array.push(strColsAddComment);
              } 
                         
         }
         catch (err)  {             
             
             //snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             //Update job info
            // strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
            // strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            // ret_value = strSQLStmt.execute();  
     
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Table schema comparison failed for table `+ strTargetTableName +`',1,current_timestamp());`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute(); 
            // return_array.push("Process Failed");
            // return return_array;
          }
        };   
      } 
  catch (err)  {     	   
     //snowflake.execute( {sqlText: "ROLLBACK;"} );
             
     //Update job info
     strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();  

     strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                   VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Table schema comparison failed for table `+ strTargetTableName +`',1,current_timestamp());`;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();      

     return_array.push("Process Failed");
     return return_array;
  }
  
  if ( tablist_array.length > 0)
     {
        strJobComments = tablist_array;
       }
  else {strJobComments = 'No tables to alter';}  
  
  strSQLText = `UPDATE CONTROL.paieb_job_ctrl 
                SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() 
                    ,comments = '`+ strJobComments +`'
                WHERE jobid = ` + numMaxJobId + `;`  ;
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
  ret_value = strSQLStmt.execute(); 
              
  //snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Process Successful");
  return return_array; /* SUCCESS */  
  $$;
   