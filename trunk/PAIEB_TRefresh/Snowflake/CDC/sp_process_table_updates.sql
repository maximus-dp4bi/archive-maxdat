//make sure to deploy the procedure in correct schema - e.g use schema PAIEB_DEV;
create or replace procedure SP_PROCESS_TABLE_CDC_UPDATES()
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */   
  var strSourceTableName = "";  
  var strSourceTableSchema = "";  
  var strRawTableSchema = "";  
  var strProcessName = "";  
  var recCounter = 0;
  var recPkId = 0;
  var recTimestamp = "1900-01-01 00:00:00";
  var strColumnList = ""; 
  var strAlterTabColStmt = ""; 
  var strSlctCoalesceStmt = ""; 
  var strSourceTablePK = ""; 
  var strWhereStmt = "";
  var strSetStmt = "";
  var strSlctMaxColumn = "";
  var strRowNumColumn = "";
  var return_array = [];
  
  
  try {
      //Need to get schema where tables to update are found
      var strSQLText = `SELECT table_schema source_table_schema,'SP_PROCESS_TABLE_CDC_UPDATES' process_name, 'RAW' raw_table_schema
                        FROM information_schema.tables WHERE table_name = '_PAIEB_TABLE_LIST' AND table_schema LIKE 'PAIEB%'; `; 
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute(); 
      ret_value.next();
      strSourceTableSchema = ret_value.getColumnValue('SOURCE_TABLE_SCHEMA');
      strProcessName = ret_value.getColumnValue('PROCESS_NAME');
      strRawTableSchema = ret_value.getColumnValue('RAW_TABLE_SCHEMA');
      
      //Insert Job info
      strSQLText = `INSERT INTO CONTROL.paieb_job_ctrl(jobid,jobname,status,starttime) VALUES(CONTROL.PAIEB_JOB_SEQ.NEXTVAL,'`+ strProcessName +`','STARTED',current_timestamp());`;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute();  
      
       //Get JobId
       strSQLText = `SELECT MAX(jobid) refresh_job_id
                     FROM CONTROL.paieb_job_ctrl s  
                     WHERE jobname = '`+ strProcessName +`'
                     AND status = 'STARTED';` ;       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
       ret_value = strSQLStmt.execute();
       ret_value.next();      
       var numMaxJobId = ret_value.getColumnValue('REFRESH_JOB_ID');      
       
       strSQLText = `SELECT DISTINCT source_table_name FROM raw.awsdms_cdc_raw WHERE COALESCE(processed,0) = 0 AND operation = 'U' ORDER BY source_table_name;`;   
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
       var cdcTabList = strSQLStmt.execute();
       
       //snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
       
       while (cdcTabList.next())  {
         try {
           strSourceTableName = cdcTabList.getColumnValue('SOURCE_TABLE_NAME');
           
           //get Table PK
           strSQLText = `SELECT UPPER(primary_key_column) primary_key_column,CONCAT('ROW_NUMBER() OVER(PARTITION BY ', UPPER(primary_key_column),' ORDER BY filenum DESC,rownumber DESC,committimestamp DESC) AS rn') slct_rownum_stmt
                         FROM CONTROL.paieb_awsdms_tables_list WHERE source_table_name = '`+ strSourceTableName + `';`;                       
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});           
           ret_value = strSQLStmt.execute();
           ret_value.next();  
           
           strSourceTablePK = ret_value.getColumnValue('PRIMARY_KEY_COLUMN');
           strRowNumColumn = ret_value.getColumnValue('SLCT_ROWNUM_STMT');
           
           //get column ordinal position excluding committimestamp and merge components       
           strSQLText = `SELECT LISTAGG(CASE WHEN column_name IN('COMMITTIMESTAMP','`+ strSourceTablePK +`') THEN NULL ELSE ordinal_position END,',') WITHIN GROUP (ORDER BY ordinal_position) column_list 
                               ,LISTAGG(CONCAT('COALESCE(nw.',column_name,',prv.',column_name,') AS ',column_name),',') WITHIN GROUP(ORDER BY ordinal_position) slct_coalesce_stmt
                               ,LISTAGG(CONCAT('FIRST_VALUE(',column_name,') IGNORE NULLS OVER(PARTITION BY `+ strSourceTablePK + ` ORDER BY filenum DESC,rownumber DESC,committimestamp DESC) AS ',column_name),',') WITHIN GROUP(ORDER BY ordinal_position) slct_maxcol_stmt
                               ,CONCAT(LISTAGG(CONCAT('COALESCE(tgt.',CASE WHEN column_name = '`+ strSourceTablePK +`' THEN NULL ELSE column_name END, ','
                                            ,CASE WHEN data_type ='FLOAT' THEN '0' 
                                                  WHEN data_type ='NUMBER' THEN '0' 
                                                  WHEN data_type ='BOOLEAN' THEN 'FALSE' 
                                                  WHEN data_type ='DATE' THEN '''1900-12-01''' 
                                                  WHEN data_type IN('VARCHAR','TEXT') THEN '''XXXXX'''
                                                  WHEN data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' ELSE '-999999' END ,') != COALESCE(src.',column_name,',', CASE  WHEN data_type ='FLOAT' THEN '0' 
                                                       WHEN data_type ='NUMBER' THEN '0' 
                                                       WHEN data_type ='BOOLEAN' THEN 'FALSE' 
                                                       WHEN data_type ='DATE' THEN '''1900-12-01''' 
                                                       WHEN data_type IN('VARCHAR','TEXT') THEN '''XXXXX'''
                                                       WHEN data_type ='TIMESTAMP_NTZ' THEN '''1900-12-01 00:00:00''' ELSE '-999999' END ),') OR ' ) WITHIN GROUP (ORDER BY ordinal_position),')') where_stmt,
                            LISTAGG(CONCAT('tgt.',CASE WHEN column_name = '`+ strSourceTablePK +`' THEN NULL ELSE column_name END,' = src.',column_name ),',')  WITHIN GROUP (ORDER BY ordinal_position) set_stmt 
                         FROM information_schema.columns
                         WHERE table_name = '` + strSourceTableName + `' AND table_schema = '` + strSourceTableSchema + `';` ;       
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});                      
           ret_value = strSQLStmt.execute();
           ret_value.next();             
           strColumnList = ret_value.getColumnValue('COLUMN_LIST');     
           strSlctCoalesceStmt = ret_value.getColumnValue('SLCT_COALESCE_STMT');
           strWhereStmt = ret_value.getColumnValue('WHERE_STMT');
           strSetStmt = ret_value.getColumnValue('SET_STMT');
           strSlctMaxColumn = ret_value.getColumnValue('SLCT_MAXCOL_STMT'); 
           
           //drop table if it exists
           strSQLText = `DROP TABLE IF EXISTS ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp;`;
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
           //create temp table 
           strSQLText = `CREATE TABLE ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp AS 
                         WITH rawdata AS(
                           SELECT DISTINCT pk_id,source_table_name,filenum,rownumber,committimestamp, x.value, i.ordinal_position
                           FROM information_schema.columns i
                             LEFT JOIN(SELECT *
                                       FROM(SELECT source_table_name,primary_key,pk_id,path,value,committimestamp,MAX(committimestamp) OVER (PARTITION BY source_table_name,primary_key,pk_id,path) max_ts,
                                             rownumber,MAX(rownumber) OVER (PARTITION BY source_table_name,primary_key,pk_id,path) max_rownum,
                                             filenum, MAX(filenum) OVER (PARTITION BY source_table_name,primary_key,pk_id,path) max_filenum
                                            FROM(SELECT source_table_name,primary_key,pk_id,filenum,TRY_TO_NUMBER(rownumber) AS rownumber,committimestamp, f.path,typeof(f.value) as type, f.value         
                                                 FROM raw.awsdms_cdc_raw, 
                                                       lateral flatten(raw, recursive=>true) f 
                                                 WHERE 1=1
                                                 AND source_table_name = '` + strSourceTableName + `'
                                                 AND COALESCE(processed,0) = 0                                                 
                                                 AND operation = 'U') )
                                            WHERE committimestamp = max_ts
                                            AND rownumber = max_rownum  
                                            AND filenum = max_filenum
                                            AND path != primary_key AND path NOT IN('Op','COMMITTIMESTAMP') ) x ON i.table_name = x.source_table_name AND i.column_name = x.path
                            WHERE i.column_name NOT IN('COMMITTIMESTAMP','`+ strSourceTablePK +`')
                            AND i.table_name = '` + strSourceTableName + `'
                            AND i.table_schema = '` + strSourceTableSchema + `')
                         SELECT x.* 
                         FROM rawdata
                           PIVOT (MAX(value) FOR ordinal_position IN (` + strColumnList +`  ))  x
                         WHERE pk_id IS NOT NULL;`;           
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();

           //get rename column statement
           strSQLText = `SELECT  CONCAT(' RENAME COLUMN "',ordinal_position,'" TO ', column_name)  alter_tabcol_stmt                               
                           FROM information_schema.columns
                           WHERE column_name NOT IN('COMMITTIMESTAMP','`+ strSourceTablePK + `') AND table_name = '` + strSourceTableName + `' AND table_schema = '` + strSourceTableSchema + `';` ;
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           var cdcTabAlterList = strSQLStmt.execute();
           
           strSQLText = `ALTER TABLE ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp RENAME COLUMN pk_id TO ` + strSourceTablePK + `;`; 
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
           //alter table column names from ordinal position to actual column names in temp table
           while (cdcTabAlterList.next())  {
             try {
                strAlterTabColStmt = cdcTabAlterList.getColumnValue('ALTER_TABCOL_STMT');   
                
                strSQLText = `ALTER TABLE ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp ` + strAlterTabColStmt + `;`;                
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                ret_value = strSQLStmt.execute();
               }               
             catch (err)  {                                           
                 //Update job info
                 strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
                 strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                 ret_value = strSQLStmt.execute();  
         
                 strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                               VALUES(` + numMaxJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
                 strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                 ret_value = strSQLStmt.execute(); 
                 return_array.push("Process Failed");
                 return return_array;
               } 
           };    
           
           //Do the merge
           strSQLText = `MERGE INTO `+ strSourceTableSchema + `.` + strSourceTableName + ` tgt
                         USING(SELECT ` + strSlctCoalesceStmt + 
                              ` FROM (SELECT * FROM (SELECT `+ strSlctMaxColumn +`, `+ strRowNumColumn + 
                                      ` FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp)
                                      WHERE rn = 1) nw
                                  JOIN ` + strSourceTableSchema + `.` + strSourceTableName + ` prv ON nw.` + strSourceTablePK + ` = prv.` + strSourceTablePK +
                              ` WHERE nw.committimestamp > prv.committimestamp) src ON (tgt.` + strSourceTablePK + ` = src.` + strSourceTablePK + `)
                         WHEN MATCHED AND ` + strWhereStmt + ` THEN 
                         UPDATE SET  ` + strSetStmt + `;`;    
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();        
           //Update processed
           strSQLText = `UPDATE raw.awsdms_cdc_raw rw 
                         SET processed = 1 
                         FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp nw
                         WHERE nw.` + strSourceTablePK + ` = rw.pk_id AND rw.source_table_name = '`+ strSourceTableName +`' 
                         AND nw.committimestamp >= rw.committimestamp
                         AND COALESCE(processed,0) = 0;`;               
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();      
           
           strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz)                              
                         SELECT `+ numMaxJobId +`,'`+ strProcessName +`', CONCAT('CDC Process completed. ',num_rows,' records updated for table ',srctab_name),1, current_timestamp()
                         FROM (SELECT COUNT(`+ strSourceTablePK +`) num_rows,'`+ strSourceTableName +`' srctab_name FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp nw);`;                                      
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();              
              
           
         }
         catch (err)  {             
             
             //snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             //Update job info
             strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();  
     
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + numMaxJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute(); 
             return_array.push("Process Failed");
             return return_array;
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
                    VALUES(` + numMaxJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();       
     
     return_array.push("Process Failed");
     return return_array;
  }
  
  strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
          ret_value = strSQLStmt.execute();   
              
  //snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Process Successful");
  return return_array; /* SUCCESS */  
  $$;
   