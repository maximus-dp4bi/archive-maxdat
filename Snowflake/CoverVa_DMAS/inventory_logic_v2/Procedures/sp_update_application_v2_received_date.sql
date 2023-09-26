use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V2_RECEIVED_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 3: Update app received date */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas 
             SET dmas.app_received_date = ard.app_received_date, dmas.state_app_received_date = ard.state_app_received_date, dmas.override_value_indicator = ard.override_indicator, fp_update_dt = current_timestamp() 
             FROM (SELECT DISTINCT da.tracking_number,da.file_inventory_date 
                      ,DATE(COALESCE(aofl.app_received_date,cpu.app_received_date,mar.app_received_date)) app_received_date 
                      ,DATE(COALESCE(aofl.app_received_date,cpu.state_app_received_date,mar.app_received_date)) state_app_received_date 
                     ,CASE WHEN aofl.app_received_date IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                   FROM coverva_dmas.dmas_application_v2_inventory da 
                      LEFT JOIN(SELECT tracking_number, MIN(CAST(lf.file_date AS DATE)) OVER(PARTITION BY tracking_number ORDER BY CAST(lf.file_date AS DATE), cpu_data_id) app_received_date 
                                   , MIN(app_received_date) OVER(PARTITION BY tracking_number ORDER BY CAST(lf.file_date AS DATE), cpu_data_id) state_app_received_date 
                                FROM coverva_dmas.cpu_data_full_load cpu 
                                  JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename 
                                    WHERE application_source = 'RDE' 
                                    AND (assigned_to IS NOT NULL OR status IS NOT NULL)
                                UNION ALL 
                                SELECT tracking_number, MIN(rundate) app_received_date, MIN(app_received_date) state_app_received_date 
                                FROM coverva_dmas.cpu_data_full_load cpu 
                                  JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename 
                                WHERE COALESCE(application_source,'X') != 'RDE' 
                                GROUP BY tracking_number ) cpu ON da.tracking_number = cpu.tracking_number 
                      LEFT JOIN (SELECT tracking_number,file_date,MIN(app_received_date) app_received_date 
                                 FROM(SELECT tracking_number,date_received app_received_date,file_date 
                                      FROM (SELECT DISTINCT tracking_number, CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) date_received,CAST(lf.file_date AS DATE) file_date 
                                            FROM coverva_dmas.cpu_incarcerated_full_load cpui JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = lf.filename ) cpui 
                                            UNION SELECT tracking_number,date_received,file_date 
                                            FROM (SELECT DISTINCT tracking_number, CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) date_received,CAST(lf.file_date AS DATE) file_date 
                                                  FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename) cviu 
                                            UNION SELECT tracking_number,app_received_date,file_date 
                                            FROM (SELECT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(app_received_date),2),'00','20'),RIGHT(date(app_received_date),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                                   FROM coverva_dmas.dmas_app_metric_and_renewal_v2_vw amfl 
                                                     JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(lf.file_date AS DATE) ORDER BY COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1  ) amfl                                             
                                            UNION SELECT tracking_number, app_received_date ,file_date 
                                            FROM (SELECT DISTINCT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(app_received_date),2),'00','20'),RIGHT(date(app_received_date),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                                  FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename ) pdfl 
                                            UNION SELECT tracking_number,app_received_date,file_date 
                                            FROM(SELECT tracking_number,CAST(rundate AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                                     ,RANK() OVER(PARTITION BY cdfl.tracking_number ORDER BY CAST(lf.file_date AS DATE) DESC,UPPER(lf.filename),cdfl.cpu_data_id DESC) rnk       
                                                 FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename ) cdfl 
                                                 WHERE rnk = 1        
                                            UNION SELECT tracking_number,app_received_date,file_date 
                                            FROM(SELECT DISTINCT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                                 FROM coverva_dmas.cm043_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename) cm )  
                                 GROUP BY tracking_number,file_date ) mar ON da.tracking_number = mar.tracking_number AND da.file_inventory_date = mar.file_date 
                      LEFT JOIN (SELECT tracking_number,app_received_date,file_date 
                                 FROM(SELECT DISTINCT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(app_received_date),2),'00','20'),RIGHT(date(app_received_date),8)) AS DATE) app_received_date, CAST(lf.file_date AS DATE) AS file_date 
                                        ,RANK() OVER(PARTITION BY tracking_number, lf.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                      FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename ) aofl 
                                 WHERE  rnk = 1 AND app_received_date IS NOT NULL ) aofl ON da.tracking_number = aofl.tracking_number AND da.file_inventory_date = aofl.file_date 
                   WHERE da.file_inventory_date = CAST(:1 AS DATE) ) ard 
             WHERE dmas.tracking_number = ard.tracking_number AND dmas.file_inventory_date = ard.file_inventory_date AND dmas.app_received_date IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
       
       /* update maximus source date from CP my workspace date*/
       strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas          
             SET maximus_source_date = mwd.my_workspace_date,fp_update_dt = current_timestamp() 
              FROM(SELECT tracking_number,MIN(my_workspace_date) my_workspace_date 
                   FROM coverva_dmas.cp_application_inventory 
                   GROUP BY tracking_number) mwd WHERE dmas.tracking_number = mwd.tracking_number AND dmas.file_inventory_date = CAST(:1 AS DATE) 
                   AND mwd.my_workspace_date IS NOT NULL;`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                  
      
            
       } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;