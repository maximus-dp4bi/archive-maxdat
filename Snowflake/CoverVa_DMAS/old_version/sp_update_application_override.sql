use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_OVERRIDE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 2: Update values from the Application Override Form if Application ID exists */         
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = aofl.source,app_received_date = aofl.app_received_date,processing_unit = aofl.processing_unit,application_type = aofl.type,current_state = aofl.current_state, in_cp_indicator = UPPER(LEFT(aofl.in_cp,1)), \
               initial_review_complete_date = aofl.initial_review_complete_date,application_processing_end_date = aofl.end_date,last_employee = aofl.last_employee, fp_update_dt = current_timestamp() ,override_value_indicator = 'Y' \
            FROM coverva_dmas.application_override_full_load aofl WHERE dmas.application_id = aofl.tracking_number ;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();     
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;