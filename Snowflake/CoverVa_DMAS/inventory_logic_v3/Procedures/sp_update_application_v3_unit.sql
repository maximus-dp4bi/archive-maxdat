use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_UNIT(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 4: Update application unit */
       var strSQLText = ` UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
               SET dmas.processing_unit = da.processing_unit, fp_update_dt = current_timestamp() 
               FROM (SELECT da.tracking_number,da.dmas_application_id
                      ,CASE WHEN cvl.cvl_unit IS NOT NULL THEN cvl.cvl_unit
                            WHEN rp.rp190_unit IS NOT NULL THEN rp.rp190_unit
                            --WHEN prev_unit = 'CVIU' THEN prev_unit
                        ELSE UPPER(COALESCE(o.override_unit,am.am_unit,rp.rp190_unit,cvl.cvl_unit,cp.business_unit,prev_unit,'CPU')) END processing_unit                       
                     FROM (SELECT tracking_number, event_date,dmas_application_id,prev_unit
                          FROM (SELECT tracking_number,file_inventory_date event_date,dmas_application_id,                                  
                                   RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk,
                                   COALESCE(processing_unit,LEAD(processing_unit) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) prev_unit
                                 FROM coverva_dmas.dmas_application_v3_inventory ) d 
                           WHERE rnk = 1 ) da 
                       LEFT JOIN (SELECT tracking_number,UPPER(processing_unit) override_unit, CAST(f.file_date AS DATE) file_date
                                  FROM coverva_dmas.application_override_full_load o 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) 
                                  WHERE 1=1
                                  /*AND CAST(f.file_date AS DATE) <= CAST(:1 AS DATE)*/
                                  AND LENGTH(override_unit) > 0
                                  QUALIFY RANK() OVER(PARTITION BY tracking_number ORDER BY recent_submission_date DESC,app_override_id DESC)  = 1) o ON da.tracking_number = o.tracking_number
                       LEFT JOIN (SELECT tracking_number, 
                                    CASE WHEN processing_unit = 'CVIU' THEN 'CVIU'
                                      WHEN --UPPER(case_incarcerated_indicator) IN('YES','Y') OR 
                                        UPPER(application_incarcerated_indicator) IN ('YES','Y') THEN 'CVIU'                                     
                                      WHEN EXISTS(SELECT 1 FROM app_metric_v2_full_load v WHERE v.tracking_number = am.tracking_number AND processing_unit = 'CVIU')
                                         AND processing_unit = 'LDSS' THEN 'CVIU'
                                     ELSE 'CPU' END am_unit,
                                    CAST(f.file_date AS DATE) file_date 
                                  FROM coverva_dmas.app_metric_v2_full_load am 
                                    JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                  WHERE 1=1                                  
                                  QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,appmetric_data_id DESC) = 1 ) am ON da.tracking_number = am.tracking_number                        
                       LEFT JOIN (SELECT tracking_number,business_unit 
                                  FROM(SELECT DISTINCT tracking_number,UPPER(business_unit) business_unit, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk 
                                       FROM coverva_dmas.cp_application_inventory) 
                                   WHERE rnk = 1 
                                   AND business_unit IS NOT NULL) cp ON da.tracking_number = cp.tracking_number               
                       LEFT JOIN (SELECT DISTINCT tracking_number,'CVIU' rp190_unit,CAST(f.file_date AS DATE) file_date 
                                  FROM coverva_dmas.rp190_data_full_load rp 
                                    JOIN coverva_dmas.dmas_file_log f ON UPPER(rp.filename) = UPPER(f.filename)
                                  WHERE 1=1
                                  QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,rp190_data_id DESC) = 1 )  rp ON da.tracking_number = rp.tracking_number              
                       LEFT JOIN(SELECT DISTINCT tracking_number,case_number,lf.file_id, CAST(lf.file_date AS DATE) file_date,'CVIU' cvl_unit
                                 FROM coverva_dmas.cviu_liaison_data_full_load cvl
                                   JOIN coverva_dmas.dmas_file_log lf ON UPPER(cvl.filename) = lf.filename 
                                 WHERE 1=1
                                 AND UPPER(paper_application) LIKE 'PAPER%'
                                 AND tracking_number IS NOT NULL
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cviu_liaison_id DESC) = 1) cvl ON da.tracking_number = cvl.tracking_number ) da 
               WHERE dmas.dmas_application_id = da.dmas_application_id AND (dmas.processing_unit IS NULL OR dmas.processing_unit != da.processing_unit);`;
       /*var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});*/
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();                  
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;