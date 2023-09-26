use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_WORKER(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 10: Update Last Employee */                
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
             SET dmas.last_employee = da.last_employee,fp_update_dt = current_timestamp() 
             FROM (SELECT v.tracking_number, dmas_application_id,v.event_date, latest_inventory_date, last_employee                      
                   FROM coverva_dmas.dmas_application_v3_last_employee_vw v 
                   WHERE event_date = CAST(:1 AS DATE) ) da 
             WHERE dmas.dmas_application_id = da.dmas_application_id AND COALESCE(dmas.last_employee,'X') != da.last_employee;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;