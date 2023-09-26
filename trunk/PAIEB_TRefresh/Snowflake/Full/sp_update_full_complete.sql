create or replace procedure control.UPDATE_JOB_COMPLETE(ISTASK varchar, PJOBID varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  
  //Vars
  var strCtlTableSchema = 'CONTROL';
  var strmainjobname = 'FULL_LOAD';
  var strjobname = 'UPDATE_JOB_COMPLETE';
  var numMaxJobId;
  var strStageName = "";
  var strAwsFolder = "";
  var strPqSchema = "";
  var strTargetSchema = "";
  var strTableName = "";
  var strFullStage = "";
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
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";

//new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '')

function logerr(rowid, msg){
      return_array.push(msg);
      var vmsg = msg.substr(1,2000);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', numMaxJobId, strjobname, rowid,  vmsg] } ).execute();
} 

//log
function log(rowid, msg){
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

       if (ISTASK =='Y') {
          //if task is yes get the jobid from predecessor
           //cannot use predecessor
           //ret_value = snowflake.execute({sqlText: "select system$get_predecessor_return_value() PREVMSG from dual" });
              strSQLText = `SELECT MAX(jobid) LOAD_JOB_ID
                            FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                            WHERE jobname = '`+ strmainjobname + `'
                            AND status = 'STARTED';` ;       
              log(0, strSQLText);
              strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
              ret_value = strSQLStmt.execute();
              ret_value.next();      
              numMaxJobId = ret_value.getColumnValue('LOAD_JOB_ID');
              log(0, 'Job id Standalone:'+numMaxJobId);
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
          
          try {
              var updateJobSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set status='COMPLETED', status_time = current_timestamp(), end_time = current_timestamp(),
                   comments = comments || CHR(10) || 'REPLACE_EVENT:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
                            where s.jobid = REPLACE_JOBID;`;

              snowflake.execute( {sqlText: "BEGIN;"} );

              var updJobSql = updateJobSql.replace('REPLACE_JOBID',numMaxJobId);
              updJobSql = updJobSql.replace('REPLACE_EVENT','Completed');
                                    
              log( 0, updJobSql);
              strSQLStmt = snowflake.createStatement({sqlText: updJobSql });   
              ret_value = strSQLStmt.execute();

              snowflake.execute( {sqlText: "COMMIT;"} );
          }
          catch (err)  {             
              snowflake.execute( {sqlText: "ROLLBACK;"} );
            vMessage = 'FAIL:'+err.message.replace(/'/g,"");               
            log(0, 'MergeData:'+vMessage);
            if (ISTASK == 'Y') {
              taskStmt = `call system$set_return_value('`+vMessage+`');`;
              snowflake.execute( {sqlText: taskStmt});
            }            
            return return_array;
          }
       }   
          
      taskStmt = `call system$set_return_value('REPLACE_SUCCESSMESSAGE');`;
      taskStmt = taskStmt.replace('REPLACE_SUCCESSMESSAGE',successTaskMsg);
      if (ISTASK == 'Y') {
                snowflake.execute( {sqlText: taskStmt});
      }            
      log(0, successTaskMsg);

return return_array; /* SUCCESS */  
  $$;
    

