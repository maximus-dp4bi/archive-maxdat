use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V2_REVIEW_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 8: Update app initial review date */         
                     
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas
                SET dmas.initial_review_complete_date = da.app_initial_review_date, dmas.initial_review_dt_null_reason = da.initial_review_dt_null_reason, override_value_indicator = da.override_indicator,fp_update_dt = current_timestamp(), 
                    dmas.application_processing_end_date = da.app_end_date 
                FROM (SELECT DISTINCT e.tracking_number, e.event_date,inv.latest_inventory_date,e.initial_review_dt_null_reason,override_indicator, 
                          CASE WHEN final_app_initial_review_date IS NULL AND current_state = 'Waiting for Verification Documents' AND vcl_sent_date IS NOT NULL THEN vcl_sent_date ELSE final_app_initial_review_date END app_initial_review_date, 
                          CASE WHEN inv.application_processing_end_date < final_app_initial_review_date THEN final_app_initial_review_date ELSE inv.application_processing_end_date END app_end_date  
                      FROM coverva_dmas.dmas_application_v2_review_date_vw e 
                        LEFT JOIN (SELECT tracking_number,file_inventory_date latest_inventory_date,application_processing_end_date,vcl_sent_date 
                                   FROM(SELECT da.*, RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                        FROM coverva_dmas.dmas_application_v2_inventory da) 
                                   WHERE rnk = 1) inv ON e.tracking_number = inv.tracking_number 
                      WHERE event_date = CAST(:1 AS DATE) ) da 
                WHERE dmas.tracking_number = da.tracking_number AND  ((dmas.file_inventory_date = da.event_date AND dmas.initial_review_complete_date IS NULL) OR dmas.file_inventory_date = da.latest_inventory_date) ;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();              
       
       } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;