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
      
      /* Transferred to LDSS*/
      var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "          
            + "SET dmas.current_state = 'Transferred to LDSS',application_processing_end_date = app_end_date, fp_update_dt = current_timestamp() "
            + "     FROM(SELECT tracking_number, MIN(LEAST(COALESCE(complete_task_date,sr_status_date),COALESCE(sr_status_date,complete_task_date))) app_end_date "
            + "          FROM coverva_dmas.cp_application_inventory "
            + "          WHERE action_taken = 'TRANSFERRED_TO_LDSS' "
            + "          GROUP BY tracking_number) tat "
            + "  WHERE dmas.tracking_number = tat.tracking_number AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "          
            + "SET dmas.current_state = 'Transferred to LDSS',application_processing_end_date = cpu_activity_date, fp_update_dt = current_timestamp() "
            + "FROM(SELECT application_number,sent_to_ldss,CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cpu_activity_date "
            + "     FROM(SELECT application_number,sent_to_ldss,activity_date, RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC) rnk "
            + "          FROM coverva_dmas.manual_cpu_tracking mct) "
            + "     WHERE rnk = 1 AND sent_to_ldss = '1') mct "
            + "  WHERE  dmas.tracking_number = mct.application_number  AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
              
        var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "          
            + "SET dmas.current_state = 'Transferred to LDSS',application_processing_end_date = app_end_date, fp_update_dt = current_timestamp() "
            + "     FROM(SELECT tracking_number, MIN(status_date) app_end_date "
            + "          FROM coverva_dmas.cp_initial_application_review "
            + "          WHERE action_taken = 'TRANSFERRED_TO_LDSS' "
            + "          GROUP BY tracking_number) tat "
            + "  WHERE dmas.tracking_number = tat.tracking_number AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       /* From CM044 - First status in alphabetical order */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.current_state = cm.status,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number, status,app_end_date,file_date "
            + "            FROM (SELECT tracking_number,status,CASE WHEN UPPER(status) IN('APPROVED','DENIED') THEN authorized_date ELSE NULL END app_end_date, "
            + "                    CAST(lf.file_date AS DATE) AS file_date,RANK() OVER(PARTITION BY cm.tracking_number ORDER BY lf.file_date DESC,UPPER(LEFT(cm.status,1))) rnk "
            + "                  FROM coverva_dmas.CM044_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename) "
            + "                  WHERE rnk = 1 ) cm "
            + " WHERE dmas.tracking_number = cm.tracking_number AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();
       
       /* Approved/Denied/Needs Research */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = da.current_state,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() "
            + "FROM(SELECT tracking_number,current_state,app_end_date "
            + "     FROM(SELECT tracking_number, "
            + "            CASE WHEN disposition IN('APPROVED','AUTO_APPROVED') THEN 'Approved' "
            + "                 WHEN disposition IN('DENIED','AUTO_DENIED') THEN 'Denied' ELSE 'Complete - Needs Research' END current_state, "
            + "            CASE WHEN disposition IN('DENIED','AUTO_DENIED','APPROVED','AUTO_APPROVED') THEN "
            + "              LEAST(COALESCE(complete_task_date,sr_status_date),COALESCE(sr_status_date,complete_task_date)) ELSE NULL END app_end_date "
            + "           ,RANK() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),COALESCE(complete_task_date,sr_status_date),sr_id) rn "
            + "          FROM coverva_dmas.cp_application_inventory cp "  
            + "          WHERE disposition NOT IN('PENDING_MI','CANCELLED') ) cp "
            + "      WHERE rn = 1 "
            + "      AND (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE cp.tracking_number = amfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE cp.tracking_number = ampfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE cp.tracking_number = pdfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ) ) da "
            + "    WHERE dmas.tracking_number = da.tracking_number  AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = da.cpu_current_state,application_processing_end_date = cpu_activity_date,fp_update_dt = current_timestamp() "
            + "FROM(SELECT application_number,cpu_current_state,cpu_activity_date "
            + "     FROM(SELECT application_number,CASE WHEN approved = '1' THEN 'Approved' WHEN denied = '1' THEN 'Denied' ELSE NULL END cpu_current_state,cpu_activity_date "
            + "          FROM(SELECT application_number,approved,denied, CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) cpu_activity_date, "
            + "                     RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE) DESC,approved,denied) rnk "
            + "               FROM coverva_dmas.manual_cpu_tracking mct ) "
            + "          WHERE rnk = 1 AND (approved = '1' OR denied = '1') ) cp "            
            + "      WHERE (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE amfl.tracking_number= cp.application_number  AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE ampfl.tracking_number = cp.application_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE pdfl.tracking_number = cp.application_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ) ) da "
            + "    WHERE dmas.tracking_number = da.application_number AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute(); 
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = da.current_state,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() "
            + "FROM(SELECT tracking_number,current_state,app_end_date "
            + "     FROM(SELECT tracking_number, "
            + "            CASE WHEN disposition IN('APPROVED','AUTO_APPROVED') THEN 'Approved' "
            + "                 WHEN disposition IN('DENIED','AUTO_DENIED') THEN 'Denied' ELSE 'Complete - Needs Research' END current_state, "
            + "            CASE WHEN disposition IN('DENIED','AUTO_DENIED','APPROVED','AUTO_APPROVED') THEN  status_date ELSE NULL END app_end_date "            
            + "           ,RANK() OVER (PARTITION BY tracking_number ORDER BY DECODE(disposition,'APPROVED',1,'AUTO_APPROVED',1,'DENIED',2,'AUTO_DENIED',2,3),status_date,task_id) rn "
            + "          FROM coverva_dmas.cp_initial_application_review cp "  
            + "          WHERE disposition NOT IN('PENDING_MI','CANCELLED') ) cp "
            + "      WHERE rn = 1 "
            + "      AND (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE cp.tracking_number = amfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE cp.tracking_number = ampfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE cp.tracking_number = pdfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ) ) da "
            + "    WHERE dmas.tracking_number = da.tracking_number  AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
              
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.current_state = cpu.current_state,fp_update_dt = current_timestamp() "
            + " FROM(SELECT tracking_number,'Complete - Needs Research' current_state, file_date "
            + "      FROM(SELECT tracking_number,status,CAST(lf.file_date AS DATE) AS file_date,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC) rnk "
            + "           FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename ) cpu "
            + "      WHERE rnk = 1 "
            + "      AND UPPER(status) = 'SUBMITTED' "
            + "      AND (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE cpu.tracking_number = amfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE cpu.tracking_number= ampfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) "
            + "      AND NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE cpu.tracking_number = pdfl.tracking_number AND CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) ) ) cpu "
            + " WHERE dmas.tracking_number = cpu.tracking_number AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                    
       
       /* Waiting Initial Review/Waiting for Verification Documents. */       
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = vcl.current_state,fp_update_dt = current_timestamp() "
            + "FROM (SELECT da.tracking_number, "
            + "        CASE WHEN COALESCE(vclpw.pending_due_to_vcl,vclam.pending_due_to_vcl,'N') = 'N' AND (CAST(vclam.file_date AS DATE) = CAST(:1 AS DATE) OR CAST(vclpw.file_date AS DATE) = CAST(:1 AS DATE)) "
            + "               THEN 'Waiting Initial Review' "
            + "             WHEN COALESCE(vclpw.pending_due_to_vcl,vclam.pending_due_to_vcl) = 'Y' AND (CAST(vclam.file_date AS DATE) = CAST(:1 AS DATE) OR CAST(vclpw.file_date AS DATE) = CAST(:1 AS DATE)) "
            + "               THEN 'Waiting for Verification Documents' "
            + "             WHEN (iar.tracking_number IS NOT NULL OR ai.tracking_number IS NOT NULL)  "
            + "                 THEN 'Waiting for Verification Documents'  ELSE 'Waiting Initial Review' END current_state,da.file_inventory_date  file_date "
            + "      FROM coverva_dmas.dmas_application da "
            + "        LEFT JOIN(SELECT tracking_number, pending_due_to_vcl,file_date "
            + "                  FROM(SELECT tracking_number,pending_due_to_vcl,CAST(lf.file_date AS DATE) AS file_date,RANK() OVER(PARTITION BY amfl.tracking_number ORDER BY lf.file_date DESC) rnk "
            + "                       FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename) amfl "
            + "                  WHERE rnk = 1 ) vclam ON da.tracking_number = vclam.tracking_number "
            + "        LEFT JOIN(SELECT tracking_number, pending_due_to_vcl,file_date "
            + "                  FROM(SELECT tracking_number tracking_number,pending_due_to_vcl,CAST(lf.file_date AS DATE) AS file_date,RANK() OVER(PARTITION BY ampfl.tracking_number ORDER BY lf.file_date DESC) rnk "
            + "                       FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename) ampfl "
            + "                  WHERE rnk = 1 ) vclpw ON da.tracking_number = vclpw.tracking_number "
            + "        LEFT JOIN(SELECT DISTINCT tracking_number "
            + "                  FROM coverva_dmas.cp_initial_application_review "
            + "                  WHERE disposition = 'PENDING_MI') iar ON iar.tracking_number = da.tracking_number "
            + "        LEFT JOIN(SELECT DISTINCT tracking_number "
            + "                  FROM coverva_dmas.cp_application_inventory "
            + "                  WHERE disposition = 'PENDING_MI') ai ON ai.tracking_number = da.tracking_number  ) vcl "
            + " WHERE dmas.tracking_number = vcl.tracking_number AND dmas.file_inventory_date = vcl.file_date AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
              
       /*Set initial status to Waiting Initial Review. */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas SET dmas.current_state = 'Waiting Initial Review' WHERE dmas.current_state IS NULL  ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();     
             
       /* Override source value */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.current_state = aofl.current_state, fp_update_dt = current_timestamp() ,override_value_indicator = 'Y' "
            + " FROM (SELECT tracking_number,current_state,file_date "
            + "       FROM(SELECT tracking_number,current_state, CAST(lf.file_date AS DATE) AS file_date,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC, aofl.recent_submission_date DESC) rnk "
            + "            FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl WHERE rnk =1 AND current_state IS NOT NULL ) aofl "
            + " WHERE dmas.tracking_number = aofl.tracking_number;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();         
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;