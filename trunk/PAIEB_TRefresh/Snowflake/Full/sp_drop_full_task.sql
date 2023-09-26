create or replace procedure control.DROP_FULL_TASK(intaskprefix varchar)
  --returns VARCHAR(32000)
  returns array
  language javascript
  execute as caller
  as
  $$
  //Created Soundra 20220803
    
  var return_array = [];
  var strErrMsg = "";
  var isFatal = 'N';
  var vjobid = 9999999;
  var vjobname = 'DROP_FULL_TASK';
  return_array.push(vjobname);
  
  //defines where the source is and target is
  var stagename = "";    //'MAXEB_DP4BI_PAIEB_UAT_S3';
  var awsfolder = "";   //'/FULL1/ATS';
  var pqschema = "";   //'FULL1';
  var vtaskprefix = "";
  var fullLoadTaskName = "";
  var inferTaskName= "";
  var mergeTaskName = "";
  var completeTaskName = "";
  
  vtaskprefix = INTASKPREFIX;
fullLoadTaskName = vtaskprefix + '_FULL_LOAD';
listTaskName = vtaskprefix + '_LIST_FILES';
inferTaskName = vtaskprefix + '_INFER_';
mergeTaskName = vtaskprefix + '_MERGE_';
completeTaskName = vtaskprefix + '_COMPLETE';
  
    
  var user_role = "";
  var dbname = ""; 
  var schemaname = "";
  var dbwarehouse = "";
  var dbtablename = "ALL";
  var strSQLStmt = "";
  var ret_value = "";
  var strtablelist = "";

var sqlCommand = "";
var dropCommand = "";
var vtablename = "";

function logerr(rowid, msg){
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', vjobid, vjobname, rowid,  msg] } ).execute();
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
          return_array.push(result);
        */
        
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


    if (dbtablename == 'ALL') {
    strtablelist = `SELECT source_table_name from control.paieb_awsdms_tables_list s ;`; 
    }
    else {
    strtablelist = `SELECT source_table_name from control.paieb_awsdms_tables_list s  
                  WHERE source_table_name = '`+ dbtablename + `';`;
    }
    return_array.push(strtablelist);              

try{
        dropCommand = 'drop task if exists '+fullLoadTaskName+';';
        return_array.push(dropCommand);
          try {
            snowflake.execute({sqlText:dropCommand});
          } catch(err) {
                    strErrMsg = err.message.replace(/'/g,""); 
                    return_array.push(strErrMsg);
                    logerr(1,strErrMsg);
                    isFatal = 'N';
          }

        dropCommand = 'drop task if exists '+listTaskName+';';
        return_array.push(dropCommand);
          try {
            snowflake.execute({sqlText:dropCommand});
          } catch(err) {
                    strErrMsg = err.message.replace(/'/g,""); 
                    return_array.push(strErrMsg);
                    logerr(1,strErrMsg);
                    isFatal = 'N';
          }

          strSQLStmt = snowflake.createStatement({sqlText: strtablelist});   
          ret_value = strSQLStmt.execute();
          //ret_value.next();      
          while (ret_value.next()) {
            vtablename = ret_value.getColumnValue('SOURCE_TABLE_NAME');
                dropCommand = 'drop task if exists '+vtaskprefix+'_MERGE_' + vtablename +';';
                return_array.push(dropCommand);
                try {
                    snowflake.execute({sqlText:dropCommand});
                } catch(err) {
                    strErrMsg = err.message.replace(/'/g,""); 
                    return_array.push(strErrMsg);
                    logerr(1,strErrMsg);
                    isFatal = 'N';
                }    
                dropCommand = 'drop task if exists '+vtaskprefix+'_INFER_' + vtablename +';';
                return_array.push(dropCommand);
                try {
                    snowflake.execute({sqlText:dropCommand});
                } catch(err) {
                    strErrMsg = err.message.replace(/'/g,""); 
                    return_array.push(strErrMsg);
                    logerr(1,strErrMsg);
                    isFatal = 'N';
                }    
          }  
        sCommand = 'drop task if exists '+completeTaskName+';';
          return_array.push(sCommand);
          snowflake.execute({sqlText:sCommand});
          
    
} catch(err) {
    strErrMsg = err.message.replace(/'/g,""); 
    return_array.push(strErrMsg);
    logerr(1,strErrMsg);
    isFatal = 'Y';
}

if (isFatal=='Y') {
    return_array.push('Fail');
} else {
    return_array.push('Success');
}

return return_array;
//return 'Success';
$$
