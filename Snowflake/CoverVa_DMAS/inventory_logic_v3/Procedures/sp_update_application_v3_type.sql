use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_TYPE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 5: Update application type */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
                SET dmas.application_type = da.application_type,fp_update_dt = current_timestamp() 
                FROM (SELECT DISTINCT da.tracking_number, da.dmas_application_id,da.event_date 
                        ,CASE WHEN prev_app_type = 'PW' THEN prev_app_type ELSE COALESCE(o.override_app_type,pw.pw_app_type,cm.cm_app_type,rp_app_type,'non-PW') END application_type                         
                      FROM (SELECT tracking_number, event_date,dmas_application_id,prev_app_type 
                            FROM (SELECT tracking_number,dmas_application_id,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk
                                     ,COALESCE(application_type,LEAD(application_type) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) prev_app_type
                                  FROM coverva_dmas.dmas_application_v3_inventory  ) d 
                            WHERE rnk = 1 ) da 
                        LEFT JOIN (SELECT tracking_number,'PW' pw_app_type,CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.app_metric_v2_full_load pw 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename)
                                     WHERE UPPER(ma_pg_indicator) IN('YES','Y')
                                     QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,appmetric_data_id DESC) = 1) pw ON da.tracking_number = pw.tracking_number 
                        LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN UPPER(potential_pregnancy) IN('YES','Y') THEN 'PW' ELSE 'non-PW' END rp_app_type,file_date 
                                   FROM(SELECT tracking_number,ma_pregnancy_indicator potential_pregnancy, CAST(f.file_date AS DATE) file_date 
                                          ,ROW_NUMBER() OVER(PARTITION BY rp.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC, rp190_data_id DESC) rnk 
                                        FROM coverva_dmas.rp190_data_full_load rp 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(rp.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1 ) rp ON da.tracking_number = rp.tracking_number                                                              
                        LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN UPPER(potential_pregnancy) IN('YES','Y') THEN 'PW' ELSE 'non-PW' END cm_app_type,file_date 
                                   FROM(SELECT tracking_number,ma_pregnancy_indicator potential_pregnancy, CAST(f.file_date AS DATE) file_date 
                                          ,ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC, cm_pt_data_id DESC) rnk 
                                        FROM coverva_dmas.cm_processing_time_full_load cm 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number                         
                        LEFT JOIN (SELECT DISTINCT tracking_number, CASE WHEN UPPER(type) LIKE 'NON%' THEN 'non-PW' ELSE UPPER(type) END override_app_type,file_date 
                                   FROM(SELECT tracking_number,type, CAST(f.file_date AS DATE) file_date, ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                        FROM coverva_dmas.application_override_full_load o 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1 AND LENGTH(type) > 0) o ON da.tracking_number = o.tracking_number) da 
                WHERE dmas.dmas_application_id = da.dmas_application_id AND (dmas.application_type IS NULL OR dmas.application_type != da.application_type );`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute(); 
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;