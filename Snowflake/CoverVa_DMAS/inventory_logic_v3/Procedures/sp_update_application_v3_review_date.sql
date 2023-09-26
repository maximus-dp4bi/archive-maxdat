use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_REVIEW_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 8: Update app initial review date */         
                     
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas
                SET dmas.initial_review_complete_date = da.final_initial_review_date,
                    dmas.initial_review_dt_null_reason = da.initial_review_dt_null_reason,
                    dmas.fp_update_dt = current_timestamp(), 
                    dmas.application_processing_end_date = CASE WHEN CAST(dmas.application_processing_end_date AS DATE) < CAST(da.final_initial_review_date AS DATE) 
                      THEN da.final_initial_review_date ELSE dmas.application_processing_end_date END,
                    dmas.vcl_sent_date = CASE WHEN dmas.vcl_sent_date IS NULL THEN da.final_vcl_sent_date ELSE dmas.vcl_sent_date END,
                    dmas.previous_initial_review_date = CASE WHEN dmas.previous_initial_review_date IS NULL THEN da.final_initial_review_date ELSE  dmas.previous_initial_review_date END
                FROM (WITH da AS (
                        SELECT tracking_number,file_inventory_date, current_state, dmas_application_id,state_app_received_date,initial_review_complete_date,application_processing_end_date,                    
                                COALESCE(initial_review_complete_date,previous_initial_review_date,
                                          LEAD(initial_review_complete_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) ) previous_review_date,
                                COALESCE(application_processing_end_date,previous_processing_end_date,
                                          LEAD(application_processing_end_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_app_end_date,                                                                
                                COALESCE(vcl_sent_date,LEAD(vcl_sent_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_vcl_sent_date                                
                        FROM coverva_dmas.dmas_application_v3_inventory 
                        QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC, dmas_application_id DESC) = 1),
                        irc AS(
                            SELECT da.*,irc.app_initial_review_date
                            FROM da               
                             LEFT JOIN(SELECT tracking_number,MIN(non_maximus_initial_date) app_initial_review_date
                                       FROM dmas_application_v3_inventory
                                       WHERE non_maximus_initial_date IS NOT NULL
                                       GROUP BY tracking_number
                                       UNION
                                       SELECT tracking_number,complete_task_date app_initial_review_date 
                                       FROM coverva_dmas.cp_application_inventory 
                                        UNION 
                                        SELECT tracking_number,status_date app_initial_review_date 
                                        FROM coverva_dmas.cp_initial_application_review 
                                        UNION
                                        SELECT case_number tracking_number,disposition_date mio_initial_review_date                       
                                        FROM coverva_mio.mio_inventory_full_load_vw mio
                                        WHERE (mio_current_state NOT IN('Waiting Initial Review','Intake')  OR mio_term_state NOT IN('Waiting Initial Review','Intake'))
                                        UNION
                                        SELECT tracking_number,vcl_generation_date rp269_vcl_generation_date
                                        FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date ,vcl_status
                                                ,ROW_NUMBER() OVER(PARTITION BY rp269.tracking_number ORDER BY f.file_date DESC,rp269.rp269_data_id DESC) rnk
                                             FROM coverva_dmas.rp269_data_full_load rp269 
                                               JOIN coverva_dmas.dmas_file_log f ON UPPER(rp269.filename) = UPPER(f.filename)
                                             WHERE UPPER(vcl_status) NOT LIKE '%SUPPRESSED%') 
                                        WHERE rnk = 1
                                        UNION
                                        SELECT tracking_number,vcl_generation_date rp270_vcl_generation_date
                                        FROM(SELECT tracking_number,vcl_generation_date,CAST(f.file_date AS DATE) file_date, vcl_status
                                               ,ROW_NUMBER() OVER(PARTITION BY rp270.tracking_number ORDER BY f.file_date DESC,rp270.rp270_data_id DESC) rnk
                                             FROM coverva_dmas.rp270_data_full_load rp270 
                                               JOIN coverva_dmas.dmas_file_log f ON UPPER(rp270.filename) = UPPER(f.filename)
                                            WHERE UPPER(vcl_status) NOT LIKE '%SUPPRESSED%') 
                                         WHERE rnk = 1 
                                         UNION
                                         SELECT tracking_number,MIN(CAST(f.file_date AS DATE)) file_date 
                                         FROM coverva_dmas.app_metric_v2_full_load am 
                                            JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                          WHERE stage LIKE '%Pending VCL%'
                                          GROUP BY tracking_number
                                          UNION
                                          SELECT tracking_number,MIN(CAST(am.vcl_sent_date AS DATE)) vcl_sent_date 
                                          FROM coverva_dmas.app_metric_v2_full_load am                                             
                                          WHERE vcl_sent_date IS NOT NULL
                                          GROUP BY tracking_number) irc ON da.tracking_number = irc.tracking_number AND CAST(irc.app_initial_review_date AS DATE) >= CAST(state_app_received_date AS DATE)  )
                        SELECT tracking_number, dmas_application_id,state_app_received_date,current_state,previous_app_end_date,app_initial_review_date,previous_review_date,
                          CASE WHEN current_state IN('Waiting Initial Review','Intake') THEN NULL
                            ELSE CASE WHEN previous_review_date IS NOT NULL AND CAST(previous_review_date AS DATE) >= CAST(state_app_received_date AS DATE) THEN previous_review_date
                                   WHEN previous_review_date IS NULL AND CAST(previous_app_end_date AS DATE) >= CAST(state_app_received_date AS DATE) THEN CAST(previous_app_end_date AS DATE)
                                   ELSE COALESCE(app_initial_review_date,previous_app_end_date) END END final_initial_review_date,                      
                          CASE WHEN current_state = 'Waiting for Verification Documents' AND previous_vcl_sent_date IS NULL THEN 
                            CASE WHEN previous_review_date IS NOT NULL AND CAST(previous_review_date AS DATE) >= CAST(state_app_received_date AS DATE) THEN previous_review_date
                                 WHEN previous_review_date IS NULL AND CAST(previous_app_end_date AS DATE) >= CAST(state_app_received_date AS DATE) THEN CAST(previous_app_end_date AS DATE)
                               ELSE COALESCE(app_initial_review_date,previous_app_end_date) END
                            ELSE NULL END final_vcl_sent_date,
                            CASE WHEN current_state IN('Intake', 'Waiting Initial Review') THEN 'In Application Inventory but waiting initial review'
                               ELSE null END initial_review_dt_null_reason 
                        FROM irc
                        QUALIFY ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY COALESCE(app_initial_review_date,previous_review_date)) = 1 ) da 
                WHERE dmas.dmas_application_id = da.dmas_application_id ;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();              
       
       } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;