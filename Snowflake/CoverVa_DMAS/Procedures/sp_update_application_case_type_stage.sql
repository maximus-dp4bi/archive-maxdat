use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_CASE_TYPE_STAGE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 5: Update application type */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application dmas
                         SET dmas.sd_stage = da.sd_stage,fp_update_dt = current_timestamp()
                         FROM(SELECT sd.*,da.event_date
                              FROM (SELECT tracking_number,application_type,stage sd_stage,CAST(f.file_date AS DATE) file_date 
                                    FROM coverva_dmas.dmas_app_metric_and_renewal_vw am 
                                      JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)  
                                    WHERE  CAST(f.file_date AS DATE) = CAST(:1 AS DATE)
                                    QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY CAST(f.file_date AS DATE) DESC,COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1) sd
                                LEFT JOIN(SELECT tracking_number, file_inventory_date event_date
                                          FROM coverva_dmas.dmas_application 
                               QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) = 1) da ON sd.tracking_number = da.tracking_number  ) da 
                         WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND (dmas.sd_stage IS NULL OR dmas.sd_stage != da.sd_stage) ;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
       
       strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
                SET dmas.case_type = da.case_type,fp_update_dt = current_timestamp() 
                FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                        ,COALESCE(am.application_type,cm.application_type,'Application') case_type,sd_stage                       
                      FROM (SELECT tracking_number, event_date 
                            FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                  FROM coverva_dmas.dmas_application) d 
                            WHERE rnk = 1 ) da 
                        LEFT JOIN (SELECT tracking_number,application_type,stage sd_stage,CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.dmas_app_metric_and_renewal_vw am 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)                                    
                                   WHERE CAST(f.file_date AS DATE) = CAST(:1 AS DATE)  
                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY CAST(f.file_date AS DATE) DESC, COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1) am 
                           ON da.tracking_number = am.tracking_number 
                         LEFT JOIN (SELECT tracking_number,application_type, CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.cm043_data_full_load cm 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename)                                    
                                   WHERE CAST(f.file_date AS DATE) = CAST(:1 AS DATE)  
                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY CAST(f.file_date AS DATE) DESC, cm043_data_id DESC) = 1) cm 
                           ON da.tracking_number = cm.tracking_number 
                         ) da
                WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.case_type IS NULL;`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute(); 
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;