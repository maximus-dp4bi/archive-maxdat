use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_UNIT(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 4: Update application unit */
       var strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
               SET dmas.processing_unit = da.processing_unit, dmas.override_value_indicator = da.override_indicator, fp_update_dt = current_timestamp() 
               FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                      ,COALESCE(o.override_unit,cpui.cpui_unit,cviu.cviu_unit,cpu.cpu_unit,cp.business_unit,ppit.ppit_unit,am.am_unit,'CPU') processing_unit 
                     ,CASE WHEN o.override_unit IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                    FROM (SELECT tracking_number, event_date 
                          FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                FROM coverva_dmas.dmas_application 
                                 WHERE file_inventory_date = CAST(:1 AS DATE)) d 
                          WHERE rnk = 1 ) da 
                      LEFT JOIN (SELECT DISTINCT tracking_number,'CVIU' cviu_unit, CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.cviu_data_full_load cviu 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date 
                      LEFT JOIN (SELECT DISTINCT tracking_number,'CVIU' cpui_unit, CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date 
                      LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN UPPER(worker_ldss) LIKE '%CVIU%' THEN 'CVIU' ELSE 'CPU' END ppit_unit, CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.ppit_data_full_load ppit 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(ppit.filename) = UPPER(f.filename)) ppit ON da.tracking_number = ppit.tracking_number AND da.event_date = ppit.file_date 
                      LEFT JOIN (SELECT tracking_number,CASE WHEN UPPER(case_incarcerated_indicator) IN('YES','Y') THEN 'CVIU' ELSE processing_unit END am_unit, CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.dmas_app_metric_and_renewal_vw am 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename)
                                  WHERE application_type = 'Renewal' 
                                  QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1 ) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date                      
                      LEFT JOIN (SELECT tracking_number,cpu_unit 
                                 FROM(SELECT tracking_number,CASE WHEN COALESCE(doc_app_switch,'N') = 'Y' THEN 'CVIU' ELSE 'CPU' END cpu_unit, CAST(f.file_date AS DATE) file_date 
                                        ,RANK() OVER(PARTITION BY cpu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,UPPER(f.filename),cpu.cpu_data_id DESC) rnk 
                                      FROM coverva_dmas.cpu_data_full_load cpu 
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) )  
                                 WHERE rnk = 1) cpu ON da.tracking_number = cpu.tracking_number 
                      LEFT JOIN (SELECT tracking_number,business_unit 
                                 FROM(SELECT DISTINCT tracking_number,UPPER(business_unit) business_unit, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id DESC) rnk 
                                      FROM coverva_dmas.cp_application_inventory) 
                                 WHERE rnk = 1 AND business_unit IS NOT NULL) cp ON da.tracking_number = cp.tracking_number 
                      LEFT JOIN (SELECT DISTINCT tracking_number, processing_unit override_unit,file_date 
                                 FROM(SELECT tracking_number,UPPER(processing_unit) processing_unit, CAST(f.file_date AS DATE) file_date, RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                      FROM coverva_dmas.application_override_full_load o 
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                 WHERE rnk = 1 AND LENGTH(override_unit) > 0) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date ) da 
               WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.processing_unit IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();                  
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;