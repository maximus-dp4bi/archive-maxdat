create or replace procedure control.HANDLE_CDC_TASK(instagename varchar, inawsfolder varchar, inpqschema varchar, inaction varchar)
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
  var vjobname = 'CREATE_CDC_TASK';
  return_array.push(vjobname);

//defines where the source is and target is
var stagename = "";    //'MAXEB_DP4BI_PAIEB_UAT_S3';
var awsfolder = "";   //'/FULL1/ATS';
var pqschema = "";   //'FULL1';
var vtaskprefix = "";
var fullLoadTaskName = "";
var copyTaskName= "";
var mergeTaskName = "";
var listTaskName ="";
var completeTaskName="";
var vaction = INACTION;
stagename = INSTAGENAME;
awsfolder = INAWSFOLDER;
pqschema = INPQSCHEMA;

//default REINGEST=Y
var vreingest = 'Y';

//Matching PQ schema to Task 
vtaskprefix = 'CDC'; 

fullLoadTaskName = vtaskprefix + '_LOAD';
listTaskName = vtaskprefix + '_LIST_FILES';
copyTaskName = vtaskprefix + '_COPY_ALL';
  
var user_role = "";
var dbname = ""; 
var schemaname = "";
var dbwarehouse = "";
var dbtablename = 'ALL';
var strSQLStmt = "";
var ret_value = "";
var strtablelist = "";
return_array.push('Input table name = ' + dbtablename);

var sqlCommand = "";
var dropCommand = "";
var vtablename = "";

function logerr(rowid, msg){
    snowflake.createStatement( { sqlText: `call control.do_log(:1, trunc(:2), :3, :4, :5)`, binds:['E', vjobid, vjobname, rowid,  msg] } ).execute();
} 

try{
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

    var sqlAfterFullTask = "create task "+copyTaskName+" \
    warehouse= "+dbwarehouse+" \
    ALLOW_OVERLAPPING_EXECUTION = FALSE \
    AFTER "+listTaskName+" \
    as call control.copy_cdc_all('Y','0','Y') \
    ; \
    ";
    return_array.push(sqlAfterFullTask);

    var listTaskSql = " \
    create task "+listTaskName+" \
    warehouse= "+dbwarehouse+" \
    ALLOW_OVERLAPPING_EXECUTION = FALSE \
    AFTER "+fullLoadTaskName+" \
    as call control.list_files_cdc('Y','0') \
    ;";
    
    
    //FIRST: CREATE FULL TASK
    sqlCommand = " \
    create task "+fullLoadTaskName+" \
    warehouse= "+dbwarehouse+" \
    as call control.START_CDC_LOAD('"+stagename+"', '"+awsfolder+"', '"+pqschema+"','"+schemaname+"', '"+dbtablename+"','Y','"+vreingest+"') \
    ;";
    
    if (vaction == 'CREATE') {
    return_array.push(sqlCommand);
    snowflake.execute({sqlText:sqlCommand});


    //SECOND: CREATE LIST TASK
    return_array.push(listTaskSql);
    snowflake.execute({sqlText:listTaskSql});

    return_array.push(sqlAfterFullTask);
    snowflake.execute({sqlText:sqlAfterFullTask});
    }
    if (vaction == 'SUSPEND') {
      sqlCommand = 'alter task if exists '+fullLoadTaskName+' SUSPEND;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'alter task if exists '+listTaskName+' SUSPEND;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'alter task if exists '+copyTaskName+' SUSPEND;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
    
    }  
    if (vaction == 'RESUME') {
      sqlCommand = 'alter task if exists '+copyTaskName+' RESUME;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'alter task if exists '+listTaskName+' RESUME;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'alter task if exists '+fullLoadTaskName+' RESUME;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
    
    }
    if (vaction == 'DROP') {
      sqlCommand = 'drop task if exists '+fullLoadTaskName+' ;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'drop task if exists '+listTaskName+' ;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
      sqlCommand = 'drop task if exists '+copyTaskName+' ;';
      return_array.push(sqlCommand);
      snowflake.execute({sqlText:sqlCommand});
    
    }    
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
    
 


 

