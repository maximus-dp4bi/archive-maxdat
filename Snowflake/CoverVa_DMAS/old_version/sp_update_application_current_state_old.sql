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
            + "     FROM(SELECT tdh.ext_app_id, "
            + "             MIN(LEAST(COALESCE(CAST(xacttk.task_complete_date AS DATE),CAST(comptsk.status_date AS DATE),CAST(sr.status_date AS DATE)),COALESCE(CAST(comptsk.status_date AS DATE),CAST(sr.status_date AS DATE),CAST(xacttk.task_complete_date AS DATE)), "
            + "                   COALESCE(CAST(sr.status_date AS DATE),CAST(xacttk.task_complete_date AS DATE),CAST(comptsk.status_date AS DATE)))) app_end_date "
            + "           FROM MARSDB.MARSDB_TASKS_VW sr "
            + "             JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id AND sr.project_id = tt2.project_id) "
            + "             JOIN MARSDB.MARSDB_PROJECT_VW p ON sr.project_id = p.project_id "
            + "             JOIN (SELECT ext_app_id,project_id, task_id "
            + "                   FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn "
            + "                        FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') "
            + "                   WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON sr.task_id = tdh.task_id AND sr.project_id = tdh.project_id "           
            + "       LEFT JOIN (SELECT srid,task_id,project_id,action_taken3 "
            + "                  FROM (SELECT DISTINCT el.internal_id AS srid, el.project_id,t.task_status, t.status_date, t.task_id, t.task_type_id, t.updated_by, t.staff_assigned_to, tt.task_type_name "
            + "                              ,th.task_field_id, th.task_field_name, th.task_detail_history_id, th.selection_varchar AS action_taken3 "
            + "                              ,RANK() OVER(PARTITION BY el.internal_id,el.project_id  ORDER BY th.task_detail_history_id DESC) rn "
            + "                        FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                          LEFT JOIN MARSDB.MARSDB_TASKS_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id AND t.task_type_id = 15182) "
            + "                          JOIN MARSDB.MARSDB_TASK_TYPE_VW tt ON (t.task_type_id = tt.task_type_id AND tt.project_id = t.project_id) "
            + "                          LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th ON (t.task_id = th.task_id AND th.project_id = t.project_id AND UPPER(th.task_field_name) = 'ACTION TAKEN SINGLE') "
            + "                        WHERE  el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST') "
            + "                  WHERE rn = 1 ) acttk3 ON (acttk3.srid = sr.task_id AND acttk3.project_id = sr.project_id) "
            + "      LEFT JOIN (SELECT srid,task_id,project_id,action_taken,task_complete_date,task_status "
            + "                  FROM (SELECT DISTINCT el.internal_id AS srid, el.project_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date task_complete_date, th.selection_varchar as action_taken "
            + "                                ,RANK() OVER(PARTITION BY el.internal_id,el.project_id  ORDER BY th.task_detail_history_id DESC,th.task_history_id DESC) rn "
            + "                         FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                           LEFT JOIN MARSDB.MARSDB_TASKS_HISTORY_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id) "
            + "                           LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th ON (t.task_id = th.task_id AND t.project_id = th.project_id AND UPPER(th.task_field_name) = 'ACTION TAKEN SINGLE') "
            + "                        WHERE el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST'  AND t.task_status = 'Complete') "
            + "                  WHERE rn = 1 ) xacttk ON (xacttk.srid = sr.task_id AND xacttk.project_id = sr.project_id AND xacttk.task_status = 'Complete') "
            + "       LEFT JOIN (SELECT srid,project_id,task_status,status_date "
            + "                  FROM (SELECT DISTINCT el.internal_id as srid, t.task_status, t.status_date, el.project_id,RANK() OVER(PARTITION BY el.internal_id ORDER BY th.task_detail_history_id DESC) rn "
            + "                        FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                          LEFT JOIN MARSDB.MARSDB_TASKS_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id) "
            + "                          JOIN MARSDB.MARSDB_TASK_TYPE_VW tt ON (t.task_type_id = tt.task_type_id AND t.project_id = tt.project_id) "
            + "                          LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id AND t.project_id = th.project_id) "
            + "                        WHERE el.external_ref_type = 'TASK' AND el.internal_ref_type = 'SERVICE_REQUEST' AND t.task_status in ('Closed','Complete')) "
            + "                  WHERE rn = 1 ) comptsk on (comptsk.srid = sr.task_id AND comptsk.project_id = sr.project_id) "
            + "      WHERE sr.task_type_id IN (13473,13475,15180,15181) "
            + "      AND (xacttk.action_taken = 'TRANSFERRED_TO_LDSS' OR acttk3.action_taken3 = 'TRANSFERRED_TO_LDSS' ) "
            + "      AND p.project_name = 'CoverVA' "
            + "      GROUP BY tdh.ext_app_id) tat "
            + "  WHERE dmas.application_id = tat.ext_app_id AND dmas.file_inventory_date = CAST(:1 AS DATE) AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
       
       
       /* From CM044 - First status in alphabetical order */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = cm.status,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() \
            FROM (SELECT tracking_number, status,app_end_date,file_date \
                        FROM (SELECT tracking_number,status,CASE WHEN UPPER(status) IN('APPROVED','DENIED') THEN authorized_date ELSE NULL END app_end_date, \
                                CAST(lf.file_date AS DATE) AS file_date,RANK() OVER(PARTITION BY cm.tracking_number ORDER BY lf.file_id DESC,UPPER(LEFT(cm.status,1))) rnk \
                              FROM coverva_dmas.CM044_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename \
                              WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) WHERE rnk = 1 ) cm \
            WHERE dmas.application_id = cm.tracking_number AND dmas.file_inventory_date = cm.file_date AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* Approved/Denied/Needs Research */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = da.current_state,application_processing_end_date = app_end_date,fp_update_dt = current_timestamp() "
            + "FROM(SELECT ext_app_id,current_state,app_end_date,RANK() OVER (PARTITION BY ext_app_id ORDER BY DECODE(current_state,'Approved',1,'Denied',2,3),app_end_date,task_id) rn "
            + "  FROM(SELECT DISTINCT sr.task_id,tdh.ext_app_id "
            + "           ,CASE WHEN COALESCE(disposition,sr_disposition) IN('APPROVED','AUTO_APPROVED') THEN 'Approved' "
            + "                WHEN COALESCE(disposition,sr_disposition) IN('DENIED','AUTO_DENIED') THEN 'Denied' ELSE 'Complete - Needs Research' END current_state "
            + "           ,CASE WHEN COALESCE(disposition,sr_disposition) IN('DENIED','AUTO_DENIED','APPROVED','AUTO_APPROVED') THEN "
            + "               LEAST(COALESCE(CAST(dispo.task_complete_date AS DATE),CAST(comptsk.status_date AS DATE),CAST(sr.status_date AS DATE)), "
            + "                     COALESCE(CAST(comptsk.status_date AS DATE),CAST(sr.status_date AS DATE),CAST(dispo.task_complete_date AS DATE)), "
            + "                     COALESCE(CAST(sr.status_date AS DATE),CAST(dispo.task_complete_date AS DATE),CAST(comptsk.status_date AS DATE))) ELSE NULL END app_end_date "
            + "       FROM MARSDB.MARSDB_TASKS_VW sr "
            + "         JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id AND sr.project_id = tt2.project_id) "
            + "         JOIN MARSDB.MARSDB_PROJECT_VW p ON sr.project_id = p.project_id "
            + "         JOIN (SELECT ext_app_id,project_id, task_id "
            + "               FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn "
            + "                    FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') "
            + "                    WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON sr.task_id = tdh.task_id AND sr.project_id = tdh.project_id "
            + "                LEFT JOIN (SELECT srid,project_id,task_id, disposition,task_complete_date "
            + "                           FROM (SELECT DISTINCT el.internal_id AS SRID, el.project_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date "
            + "                                   ,t.updated_by, th.selection_varchar AS disposition, t.status_date task_complete_date "
            + "                                   ,RANK() OVER(PARTITION BY el.internal_id,el.project_id  ORDER BY th.task_detail_history_id DESC,th.task_history_id DESC) rn "
            + "                                 FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                                   LEFT JOIN MARSDB.MARSDB_TASKS_HISTORY_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id) "
            + "                                   LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th ON (t.task_id = th.task_id AND t.project_id = th.project_id AND UPPER(th.task_field_name) = 'DISPOSITION') "
            + "                                 WHERE el.external_ref_type = 'TASK' "
            + "                                 AND el.internal_ref_type = 'SERVICE_REQUEST' "
            + "                                 AND t.task_status = 'Complete') "
            + "                          WHERE rn = 1 ) dispo ON (dispo.srid = sr.task_id AND dispo.project_id = sr.project_id) "
            + "           LEFT JOIN (SELECT task_id,project_id,sr_disposition "
            + "                      FROM (SELECT distinct tdh.task_id, tdh.project_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.selection_varchar sr_disposition "
            + "                              ,row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn "
            + "                            FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(tdh.task_field_name) = 'DISPOSITION' ) "
            + "                      WHERE rn = 1 ) sr_dispo ON sr_dispo.task_id = sr.task_id AND sr_dispo.project_id = sr.project_id "            
            + "                LEFT JOIN (SELECT SRID,project_id,status_date,task_status "
            + "                           FROM (SELECT DISTINCT el.internal_id as SRID, t.task_status, t.status_date, el.project_id "
            + "                                   ,RANK() OVER(PARTITION BY el.internal_id ORDER BY th.task_detail_history_id DESC) rn "
            + "                                FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                                  LEFT JOIN MARSDB.MARSDB_TASKS_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id) "
            + "                                  JOIN MARSDB.MARSDB_TASK_TYPE_VW tt ON (t.task_type_id = tt.task_type_id AND t.project_id = tt.project_id) "
            + "                                  LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th on (t.task_id = th.task_id AND t.project_id = th.project_id) "
            + "                                WHERE el.external_ref_type = 'TASK' "
            + "                                AND el.internal_ref_type = 'SERVICE_REQUEST' "
            + "                                AND t.task_status in ('Closed','Complete')) "
            + "                            WHERE rn = 1 ) comptsk on (comptsk.srid = sr.task_id AND comptsk.project_id = sr.project_id) "
            + "               JOIN coverva_dmas.dmas_application dmas ON dmas.application_id = tdh.ext_app_id AND CAST(dmas.file_inventory_date AS DATE) = CAST(:1 AS DATE) "
            + "        WHERE sr.task_type_id IN (13473,13475,15180,15181) AND p.project_name = 'CoverVA' "
            + "        AND COALESCE(disposition,sr_disposition) != 'PENDING_MI'"
            + "        AND (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE dmas.application_id = amfl.app_number AND CAST(lf.file_date AS DATE) = CAST(:2 AS DATE) ) "
            + "        OR NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE dmas.application_id = ampfl.application_number AND CAST(lf.file_date AS DATE) = CAST(:3 AS DATE) ) "
            + "        OR NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE dmas.application_id = pdfl.t_number AND CAST(lf.file_date AS DATE) = CAST(:4 AS DATE) ) ) ) ) da "
            + "    WHERE da.rn = 1 AND dmas.application_id = da.ext_app_id AND dmas.file_inventory_date = CAST(:5 AS DATE) AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE,INV_FILE_DATE,INV_FILE_DATE,INV_FILE_DATE,INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
              
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.current_state = cpu.current_state,fp_update_dt = current_timestamp() "
            + " FROM(SELECT tracking_number,'Complete - Needs Research' current_state, file_date "
            + "      FROM(SELECT tracking_number,status,CAST(lf.file_date AS DATE) AS file_date,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_id) rnk "
            + "           FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename "
            + "           WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) cpu "
            + "      WHERE rnk = 1 "
            + "      AND UPPER(status) = 'SUBMITTED' "
            + "      AND (NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename WHERE cpu.tracking_number = amfl.app_number AND CAST(lf.file_date AS DATE) = CAST(:2 AS DATE) ) "
            + "      OR NOT EXISTS(SELECT 1 FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename WHERE cpu.tracking_number= ampfl.application_number AND CAST(lf.file_date AS DATE) = CAST(:3 AS DATE) ) "
            + "      OR NOT EXISTS(SELECT 1 FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename WHERE cpu.tracking_number = pdfl.t_number AND CAST(lf.file_date AS DATE) = CAST(:4 AS DATE) ) ) ) cpu "
            + " WHERE dmas.application_id = cpu.tracking_number AND dmas.file_inventory_date = cpu.file_date AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE,INV_FILE_DATE,INV_FILE_DATE,INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                    
       
       
       
       /* Waiting Initial Review. */       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting Initial Review',fp_update_dt = current_timestamp() \
            FROM (SELECT app_number,pending_due_to_vcl,file_date \
                  FROM (SELECT app_number,pending_due_to_vcl,CAST(lf.file_date AS DATE) AS file_date,RANK() OVER(PARTITION BY amfl.app_number ORDER BY lf.file_id DESC) rnk \
                        FROM app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename \
                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl \
                  WHERE rnk = 1 AND COALESCE(pending_due_to_vcl,'N') = 'N' ) amfl \
            WHERE dmas.application_id = amfl.app_number AND dmas.file_inventory_date = amfl.file_date AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = 'Waiting for Verification Documents',fp_update_dt = current_timestamp() "
            + " FROM(SELECT DISTINCT sr.task_id,tdh.ext_app_id,disposition,sr_disposition "
            + "        FROM MARSDB.MARSDB_TASKS_VW sr "
            + "          JOIN MARSDB.MARSDB_TASK_TYPE_VW tt2 on (sr.task_type_id = tt2.task_type_id AND sr.project_id = tt2.project_id) "
            + "          JOIN MARSDB.MARSDB_PROJECT_VW p ON sr.project_id = p.project_id "
            + "          JOIN (SELECT ext_app_id,project_id, task_id "
            + "                FROM(SELECT tdh.task_id, tdh.project_id,tdh.selection_varchar AS ext_app_id, RANK() OVER (PARTITION BY tdh.task_id ORDER BY tdh.task_detail_history_id DESC) rn "
            + "                     FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(task_field_name) = 'EXTERNAL APPLICATION ID') "
            + "                     WHERE rn = 1 AND ext_app_id IS NOT NULL) tdh ON sr.task_id = tdh.task_id AND sr.project_id = tdh.project_id "
            + "                 LEFT JOIN (SELECT srid,project_id,task_id, disposition,task_complete_date "
            + "                            FROM (SELECT DISTINCT el.internal_id AS SRID, el.project_id, th.task_detail_history_id, t.task_id, t.task_type_id, t.task_status, t.status_date "
            + "                                    ,t.updated_by, th.selection_varchar AS disposition, t.status_date task_complete_date "
            + "                                    ,RANK() OVER(PARTITION BY el.internal_id,el.project_id  ORDER BY th.task_detail_history_id DESC) rn "
            + "                                  FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW el "
            + "                                    LEFT JOIN MARSDB.MARSDB_TASKS_VW t ON (el.external_ref_id = t.task_id AND el.project_id = t.project_id) "
            + "                                    LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW th ON (t.task_id = th.task_id AND t.project_id = th.project_id AND UPPER(th.task_field_name) = 'DISPOSITION') "
            + "                                  WHERE el.external_ref_type = 'TASK' "
            + "                                  AND el.internal_ref_type = 'SERVICE_REQUEST' "
            + "                                  AND t.task_status = 'Complete' ) "
            + "                           WHERE rn = 1 ) dispo ON (dispo.srid = sr.task_id AND dispo.project_id = sr.project_id) "   
            + "           LEFT JOIN (SELECT task_id,project_id,sr_disposition "
            + "                      FROM (SELECT distinct tdh.task_id, tdh.project_id, tdh.task_detail_id, tdh.task_detail_history_id, tdh.task_field_id, tdh.task_field_name, tdh.selection_varchar sr_disposition "
            + "                              ,row_number() over (partition by tdh.task_id, tdh.task_field_id  order by tdh.task_detail_history_id desc, tdh.task_history_id desc) rn "
            + "                            FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW tdh WHERE UPPER(tdh.task_field_name) = 'DISPOSITION' ) "
            + "                      WHERE rn = 1 ) sr_dispo ON sr_dispo.task_id = sr.task_id AND sr_dispo.project_id = sr.project_id "                
            + "         WHERE sr.task_type_id IN (13473,13475,15180,15181) AND p.project_name = 'CoverVA' "
            + "         AND (disposition = 'PENDING_MI' OR sr_disposition = 'PENDING_MI') ) disp "
            + " WHERE dmas.application_id = disp.ext_app_id AND dmas.file_inventory_date = CAST(:1 AS DATE) AND COALESCE(dmas.current_state,'X') NOT IN('Transferred to LDSS','Approved','Denied');";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();

       /*Set initial status to Waiting Initial Review. */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas SET dmas.current_state = 'Waiting Initial Review' WHERE dmas.current_state IS NULL AND dmas.file_inventory_date = CAST(:1 AS DATE) ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();     
             
       /* Override source value */
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.current_state = aofl.current_state, fp_update_dt = current_timestamp() ,override_value_indicator = 'Y' \
            FROM (SELECT tracking_number,current_state,file_date \
                  FROM(SELECT tracking_number,current_state, CAST(lf.file_date AS DATE) AS file_date,RANK() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC) rnk \
                       FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename) aofl WHERE rnk =1 AND current_state IS NOT NULL ) aofl \
            WHERE dmas.application_id = aofl.tracking_number AND dmas.file_inventory_date = CAST(:1 AS DATE);";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();         
             
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;