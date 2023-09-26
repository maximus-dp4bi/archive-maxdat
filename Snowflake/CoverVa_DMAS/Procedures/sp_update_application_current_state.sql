use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_CURRENT_STATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 7 & 9: Update the Application Current State and End Date*/                     
      var strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
          SET dmas.current_state = da.current_state,dmas.application_processing_end_date = da.app_end_date, dmas.override_value_indicator = da.override_indicator, fp_update_dt = current_timestamp(), 
              dmas.cm044_verified = da.cm044_verified, dmas.non_maximus_initial_date = da.non_maximus_initial_date,dmas.non_maximus_returned_date = da.non_maximus_returned_date, 
              dmas.vcl_sent_date = da.waiting_for_vdoc_date 
          FROM(SELECT tracking_number,event_date,final_current_state current_state,latest_inventory_date,final_end_date app_end_date, CASE WHEN current_state_2 IS NOT NULL THEN 'Y' ELSE 'N' END override_indicator, 
                   cm044_verified,non_maximus_initial_date,non_maximus_returned_date,waiting_for_vdoc_date 
               FROM coverva_dmas.dmas_application_current_state_vw 
               WHERE event_date = CAST(:1 AS DATE)) da 
          WHERE dmas.tracking_number = da.tracking_number AND ((dmas.current_state IS NULL AND dmas.file_inventory_date = da.event_date) OR dmas.file_inventory_date = da.latest_inventory_date);`;
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
      var ret_value = strSQLStmt.execute();                      
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;