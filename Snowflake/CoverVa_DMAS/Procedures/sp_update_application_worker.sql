use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_WORKER(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 10: Update Last Employee */                
       var strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
             SET dmas.last_employee = da.last_employee,override_value_indicator = da.override_indicator,fp_update_dt = current_timestamp() 
             FROM (SELECT v.tracking_number, v.event_date, latest_inventory_date, last_employee 
                     ,CASE WHEN v.override_last_employee IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                   FROM coverva_dmas.dmas_application_last_employee_vw v 
                   WHERE event_date = CAST(:1 AS DATE) ) da 
             WHERE dmas.tracking_number = da.tracking_number AND COALESCE(dmas.last_employee,'X') != da.last_employee AND (dmas.file_inventory_date = da.event_date OR dmas.file_inventory_date = da.latest_inventory_date);`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;