use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_CURRENT_STATE_FIRST_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 7 & 9: Update the Application Current State and End Date*/                     
      var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
          SET dmas.intake_state_first_date = COALESCE(da.min_intake_state_first_date,CASE WHEN dmas.intake_state_first_date IS NULL THEN da.intake_state_first_date ELSE dmas.intake_state_first_date END),
          dmas.wir_state_first_date = COALESCE(da.min_wir_state_first_date,CASE WHEN dmas.wir_state_first_date IS NULL THEN da.wir_state_first_date ELSE dmas.wir_state_first_date END),
          dmas.nma_state_first_date = COALESCE(da.min_nma_state_first_date,CASE WHEN dmas.nma_state_first_date IS NULL THEN da.nma_state_first_date ELSE dmas.nma_state_first_date END),
          dmas.wfvd_state_first_date = COALESCE(da.min_wfvd_state_first_date,CASE WHEN dmas.wfvd_state_first_date IS NULL THEN da.wfvd_state_first_date ELSE dmas.wfvd_state_first_date END),
          dmas.irc_state_first_date = COALESCE(da.min_irc_state_first_date,CASE WHEN dmas.irc_state_first_date IS NULL THEN da.irc_state_first_date ELSE dmas.irc_state_first_date END),
          dmas.approved_state_first_date = COALESCE(da.min_approved_state_first_date,CASE WHEN dmas.approved_state_first_date IS NULL THEN da.approved_state_first_date ELSE dmas.approved_state_first_date END),
          dmas.denied_state_first_date = COALESCE(da.min_denied_state_first_date,CASE WHEN dmas.denied_state_first_date IS NULL THEN da.denied_state_first_date ELSE dmas.denied_state_first_date END),
          dmas.ttldss_state_first_date = COALESCE(da.min_ttldss_state_first_date,CASE WHEN dmas.ttldss_state_first_date IS NULL THEN da.ttldss_state_first_date ELSE dmas.ttldss_state_first_date END),
          dmas.complete_state_first_date = COALESCE(da.min_complete_state_first_date,CASE WHEN dmas.complete_state_first_date IS NULL THEN da.complete_state_first_date ELSE dmas.complete_state_first_date END),          
          dmas.fp_update_dt = current_timestamp()
          FROM(SELECT da.tracking_number, da.current_state,da.dmas_application_id,initial_review_complete_date, application_processing_end_date,
                CASE WHEN da.current_state = 'Intake' THEN COALESCE(MIN(intake_state_first_date) OVER (PARTITION BY tracking_number), status_date) ELSE NULL END intake_state_first_date,
                CASE WHEN da.current_state = 'Waiting Initial Review' THEN COALESCE(MIN(wir_state_first_date) OVER (PARTITION BY tracking_number), status_date) ELSE NULL END wir_state_first_date,
                CASE WHEN da.current_state = 'Non Maximus Assigned' THEN COALESCE(MIN(nma_state_first_date) OVER (PARTITION BY tracking_number), non_maximus_initial_date) ELSE NULL END nma_state_first_date,
                CASE WHEN da.current_state = 'Waiting for Verification Documents' THEN COALESCE(MIN(wfvd_state_first_date) OVER (PARTITION BY tracking_number), initial_review_complete_date) ELSE NULL END wfvd_state_first_date,
                CASE WHEN da.current_state = 'Initial Review Complete' THEN COALESCE(MIN(irc_state_first_date) OVER (PARTITION BY tracking_number), initial_review_complete_date) ELSE NULL END irc_state_first_date,
                CASE WHEN da.current_state = 'Approved' THEN COALESCE(MIN(approved_state_first_date) OVER (PARTITION BY tracking_number), actual_app_end_date) ELSE NULL END approved_state_first_date,
                CASE WHEN da.current_state = 'Denied' THEN COALESCE(MIN(denied_state_first_date) OVER (PARTITION BY tracking_number), actual_app_end_date) ELSE NULL END denied_state_first_date,
                CASE WHEN da.current_state = 'Transferred to LDSS' THEN COALESCE(MIN(ttldss_state_first_date) OVER (PARTITION BY tracking_number), actual_app_end_date) ELSE NULL END ttldss_state_first_date,
                CASE WHEN da.current_state = 'Complete - Needs Research' THEN COALESCE(MIN(complete_state_first_date) OVER (PARTITION BY tracking_number), actual_app_end_date)
                  ELSE NULL END complete_state_first_date,
                MIN(intake_state_first_date) OVER (PARTITION BY tracking_number) min_intake_state_first_date,
                MIN(wir_state_first_date) OVER (PARTITION BY tracking_number) min_wir_state_first_date,  
                MIN(nma_state_first_date) OVER (PARTITION BY tracking_number) min_nma_state_first_date,  
                MIN(wfvd_state_first_date) OVER (PARTITION BY tracking_number) min_wfvd_state_first_date, 
                MIN(irc_state_first_date) OVER (PARTITION BY tracking_number) min_irc_state_first_date, 
                MIN(approved_state_first_date) OVER (PARTITION BY tracking_number) min_approved_state_first_date, 
                MIN(denied_state_first_date) OVER (PARTITION BY tracking_number) min_denied_state_first_date, 
                MIN(ttldss_state_first_date) OVER (PARTITION BY tracking_number) min_ttldss_state_first_date, 
                MIN(complete_state_first_date) OVER (PARTITION BY tracking_number) min_complete_state_first_date  
               FROM coverva_dmas.dmas_application_v3_inventory da                 
               QUALIFY ROW_NUMBER() OVER (PARTITION BY da.tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) = 1) da 
          WHERE dmas.dmas_application_id = da.dmas_application_id;`;
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});;
      var ret_value = strSQLStmt.execute();                      
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;