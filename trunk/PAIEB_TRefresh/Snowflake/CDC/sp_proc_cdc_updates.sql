//make sure to deploy the procedure in correct schema - e.g use schema PAIEB_DEV;
create or replace procedure control.PROC_CDC_UPDATES(SOURCETABLENAME VARCHAR,ISTASK varchar, PJOBID varchar)
  returns array
  language javascript
  execute as caller              
  as
  $$

  var strStageName = "";
  var strAwsFolder = "";
  var strPqSchema = "";
  var strTargetSchema = "";
  var strTableName = "";
  var strFullStage = "";
  var strmainjobname = 'CDC_LOAD';
  var strjobname = 'PROC_CDC_UPDATES';
  var numMaxJobId = PJOBID;
  var strCtlTableSchema = 'CONTROL';
                
  /* Declare Variables */   
  var strSourceTableName = SOURCETABLENAME;  
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
  var previousMessage = "";
  var vMessage = "";
  var taskStmt = "";
  var successTaskMsg = 'SUCCESS';
  var failTaskMsg = 'FAIL';

  //defines where the source is and target is
  var user_role = "";
  var dbname = ""; 
  var schemaname = "";
  var dbwarehouse = "";
  var dbtablename = SOURCETABLENAME;
  var strSQLStmt = "";
  var ret_value = "";
  var strtablelist = "";

  var updateJobSql = `update control.paieb_job_ctrl s set 
                   comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                      || CHR(10) || 'REPLACE_COMMENTS'
                            where s.jobid = REPLACE_JOBID;`;

function logerr(rowid, msg){
      return_array.push(msg);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', numMaxJobId, strjobname, rowid,  msg] } ).execute();
} 

//log
function log(rowid, msg){
  if (msg != null) { 
      return_array.push(msg);
      if (typeof numMaxJobID == 'undefined') {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', 0, strjobname, rowid,  msg] } ).execute();
      }
      else {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', numMaxJobId, strjobname, rowid,  msg] } ).execute();
      }
  }    
} 
  
//use this in every task routine
      var pName = "";
      var pValue = "";
      var pSql = "";
      var sessionSQLStmt = 'select PARAM_NAME, PARAM_VALUE, PARAM_SQL from control.CFG_PAIEB_SESSION_PARAMS ORDER BY PARAM_ORDER;';
      strSQLStmt = snowflake.createStatement({sqlText: sessionSQLStmt});   
      ret_value = strSQLStmt.execute();
      //ret_value.next();
      while (ret_value.next()) {
      try {
        pName = ret_value.getColumnValue('PARAM_NAME');
        pValue = ret_value.getColumnValue('PARAM_VALUE');
        pSql = ret_value.getColumnValue('PARAM_SQL');
        pSql = pSql.replace('~PN~',pName);
        pSql = pSql.replace('~PV~',pValue);
              strSQLStmt = snowflake.createStatement({sqlText: pSql});   
              var retv = strSQLStmt.execute();
              log(0, 'setSessionParam:'+pSql);
              //set local variables
              if (pName=='ROLE') {user_role=pValue;}
              if (pName=='DATABASE') {dbname = pValue;}
              if (pName=='SCHEMA') {schemaname = pValue;}
              if (pName=='WAREHOUSE') {dbwarehouse = pValue;}

        } catch(err) {
            strErrMsg = err.message.replace(/'/g,""); 
              log(0, 'setSessionParam:'+pSql+':Err:'+strErrMsg);
            logerr(1,strErrMsg);
        }
      }

   try {
      
       if (ISTASK =='Y') {
          //if task is yes get the jobid from predecessor
           ret_value = snowflake.execute({sqlText: "select system$get_predecessor_return_value() PREVMSG from dual" });
           ret_value.next();
           previousMessage = ret_value.getColumnValue('PREVMSG');
           //Testing previousMessage='SUCCESS:79';
           var prevMesgSub = previousMessage.substring(0,4).toUpperCase();
           if (prevMesgSub == 'FAIL') {
              vMessage = previousMessage;
              taskStmt = `call system$set_return_value('FAIL:`+vMessage+`');`;
              snowflake.execute( {sqlText: taskStmt});
              log(0, vMessage);
              return return_array;
           }
           if (prevMesgSub == 'SUCC') {
              var retarray = [];
              retarray = previousMessage.split(':',2);
              if (retarray.length >= 2) {
                var val1 = retarray[0];
                var val2 = retarray[1];
                numMaxJobId = val2;
              }  
              log(0, 'Job id from Task:' + numMaxJobId);
           }  
           //testing 'Y'
           //return return_array;
       }
          
      //Get JobId
      if (ISTASK == 'N') {
         //if task is no get the jobid from input param and check table
         
          strSQLText = `SELECT MAX(jobid) LOAD_JOB_ID
                        FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                        WHERE jobname = '`+ strmainjobname + `'
                        AND jobid = nvl(try_to_number('`+PJOBID+`'),0)
                        AND status = 'STARTED';` ;       
          log(0, strSQLText);
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
          ret_value = strSQLStmt.execute();
          ret_value.next();      
          numMaxJobId = ret_value.getColumnValue('LOAD_JOB_ID');
          log(0, 'Job id Standalone:'+numMaxJobId);
      }
                
      if (numMaxJobId != null) {
          
          //Get JobId params
          strSQLText = `SELECT jobid load_job_id, params:STAGENAME::VARCHAR stagename, params:AWSFOLDER::VARCHAR awsfolder, params:PQ_SCHEMA_NAME::VARCHAR pqschema , params:TARGET_SCHEMA_NAME::VARCHAR targetschema , params:SOURCE_TABLE_NAME::VARCHAR tablename
                        FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                        WHERE jobname = '`+ strmainjobname + `'
                        AND status = 'STARTED'
                        AND jobid = :1;` ;   
          
          log(0, 'sql = ' + strSQLText);              
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText, binds:[numMaxJobId]});   
          ret_value = strSQLStmt.execute();
          ret_value.next();      
         // numMaxJobId = ret_value.getColumnValue('LOAD_JOB_ID');
          strStageName = ret_value.getColumnValue('STAGENAME');
          strAwsFolder = ret_value.getColumnValue('AWSFOLDER');
          strPqSchema = ret_value.getColumnValue('PQSCHEMA');
          strTargetSchema = ret_value.getColumnValue('TARGETSCHEMA');
          strTableName = ret_value.getColumnValue('TABLENAME');
           strFullStage = '@' + dbname + '.' + schemaname + '.' + strStageName + strAwsFolder ;
           log(0, 'SourceTableName:' + strTableName);
         
      }
      else {
            vMessage='FAIL:Full Load job record found:' + numMaxJobId;
            log(0, vMessage);
             log(0, 'procCDCUpdates-' + vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
           }
      
     } 
      catch (err)  {             
          vMessage = 'FAIL:'+err.message.replace(/'/g,"");               
          log( 1, vMessage);
          log(0, 'procCDCUpdates:'+vMessage);
          if (ISTASK == 'Y') {
            taskStmt = `call system$set_return_value('`+vMessage+`');`;
            snowflake.execute( {sqlText: taskStmt});
          }            
          return return_array;
      } 
    log(0, 'Job id found = ' + numMaxJobId);
    successTaskMsg += ':' + numMaxJobId;

  
  try {
      //Need to get schema where tables to update are found
      var strSQLText = `SELECT table_schema source_table_schema,'SP_PROCESS_TABLE_CDC_UPDATES' process_name, 'RAW' raw_table_schema
                        FROM information_schema.tables WHERE table_name = '_PAIEB_TABLE_LIST'; `; 
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
       var refJobId = ret_value.getColumnValue('REFRESH_JOB_ID');      
       
       strSQLText = `SELECT DISTINCT source_table_name FROM raw.awsdms_cdc_raw WHERE COALESCE(processed,0) = 0 AND operation = 'U' and (source_table_name = '`+strSourceTableName+`' or 'ALL' = '`+strSourceTableName+`' ) and jobid = `+PJOBID+` ORDER BY source_table_name;`;   
       return_array.push(strSQLText);
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
       var cdcTabList = strSQLStmt.execute();
       
       //snowflake.execute( {sqlText: "BEGIN;"});
       
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
            return_array.push(strSQLText);
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
            return_array.push(strSQLText);
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
                                                 AND operation = 'U'
                                                 AND jobid = `+PJOBID+`) )
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
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();

           //get rename column statement
           strSQLText = `SELECT  CONCAT(' RENAME COLUMN "',ordinal_position,'" TO ', column_name)  alter_tabcol_stmt                               
                           FROM information_schema.columns
                           WHERE column_name NOT IN('COMMITTIMESTAMP','`+ strSourceTablePK + `') AND table_name = '` + strSourceTableName + `' AND table_schema = '` + strSourceTableSchema + `';` ;
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           var cdcTabAlterList = strSQLStmt.execute();
           
           strSQLText = `ALTER TABLE ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp RENAME COLUMN pk_id TO ` + strSourceTablePK + `;`; 
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();
           
           //alter table column names from ordinal position to actual column names in temp table
           while (cdcTabAlterList.next())  {
             try {
                strAlterTabColStmt = cdcTabAlterList.getColumnValue('ALTER_TABCOL_STMT');   
                
                strSQLText = `ALTER TABLE ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp ` + strAlterTabColStmt + `;`;                
                return_array.push(strSQLText);
                strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                ret_value = strSQLStmt.execute();
               }               
             catch (err)  {                                           
                 //Update job info
                 strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
                return_array.push(strSQLText);
                 strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                 ret_value = strSQLStmt.execute();  
         
                 strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                               VALUES(` + refJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
                return_array.push(strSQLText);
                 strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
                 ret_value = strSQLStmt.execute(); 
                  
                  vMessage='FAIL:Alter failed';
                  if (ISTASK == 'Y') {
                  taskStmt = `call system$set_return_value('`+vMessage+`');`;
                  snowflake.execute( {sqlText: taskStmt});
                  }            
                 return_array.push(vMessage);
                 return return_array;
               } 
           };    
           
           //set processed to 2 where main record is later than update record
           strSQLText = `UPDATE raw.awsdms_cdc_raw rw 
                         SET processed = 1, comments = 'Target is advanced,Update is older, Jobid: `+numMaxJobId+` '
                         FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp nw
                         WHERE nw.` + strSourceTablePK + ` = rw.pk_id AND rw.source_table_name = '`+ strSourceTableName +`' 
                         AND nw.committimestamp >= rw.committimestamp
                         AND COALESCE(processed,0) = 0
                         AND JOBID = `+PJOBID+` ;`;               
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();      

           
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
           return_array.push(strSQLText);     
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();        
           //Update processed
           strSQLText = `UPDATE raw.awsdms_cdc_raw rw 
                         SET processed = 1 , comments = 'Merged Jobid:' `+numMaxJobId+`
                         FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp nw
                         WHERE nw.` + strSourceTablePK + ` = rw.pk_id AND rw.source_table_name = '`+ strSourceTableName +`' 
                         AND nw.committimestamp >= rw.committimestamp
                         AND COALESCE(processed,0) = 0
                         AND JOBID = `+PJOBID+` ;`;               
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();      
           
           strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz)                              
                         SELECT `+ refJobId +`,'`+ strProcessName +`', CONCAT('CDC Process completed. ',num_rows,' records updated for table ',srctab_name),1, current_timestamp()
                         FROM (SELECT COUNT(`+ strSourceTablePK +`) num_rows,'`+ strSourceTableName +`' srctab_name FROM ` + strRawTableSchema + `.` + strSourceTableName +`_cdc_temp nw);`;                                      
            return_array.push(strSQLText);
           strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
           ret_value = strSQLStmt.execute();              
              
           
         }
         catch (err)  {             
             
             //snowflake.execute( {sqlText: "ROLLBACK;"} );
             
             //Update job info
             strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + refJobId + `;`  ;
            return_array.push(strSQLText);
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();  
     
             strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                           VALUES(` + refJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
            return_array.push(strSQLText);
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute(); 

              vMessage='FAIL:' + numMaxJobId + ':Err:'+err.message.replace(/'/g,"").substr(0,1000);
             strSQLText = updateJobSql.replace('REPLACE_COMMENTS',vMessage);
             strSQLText = strSQLText.replace('REPLACE_EVENT','MergeUpdate:');
             strSQLText = strSQLText.replace('REPLACE_JOBID',numMaxJobId);
            return_array.push(strSQLText);
             strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
             ret_value = strSQLStmt.execute();  
                 
                  if (ISTASK == 'Y') {
                  taskStmt = `call system$set_return_value('`+vMessage+`');`;
                  snowflake.execute( {sqlText: taskStmt});
                  }            

             return_array.push(vMessage);
             return return_array;
          }
        };   
      } 
  catch (err)  {          
     //snowflake.execute( {sqlText: "ROLLBACK;"} );
             
     //Update job info
     strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'FAILED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + refJobId + `;`  ;
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            return_array.push(strSQLText);
     ret_value = strSQLStmt.execute();  
     
     strSQLText = `INSERT INTO CONTROL.paieb_comment_log(jobid,jobname,comments,comment_rowid,create_ntz) 
                    VALUES(` + refJobId +`,'`+ strProcessName +`','CDC processing failed for table `+ strSourceTableName +`.',1,current_timestamp());`;
            return_array.push(strSQLText);
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();       
     
      vMessage='FAIL:' + numMaxJobId + ':Err:'+err.message.replace(/'/g,"").substr(0,1000);
     strSQLText = updateJobSql.replace('REPLACE_COMMENTS',vMessage);
     strSQLText = strSQLText.replace('REPLACE_EVENT','MergeUpdate:');
   strSQLText = strSQLText.replace('REPLACE_JOBID',numMaxJobId);
            return_array.push(strSQLText);
     strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     ret_value = strSQLStmt.execute();  
      if (ISTASK == 'Y') {
      taskStmt = `call system$set_return_value('`+vMessage+`');`;
      snowflake.execute( {sqlText: taskStmt});
      }            

      return_array.push(vMessage);
     return return_array;
  }
  
  strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = 'COMPLETED',status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + refJobId + `;`  ;
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});          
          ret_value = strSQLStmt.execute();   
              
   vMessage = 'Success:'+numMaxJobId;
                
   strSQLText = updateJobSql;
   strSQLText = strSQLText.replace('REPLACE_COMMENTS',vMessage);
   strSQLText = strSQLText.replace('REPLACE_EVENT','MergeUpdate:');
   strSQLText = strSQLText.replace('REPLACE_JOBID',numMaxJobId);
                
            return_array.push(strSQLText);
   strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
   ret_value = strSQLStmt.execute();  
  //snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Success:" + numMaxJobId);
  return return_array; /* SUCCESS */  
  $$;
   
