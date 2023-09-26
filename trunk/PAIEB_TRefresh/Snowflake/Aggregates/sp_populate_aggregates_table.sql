use schema paieb_uat;
create or replace procedure SP_POPULATE_AGGREGATES_TABLE()
  returns array
  language javascript
  execute as caller
  as
  $$
  
  /* Declare Variables */  
  var strInsertStmt = ""; 
  var strSelectStmt = ""; 
  var strWhereStmt = ""; 
  var strSrcTgtJoin = ""; 
  var strFromTableName = "";
  var strIntoTableName = "";  
  var strFromTableSchema = "";
  var strIntoTableSchema = "";
  var strProcessName = "";  
  var aggTabCount = 0;
  var return_array = [];
  
  //snowflake.execute( {sqlText: "BEGIN;"} );
   try {
      
       var strSQLText = `ALTER SESSION SET week_start = 7;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText}); 
       var ret_value = strSQLStmt.execute();
      
       strSQLText = `SELECT aggregate_process_name, source_table_name, source_table_schema, destination_table_name, destination_table_schema, insert_fields, select_fields, where_clause,merge_join
                     FROM CONTROL.paieb_aggregate_tables_list
                     WHERE is_active = 'Y';` ;       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       aggListTabs = strSQLStmt.execute();       
       
       while (aggListTabs.next())  {
         try{         
          //Get aggregates processes
          strProcessName = aggListTabs.getColumnValue('AGGREGATE_PROCESS_NAME');
          strIntoTableName = aggListTabs.getColumnValue('DESTINATION_TABLE_NAME');
          strFromTableName = aggListTabs.getColumnValue('SOURCE_TABLE_NAME');
          strIntoTableSchema = aggListTabs.getColumnValue('DESTINATION_TABLE_SCHEMA');
          strFromTableSchema = aggListTabs.getColumnValue('SOURCE_TABLE_SCHEMA');
          strInsertStmt = aggListTabs.getColumnValue('INSERT_FIELDS');
          strSelectStmt = aggListTabs.getColumnValue('SELECT_FIELDS');
          strWhereStmt = aggListTabs.getColumnValue('WHERE_CLAUSE');
          strSrcTgtJoin = aggListTabs.getColumnValue('MERGE_JOIN');
          
          //Insert Job info
          strSQLText = `INSERT INTO CONTROL.paieb_job_ctrl(jobid,jobname,status,starttime) VALUES(CONTROL.PAIEB_JOB_SEQ.NEXTVAL,'`+ strProcessName +`','STARTED',current_timestamp());`;
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          var ret_value = strSQLStmt.execute();  
      
          //Get JobId
          strSQLText = `SELECT MAX(jobid) refresh_job_id
                        FROM CONTROL.paieb_job_ctrl s  
                        WHERE jobname = '`+ strProcessName +`'
                        AND status = 'STARTED';` ;       
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
          ret_value = strSQLStmt.execute();
          ret_value.next();      
          var numMaxJobId = ret_value.getColumnValue('REFRESH_JOB_ID');      
          
          snowflake.execute( {sqlText: "BEGIN;"} );
          
          strSQLText = ` MERGE INTO `+ strIntoTableSchema + `.` + strIntoTableName + ` AS tgt 
                  USING (SELECT ` + strSelectStmt + ` FROM ` + strFromTableSchema + `.` + strFromTableName + ` src ` + strWhereStmt +`) AS src ON ( ` + strSrcTgtJoin + `) 
                  WHEN NOT MATCHED THEN 
                    INSERT ( ` + strInsertStmt + `) VALUES (` + strSelectStmt + `);`;    
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
          ret_value = strSQLStmt.execute();
          
          aggTabCount = 0;
          strSQLText = `SELECT COUNT(*) agg_table_count FROM ` + strIntoTableSchema + `.` + strIntoTableName +` WHERE TRUNC(create_ts,'DD') = current_date() ;` ;          
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
          var tabCount = strSQLStmt.execute();
          tabCount.next();
          aggTabCount = tabCount.getColumnValue('AGG_TABLE_COUNT');
          
          strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
          ret_value = strSQLStmt.execute(); 
              
          if (aggTabCount > 0 ) {          
              strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                             VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Process completed. `+ aggTabCount +` records inserted.',1,current_timestamp());`;              
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
              ret_value = strSQLStmt.execute();              
          }
          else
          {  
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Process completed.  No records inserted.',1,current_timestamp());`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute(); 
             }
         
           snowflake.execute( {sqlText: "COMMIT;"} );   
          }
          catch (err)  {             
             
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             //Update job info
             strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();  
     
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Process to populate aggregates table failed.',1,current_timestamp());`;
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute(); 
          }
       };       
      } 
  catch (err)  {     	   
     snowflake.execute( {sqlText: "ROLLBACK;"} );
             
     //Update job info
     strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();  
     
     strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                    VALUES(` + numMaxJobId +`,'`+ strProcessName +`','Process to populate aggregates table failed.',1,current_timestamp());`;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();       
     
     return_array.push("Process Failed");
     return return_array;
  }
  
  snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Process Successful");
  return return_array; /* SUCCESS */  
  $$;
   