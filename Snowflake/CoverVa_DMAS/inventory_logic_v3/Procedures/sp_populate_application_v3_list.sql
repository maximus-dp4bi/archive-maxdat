use schema coverva_dmas;
create or replace procedure SP_POPULATE_APPLICATION_V3_LIST(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
          /* STEP 1: Get list of application IDs */
         
       /* App List from AppMetrics */     
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION_V3_INVENTORY (tracking_number,case_number,applicant_name,file_id,fp_create_dt,file_inventory_date,case_incarcerated_indicator,application_incarcerated_indicator) 
                 SELECT tracking_number,case_number,applicant_name,file_id,current_timestamp(),file_date,case_incarcerated_indicator,application_incarcerated_indicator 
                   FROM (SELECT DISTINCT tracking_number,case_number,application_source 
                           ,CASE WHEN (application_type = 'Renewal' AND app_received_date < CAST('04/01/2023' AS DATE))
                              OR (application_type != 'Renewal' AND app_received_date < CAST('03/16/2021' AS DATE)) 
                             OR ((REGEXP_INSTR(worker_id, '900') = 0 OR processing_unit = 'LDSS')
                                AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory v WHERE v.tracking_number = amfl.tracking_number AND CAST(v.file_inventory_date AS DATE) < CAST(lf.file_date AS DATE)) ) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                           ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date  
                           ,case_incarcerated_indicator,application_incarcerated_indicator
                         FROM coverva_dmas.app_metric_v2_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                         WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                         QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,appmetric_data_id DESC) = 1  ) amfl 
                   WHERE ignore_application_indicator = 'N' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory dmas WHERE dmas.tracking_number = amfl.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(amfl.file_date AS DATE)  )                 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application x WHERE x.tracking_number = amfl.tracking_number AND CAST(x.file_inventory_date AS DATE) = CAST(amfl.file_date AS DATE) );`;                
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();

       /* insert excluded applications for appmetrics*/
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_V3_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
                   SELECT tracking_number,file_id,ignore_application_reason,current_timestamp(),file_date 
                   FROM (SELECT DISTINCT tracking_number,application_source 
                           ,CASE WHEN (application_type = 'Renewal' AND app_received_date < CAST('04/01/2023' AS DATE))
                              OR (application_type != 'Renewal' AND app_received_date < CAST('03/16/2021' AS DATE))                            
                              OR ((REGEXP_INSTR(worker_id, '900') = 0 OR processing_unit = 'LDSS')
                                AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory v WHERE v.tracking_number = amfl.tracking_number AND CAST(v.file_inventory_date AS DATE) < CAST(lf.file_date AS DATE)) ) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                          ,CASE WHEN (application_type = 'Renewal' AND app_received_date < CAST('04/01/2023' AS DATE))
                                OR (application_type != 'Renewal' AND app_received_date < CAST('03/16/2021' AS DATE)) THEN 'Application Too early' 
                                 WHEN  ((REGEXP_INSTR(worker_id, '900') = 0 OR processing_unit = 'LDSS')
                                AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory v WHERE v.tracking_number = amfl.tracking_number AND CAST(v.file_inventory_date AS DATE) < CAST(lf.file_date AS DATE)) ) 
                             THEN 'Not a Maximus application' ELSE NULL END ignore_application_reason     
                          ,CONCAT(applicant_last_name,', ',applicant_first_name) applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date                
                         FROM coverva_dmas.app_metric_v2_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                         WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                         QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,appmetric_data_id DESC) = 1  ) amfl 
                   WHERE ignore_application_indicator = 'Y' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory dmas WHERE dmas.tracking_number = amfl.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(amfl.file_date AS DATE));` ;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* App List from CM43 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION_V3_INVENTORY (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                SELECT tracking_number, applicant_name,file_id, current_timestamp(),file_date 
                FROM (SELECT DISTINCT tracking_number,
                             CASE WHEN (application_type = 'Renewal' AND date_received < CAST('04/01/2023' AS DATE))
                                OR (application_type != 'Renewal' AND date_received < CAST('03/16/2021' AS DATE)) 
                               THEN 'Y' ELSE 'N' END ignore_application_indicator  
                             ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                       FROM coverva_dmas.cm043_data_full_load cm 
                         JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cm043_data_id DESC) = 1 ) cm 
                 WHERE ignore_application_indicator = 'N' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory dmas WHERE dmas.tracking_number = cm.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(cm.file_date AS DATE)) 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application x WHERE x.tracking_number = cm.tracking_number AND CAST(x.file_inventory_date AS DATE) = CAST(cm.file_date AS DATE));`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* insert excluded applications for CM43 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_V3_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
            SELECT tracking_number, file_id, ignore_application_reason, current_timestamp(),file_date 
               FROM (SELECT DISTINCT tracking_number,
                            CASE WHEN (application_type = 'Renewal' AND date_received < CAST('04/01/2023' AS DATE))
                                OR (application_type != 'Renewal' AND date_received < CAST('03/16/2021' AS DATE)) 
                              THEN 'Y' ELSE 'N' END ignore_application_indicator 
                            ,CASE WHEN (application_type = 'Renewal' AND date_received < CAST('04/01/2023' AS DATE))
                                OR (application_type != 'Renewal' AND date_received < CAST('03/16/2021' AS DATE)) 
                               THEN 'Application Too early' ELSE NULL END ignore_application_reason 
                            ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                      FROM coverva_dmas.cm043_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename 
                      WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                      QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cm043_data_id DESC) = 1) cm 
                WHERE ignore_application_indicator = 'Y' 
                AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application dmas WHERE dmas.tracking_number = cm.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(cm.file_date AS DATE));`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();        
       
       /* App List from RP190 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION_V3_INVENTORY (tracking_number,applicant_name,file_id,fp_create_dt,file_inventory_date) 
                SELECT tracking_number, applicant_name,file_id, current_timestamp(),file_date 
                FROM (SELECT DISTINCT tracking_number,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator  
                             ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                       FROM coverva_dmas.rp190_data_full_load rp 
                         JOIN coverva_dmas.dmas_file_log lf ON UPPER(rp.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,rp190_data_id DESC) = 1) rp 
                 WHERE ignore_application_indicator = 'N' 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory dmas WHERE dmas.tracking_number = rp.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(rp.file_date AS DATE)) 
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application x WHERE x.tracking_number = rp.tracking_number AND CAST(x.file_inventory_date AS DATE) = CAST(rp.file_date AS DATE));`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* insert excluded applications for RP190 */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_EXCLUDED_V3_APPLICATION (tracking_number,file_id,ignore_application_reason,fp_create_dt,file_inventory_date) 
            SELECT tracking_number, file_id, ignore_application_reason, current_timestamp(),file_date 
               FROM (SELECT DISTINCT tracking_number tracking_number,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Y' ELSE 'N' END ignore_application_indicator 
                            ,CASE WHEN date_received < CAST('03/16/2021' AS DATE) THEN 'Application Too early' ELSE NULL END ignore_application_reason 
                            ,name applicant_name,lf.file_id,CAST(lf.file_date AS DATE) file_date 
                      FROM coverva_dmas.rp190_data_full_load rp JOIN coverva_dmas.dmas_file_log lf ON UPPER(rp.filename) = lf.filename 
                      WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                      QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,rp190_data_id DESC) = 1) rp 
                WHERE ignore_application_indicator = 'Y' 
                AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application dmas WHERE dmas.tracking_number = rp.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(rp.file_date AS DATE));`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();    
       
       /* App List from CVIU Liaison Smartsheet */
       strSQLText = `INSERT INTO COVERVA_DMAS.DMAS_APPLICATION_V3_INVENTORY (tracking_number,case_number,file_id,fp_create_dt,file_inventory_date) 
                SELECT tracking_number,case_number,file_id, current_timestamp(),file_date 
                FROM (SELECT DISTINCT tracking_number,case_number,lf.file_id, CAST(lf.file_date AS DATE) file_date                             
                          ,ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cviu_liaison_id DESC) rnk 
                       FROM coverva_dmas.cviu_liaison_data_full_load cvl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cvl.filename) = lf.filename 
                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)
                       AND UPPER(paper_application) LIKE 'PAPER%'
                       AND tracking_number IS NOT NULL
                       AND COALESCE(CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) ,
                                 CASE WHEN TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) IS NOT NULL
                                      AND LEFT(date(TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) ),2) >= 20 THEN
                                        TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) ELSE NULL END  ) IS NOT NULL) cvl 
                 WHERE rnk = 1
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_inventory dmas WHERE dmas.tracking_number = cvl.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(cvl.file_date AS DATE))
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_excluded_v3_application dmas WHERE dmas.tracking_number = cvl.tracking_number AND CAST(dmas.file_inventory_date AS DATE) = CAST(cvl.file_date AS DATE));`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* Remove applications found in Removal List */
       strSQLText = `DELETE FROM COVERVA_DMAS.DMAS_APPLICATION_V3_INVENTORY inv
                     WHERE EXISTS(SELECT 1 FROM application_removal_list_full_load rm WHERE rm.tracking_number = inv.tracking_number );`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();   
    
       strSQLText = `DELETE FROM COVERVA_DMAS.DMAS_APPLICATION_V3_CURRENT inv
                     WHERE EXISTS(SELECT 1 FROM application_removal_list_full_load rm WHERE rm.tracking_number = inv.tracking_number );`;              
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();                 
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
  
    return 0; /* SUCCESS */   
  $$;