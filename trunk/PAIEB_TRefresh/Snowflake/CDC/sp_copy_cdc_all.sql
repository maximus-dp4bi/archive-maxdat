create or replace procedure control.copy_cdc_all(ISTASK varchar, PJOBID varchar, PRUN_MERGE varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  //Soundra 08102022
  //This SP copies the list of files in CDC which were not previously processed to paieb_s3_cdc_to_ingest
  //and runs copy into for source tablename and runs merge to target schema for insert records
  
  //Vars
  var strCtlTableSchema = 'CONTROL';
  var strmainjobname = 'CDC_LOAD';
  var strjobname = 'COPY_CDC_ALL';
  var numMaxJobId;
  var strStageName = "";
  var strAwsFolder = "";
  var strPqSchema = "";
  var strTargetSchema = "";
  var strTableName = "ALL";
  var strFullStage = "";
  var sourceTableName = ""; //input
  var runMerge = PRUN_MERGE;
  var return_array = [];
  var previousMessage = "";
  var vMessage = "";
  var taskStmt = "";
  var successTaskMsg = 'SUCCESS';
  var failTaskMsg = 'FAIL';
  var allSuccessTaskMsg = "";
  var allFailTaskMsg = "";
  
//defines where the source is and target is
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var dbtablename = "";;
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";
var currentTimestamp = "";
var vsupresslogs = 1;

    updateJobDone0Sql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set status = 'COMPLETE-0', status_time = current_timestamp(), end_time = current_timestamp(),
                     comments = comments || CHR(10) || 'Completed:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                              where s.jobid = REPLACE_JOBID;`;

log(0, 'Input table name = ' + dbtablename);

function logerr(rowid, msg){
      return_array.push(msg);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', numMaxJobId, strjobname, rowid,  msg] } ).execute();
} 

//log
function log(rowid, msg){
  if (msg != null) { 
      var vmsg = msg.substr(1,2000);
      return_array.push(msg);
      if (vsupresslogs != 1) {
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
           var prevMesgSub = previousMessage.toUpperCase();
           if (prevMesgSub.match(/NO FILES/gi)) {
              vMessage = previousMessage;
              taskStmt = `call system$set_return_value('`+vMessage+`');`;
              snowflake.execute( {sqlText: taskStmt});

              try{ 
                  var retarray = [];
                  retarray = previousMessage.split(':',2);
                  if (retarray.length >= 2) {
                    var val1 = retarray[0];
                    var val2 = retarray[1];
                    numMaxJobId = val2;
                   }
                   
                    var updJobSql = updateJobDone0Sql.replace('REPLACE_COMMENTS','Completed No Files: ');
                      updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
                      updJobSql = updJobSql.replace('REPLACE_EVENT','CDC ');
                                      
                      //log( 0, updJobSql);
                      strSQLStmt = snowflake.createStatement({sqlText: updJobSql});   
                      ret1 = strSQLStmt.execute();
              }
              catch(err){
                vMessage='FAIL:'+err.message.replace(/'/g,"");               
                logerr(1, vMessage);
              }
      
              log(0, vMessage);
              return return_array;
           }
           prevMesgSub = previousMessage.substring(0,4).toUpperCase();
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
          //strTableName = ret_value.getColumnValue('TABLENAME');
           strFullStage = '@' + dbname + '.' + schemaname + '.' + strStageName + strAwsFolder ;
           log(0, 'SourceTableName:' + strTableName);
         
      }
      else {
            vMessage='FAIL:Full Load job record found:' + numMaxJobId;
            log(0, vMessage);
             log(0, 'CopyCDCRaw-' + vMessage);
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
             log(0, 'CopyCDCRaw:'+vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
             return return_array;
     } 
    log(0, 'Job id found = ' + numMaxJobId);
    successTaskMsg += ':' + numMaxJobId  +':';

    var primaryKeyColumn = "";
    var primaryKeyLimit = "";
    var createPqTableStr = "";
    var copyPqTableStr = "";
    var alterPqTableStr = "";
    var updTableStr = "";
    var updateJobSql = "";
    var updateS3Sql = "";
    var filesSql = "";
    var mergeSql = "";
    var retwhile = "";
    var updateJobDoneSql = "";
        
    updateJobSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set 
                     comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                        || CHR(10) || 'REPLACE_COMMENTS'
                              where s.jobid = REPLACE_JOBID;`;
        
    updateJobDoneSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set status = 'COMPLETED', status_time = current_timestamp(), end_time = current_timestamp(),
                     comments = comments || CHR(10) || 'Completed:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                              where s.jobid = REPLACE_JOBID;`;

    updateS3Sql = `update ` + strCtlTableSchema + `.paieb_s3_cdc_to_ingest s set processed = REPLACE_PROCESSED ,
                     comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                        || CHR(10) || 'REPLACE_COMMENTS'
                              where s.table_name = 'REPLACE_TABLENAME' and s.jobid = REPLACE_JOBID;`;

    filesSql = `select array_to_string(array_construct_compact(listagg(''''||filename||'''',',')),'') filelist 
                    from (
                      select filename, ceil(abs(row_number() over (order by try_to_number(substr(filename,1,8) || substr(filename,10,8)), filename asc)/100)) rn from control.paieb_s3_cdc_to_ingest 
                        where jobid = REPLACE_JOBID
                        and table_name = 'REPLACE_TABLENAME'
                        and nvl(processed,0) = 0
                    )
                    group by rn;
                    `;


    var tableSql = `select source_table_name,primary_key_column, primary_key_limit 
                    , replace(replace(replace(cdc_copy_str,'REPLACE_PQSCHEMA','`+strPqSchema+`'),'REPLACE_STAGE','`+strFullStage+`'),'REPLACE_JOBID',`+numMaxJobId+`) copy_pq_table_str
                     from control.paieb_awsdms_tables_list aws
                   where exists (select 1 from control.paieb_s3_cdc_to_ingest cdc  
                                           where jobid = `+numMaxJobId+`
                                           and table_name = aws.source_table_name
                                           and nvl(processed,0) = 0)
                                           ;`;
    strSQLStmt = snowflake.createStatement({sqlText: tableSql });   
    retwhile = strSQLStmt.execute();
    while(retwhile.next()) {
    try {

        primaryKeyColumn = "";
        primaryKeyLimit = "";
        createPqTableStr = "";
        copyPqTableStr = "";
        alterPqTableStr = "";

        var tabFailed = 'N';
        sourceTableName = retwhile.getColumnValue('SOURCE_TABLE_NAME');
        primaryKeyColumn = retwhile.getColumnValue('PRIMARY_KEY_COLUMN');
        primaryKeyLimit = retwhile.getColumnValue('PRIMARY_KEY_LIMIT');
        copyPqTableStr = retwhile.getColumnValue('COPY_PQ_TABLE_STR');
        failTaskMsg = sourceTableName+':FAIL';

        //Get the files to copy
        var updfilesql = filesSql.replace('REPLACE_JOBID',numMaxJobId);
        updfilesql = updfilesql.replace('REPLACE_TABLENAME',sourceTableName);
        log(0, updfilesql);
            
        var filesfound = 'N';
        strSQLStmt = snowflake.createStatement({sqlText: updfilesql });   
        ret_value = strSQLStmt.execute();
        while(ret_value.next()) {
            var vfilesList = ret_value.getColumnValue('FILELIST');

            if (filesfound == 'N' && vfilesList != null) { filesfound = 'Y';}
                          
                log(0, 'Files List:'+ vfilesList.substr(1,1000));
                if (vfilesList != null) { 
                    var copySql = copyPqTableStr.replace('REPLACE_FILELIST',vfilesList);
                    
                    log( 0, copySql.substr(1,1000));
                    var ret_result = [];
                    strSQLStmt = snowflake.createStatement({sqlText: copySql });   
                    ret_result = strSQLStmt.execute();
                    if(ret_result.next()) {
                          var vjsonres = JSON.stringify(Object.assign({}, ret_result));
                          log(0, 'CopyPQData:'+ vjsonres.substr(0,1000));
                          //successTaskMsg += ':ListCreateCopyPQResult=' + vjsonres;
                          var upd2S3Sql = updateS3Sql.replace('REPLACE_COMMENTS','CreateResult:'+vjsonres);
                          upd2S3Sql = upd2S3Sql.replace('REPLACE_PROCESSED','1');
                          upd2S3Sql = upd2S3Sql.replace('REPLACE_TABLENAME',sourceTableName);
                          upd2S3Sql = upd2S3Sql.replace('REPLACE_JOBID',numMaxJobId);
                          upd2S3Sql = upd2S3Sql.replace('REPLACE_EVENT','CreatePQ');

                          log( 0, upd2S3Sql.substr(0,1000));
                          strSQLStmt = snowflake.createStatement({sqlText: upd2S3Sql });   
                          ret1 = strSQLStmt.execute();

                          var upd2JobSql = updateJobSql.replace('REPLACE_COMMENTS','Result:'+vjsonres);
                          upd2JobSql = upd2JobSql.replace('REPLACE_JOBID',numMaxJobId);
                          upd2JobSql = upd2JobSql.replace('REPLACE_EVENT','CopyResult for '+sourceTableName);
                          strSQLStmt = snowflake.createStatement({sqlText: upd2JobSql });   
                          ret1 = strSQLStmt.execute();

                          }
                                                              
                 }
        }//while files loop
        if (filesfound == 'Y') {
            var updCommitSql = `update `+strPqSchema+`.awsdms_cdc_raw set commit_ntz = to_timestamp_ntz(substr(committimestamp,1,19),'yyyy-mm-dd hh24:mi:ss'),
                                   commit_num = to_number(to_char(TO_timestamp_ntz(substr(committimestamp,1,19),'yyyy-mm-dd hh24:mi:ss'),'yyyymmddhh24miss'))
                                   where jobid = `+numMaxJobId+` and commit_ntz is null and source_table_name = '`+sourceTableName+`';`;
            strSQLStmt = snowflake.createStatement({sqlText: updCommitSql });   
            ret_value = strSQLStmt.execute();
        }
        }
        catch (err)  { 
            tabFailed = 'Y';
            vMessage='FAIL:'+err.message.replace(/'/g,"");               
            failTaskMsg = failTaskMsg + vMessage;
            logerr(1, vMessage);
            log(0, 'CopyCDCRaw:'+vMessage);
        }
    }//while Tables loop for copy

    if (filesfound == 'Y' || runMerge == 'Y') {
        var updJobSql = updateJobSql.replace('REPLACE_COMMENTS',' ');
        updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
        updJobSql = updJobSql.replace('REPLACE_EVENT','IUD Started: ');
        strSQLStmt = snowflake.createStatement({sqlText: updJobSql });   
        ret_value = strSQLStmt.execute();

        tableSql = `with oc as (
                          select source_table_name, operation, count(1) rcount
                          from raw.awsdms_cdc_raw rw
                          where jobid = `+numMaxJobId+`
                          group by source_table_name, operation
                          )
                          , ocl as (
                            select source_table_name, listagg(operation,'') within group (order by operation) oplist
                            , listagg(to_char(rcount),',') within group (order by operation) countlist
                          from oc
                          group by source_table_name
                          )
                          select aws.source_table_name,primary_key_column, primary_key_limit , oplist , countlist
                                              , replace(replace(cdc_upd_str,'REPLACE_PQSCHEMA','`+strPqSchema+`'),'REPLACE_JOBID',`+numMaxJobId+`) upd_table_str
                                               from control.paieb_awsdms_tables_list aws
                                               join ocl tl on tl.source_table_name = aws.source_table_name
                         ;`;
          strSQLStmt = snowflake.createStatement({sqlText: tableSql });   
          retwhile = strSQLStmt.execute();
          while(retwhile.next()) {
          try {

              primaryKeyColumn = "";
              primaryKeyLimit = "";
              createPqTableStr = "";
              updTableStr = "";
              var opList = "";
              var countList = "";
              
              var tabFailed = 'N';
              sourceTableName = retwhile.getColumnValue('SOURCE_TABLE_NAME');
              primaryKeyColumn = retwhile.getColumnValue('PRIMARY_KEY_COLUMN');
              primaryKeyLimit = retwhile.getColumnValue('PRIMARY_KEY_LIMIT');
              updTableStr = retwhile.getColumnValue('UPD_TABLE_STR');
              opList = retwhile.getColumnValue('OPLIST');
              countList = retwhile.getColumnValue('COUNTLIST');

              successTaskMsg += "\n" + sourceTableName + ' has '+ opList + ' (' + countList + ') '+ ' records';

                    //update commit_ntz
                      var updCommitSql = `update `+strPqSchema+`.awsdms_cdc_raw set commit_ntz = to_timestamp_ntz(substr(committimestamp,1,19),'yyyy-mm-dd hh24:mi:ss'),
                                             commit_num = to_number(to_char(TO_timestamp_ntz(substr(committimestamp,1,19),'yyyy-mm-dd hh24:mi:ss'),'yyyymmddhh24miss'))
                                             where jobid = `+numMaxJobId+` and commit_ntz is null and source_table_name = '`+sourceTableName+`';`;
                      strSQLStmt = snowflake.createStatement({sqlText: updCommitSql });   
                      ret_value = strSQLStmt.execute();
                      
                      if (opList.indexOf('I') != -1 || opList.indexOf('D') != -1) {
                      //below will build the merge sql for insert and delete         
                      mergeSql = `select source_table_name, primary_key_column, 'merge into `+strTargetSchema+`.'|| source_table_name || ' tgt using 
                                              (select operation, ' || select_list_str || ' from `+strPqSchema+`.awsdms_cdc_raw where source_table_name = '''|| source_table_name || ''' and operation in ( ''I'') and jobid = ' || `+numMaxJobId+` || ') src ' ||
                                        ' on tgt.' || primary_key_column || ' = src.'|| primary_key_column ||  
                                        ' when not matched and operation = ''I'' then insert (' || insert_into_str || ') values (' || insert_values_str || ');' merge_str
                                        , 'merge into `+strTargetSchema+`.'|| source_table_name || ' tgt using 
                                              (select operation, ' || select_list_str || ' from `+strPqSchema+`.awsdms_cdc_raw where source_table_name = '''|| source_table_name || ''' and operation in ( ''D'') and jobid = ' || `+numMaxJobId+` || ') src ' ||
                                        ' on tgt.' || primary_key_column || ' = src.'|| primary_key_column ||  
                                        ' when matched and operation = ''D'' then delete ' delete_str
                                        from (                
                                        select  source_table_name, primary_key_column, listagg( 
                                        case when data_type = 'TIMESTAMP_NTZ' then 'to_timestamp(substr(parse_json(raw):'|| column_name || '::VARCHAR,1,19), ''YYYY-MM-DD HH24:MI:SS'') ' || column_name
                                        else 'parse_json(raw):'|| column_name || '::' || data_type || ' ' || column_name end 
                                        ,', ') within group (order by ordinal_position) select_list_str
                                        , listagg(column_name ,', ') within group (order by ordinal_position) insert_into_str       
                                        , listagg('src.'|| column_name, ', ') within group (order by ordinal_position) insert_values_str
                                        , listagg('tgt.'|| column_name || ' = src.' || column_name, ', ')  within group (order by ordinal_position) update_str      
                                        from information_schema.columns intab
                                        join control.paieb_awsdms_tables_list aws on aws.source_table_name = intab.table_name
                                        where table_schema = '`+strTargetSchema+`' 
                                        and source_table_name = '`+sourceTableName+`'
                                        group by source_table_name, primary_key_column
                                        );
                                        `;
                      log(0, mergeSql);
                                  
                      strSQLStmt = snowflake.createStatement({sqlText: mergeSql });   
                      ret_value = strSQLStmt.execute();
                      if (ret_value.next()) {
                          var mergeStr = ret_value.getColumnValue('MERGE_STR');
                          var deleteStr = ret_value.getColumnValue('DELETE_STR');
                           
                        if (opList.indexOf('I') != -1) {
                            strSQLStmt = snowflake.createStatement({sqlText: mergeStr});
                            ret_result = strSQLStmt.execute();
                            if (ret_result.next()) {
                                  var vjsonres = JSON.stringify(Object.assign({}, ret_result));
                                  log(0, 'MergeData:'+ vjsonres);
                                  successTaskMsg += vjsonres;
                              }  
                          }
                        
                          if (opList.indexOf('D') != -1) {
                              strSQLStmt = snowflake.createStatement({sqlText: deleteStr});
                              ret_result = strSQLStmt.execute();
                              if (ret_result.next()) {
                                    var vjsonres = JSON.stringify(Object.assign({}, ret_result));
                                    log(0, 'DeleteData:'+ vjsonres);
                                    successTaskMsg += vjsonres;
                                }  
                            }
                        
                      }
                      }//indexof check

                      if (opList.indexOf('U') != -1) {
                        log(0, updTableStr);
                        strSQLStmt = snowflake.createStatement({sqlText: updTableStr});
                        ret_result = strSQLStmt.execute();
                        if (ret_result.next()) {
                              var vjsonres = JSON.stringify(Object.assign({}, ret_result));
                              log(0, 'UpdateData:'+ vjsonres);
                              successTaskMsg += vjsonres;
                        }
                      }
              }
              catch (err)  { 
                  tabFailed = 'Y';
                  vMessage='FAIL:'+err.message.replace(/'/g,"");               
                    failTaskMsg = failTaskMsg + vMessage;
                  logerr(1, vMessage);
                  log(0, 'CopyCDCRaw:'+vMessage);

                  //continue;
               }
        }//while tables list for merge
        var updJobSql = updateJobSql.replace('REPLACE_COMMENTS',successTaskMsg);
        updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
        updJobSql = updJobSql.replace('REPLACE_EVENT','IUD: ');
        strSQLStmt = snowflake.createStatement({sqlText: updJobSql });   
        ret_value = strSQLStmt.execute();

    }   //files found and runMerge

    if (filesfound == 'N' && runMerge == 'N') {
      tabFailed = 'Y';
      vMessage='FAIL:No Action:' + numMaxJobId;
      failTaskMsg = failTaskMsg + ':No Action:' + numMaxJobId;
      log(0, 'CopyCDCRaw:'+vMessage);
    }

    if (tabFailed == 'Y') {
        if (allFailTaskMsg == null) {
            allFailTaskMsg = failTaskMsg;
          }
          else {
            allFailTaskMsg += failTaskMsg;
          }   
    }
    else {  
        if (allSuccessTaskMsg == null) {
            allSuccessTaskMsg = successTaskMsg;
          }
          else {
            allSuccessTaskMsg += successTaskMsg;
          }   
    } 
     
     if (allFailTaskMsg != null) {
          allSuccessTaskMsg += ' ' + allFailTaskMsg;
     }
      taskStmt = `call system$set_return_value('REPLACE_SUCCESSMESSAGE');`;
      taskStmt = taskStmt.replace('REPLACE_SUCCESSMESSAGE',allSuccessTaskMsg);
      if (ISTASK == 'Y') {
                snowflake.execute( {sqlText: taskStmt});
      }            
      log(0, allSuccessTaskMsg);
     try{ 
        var updJobSql = updateJobDoneSql.replace('REPLACE_COMMENTS','Completed ');
        updJobSql = updJobSql.replace('REPLACE_JOBID',numMaxJobId);
        updJobSql = updJobSql.replace('REPLACE_EVENT','CDC ');
                        
        //log( 0, updJobSql);
        strSQLStmt = snowflake.createStatement({sqlText: updJobSql});   
        ret1 = strSQLStmt.execute();
      }
      catch(err){
        vMessage='FAIL:'+err.message.replace(/'/g,"");               
        logerr(1, vMessage);
      }

      return return_array; /* SUCCESS */  
  $$;
                                           
