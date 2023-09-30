create or replace procedure control.MERGE_FULL_PQ(SOURCETABLENAME VARCHAR, ISTASK varchar, PJOBID varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  
  //Vars
  var strCtlTableSchema = 'CONTROL';
  var strmainjobname = 'FULL_LOAD';
  var strjobname = 'MERGE_FULL_PQ';
  var numMaxJobId;
  var strStageName = "";
  var strAwsFolder = "";
  var strPqSchema = "";
  var strTargetSchema = "";
  var strTableName = "";
  var strFullStage = "";
  var sourceTableName = SOURCETABLENAME; //input
  var return_array = [];
  var previousMessage = "";
  var vMessage = "";
  var taskStmt = "";
  var successTaskMsg = 'SUCCESS';
  var failTaskMsg = 'FAIL';
  var insertlog = '0';
  
//defines where the source is and target is
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var dbtablename = SOURCETABLENAME;
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";
log(0, 'Input table name = ' + dbtablename);

//new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '')

function logerr(rowid, msg){
      return_array.push(msg);
      var vmsg = msg.substr(1,2000);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['E', numMaxJobId, strjobname, rowid,  vmsg] } ).execute();
} 

//log
function log(rowid, msg){
  if (insertlog == '1' || rowid == 1) {
  if (msg != null) { 
      var vmsg = msg.substr(1,2000);
      return_array.push(msg);
      if (typeof numMaxJobID == 'undefined') {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', 0, strjobname, rowid,  vmsg] } ).execute();
      }
      else {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', numMaxJobId, strjobname, rowid,  vmsg] } ).execute();
      }
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
          /*
          var result = "";
          for(i=1;i<=ret_value.getColumnCount();i++) {
            result += ret_value.getColumnName(i) +'='+ret_value.getColumnValue(i)+'; ';
            
          }
          log(0, result);
        */
        
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
          //Insert Job info
          
          //Get JobId
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
           strFullStage = '@' + strStageName + strAwsFolder ;
           log(0, 'SourceTableName:' + strTableName);
         
      }
      else {
            vMessage='FAIL:Full Load job record found:' + numMaxJobId;
            log(0, vMessage);
             log(0, 'MergeData-' + vMessage);
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
             log(0, 'MergeData:'+vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
     } 
    log(0, 'Job id found = ' + numMaxJobId);
    successTaskMsg += ':' + numMaxJobId;

        if (strTableName != 'ALL' && strTableName != sourceTableName) {
          vMEssage='FAIL:Nothing to do';
             log(0, vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
        }    
        
    try {
        var primaryKeyColumn = "";
        var primaryKeyLimit = "";
        var mergeStr = "";

        var updateJobSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set 
                         comments = comments || CHR(10) || 'REPLACE_TABLENAME REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                            || CHR(10) || 'REPLACE_COMMENTS'
                                  where s.jobid = REPLACE_JOBID;`;
        
        var updateS3Sql = `update ` + strCtlTableSchema + `.paieb_s3_files_to_ingest s set processed = 1
                        , comments = comments || CHR(10) || 'Merged:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                            || CHR(10) || 'REPLACE_COMMENTS'
                                  where s.table_name = 'REPLACE_TABLENAME' and s.jobid = REPLACE_JOBID;`;
        
          strSQLText = `SELECT primary_key_column, primary_key_limit
                     , replace(replace(merge_str,'SRC_SCHEMANAME','`+strPqSchema+`'),'TGT_SCHEMANAME','`+strTargetSchema+`')  merge_str
                        FROM ` + strCtlTableSchema + `.` + `paieb_awsdms_tables_list s  
                        WHERE source_table_name = '`+ sourceTableName + `';`;
                        
                        
          log( 0, 'sql = ' + strSQLText);              
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
          ret_value = strSQLStmt.execute();
          //ret_value.next();      
          if (ret_value.next()) {
              primaryKeyColumn = ret_value.getColumnValue('PRIMARY_KEY_COLUMN');
              primaryKeyLimit = ret_value.getColumnValue('PRIMARY_KEY_LIMIT');
              mergeStr = ret_value.getColumnValue('MERGE_STR');
              //break; //handle first table alone
          }
          else {
              vMessage='FAIL:Not able to get SQL';
              log(0, vMessage);
              if (ISTASK == 'Y') {
                  taskStmt = `call system$set_return_value('`+vMessage+`');`;
                  snowflake.execute( {sqlText: taskStmt});
              }            
              return return_array;
          }

            snowflake.execute( {sqlText: "BEGIN;"} );
            log( 0, mergeStr);
            strSQLStmt = snowflake.createStatement({sqlText: mergeStr });   
            ret_value = strSQLStmt.execute();
            if(ret_value.next()) {
                var vjsonres = JSON.stringify(Object.assign({}, ret_value));
                 log(0, 'MergeData:'+ vjsonres);
                 successTaskMsg += ':MergeResult=' + vjsonres;
                 updateS3Sql = updateS3Sql.replace('REPLACE_COMMENTS','MergeResult:'+vjsonres);
                 updateS3Sql = updateS3Sql.replace('REPLACE_TABLENAME',sourceTableName);
                 updateS3Sql = updateS3Sql.replace('REPLACE_JOBID',numMaxJobId);

                  log( 0, updateS3Sql);
                  strSQLStmt = snowflake.createStatement({sqlText: updateS3Sql });   
                  ret_value = strSQLStmt.execute();

                   var updJobSql = updateJobSql.replace('REPLACE_COMMENTS','MergeResult:'+vjsonres);
                   updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
                   updJobSql = updJobSql.replace('REPLACE_TABLENAME',sourceTableName);
                   updJobSql = updJobSql.replace('REPLACE_EVENT','Merged');
                      
                    log( 0, updJobSql);
                    strSQLStmt = snowflake.createStatement({sqlText: updJobSql });   
                    ret_value = strSQLStmt.execute();

                  snowflake.execute( {sqlText: "COMMIT;"} );

            }     

    }
          catch (err)  {             
                snowflake.execute( {sqlText: "ROLLBACK;"} );
             vMessage='FAIL:'+err.message.replace(/'/g,"");               
             logerr(1, vMessage);
             log(0, 'MergeData:'+vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
     } 

      taskStmt = `call system$set_return_value('REPLACE_SUCCESSMESSAGE');`;
      taskStmt = taskStmt.replace('REPLACE_SUCCESSMESSAGE',successTaskMsg);
      if (ISTASK == 'Y') {
                snowflake.execute( {sqlText: taskStmt});
      }            
      log(0, successTaskMsg);
 return return_array; /* SUCCESS */  
  $$;
    


