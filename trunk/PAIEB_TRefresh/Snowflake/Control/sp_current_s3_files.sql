create or replace procedure control.SP_CURRENT_S3_FILES(stagename varchar, awsfolder varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  
  //Vars
  //Tablename come from job record params variant
  
  var strCtlTableSchema = 'CONTROL';
  var strjobname = 'SP_CURRENT_S3_FILES';
  var numMaxJobId;
  var strStageName = STAGENAME;
  var strAwsFolder = AWSFOLDER;
  var strPqSchema = "";
  var strTargetSchema = "";
  var strTableName = "";
  var strReingest = "";
  var strFullStage = "";
  var return_array = [];
  var previousMessage = "";
  var vMessage = "";
  var successTaskMsg = 'SUCCESS';
  var failTaskMsg = 'FAIL';
var v1;

//defines where the source is and target is
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var strSQLStmt = "";
var strtablelist = "";
var vreccount = '0';
var updateJobSql = `update ` + strCtlTableSchema + `.paieb_job_ctrl s set status = 'REPLACE_STATUS' 
, comments = comments || CHR(10) || 'Current S3 Files:' || to_char(current_timestamp(),'YYYY/MM/DD HH24:MI:SS TZH') 
    || CHR(10) || 'REPLACE_COMMENTS'
          where s.jobid = REPLACE_JOBID;`;

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

 
   try {
      
          if (numMaxJobId == null) {
              //Insert Job info
              snowflake.execute( {sqlText: "BEGIN;"});
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
      } 
          catch (err)  {             
             vMessage = 'FAIL:'+err.message.replace(/'/g,"");               
             log(0, 'MergeData:'+vMessage);
             return return_array;
     } 
    log(0, 'Job id = ' + numMaxJobId);

    try {
        strFullStage = '@' + dbname +'.'+ schemaname +'.'+ strStageName + strAwsFolder;
        var listStr = "list "+ strFullStage + " pattern='.*/*parquet';";
        
        var insertStr = `insert into control.paieb_current_s3_contents (
                        stage_name 
                        ,aws_folder
                        ,full_path 
                        ,file_name 
                        ,folder_name 
                        ,size 
                        ,last_modified 
                        ,last_modified_ntz 
                        ,md5 
                        , jobid
                        ,create_ntz 
                        )
                        (
                        select '`+strStageName+`', '`+strAwsFolder+`', fullpath, filename, foldername, size, modified_timestamp, modified_timestamp_ntz, md5, `+numMaxJobId+` jobid , current_timestamp() from 
                               (with parquet as ( 
                                   select split_part("name",'/','-2') as foldername 
                                   ,"name" as fullpath  
                                   ,split_part(\"name\",'/','-1') as filename 
                                   ,"size" as size 
                                   ,"last_modified" as modified_timestamp 
                                   ,"md5" as md5
                                   ,convert_timezone('UTC','America/New_York',to_timestamp(rtrim("last_modified",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) modified_timestamp_NTZ 
                                   FROM table(result_scan(last_query_id())) lsid 
                                   order by "last_modified"     
                               ) 
                             select pt.filename, pt.fullpath 
                             , foldername
                             ,modified_timestamp           
                             ,modified_timestamp_ntz 
                             ,pt.size 
                             , md5
                             from parquet pt 
                             )
                             );`;
                        
        snowflake.execute( {sqlText: "BEGIN;"} );

        log( 0, listStr);
        log( 0, insertStr);
        //List and merge should happen one after another
        snowflake.execute( {sqlText: "BEGIN;"});
        pSql = 'delete from control.paieb_current_s3_contents;';
          strSQLStmt = snowflake.createStatement({sqlText: pSql });   
          ret_value = strSQLStmt.execute();
          strSQLStmt = snowflake.createStatement({sqlText: listStr });   
          ret_value = strSQLStmt.execute();
          strSQLStmt = snowflake.createStatement({sqlText: insertStr });   
          ret_value = strSQLStmt.execute();
          pSql = updateJobSql;
          pSql = pSql.replace('REPLACE_COMMENTS','Result:Completed ');
          pSql = pSql.replace('REPLACE_STATUS','COMPLETED');
          pSql = pSql.replace('REPLACE_JOBID',numMaxJobId);
          log( 0, pSql);
          strSQLStmt = snowflake.createStatement({sqlText: pSql });   
          ret_value = strSQLStmt.execute();
          snowflake.execute( {sqlText: "COMMIT;"} );
          }     
    catch (err)  {             
          snowflake.execute( {sqlText: "ROLLBACK;"} );
       vMessage='FAIL:'+v1 +err.message.replace(/'/g,"");               
       logerr(1, vMessage);
       log(0, 'ListData:'+vMessage);
            pSql = updateJobSql;
            pSql = pSql.replace('REPLACE_COMMENTS','Result:'+vMessage);
            pSql = pSql.replace('REPLACE_STATUS','ERRORED');
            pSql = pSql.replace('REPLACE_JOBID',numMaxJobId);

            log( 0, pSql);
            strSQLStmt = snowflake.createStatement({sqlText: pSql });   
            ret_value = strSQLStmt.execute();
       return return_array;
    } 

    log(0, successTaskMsg);
    return return_array; /* SUCCESS */  
  $$;
    

