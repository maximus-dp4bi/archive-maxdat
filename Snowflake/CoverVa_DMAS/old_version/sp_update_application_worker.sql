use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_WORKER()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 9: Update Last Employee */         
       /* From CM044 */
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = cm.worker_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
            FROM (SELECT tracking_number, authorized_worker_id,worker_name \
                  FROM (SELECT tracking_number,authorized_worker_id,worker_name,RANK() OVER(PARTITION BY cm.tracking_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.CM044_data_full_load cm \
                          JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename \
                          JOIN(SELECT * FROM(SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_id DESC) rnk \
                               FROM coverva_dmas.mms_ldap_full_load ldap JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cm.authorized_worker_id)) \
                  WHERE rnk = 1 ) cm \
            WHERE dmas.application_id = cm.tracking_number;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       /* From Manual CPU Tracking */
        strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = mct.ew,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
               FROM (SELECT application_number,ew \
                     FROM(SELECT application_number,ew, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk \
                          FROM coverva_dmas.manual_cpu_tracking) WHERE rnk = 1 AND ew IS NOT NULL) mct \
               WHERE POSITION(regexp_replace(dmas.application_id,'T',''),mct.application_number ) > 0 ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* From App Inventory Report */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = air.staff_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
              FROM(SELECT tdh.ext_app_id,dsp.disposition,staff_assigned_to,staff_name \
                   FROM(SELECT task_id,project_id,staff_assigned_to,staff_name,disposition \
                        FROM(SELECT th.task_id, th.project_id,tdh.selection_varchar AS disposition,th.staff_assigned_to,staff_name,  \
                              RANK() OVER (PARTITION BY th.task_id ORDER BY tdh.task_detail_history_id DESC) rn \
                             FROM MARSDB.MARSDB_TASKS_VW th \
                              JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh ON th.task_id = tdh.task_id AND th.project_id = tdh.project_id \
                              JOIN MARSDB.MARSDB_TASK_TYPE tt ON th.task_type_id = tt.task_type_id AND th.project_id = tt.project_id \
                              LEFT JOIN(SELECT DISTINCT u.user_id, CONCAT(s.first_name, ' ',COALESCE(s.last_name,'')) AS staff_name, s.maximus_id, u.project_id \
                                        FROM MARSDB.MARSDB_USER_VW u \
                                          LEFT JOIN MARSDB.MARSDB_STAFF_VW s on s.staff_id = u.staff_id ) emp ON TO_CHAR(emp.user_id) = th.staff_assigned_to AND emp.project_id = th.project_id \
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
                 WHERE p.project_name = 'CoverVA' AND staff_name IS NOT NULL) air \
              WHERE dmas.application_id = air.ext_app_id;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* From CVIU Inventory */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = cviu.worker_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
              FROM(SELECT t_number, worker_name \
                   FROM(SELECT t_number, ldap.worker_name,RANK() OVER (PARTITION BY t_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename \
                          JOIN(SELECT worker_name,ldap \
                               FROM(SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_id DESC) rnk \
                                    FROM coverva_dmas.mms_ldap_full_load ldap JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cviu.assigned_to)) \
                    WHERE rnk =1 AND worker_name IS NOT NULL) cviu \
              WHERE dmas.application_id = cviu.t_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();   
       
       /* From CPU Incarcerated Inventory */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = cpu.worker_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
              FROM(SELECT t_number, worker_name \
                   FROM(SELECT t_number, ldap.worker_name,RANK() OVER (PARTITION BY t_number ORDER BY lf.file_id) rnk \
                        FROM coverva_dmas.cpu_incarcerated_full_load cpu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename \
                          JOIN(SELECT worker_name,ldap \
                               FROM(SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_id DESC) rnk \
                                    FROM coverva_dmas.mms_ldap_full_load ldap JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cpu.assigned_to)) \
                    WHERE rnk =1 AND worker_name IS NOT NULL) cpu \
              WHERE dmas.application_id = cpu.t_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();  
       
       /* From App Metric PW */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = ampfl.worker,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
           FROM(SELECT application_number,worker \
                FROM (SELECT application_number,worker, RANK() OVER (PARTITION BY application_number ORDER BY lf.file_id DESC) rnk \
                      FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename ) \
                WHERE rnk = 1 AND worker IS NOT NULL) ampfl WHERE dmas.application_id = ampfl.application_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       /* From App Metric */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = amfl.worker_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
           FROM(SELECT app_number, worker_name \
                FROM (SELECT app_number, ldap.worker_name,RANK() OVER (PARTITION BY app_number ORDER BY lf.file_id DESC) rnk \
                      FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename \
                  JOIN(SELECT worker_name,ldap \
                       FROM(SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_id DESC) rnk \
                            FROM coverva_dmas.mms_ldap_full_load ldap JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(amfl.worker_id)) \
                 WHERE rnk = 1 AND worker_name IS NOT NULL) amfl WHERE dmas.application_id = amfl.app_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();  
       
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = cdfl.worker_name,last_employee_null_reason = NULL,fp_update_dt = current_timestamp() \
            FROM(SELECT tracking_number, worker_name \
                 FROM(SELECT tracking_number, ldap.worker_name,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id DESC) rnk \
                      FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename \
                        LEFT JOIN(SELECT worker_name,ldap \
                                  FROM(SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_id DESC) rnk \
                                       FROM coverva_dmas.mms_ldap_full_load ldap JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) WHERE rnk = 1) ldap ON UPPER(ldap.ldap) = UPPER(cdfl.assigned_to)) cdfl \
                  WHERE rnk =1) cdfl WHERE dmas.application_id = cdfl.tracking_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       /* Override source value */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.last_employee = aofl.last_employee,last_employee_null_reason = NULL,fp_update_dt = current_timestamp(),override_value_indicator = 'Y' \
              FROM (SELECT tracking_number,last_employee \
                    FROM(SELECT tracking_number, last_employee, RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id DESC) rnk \
                         FROM coverva_dmas.application_override_full_load aofl \
                          JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl \
              WHERE rnk =1 AND last_employee IS NOT NULL ) aofl WHERE dmas.application_id = aofl.tracking_number ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
       
       /* Update null reason if last employee is null */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET last_employee_null_reason = 'Needs Research',fp_update_dt = current_timestamp() WHERE last_employee IS NULL";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute(); 
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;