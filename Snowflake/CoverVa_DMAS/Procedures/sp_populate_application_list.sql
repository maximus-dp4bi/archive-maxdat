use schema coverva_dmas;
create or replace procedure SP_POPULATE_APPLICATION_LIST(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
          /* STEP 1: Get list of application IDs */
        /* App List from PPIT */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,case_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
             SELECT tracking_number, case_number,applicant_name,file_id, current_timestamp(),file_date 
             FROM (SELECT DISTINCT tracking_number,case_number,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                            ,applicant applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                      FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename 
                      WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) pdfl 
             WHERE ignore_application_indicator = 'N' 
             AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = pdfl.tracking_number AND dmas.file_inventory_date = pdfl.file_date) 
             AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application x WHERE x.tracking_number = pdfl.tracking_number AND x.file_inventory_date = pdfl.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* insert excluded applications for PPIT */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
            SELECT tracking_number, file_id, ignore_application_reason, current_timestamp(),file_date 
               FROM (SELECT DISTINCT tracking_number,case_number,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                            ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Application Too early' ELSE NULL END ignore_application_reason 
                            ,applicant applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                      FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename 
                      WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) pdfl 
                WHERE ignore_application_indicator = 'Y' AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application dmas WHERE dmas.tracking_number = pdfl.tracking_number AND dmas.file_inventory_date = pdfl.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
  
       /* App List from AppMetrics */     
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,case_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                 SELECT tracking_number,case_number,applicant_name,file_id,current_timestamp(),file_date 
                   FROM (SELECT DISTINCT tracking_number,case_number,application_source 
                           ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) OR cpu_assigned = 'N'  OR REGEXP_INSTR(worker_id, '900') = 0 THEN 'Y' ELSE 'N' END ignore_application_indicator 
                          ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date                
                         FROM coverva_dmas.dmas_app_metric_and_renewal_vw amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                         WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl 
                   WHERE ignore_application_indicator = 'N' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = amfl.tracking_number AND dmas.file_inventory_date = amfl.file_date)                 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application x WHERE x.tracking_number = amfl.tracking_number AND x.file_inventory_date = amfl.file_date );`;                
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();

       /* insert excluded applications for appmetrics*/
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
                 SELECT tracking_number,file_id,ignore_application_reason,current_timestamp(),file_date 
                   FROM (SELECT DISTINCT tracking_number,case_number,application_source 
                           ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) OR cpu_assigned = 'N'  OR REGEXP_INSTR(worker_id, '900') = 0 THEN 'Y' ELSE 'N' END ignore_application_indicator 
                           ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Application Too early' 
                                 WHEN cpu_assigned = 'N' OR  REGEXP_INSTR(worker_id, '900') = 0 THEN 'Not a Maximus application' ELSE NULL END ignore_application_reason 
                          ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date                 
                         FROM coverva_dmas.dmas_app_metric_and_renewal_vw amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                         WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl 
                  WHERE ignore_application_indicator = 'Y' 
                  AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application dmas WHERE dmas.tracking_number = amfl.tracking_number AND dmas.file_inventory_date = amfl.file_date);` ;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();

       /* App List from AppMetrics PW */ 
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                 SELECT tracking_number,applicant_name,file_id,current_timestamp(),file_date 
                   FROM(SELECT DISTINCT tracking_number,application_source 
                          ,CASE WHEN application_received_date < CAST('03/16/2021' AS DATE) OR (ampfl.worker IS NOT NULL AND ldap.worker_name IS NULL) THEN 'Y' ELSE 'N' END ignore_application_indicator  
                          ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                        FROM coverva_dmas.app_metric_pw_full_load ampfl 
                          JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename 
                            LEFT JOIN(SELECT DISTINCT lname_initial worker_name FROM coverva_dmas.dmas_mms_ldap_full_load_vw ldap ) ldap ON UPPER(ldap.worker_name) = UPPER(ampfl.worker) 
                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ampfl 
                   WHERE ignore_application_indicator = 'N' 
                   AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = ampfl.tracking_number AND dmas.file_inventory_date = ampfl.file_date) 
                   AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application x WHERE x.tracking_number = ampfl.tracking_number AND x.file_inventory_date = ampfl.file_date);`;                
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
      /*insert excluded applications for pw */       
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
                 SELECT tracking_number,file_id,ignore_application_reason,current_timestamp(),file_date 
                   FROM(SELECT DISTINCT tracking_number,application_source 
                          ,CASE WHEN application_received_date < CAST('03/16/2021' AS DATE) OR (ampfl.worker IS NOT NULL AND ldap.worker_name IS NULL) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                          ,CASE WHEN application_received_date < CAST('03/16/2021' AS DATE) THEN 'Application Too early' 
                                 WHEN  ampfl.worker IS NOT NULL AND ldap.worker_name IS NULL THEN 'Not a Maximus application' ELSE NULL END ignore_application_reason 
                          ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                        FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename
                          LEFT JOIN(SELECT DISTINCT lname_initial worker_name FROM coverva_dmas.dmas_mms_ldap_full_load_vw ldap ) ldap ON UPPER(ldap.worker_name) = UPPER(ampfl.worker)  
                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ampfl 
                   WHERE ignore_application_indicator = 'Y' 
                   AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application dmas WHERE dmas.tracking_number = ampfl.tracking_number AND dmas.file_inventory_date = ampfl.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();    

       /* Locality Inboxes */
       var strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                    SELECT tracking_number,applicant_name,file_id,current_timestamp(),file_date
                        FROM (SELECT DISTINCT tracking_number, source, applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                              FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename 
                              WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cviu 
                        WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = cviu.tracking_number AND dmas.file_inventory_date = cviu.file_date);`;                     
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();
           
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                    SELECT tracking_number,applicant_name,file_id,current_timestamp(),file_date 
                        FROM (SELECT DISTINCT tracking_number, source,applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                              FROM coverva_dmas.cpu_incarcerated_full_load cpui JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = lf.filename 
                              WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cpui 
                        WHERE NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = cpui.tracking_number AND dmas.file_inventory_date = cpui.file_date);`; 
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* App List from CM43 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                SELECT tracking_number, applicant_name,file_id, current_timestamp(),file_date
                FROM (SELECT DISTINCT tracking_number,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator  
                             ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                       FROM coverva_dmas.cm043_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cm 
                 WHERE ignore_application_indicator = 'N' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = cm.tracking_number AND dmas.file_inventory_date = cm.file_date) 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application x WHERE x.tracking_number = cm.tracking_number AND x.file_inventory_date = cm.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* insert excluded applications for CM43 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
            SELECT tracking_number, file_id, ignore_application_reason, current_timestamp(),file_date 
               FROM (SELECT DISTINCT tracking_number tracking_number,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                            ,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Application Too early' ELSE NULL END ignore_application_reason 
                            ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                      FROM coverva_dmas.cm043_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename 
                      WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cm 
                WHERE ignore_application_indicator = 'Y' AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application dmas WHERE dmas.tracking_number = cm.tracking_number AND dmas.file_inventory_date = cm.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();        
       
       /* App List from CPU */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                SELECT tracking_number,applicant_name,file_id, current_timestamp(),file_date 
                FROM (SELECT DISTINCT tracking_number,application_source,lf.file_id,cname applicant_name, CAST(lf.file_date AS DATE) file_date 
                          ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Y' 
                                WHEN application_source = 'RDE' AND assigned_to IS NULL AND status IS NULL THEN 'Y' ELSE 'N' END ignore_application_indicator   
                          ,ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(lf.file_date AS DATE) ORDER BY lf.filename,cpu_data_id) rnk 
                       FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cdfl 
                 WHERE rnk = 1 AND ignore_application_indicator = 'N' 
                  AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application dmas WHERE dmas.tracking_number = cdfl.tracking_number AND dmas.file_inventory_date = cdfl.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* insert excluded applications for cpu*/
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
              SELECT tracking_number,file_id, ignore_application_reason,current_timestamp(),file_date 
                 FROM (SELECT DISTINCT tracking_number,application_source,lf.file_id,cname applicant_name,CAST(lf.file_date AS DATE) file_date 
                          ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Y' 
                                WHEN application_source = 'RDE' AND assigned_to IS NULL AND status IS NULL THEN 'Y' ELSE 'N' END ignore_application_indicator 
                          ,CASE WHEN app_received_date < CAST('03/16/2021' AS DATE) THEN 'Application Too early' 
                                WHEN application_source = 'RDE' AND assigned_to IS NULL AND status IS NULL THEN 'Unsubmitted phone application' 
                            ELSE NULL END ignore_application_reason 
                          ,ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(lf.file_date AS DATE) ORDER BY lf.filename,cpu_data_id) rnk 
                       FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cdfl 
                 WHERE rnk = 1 AND ignore_application_indicator = 'Y' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_application dmas WHERE dmas.tracking_number = cdfl.tracking_number AND dmas.file_inventory_date = cdfl.file_date);`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();       
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
  
    return 0; /* SUCCESS */   
  $$;