create or replace procedure control.START_JOB(stageName varchar, awsfolder varchar, jobname varchar, istask varchar)
  //returns VARCHAR
  returns array
  language javascript
  execute as caller
  as
  $$
  
  //Vars
  var strCtlTableSchema = 'CONTROL';
  var strjobname = JOBNAME;
  var numMaxJobId = 0;
  var inparam1 = STAGENAME;
  var inparam2 = AWSFOLDER;
  var vMessage = "";
  var return_array= [];
  var statusSQLStmt = `UPDATE control.paieb_job_ctrl SET params = OBJECT_INSERT(params, 'STATUS', '~PSTATUS~', true) WHERE jobid = PJOBID and params:FULL_STATUS::VARCHAR = 'STARTED';`;
  var taskStmt = "";
  
 //defines where the source is and target is
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";
   
  //log
  function log(rowid, msg){
    if (typeof numMaxJobID == 'undefined') {
        snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', 0, strjobname, rowid,  msg] } ).execute();
    }
    else {
    snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', numMaxJobId, strjobname, rowid,  msg] } ).execute();
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
              return_array.push('setSessionParam:'+pSql);
              //set local variables
              if (pName=='ROLE') {user_role=pValue;}
              if (pName=='DATABASE') {dbname = pValue;}
              if (pName=='SCHEMA') {schemaname = pValue;}
              if (pName=='WAREHOUSE') {dbwarehouse = pValue;}

        } catch(err) {
            strErrMsg = err.message.replace(/'/g,""); 
              return_array.push('setSessionParam:'+pSql+':Err:'+strErrMsg);
            logerr(1,strErrMsg);
        }
      }

   try {
      
      //Get JobId
      strSQLText = `SELECT MAX(jobid) load_job_id
                    FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                    WHERE jobname = '`+ strjobname + `'
                    AND status = 'STARTED';` ;       
      log(0, 'SQL = ' + strSQLText);
      return_array.push(strSQLText);
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
      ret_value = strSQLStmt.execute();
      ret_value.next();      
      numMaxJobId = ret_value.getColumnValue('LOAD_JOB_ID');
      return_array.push('Job id exists:' + numMaxJobId);
      
      if (numMaxJobId == null) {
          //Insert Job info
          snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});
          var vparams = '{ "STAGENAME":"'+STAGENAME+'" , "AWSFOLDER":"'+AWSFOLDER+'" , "SCHEMA_NAME":"'+schemaname+'"}';
          strSQLText = `INSERT INTO ` + strCtlTableSchema + `.paieb_job_ctrl(jobid,jobname,status,starttime, comments, params ) 
                        select CONTROL.PAIEB_JOB_SEQ.NEXTVAL,'`+strjobname+`','STARTED',current_timestamp(), 'Start: '||to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH'), parse_json('`+vparams+`');`;
          //strSQLText = strSQLText.replace('PPARAM',vparams);
          return_array.push(strSQLText);
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText });
          ret_value = strSQLStmt.execute();  
          
          //Get JobId
          strSQLText = `SELECT MAX(jobid) load_job_id
                        FROM ` + strCtlTableSchema + `.` + `paieb_job_ctrl s  
                        WHERE jobname = '`+ strjobname + `'
                        AND status = 'STARTED';` ;   
          //log(0, 'sql = ' + strSQLText);              
          strSQLStmt = snowflake.createStatement({sqlText: strSQLText});   
          ret_value = strSQLStmt.execute();
          ret_value.next();      
          numMaxJobId = ret_value.getColumnValue('LOAD_JOB_ID');
          log(0, 'Job id inserted = ' || numMaxJobId);

            snowflake.execute( {sqlText: "COMMIT;"} );           
      }
      else {
            
            log(0, 'Job id found = ' + numMaxJobId);
            snowflake.execute( {sqlText: "ROLLBACK;"} );
            vMessage = 'FAIL:Cannot Start:Exists already:' + numMaxJobId;
            return_array.push(vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
            return return_array;
            //return 'FAIL'; //vMessage;
      }
      
      } 
          catch (err)  {             
             var strErrMsg = err.message.replace(/'/g,"");               
             snowflake.execute( {sqlText: "ROLLBACK;"} );
             log(1, strErrMsg);
            vMessage = 'FAIL:Error:' + strErrMsg;
            return_array.push(vMessage);
            if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('`+vMessage+`');`;
                snowflake.execute( {sqlText: taskStmt});
            }            
            return return_array;
            //return 'FAIL';//vMessage;
     }
     
     statusSQLStmt = statusSQLStmt.replace('~PSTATUS~','SUCCESS');
     statusSQLStmt = statusSQLStmt.replace('PJOBID', numMaxJobId.toString());
     return_array.push(statusSQLStmt);
     snowflake.createStatement( { sqlText: statusSQLStmt } ).execute();
      
  vMessage = 'Success:Job id: ' + numMaxJobId;  
      if (ISTASK == 'Y') {
                taskStmt = `call system$set_return_value('SUCCESS:`+numMaxJobId+`');`;
                snowflake.execute( {sqlText: taskStmt});
      }            
  
  //return vMessage; //
  return_array.push(vMessage);
  return return_array; /* SUCCESS */  
  //return 'SUCCESS';
  $$;
  

