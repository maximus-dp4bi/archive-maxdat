use schema coverva_dmas;
create or replace procedure SP_UPDATE_CPU_RUN_DATE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
  snowflake.execute( {sqlText: "BEGIN;"} );
   try {  

     var strSQLText = "UPDATE coverva_dmas.cpu_data_full_load f "
       +" SET rundate = cpu.run_date "
       +" FROM(SELECT tracking_number, filename, run_date "
       +"      FROM(SELECT tracking_number, filename,app_received_date, "
       +"             FIRST_VALUE(CAST(rundate AS DATE)) OVER (PARTITION BY tracking_number ORDER BY rundate) run_date "
       +"           FROM (SELECT tracking_number, app_received_date,filename, "
       +"                    CASE WHEN LEFT(RIGHT(filename,15),2) = '20' THEN to_timestamp(REPLACE(RIGHT(filename,15),'_','') ,'yyyymmddhh24miss') ELSE to_timestamp(REPLACE(RIGHT(filename,15),'_','') ,'mmddyyyyhh24miss') END  rundate "
       +"                 FROM coverva_dmas.cpu_data_full_load "
       +"                 WHERE UPPER(filename) NOT LIKE 'CPUREPORT_TRNS_YESTERDAY%' )  )  ) cpu "
       +" WHERE f.tracking_number = cpu.tracking_number AND f.rundate IS NULL;";        
     var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
     var ret_value = strSQLStmt.execute(); 
 } 
  catch (err)  {     
     snowflake.execute( {sqlText: "ROLLBACK;"} );
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    
    snowflake.execute( {sqlText: "COMMIT;"} );  
    return 0; /* SUCCESS */   
  $$;
  
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_UPDATE_CPU_RUN_DATE() TO ROLE MARS_DP4BI_PROD_COVERVA_DMAS_ADMIN;
GRANT ALL PRIVILEGES ON PROCEDURE coverva_dmas.SP_UPDATE_CPU_RUN_DATE() TO ROLE MARS_DP4BI_PROD_ADMIN;    