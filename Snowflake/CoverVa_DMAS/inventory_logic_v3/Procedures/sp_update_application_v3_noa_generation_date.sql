use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_NOA_GENERATION_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP : Update renewal closure date */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
                SET dmas.noa_generation_date = da.noa_generation_date,fp_update_dt = current_timestamp()
                FROM (SELECT rapp.tracking_number, dmas_application_id,
                          CASE WHEN cm_status IN('Approved','Denied') THEN cm_authorized_date 
                              ELSE COALESCE(rp267_noa_generation_date,rp268_noa_generation_date) END noa_generation_date
                      FROM(SELECT tracking_number, dmas_application_id, case_number, current_state,case_type,file_inventory_date event_date,cm044_verified
                           FROM coverva_dmas.dmas_application_v3_inventory 
                           WHERE 1=1
                           QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) = 1)  rapp                       
                       LEFT JOIN(SELECT DISTINCT tracking_number,cm_status,cm_authorized_date,file_date 
                                 FROM(SELECT tracking_number,
                                         CASE WHEN UPPER(status) LIKE '%APPROVED%' THEN 'Approved'
                                              WHEN UPPER(status) LIKE '%DENIED%' THEN 'Denied' 
                                          ELSE status END cm_status,
                                          authorized_date cm_authorized_date,CAST(f.file_date AS DATE) file_date,                        
                                          ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,cm_status_rank,cm.cm_pt_data_id DESC) rnk 
                                       FROM (SELECT tracking_number,status,authorized_date,authorized_worker_id,filename,cm_pt_data_id,
                                                CASE WHEN UPPER(status) LIKE '%APPROVED%' THEN 1
                                                     WHEN UPPER(status) LIKE '%DENIED%' THEN 2 
                                                  ELSE 3 END cm_status_rank
                                              FROM coverva_dmas.cm_processing_time_full_load) cm 
                                                JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) 
                                              WHERE (UPPER(status) LIKE '%APPROVED%' OR UPPER(status) LIKE '%DENIED%')) 
                                 WHERE rnk = 1 ) cm ON cm.tracking_number = rapp.tracking_number
                       LEFT JOIN(SELECT tracking_number,noa_generation_date rp267_noa_generation_date
                                 FROM coverva_dmas.rp267_data_full_load rp267
                                   JOIN coverva_dmas.dmas_file_log fl ON UPPER(rp267.filename) = UPPER(fl.filename)                                   
                                 WHERE 1=1
                                 AND UPPER(noa_status) NOT LIKE '%SUPPRESSED%'
                                 QUALIFY ROW_NUMBER() OVER(PARTITION BY rp267.tracking_number ORDER BY fl.file_date DESC,rp267.rp267_data_id DESC) = 1) rp267 ON rp267.tracking_number = rapp.tracking_number
                      LEFT JOIN(SELECT tracking_number,noa_generation_date rp268_noa_generation_date
                                 FROM coverva_dmas.rp268_data_full_load rp268
                                   JOIN coverva_dmas.dmas_file_log fl ON UPPER(rp268.filename) = UPPER(fl.filename)
                                 WHERE 1=1
                                 AND UPPER(noa_status) NOT LIKE '%SUPPRESSED%'
                                 QUALIFY ROW_NUMBER() OVER(PARTITION BY rp268.tracking_number ORDER BY fl.file_date DESC,rp268.rp268_data_id DESC) = 1) rp268 ON rp268.tracking_number = rapp.tracking_number                                  
                       WHERE COALESCE(rp267_noa_generation_date,rp268_noa_generation_date) IS NOT NULL  ) da
                WHERE dmas.dmas_application_id = da.dmas_application_id;`;
       /*var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});*/
       var strSQLStmt = strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;