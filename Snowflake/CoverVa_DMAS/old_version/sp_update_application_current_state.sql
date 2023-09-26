use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_CURRENT_STATE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 7 & 9: Update the Application Current State and End Date*/         
            
      /* Transferred to LDSS*/
      var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "          
            + "SET dmas.current_state = 'Transferred to LDSS',application_processing_end_date = app_end_date, fp_update_dt = current_timestamp() \
            FROM(SELECT DISTINCT application_id, action_taken, mct.sent_to_ldss, mcvt.sent_to_ldss, \
                     LEAST(COALESCE(sr_status_date,task_complete_date,mct.cpu_activity_date,mcvt.cviu_activity_date), \
                           COALESCE(task_complete_date,mct.cpu_activity_date,mcvt.cviu_activity_date,sr_status_date), \
                           COALESCE(mct.cpu_activity_date,mcvt.cviu_activity_date,sr_status_date,task_complete_date), \
                           COALESCE(mcvt.cviu_activity_date,sr_status_date,task_complete_date,mct.cpu_activity_date)) app_end_date \
                 FROM coverva_dmas.dmas_application dmas \
                   LEFT JOIN(SELECT tdh.ext_app_id,tat.action_taken,sr_status_date,task_complete_date \
                             FROM(SELECT task_id,project_id,action_taken,sr_status_date,task_complete_date \
                                   FROM(SELECT th.task_id, th.project_id,sr.status_date sr_status_date,th.status_date task_complete_date,tdh.selection_varchar AS action_taken, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                                        FROM MARSDB.MARSDB_TASKS_VW th \
                                          JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh ON th.task_id = tdh.task_id AND th.project_id = tdh.project_id \
                                          JOIN MARSDB.MARSDB_TASK_TYPE tt ON th.task_type_id = tt.task_type_id AND th.project_id = tt.project_id \
                                          LEFT JOIN MARSDB.MARSDB_EXTERNAL_LINKS_VW el ON th.task_id = el.internal_id AND el.project_id = th.project_id \
                                                AND el.internal_ref_type = 'TASK' AND el.external_ref_type = 'SERVICE_REQUEST' AND el.effective_end_date IS NULL \
                                          LEFT JOIN MARSDB.MARSDB_TASKS_VW sr ON el.external_ref_id = sr.task_id AND el.project_id = sr.project_id \
                                        WHERE  tt.task_type_id = 13474 \
                                        AND UPPER(task_field_name) = 'ACTION TAKEN SINGLE' \
                                        AND th.task_status = 'Complete') \
                                   WHERE rn =1) tat \
                                JOIN (SELECT task_id,project_id,ext_app_id \
                                      FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                                           FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh \
                                           WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') \
                                      WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON tdh.task_id = tat.task_id AND tdh.project_id = tat.project_id \
                                JOIN MARSDB.MARSDB_PROJECT_VW p ON tdh.project_id = p.project_id \
                             WHERE p.project_name = 'CoverVA' AND action_taken = 'TRANSFERRED_TO_LDSS') tat ON dmas.application_id = tat.ext_app_id \
                   LEFT JOIN(SELECT application_number,sent_to_ldss,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cpu_activity_date \
                             FROM(SELECT application_number,sent_to_ldss,activity_date, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk \
                                  FROM coverva_dmas.manual_cpu_tracking mct) \
                             WHERE rnk = 1 AND sent_to_ldss = '1') mct ON POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 \
                   LEFT JOIN(SELECT application_number,sent_to_ldss,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cviu_activity_date \
                             FROM(SELECT application_number,CASE WHEN UPPER(LEFT(sent_to_ldss,1)) = 'Y' THEN '1' ELSE sent_to_ldss END sent_to_ldss, activity_date,RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk \
                                  FROM coverva_dmas.manual_cviu_tracking mcvt) \
                                  WHERE rnk = 1 AND (sent_to_ldss = '1' OR UPPER(LEFT(sent_to_ldss,1)) = 'Y' )) mcvt ON POSITION(regexp_replace(dmas.application_id,'T',''),mcvt.application_number ) > 0 \
                 WHERE action_taken = 'TRANSFERRED_TO_LDSS' OR  mct.sent_to_ldss = '1' OR mcvt.sent_to_ldss = '1') tat WHERE dmas.application_id = tat.application_id;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       /* From CM044 - First status in alphabetical order */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = cm.status,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() \
            FROM (SELECT tracking_number, status,app_end_date \
                        FROM (SELECT tracking_number,status,CASE WHEN UPPER(status) IN('APPROVED','DENIED') THEN authorized_date ELSE NULL END app_end_date, RANK() OVER(PARTITION BY cm.tracking_number ORDER BY lf.file_id DESC,UPPER(LEFT(cm.status,1))) rnk \
                              FROM coverva_dmas.CM044_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename) WHERE rnk = 1 ) cm \
            WHERE dmas.application_id = cm.tracking_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* Approved/Denied/Needs Research */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = da.current_state,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() \
            FROM(SELECT DISTINCT application_id, CASE WHEN disposition = 'Approved' OR cviu_current_state = 'Approved' OR cpu_current_state = 'Approved' THEN 'Approved' \
                                                      WHEN disposition = 'Denied' OR cviu_current_state = 'Denied' OR cpu_current_state = 'Denied' THEN 'Denied' \
                                                ELSE 'Complete - Needs Research' END current_state, \
                        CASE WHEN disposition IN('Approved','Denied') OR cviu_current_state IN('Approved','Denied') OR cpu_current_state IN('Approved','Denied') THEN \
                           LEAST(COALESCE(sr_status_date,task_complete_date,mct.cpu_activity_date,mcvt.cviu_activity_date), \
                           COALESCE(task_complete_date,mct.cpu_activity_date,mcvt.cviu_activity_date,sr_status_date), \
                           COALESCE(mct.cpu_activity_date,mcvt.cviu_activity_date,sr_status_date,task_complete_date), \
                           COALESCE(mcvt.cviu_activity_date,sr_status_date,task_complete_date,mct.cpu_activity_date)) ELSE NULL END app_end_date \
                 FROM coverva_dmas.dmas_application dmas \
                   LEFT JOIN(SELECT tdh.ext_app_id,dsp.disposition,sr_status_date, task_complete_date \
                             FROM(SELECT task_id,project_id,sr_status_date, task_complete_date, \
                                    CASE WHEN disposition IN('APPROVED','AUTO_APPROVED') THEN 'Approved' \
                                         WHEN disposition IN('DENIED','AUTO_DENIED') THEN 'Denied' ELSE 'Complete - Needs Research' END disposition \
                                   FROM(SELECT th.task_id, th.project_id,tdh.selection_varchar AS disposition, sr.status_date sr_status_date, th.status_date task_complete_date, \
                                           RANK() OVER (PARTITION BY th.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                                        FROM MARSDB.MARSDB_TASKS_VW th \
                                          JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh ON th.task_id = tdh.task_id AND th.project_id = tdh.project_id \
                                          JOIN MARSDB.MARSDB_TASK_TYPE tt ON th.task_type_id = tt.task_type_id AND th.project_id = tt.project_id \
                                          LEFT JOIN MARSDB.MARSDB_EXTERNAL_LINKS_VW el ON th.task_id = el.internal_id AND el.project_id = th.project_id \
                                                AND el.internal_ref_type = 'TASK' AND el.external_ref_type = 'SERVICE_REQUEST' AND el.effective_end_date IS NULL \
                                          LEFT JOIN MARSDB.MARSDB_TASKS_VW sr ON el.external_ref_id = sr.task_id AND el.project_id = sr.project_id  \
                                        WHERE  tt.task_type_id = 13474 \
                                        AND UPPER(task_field_name) = 'DISPOSITION' \
                                        AND th.task_status = 'Complete') \
                                   WHERE rn =1) dsp \
                                JOIN (SELECT task_id,project_id,ext_app_id \
                                      FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                                           FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh \
                                           WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') \
                                      WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON tdh.task_id = dsp.task_id AND tdh.project_id = dsp.project_id \
                                JOIN MARSDB.MARSDB_PROJECT_VW p ON tdh.project_id = p.project_id \
                             WHERE p.project_name = 'CoverVA') dsp ON dmas.application_id = dsp.ext_app_id \
                   LEFT JOIN(SELECT application_number,CASE WHEN approved = '1' THEN 'Approved' WHEN denied = '1' THEN 'Denied' ELSE 'Complete - Needs Research' END cpu_current_state,cpu_activity_date \
                             FROM(SELECT application_number,approved,denied, CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cpu_activity_date, \
                                      RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk \
                                  FROM coverva_dmas.manual_cpu_tracking mct) \
                             WHERE rnk = 1 ) mct ON POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 \
                   LEFT JOIN(SELECT application_number,CASE WHEN UPPER(status) = 'APPROVED' THEN 'Approved' WHEN UPPER(status) = 'DENIED' THEN 'Denied' ELSE 'Complete - Needs Research' END cviu_current_state, cviu_activity_date \
                             FROM(SELECT application_number,status, CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cviu_activity_date, \
                                        RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk \
                                  FROM coverva_dmas.manual_cviu_tracking mcvt) \
                                  WHERE rnk = 1 )  mcvt ON POSITION(regexp_replace(dmas.application_id,'T',''),mcvt.application_number ) > 0 \
                 WHERE (disposition IS NOT NULL OR mcvt.cviu_current_state IS NOT  NULL OR mct.cpu_current_state IS NOT NULL) \
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl WHERE dmas.application_id = amfl.app_number) \
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load amfl WHERE dmas.application_id = amfl.application_number) \
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl WHERE dmas.application_id = pdfl.t_number) ) da WHERE dmas.application_id = da.application_id;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* Waiting Initial Review. */       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting Initial Review',fp_update_dt = current_timestamp() \
            FROM (SELECT app_number,pending_due_to_vcl \
                  FROM (SELECT app_number,pending_due_to_vcl,RANK() OVER(PARTITION BY amfl.app_number ORDER BY lf.file_id DESC) rnk \
                        FROM app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename ) amfl \
                  WHERE rnk = 1 AND COALESCE(pending_due_to_vcl,'N') = 'N' ) amfl \
            WHERE dmas.application_id = amfl.app_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
                     
       /* Waiting for Verification Documents. */            
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting for Verification Documents',fp_update_dt = current_timestamp() \
               FROM (SELECT application_number, vcl \
                     FROM(SELECT application_number,vcl, RANK() OVER(PARTITION BY application_number ORDER BY activity_date DESC) rnk \
                          FROM coverva_dmas.manual_cpu_tracking) \
                     WHERE rnk = 1 AND vcl = '1' ) mct \
                WHERE POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();  
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting for Verification Documents',fp_update_dt = current_timestamp() \
               FROM (SELECT application_number, vcl \
                     FROM(SELECT application_number,vcl, RANK() OVER(PARTITION BY application_number ORDER BY activity_date DESC) rnk \
                          FROM coverva_dmas.manual_cviu_tracking) \
                     WHERE rnk = 1 AND (UPPER(vcl) LIKE 'YES%' OR vcl = '1') ) mct \
                WHERE POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting for Verification Documents',fp_update_dt = current_timestamp() \
            FROM(SELECT tdh.ext_app_id,dsp.disposition \
                 FROM(SELECT task_id,project_id,disposition \
                      FROM(SELECT th.task_id, th.project_id,tdh.selection_varchar AS disposition, RANK() OVER (PARTITION BY th.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                           FROM MARSDB.MARSDB_TASKS_VW th \
                              JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh ON th.task_id = tdh.task_id AND th.project_id = tdh.project_id \
                              JOIN MARSDB.MARSDB_TASK_TYPE tt ON th.task_type_id = tt.task_type_id AND th.project_id = tt.project_id \
                      WHERE  tt.task_type_id = 13474 \
                      AND UPPER(task_field_name) = 'DISPOSITION' \
                      AND th.task_status = 'Complete') \
                 WHERE rn =1) dsp \
              JOIN (SELECT task_id,project_id,ext_app_id \
                    FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                         FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh \
                         WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') \
                    WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON tdh.task_id = dsp.task_id AND tdh.project_id = dsp.project_id \
              JOIN MARSDB.MARSDB_PROJECT_VW p ON tdh.project_id = p.project_id  \
              WHERE p.project_name = 'CoverVA' AND disposition = 'PENDING_MI') disp WHERE dmas.application_id = disp.ext_app_id;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();

       /*Set initial status to Waiting Initial Review. */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas SET dmas.current_state = 'Waiting Initial Review' WHERE dmas.current_state IS NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();     
             
       /* Override source value */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = aofl.current_state, fp_update_dt = current_timestamp() ,override_value_indicator = 'Y' \
            FROM (SELECT tracking_number,current_state \
                  FROM(SELECT tracking_number,current_state, RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id) rnk \
                       FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl WHERE rnk =1 AND current_state IS NOT NULL ) aofl \
            WHERE dmas.application_id = aofl.tracking_number ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();         
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;