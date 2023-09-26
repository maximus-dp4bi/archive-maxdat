use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_RECEIVED_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 3: Update app received date */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
             SET dmas.app_received_date = ard.app_received_date, dmas.state_app_received_date = ard.state_app_received_date, fp_update_dt = current_timestamp() 
             FROM (SELECT DISTINCT da.tracking_number,da.file_inventory_date,dmas_application_id 
                      ,DATE(COALESCE(aofl.app_received_date,prev_app_received_date,mar.app_received_date)) app_received_date 
                      ,DATE(COALESCE(aofl.app_received_date,prev_state_app_received_date,mar.app_received_date)) state_app_received_date                           
                   FROM (SELECT tracking_number, file_inventory_date,app_received_date,dmas_application_id,prev_app_received_date,prev_state_app_received_date
                          FROM (SELECT tracking_number,file_inventory_date, app_received_date, dmas_application_id,                              
                                   RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk ,
                                   COALESCE(app_received_date,LEAD(app_received_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) prev_app_received_date,
                                   COALESCE(state_app_received_date,LEAD(state_app_received_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) prev_state_app_received_date
                                 FROM coverva_dmas.dmas_application_v3_inventory ) d 
                           WHERE rnk = 1 ) da 
                      LEFT JOIN (SELECT tracking_number,MIN(app_received_date) app_received_date 
                                 FROM (SELECT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(app_received_date),2),'00','20'),RIGHT(date(app_received_date),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                       FROM coverva_dmas.app_metric_v2_full_load amfl 
                                          JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename 
                                       WHERE 1=1
                                       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,appmetric_data_id DESC) = 1                                                                                        
                                       UNION 
                                       SELECT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                       FROM coverva_dmas.cm043_data_full_load cdfl 
                                          JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename                                           
                                       WHERE 1=1
                                       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cm043_data_id DESC) = 1 
                                       UNION
                                       SELECT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date 
                                       FROM coverva_dmas.rp190_data_full_load rpfl 
                                         JOIN coverva_dmas.dmas_file_log lf ON UPPER(rpfl.filename) = lf.filename 
                                       WHERE 1=1
                                       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,rp190_data_id DESC) = 1 
                                       UNION
                                       SELECT tracking_number, COALESCE(CAST(CONCAT(REPLACE(LEFT(date(date_received),2),'00','20'),RIGHT(date(date_received),8)) AS DATE) ,
                                                 CASE WHEN TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) IS NOT NULL
                                                    AND LEFT(date(TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) ),2) >= 20 THEN
                                                      TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) ELSE NULL END  ) date_received,
                                                 CAST(lf.file_date AS DATE) file_date 
                                        FROM cviu_liaison_data_full_load cvl
                                           JOIN coverva_dmas.dmas_file_log lf ON UPPER(cvl.filename) = lf.filename 
                                        WHERE 1=1
                                        AND COALESCE(date_received,TRY_CAST(regexp_replace(date_received_char,'[^A-Za-z0-9 /]','') AS DATE) ) IS NOT NULL
                                        AND tracking_number IS NOT NULL
                                        AND UPPER(paper_application) LIKE 'PAPER%'
                                        QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY  lf.file_date DESC,cviu_liaison_id DESC) = 1) 
                                  GROUP BY tracking_number ) mar ON da.tracking_number = mar.tracking_number 
                      LEFT JOIN (SELECT tracking_number,app_received_date,file_date 
                                 FROM(SELECT DISTINCT tracking_number,CAST(CONCAT(REPLACE(LEFT(date(app_received_date),2),'00','20'),RIGHT(date(app_received_date),8)) AS DATE) app_received_date, CAST(lf.file_date AS DATE) AS file_date 
                                        ,RANK() OVER(PARTITION BY tracking_number ORDER BY lf.file_date DESC,recent_submission_date DESC,app_override_id DESC) rnk 
                                      FROM coverva_dmas.application_override_full_load aofl 
                                        JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename 
                                      WHERE 1=1 ) aofl 
                                 WHERE  rnk = 1 AND app_received_date IS NOT NULL ) aofl ON da.tracking_number = aofl.tracking_number
                   WHERE DATE(COALESCE(aofl.app_received_date,prev_app_received_date,mar.app_received_date)) IS NOT NULL AND da.app_received_date IS NULL ) ard 
             WHERE dmas.dmas_application_id = ard.dmas_application_id AND dmas.app_received_date IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       /* update maximus source date from CP my workspace date*/
       strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas          
             SET maximus_source_date = mwd.my_workspace_date,fp_update_dt = current_timestamp() 
              FROM(SELECT tracking_number,MIN(my_workspace_date) my_workspace_date 
                   FROM coverva_dmas.cp_application_inventory 
                   GROUP BY tracking_number) mwd 
              WHERE dmas.tracking_number = mwd.tracking_number 
              AND CAST(dmas.file_inventory_date AS DATE) = CAST(:1 AS DATE) 
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