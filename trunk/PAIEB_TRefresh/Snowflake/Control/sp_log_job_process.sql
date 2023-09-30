use schema CONTROL;
create or replace procedure SP_LOG_JOB_PROCESS(JOB_NAME VARCHAR,JOB_STATUS VARCHAR)
  //returns VARCHAR(32000)
  returns array
  language javascript
  as
  $$
  
  /* Declare Variables */ 
  var return_array = [];


   
   try {
      snowflake.execute( {sqlText: "BEGIN TRANSACTION;"});   
      if (JOB_STATUS == 'STARTED')
      {
        //Insert Job info
        var strSQLText = `INSERT INTO CONTROL.paieb_job_ctrl(jobid,jobname,status,starttime) VALUES(CONTROL.PAIEB_JOB_SEQ.NEXTVAL,:1,:2,current_timestamp());`;
        var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [JOB_NAME,JOB_STATUS]});
        var ret_value = strSQLStmt.execute();  
        }
      else  
       {
         //Get JobId
         var strSQLText = `SELECT MAX(jobid) refresh_job_id
                       FROM CONTROL.paieb_job_ctrl s  
                       WHERE jobname = :1
                       AND status = 'STARTED';` ;       
         var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [JOB_NAME]});
         var ret_value = strSQLStmt.execute();
         ret_value.next();      
         var numMaxJobId = ret_value.getColumnValue('REFRESH_JOB_ID');
      
          //Update job info
         strSQLText = `UPDATE CONTROL.paieb_job_ctrl SET status = :1,status_date = current_timestamp(),endtime = current_timestamp() WHERE jobid = ` + numMaxJobId + `;`  ;
         strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [JOB_STATUS]});
         ret_value = strSQLStmt.execute();  
         }
      
      } 
  catch (err)  {    
     snowflake.execute( {sqlText: "ROLLBACK;"} );
     return_array.push("Logging failed");
     return return_array;
  }
  
  snowflake.execute( {sqlText: "COMMIT;"} );          
  return_array.push("Logging successful");
  return return_array; /* SUCCESS */  
  $$;