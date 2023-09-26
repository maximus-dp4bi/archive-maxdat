use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_VCL_DUEDATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 11: Update VCL Due Date */         

       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
           SET dmas.vcl_due_date = vcl.final_vcl_due_date,fp_update_dt = current_timestamp()             
           FROM(SELECT da.tracking_number, da.event_date,final_vcl_due_date,latest_inventory_date,dmas_application_id
                 FROM coverva_dmas.dmas_application_v3_vcl_due_date_vw da 
                 WHERE da.event_date = CAST(:1 AS DATE) ) vcl 
           WHERE dmas.dmas_application_id = vcl.dmas_application_id AND dmas.vcl_due_date IS NULL AND dmas.current_state = 'Waiting for Verification Documents' ;`;       
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();   
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;