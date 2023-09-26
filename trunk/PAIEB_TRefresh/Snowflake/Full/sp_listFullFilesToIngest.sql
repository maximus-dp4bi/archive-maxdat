  CREATE or replace PROCEDURE control.listFullFilesToIngest(tableName varchar, stageName varchar, PJOBID varchar, REINGEST_FLAG varchar)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  try {
var vjobname = "listFullFilesToIngest";
var vjobid = PJOBID;
var sqlDelete = "";

//defines where the source is and target is
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var dbtablename = TABLENAME;
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";
log(0, 'Input table name = ' + dbtablename);

function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

function logerr(rowid, msg){
      return_array.push(msg);
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', vjobid, strjobname, rowid,  msg] } ).execute();
} 

//log
function log(rowid, msg){
  if (msg != null) { 
      return_array.push(msg);
      if (typeof numMaxJobID == 'undefined') {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', 0, strjobname, rowid,  msg] } ).execute();
      }
      else {
      snowflake.createStatement( { sqlText: `call control.do_log(:1, :2, :3, :4, :5)`, binds:['C', vjobid, strjobname, rowid,  msg] } ).execute();
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
       

//get date string for today
     var today_local = new Date();
     var today = convertTZ(today_local,'America/New_York')
     var dd = String(today.getDate()).padStart(2, '0');
     var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
     var yyyy = today.getFullYear();
     var hh = String(today.getHours());
     var todayDateString = yyyy + mm + dd;

    sqlCommand = "list @"+dbname+'.'+schemaname+'.'+ STAGENAME + TABLENAME + "/ pattern='.*/*parquet';";
    if (TABLENAME == "ALL"){
        sqlCommand = "list @"+ STAGENAME +" pattern='.*/*parquet';";
    }
    log(0, sqlCommand);
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        strErrMsg = err.message.replace(/'/g,"");  
        logerr(  0, "Failed to list files table "+TABLENAME+": "+ strErrMsg.substr(0,10000)); 
        return "Fail";
        }

    sqlCommand = " Merge into control.paieb_s3_files_to_ingest tgt \
                using ( \
              select tablename, fullpath, filename, psize, modified_timestamp, modified_timestamp_ntz, 0 processed, nvl(try_to_number('"+PJOBID+"'),0) jobid  from (\
                     with parquet as ( \
                    select split_part(\"name\",'/','-2') as tablename \
                    ,\"name\" as fullpath  \
                    ,split_part(\"name\",'/','-1') as filename \
                    ,\"size\" as psize \
                    ,\"last_modified\" as modified_timestamp \
                    ,convert_timezone('UTC','America/New_York',to_timestamp(rtrim(\"last_modified\",' GMT'),'DY, DD MON YYYY HH24:MI:SS')) modified_timestamp_NTZ \
                    FROM table(result_scan(last_query_id())) lsid \
                    order by \"last_modified\" \
                    ) \
                    select pt.tablename,pt.filename, pt.fullpath \
                    ,modified_timestamp \
                    ,modified_timestamp_ntz \
                    ,pt.psize \
                    from parquet pt \
                         where '"+REINGEST_FLAG+"' = 'Y' \
                         or (not exists (select 1 from control.paieb_s3_files_hist fh where fh.processed = 1 and fh.table_name = pt.tablename and fh.filename = pt.filename and fh.last_modified = pt.modified_timestamp ) \
                         and not exists (select 1 from control.paieb_s3_files fh where fh.jobid <> pt.jobid and fh.processed = 1 and fh.table_name = pt.tablename and fh.filename = pt.filename and fh.last_modified = pt.modified_timestamp )  \
                         )  \
                          )) as pql on pql.tablename = tgt.table_name and pql.fullpath = tgt.fullpath and pql.jobid = tgt.jobid  \
                          when not matched then   \
                          insert (TABLE_NAME, FULLPATH, FILENAME,SIZE, LAST_MODIFIED, LAST_MODIFIED_NTZ, PROCESSED, JOBID) \
                          values (pql.tablename, pql.fullpath, pql.filename, pql.psize, pql.modified_timestamp, pql.modified_timestamp_ntz, pql.processed, nvl(try_to_number('"+PJOBID+"'),0)) \
                          ; \
                          ";
                          
        try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
          strErrMsg = err.message.replace(/'/g,"");  
          logerr(0, 'List:' + strErrMsg);
          return ("FAIL:" + strErrMsg.substr(1,10000));
        }
}
catch (err) {
    strErrMsg = err.message.replace(/'/g,"");  
    logerr(0, 'List:' + strErrMsg);
    return ("FAIL:" + strErrMsg.substr(1,10000));
}

    return "SUCCESS";  
  $$;


