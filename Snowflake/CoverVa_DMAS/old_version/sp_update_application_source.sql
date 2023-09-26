use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_SOURCE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 2: Update application source */         
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = cpu.application_source,fp_update_dt = current_timestamp() \
            FROM (SELECT tracking_number,application_source \
                  FROM(SELECT tracking_number,application_source,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id) rnk \
                       FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename) cdfl WHERE rnk =1 ) cpu \
            WHERE dmas.application_id = cpu.tracking_number AND dmas.source IS NULL AND cpu.application_source IS NOT NULL;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();     
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = cpui.source,fp_update_dt = current_timestamp() \
            FROM (SELECT t_number,source \
                  FROM (SELECT t_number, source,RANK() OVER (PARTITION BY t_number ORDER BY lf.file_id) rnk \
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = lf.filename) cpui WHERE rnk = 1) cpui \
            WHERE dmas.application_id = cpui.t_number AND dmas.source IS NULL AND cpui.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();     

       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = cviu.source,fp_update_dt = current_timestamp() \
            FROM (SELECT t_number,source \
                  FROM (SELECT t_number, source,RANK() OVER (PARTITION BY t_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename) cviu WHERE rnk = 1) cviu \
            WHERE dmas.application_id = cviu.t_number AND dmas.source IS NULL AND cviu.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();                  
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = amfl.application_source,dmas.case_number = amfl.case_number, fp_update_dt = current_timestamp() \
            FROM (SELECT app_number,application_source,case_number \
                  FROM (SELECT app_number,application_source,case_number,RANK() OVER(PARTITION BY amfl.app_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename ) amfl WHERE rnk = 1) amfl \
            WHERE dmas.application_id = amfl.app_number AND dmas.source IS NULL AND amfl.application_source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();   
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = ampfl.application_source, fp_update_dt = current_timestamp() \
            FROM (SELECT application_number,application_source \
                  FROM (SELECT application_number,application_source,RANK() OVER(PARTITION BY ampfl.application_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename ) amfl WHERE rnk = 1) ampfl \
            WHERE dmas.application_id = ampfl.application_number AND dmas.source IS NULL AND ampfl.application_source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();     
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "            
            + "SET dmas.source = ch.channel, fp_update_dt = current_timestamp() \
            FROM (SELECT tdh.ext_app_id,tdh.project_id,ch.channel, RANK() OVER (PARTITION BY tdh.ext_app_id ORDER BY tdh.task_id DESC) rnk \
                  FROM(SELECT ext_app_id,project_id, task_id \
                       FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_history_id DESC,tdh.task_detail_history_id DESC) rn \
                            FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID')  WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh \
                  JOIN (SELECT channel,task_id,project_id \
                        FROM (SELECT DISTINCT tdh.task_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.selection_varchar AS channel,tdh.project_id, \
                                RANK() OVER (PARTITION BY tdh.project_id,tdh.task_id  ORDER BY tdh.task_detail_history_id DESC) rnk \
                        FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(tdh.task_field_name) = 'CHANNEL') \
                        WHERE rnk = 1 AND channel IS NOT NULL) ch ON ch.task_id = tdh.task_id AND ch.project_id = tdh.project_id \
                    JOIN MARSDB.MARSDB_PROJECT_VW p ON tdh.project_id = p.project_id \
                  WHERE p.project_name = 'CoverVA' AND ch.channel IS NOT NULL) ch \
             WHERE dmas.application_id = ch.ext_app_id AND ch.rnk = 1 AND dmas.source IS NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = mct.source,fp_update_dt = current_timestamp() \
               FROM (SELECT application_number,source \
                     FROM(SELECT application_number,source, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE)) rnk \
                          FROM coverva_dmas.manual_cpu_tracking) WHERE rnk = 1) mct \
                      WHERE POSITION(regexp_replace(application_id,'T',''),mct.application_number ) > 0 AND dmas.source IS NULL AND mct.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();     
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = mct.source,dmas.case_number = mct.case_number,fp_update_dt = current_timestamp() \
               FROM (SELECT application_number,source,case_number \
                     FROM(SELECT application_number,case_number,source, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE)) rnk \
                          FROM coverva_dmas.manual_cviu_tracking) WHERE rnk = 1) mct \
                      WHERE POSITION(regexp_replace(application_id,'T',''),mct.application_number ) > 0 AND dmas.source IS NULL AND mct.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       /* Override source value */
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = aofl.source,fp_update_dt = current_timestamp(),override_value_indicator = 'Y' \
            FROM (SELECT tracking_number,source \
                  FROM(SELECT tracking_number,source, RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id) rnk \
                       FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl WHERE rnk =1 AND LENGTH(source) > 0 ) aofl \
            WHERE dmas.application_id = aofl.tracking_number ;";

       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;