use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_REVIEW_DATE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 8: Update app initial review date */         
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.initial_review_dt_null_reason = 'Application Current State - Waiting Initial Review', fp_update_dt = current_timestamp() WHERE current_state = 'Waiting Initial Review';";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
              
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.initial_review_complete_date = rd.initial_review_date, dmas.min_completed_task_date = rd.complete_task_date, \
                   dmas.min_mt_cviu_action_date = cviu_action_date,dmas.min_mt_cpu_action_date = cpu_action_date, \
                   dmas.initial_review_dt_null_reason = null, fp_update_dt = current_timestamp() \
              FROM(SELECT dmas.application_id,cp.complete_task_date,mct.cpu_action_date,mcvt.cviu_action_date, \
                        LEAST(COALESCE(cp.complete_task_date,mct.cpu_action_date,mcvt.cviu_action_date),COALESCE(mct.cpu_action_date,mcvt.cviu_action_date,cp.complete_task_date),COALESCE(mcvt.cviu_action_date,cp.complete_task_date,mct.cpu_action_date)) initial_review_date \
                   FROM coverva_dmas.dmas_application dmas \
                      LEFT JOIN(SELECT tdh.ext_app_id,MIN(tdh.complete_task_date ) complete_task_date \
                           FROM(SELECT task_id,complete_task_date,project_id,ext_app_id \
                                FROM(SELECT th.task_id, th.status_date complete_task_date,th.project_id,tdh.selection_varchar AS ext_app_id, \
                                         RANK() OVER (PARTITION BY th.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                                     FROM MARSDB.MARSDB_TASKS_VW th \
                                       JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh ON th.task_id = tdh.task_id AND th.project_id = tdh.project_id \
                                       JOIN MARSDB.MARSDB_TASK_TYPE tt ON th.task_type_id = tt.task_type_id AND th.project_id = tt.project_id \
                                     WHERE  tt.task_type_id = 13474 \
                                     AND UPPER(task_field_name) = 'EXTERNAL APPLICATION ID' \
                                     AND th.task_status = 'Complete') \
                                WHERE rn =1 AND ext_app_id IS NOT NULL) tdh \
                             JOIN MARSDB.MARSDB_PROJECT_VW p ON tdh.project_id = p.project_id \
                           WHERE p.project_name = 'CoverVA' \
                           GROUP BY tdh.ext_app_id) cp ON dmas.application_id = cp.ext_app_id \
                      LEFT JOIN(SELECT application_number,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cpu_action_date \
                                FROM(SELECT application_number,activity_date, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE)) rnk \
                                     FROM coverva_dmas.manual_cpu_tracking mct) \
                                WHERE rnk = 1) mct ON POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 \
                      LEFT JOIN(SELECT application_number, CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cviu_action_date \
                                FROM(SELECT application_number,activity_date, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE)) rnk \
                                     FROM coverva_dmas.manual_cviu_tracking mcvt) \
                                WHERE rnk = 1 ) mcvt ON POSITION(regexp_replace(dmas.application_id,'T',''),mcvt.application_number ) > 0) rd \
              WHERE dmas.application_id = rd.application_id AND dmas.current_state != 'Waiting Initial Review' AND rd.initial_review_date IS NOT NULL; ";       
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.initial_review_dt_null_reason = 'Research', fp_update_dt = current_timestamp() \
              WHERE current_state != 'Waiting Initial Review' AND initial_review_complete_date IS NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* Override source value */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.initial_review_complete_date = aofl.initial_review_complete_date, dmas.initial_review_dt_null_reason = null, fp_update_dt = current_timestamp() ,override_value_indicator = 'Y' \
            FROM (SELECT tracking_number,initial_review_complete_date \
                  FROM(SELECT tracking_number,initial_review_complete_date, RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id) rnk \
                       FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl WHERE rnk =1 AND initial_review_complete_date IS NOT NULL ) aofl \
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