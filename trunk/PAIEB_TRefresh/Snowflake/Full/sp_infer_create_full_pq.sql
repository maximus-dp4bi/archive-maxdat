create or replace procedure control.INFER_CREATE_FULL_PQ(SOURCETABLENAME VARCHAR, ISTASK varchar, PJOBID varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  
  //Vars
  var strCtlTableSchema = 'CONTROL';
  var strmainjobname = 'FULL_LOAD';
  var strjobname = 'INFER_CREATE_FULL_PQ';
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

function logerr(rowid, msg){
    if (msg != null) {
        return_array.push(msg);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['E', numMaxJobId, strjobname, rowid,  msg] } ).execute();
    }
} 

//log
function log(rowid, msg){
  if (insertlog == '1' || rowid == 1) {
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
           strFullStage = '@' + dbname + '.' + schemaname + '.' + strStageName + strAwsFolder ;
           log(0, 'SourceTableName:' + strTableName);
         
      }
      else {
            vMessage='FAIL:Full Load job record found:' + numMaxJobId;
            log(0, vMessage);
             log(1, 'InferPQschema-' + vMessage);
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
             log(1, 'InferPQschema:'+vMessage);
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
             log(1, vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
        }    
        
    try {
        var primaryKeyColumn = "";
        var primaryKeyLimit = "";
        var createPqTableStr = "";
        var copyPqTableStr = "";
        var alterPqTableStr = "";
        var dropPqTableStr = `drop table if exists `+strPqSchema+`.`+sourceTableName+`_pq;`;

        var updateJobSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set 
                         comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                            || CHR(10) || 'REPLACE_COMMENTS'
                                  where s.jobid = REPLACE_JOBID;`;
        
        var updateS3Sql = `update ` + strCtlTableSchema + `.paieb_s3_files_to_ingest s set 
                         comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                            || CHR(10) || 'REPLACE_COMMENTS'
                                  where s.table_name = 'REPLACE_TABLENAME' and s.jobid = REPLACE_JOBID;`;
        
          strSQLText = `SELECT primary_key_column, primary_key_limit
                     , replace(replace(create_pq_table_str,'~PQSCHEMA~','`+strPqSchema+`'),'~PQSTAGE~','`+strFullStage+`')  create_pq_table_str
                     , replace(replace(copy_pq_table_str,'~PQSCHEMA~','`+strPqSchema+`'),'~PQSTAGE~','`+strFullStage+`') copy_pq_table_str
                     , replace(replace(alter_pq_table_str,'~PQSCHEMA~','`+strPqSchema+`'),'~PQSTAGE~','`+strFullStage+`') alter_pq_table_str
                        FROM ` + strCtlTableSchema + `.` + `paieb_awsdms_tables_list s  
                        WHERE source_table_name = '`+ sourceTableName + `';`;
                        
          log( 0, 'sql = ' + strSQLText);              
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
          ret_value = strSQLStmt.execute();
          //ret_value.next();      
          if (ret_value.next()) {
              primaryKeyColumn = ret_value.getColumnValue('PRIMARY_KEY_COLUMN');
              primaryKeyLimit = ret_value.getColumnValue('PRIMARY_KEY_LIMIT');
              createPqTableStr = ret_value.getColumnValue('CREATE_PQ_TABLE_STR');
              alterPqTableStr = ret_value.getColumnValue('ALTER_PQ_TABLE_STR');
              copyPqTableStr = ret_value.getColumnValue('COPY_PQ_TABLE_STR');
              //break; //handle first table alone
          }
          else {
          //if (createPqTableStr == null ) {
               vMessage='FAIL:Not able to get Create SQL';
             log(1, vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
          }

            snowflake.execute( {sqlText: "BEGIN;"} );

            log( 0, dropPqTableStr);
            strSQLStmt = snowflake.createStatement({sqlText: dropPqTableStr });   
            ret_value = strSQLStmt.execute();
            
            log( 0, createPqTableStr);
            strSQLStmt = snowflake.createStatement({sqlText: createPqTableStr });   
            ret_value = strSQLStmt.execute();
            if(ret_value.next()) {
                var vjsonres = JSON.stringify(Object.assign({}, ret_value));
                 log(0, 'CreatePQTable:'+ vjsonres);
                 var updS3Sql = updateS3Sql.replace('REPLACE_COMMENTS','CreateResult:'+vjsonres);
                 updS3Sql = updS3Sql.replace('REPLACE_TABLENAME',sourceTableName);
                 updS3Sql = updS3Sql.replace('REPLACE_JOBID',numMaxJobId);
                 updS3Sql = updS3Sql.replace('REPLACE_EVENT','CreatePQTable');

                  //log( 0, updS3Sql);
                  //strSQLStmt = snowflake.createStatement({sqlText: updS3Sql });   
                  //ret_value = strSQLStmt.execute();
                  
                  var updJobSql = updateJobSql.replace('REPLACE_COMMENTS','CreateResult:'+vjsonres);
                   updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
                   updJobSql = updJobSql.replace('REPLACE_EVENT','CreatePQTable');
                      
                    //log( 0, updJobSql);
                    //strSQLStmt = snowflake.createStatement({sqlText: updJobSql });   
                    //ret_value = strSQLStmt.execute();
                  
            }

             log( 0, copyPqTableStr);
            strSQLStmt = snowflake.createStatement({sqlText: copyPqTableStr });   
            ret_value = strSQLStmt.execute();
            if(ret_value.next()) {
                var vjsonres = JSON.stringify(Object.assign({}, ret_value));
                 log(0, 'CopyPQData:'+ vjsonres);
                 successTaskMsg += ':ListCreateCopyPQResult=' + vjsonres;
                 var upd2S3Sql = updateS3Sql.replace('REPLACE_COMMENTS','CreateResult:'+vjsonres);
                 upd2S3Sql = upd2S3Sql.replace('REPLACE_TABLENAME',sourceTableName);
                 upd2S3Sql = upd2S3Sql.replace('REPLACE_JOBID',numMaxJobId);
                 upd2S3Sql = upd2S3Sql.replace('REPLACE_EVENT','CreatePQ');

                  //log( 0, upd2S3Sql);
                  //strSQLStmt = snowflake.createStatement({sqlText: upd2S3Sql });   
                  //ret_value = strSQLStmt.execute();
                  
                  var upd2JobSql = updateJobSql.replace('REPLACE_COMMENTS','CopyResult:'+vjsonres);
                   upd2JobSql = upd2JobSql.replace('REPLACE_JOBID',numMaxJobId);
                   upd2JobSql = upd2JobSql.replace('REPLACE_EVENT','CopyPQ');
                      
                    log( 0, updateJobSql);
                    try {
                    strSQLStmt = snowflake.createStatement({sqlText: upd2JobSql });   
                    ret_value = strSQLStmt.execute();
                    }
                    catch(err) {
                      strSQLStmt = snowflake.createStatement({sqlText: `call system$wait(2, 'MINUTES')` });
                      ret_value = strSQLStmt.execute();
                      strSQLStmt = snowflake.createStatement({sqlText: upd2JobSql });   
                      ret_value = strSQLStmt.execute();
                    }

            }

            snowflake.execute( {sqlText: "COMMIT;"} );
    
    }
          catch (err)  { 
                snowflake.execute( {sqlText: "ROLLBACK;"} );
             vMessage='FAIL:'+err.message.replace(/'/g,"");               
             logerr(1, vMessage);
             log(1, 'InferPQschema:'+vMessage);
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
      log(1, successTaskMsg);
 return return_array; /* SUCCESS */  
  $$;
