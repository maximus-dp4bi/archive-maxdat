//make sure to deploy the procedure in correct schema - e.g use schema PAIEB_DEV;
create or replace procedure SP_PROCESS_TABLE_MISMATCHED_DATATYPES()
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */  
 
  var strTargetTableName = "";  
  var strTargetTableSchema = "";  
  var strPQTableSchema = "";
  var strProcessName = "";  
  var return_array = [];
  var tablist_array = [];
  var strJobComments = "";              
    
  try {
      //Need to get schema where permanent tables reside
      var strSQLText = `SELECT table_schema target_table_schema,'SP_PROCESS_TABLE_MISMATCHED_DATATYPES' process_name
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
              
       while (cdcTabList.next())  {
         try {
           strTargetTableName = cdcTabList.getColumnValue('SOURCE_TABLE_NAME');
           
           //get mismatched columns
           strSQLText = `SELECT  CONCAT('Mismatch  - ',LISTAGG(CONCAT(p.table_schema,'.',p.table_name,'.',p.column_name,' ',p.data_type,' vs. ',h.table_schema,'.',h.table_name,'.',h.column_name,' ',h.data_type),',') WITHIN GROUP(ORDER BY p.ordinal_position asc),chr(13) ) cols_mismatch_comment       
                          FROM information_schema.columns p
                            JOIN (SELECT table_schema,table_name,column_name,data_type
                                  FROM information_schema.columns
                                  WHERE  table_schema = '`+ strPQTableSchema +`'
                                  AND table_name = '`+ strTargetTableName +`_PQ')  h ON p.table_name = TRIM(REPLACE(h.table_name,'_PQ','')) AND p.column_name = h.column_name
                          WHERE p.table_schema = '`+ strTargetTableSchema +`' 
                          AND h.data_type <> p.data_type
                          AND p.table_name = '`+ strTargetTableName +`'
                          AND NOT EXISTS(SELECT x.column_name FROM control.paieb_awsdms_column_compare_exclude x WHERE p.table_name = x.source_table_name AND p.column_name = x.column_name)
                          GROUP BY p.table_name;`;    
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
           var colMismatchStmt = strSQLStmt.execute();
           
           if (strSQLStmt.getRowCount() > 0) 
              {                                
                colMismatchStmt.next();                
                var strColsMismatchComment = colMismatchStmt.getColumnValue('COLS_MISMATCH_COMMENT');                 
                strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz)                              
                         SELECT `+ numMaxJobId +`,'`+ strProcessName +`', '`+ strColsMismatchComment +`',1, current_timestamp()
                         FROM dual;`;                                      
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                ret_value = strSQLStmt.execute();  
                
                tablist_array.push(strColsMismatchComment);
              } 
                         
         }
         catch (err)  {                                       
             
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Table schema comparison failed for table `+ strTargetTableName +`',1,current_timestamp());`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();             
          }
        };   
      } 
  catch (err)  {     	   
     
     //Update job info
     strSQLText = `UPDATE CONTROL.paieb_job_ctrl 
                   SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp(),
                      comments = 'Table schema comparison failed for table `+ strTargetTableName +`'
                   WHERE jobid = ` + numMaxJobId + `;`  ;
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
        strJobComments =   tablist_array ;
       }
  else {strJobComments = 'No datatype mismatches from any tables'; }     
  
  strSQLText = `UPDATE CONTROL.paieb_job_ctrl 
                SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() 
                    ,comments = '`+ strJobComments +`'
                WHERE jobid = ` + numMaxJobId + `;`  ;
  strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
  ret_value = strSQLStmt.execute();   
    
  return_array.push("Process Successful");
  return return_array; /* SUCCESS */  
  $$;