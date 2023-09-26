use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_CASE_TYPE_STAGE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 5: Update application type */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas
                         SET dmas.sd_stage = da.sd_stage,fp_update_dt = current_timestamp()
                         FROM(SELECT DISTINCT da.tracking_number, da.case_number,da.event_date,dmas_application_id,sd_stage                       
                              FROM (SELECT tracking_number,case_number, event_date,dmas_application_id 
                                    FROM (SELECT tracking_number,case_number,file_inventory_date event_date,dmas_application_id,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                          FROM coverva_dmas.dmas_application_v3_inventory) d 
                                    WHERE rnk = 1 ) da 
                                LEFT JOIN (SELECT tracking_number,application_type,stage sd_stage,CAST(f.file_date AS DATE) file_date 
                                           FROM coverva_dmas.app_metric_v2_full_load am 
                                             JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)                                    
                                           WHERE 1=1
                                           QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, appmetric_data_id DESC) = 1) am 
                                  ON da.tracking_number = am.tracking_number ) da 
                         WHERE dmas.dmas_application_id = da.dmas_application_id AND (dmas.sd_stage IS NULL OR dmas.sd_stage != da.sd_stage) ;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
       strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
                SET dmas.case_type = da.case_type,fp_update_dt = current_timestamp() 
                FROM (SELECT DISTINCT da.tracking_number, da.case_number,da.event_date,dmas_application_id 
                        ,COALESCE(am.application_type,cm.application_type,rp.application_type,'Application') case_type,sd_stage                       
                      FROM (SELECT tracking_number,case_number, event_date,dmas_application_id 
                            FROM (SELECT tracking_number,case_number,file_inventory_date event_date,dmas_application_id,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                  FROM coverva_dmas.dmas_application_v3_inventory) d 
                            WHERE rnk = 1 ) da 
                        LEFT JOIN (SELECT tracking_number,application_type,stage sd_stage,CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.app_metric_v2_full_load am 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)                                    
                                   WHERE 1=1
                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, appmetric_data_id DESC) = 1) am 
                           ON da.tracking_number = am.tracking_number
                         LEFT JOIN (SELECT tracking_number,application_type, CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.cm043_data_full_load cm 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename)                                    
                                   WHERE 1=1
                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY CAST(f.file_date AS DATE) DESC, cm043_data_id DESC) = 1) cm 
                           ON da.tracking_number = cm.tracking_number  
                          LEFT JOIN (SELECT case_number,'Renewal' application_type, CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.rp274_data_full_load rp 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(rp.filename) = UPPER(f.filename)                                    
                                   WHERE 1=1
                                   QUALIFY ROW_NUMBER() OVER (PARTITION BY case_number ORDER BY CAST(f.file_date AS DATE) DESC, rp274_data_id DESC) = 1) rp 
                           ON da.case_number = rp.case_number   ) da
                WHERE dmas.dmas_application_id = da.dmas_application_id AND dmas.case_type IS NULL;`;
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       ret_value = strSQLStmt.execute();        
      
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;