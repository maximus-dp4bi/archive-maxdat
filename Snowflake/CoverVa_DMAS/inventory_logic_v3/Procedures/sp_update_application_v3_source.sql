use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_SOURCE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 2: Update application source */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
             SET dmas.source = da.application_source,fp_update_dt = current_timestamp() 
             FROM (SELECT da.tracking_number,da.dmas_application_id
                      ,CASE WHEN cvl.cvl_source IS NOT NULL THEN cvl.cvl_source
                            WHEN o.override_source IS NOT NULL AND LENGTH(REGEXP_REPLACE(o.override_source,'[^A-Za-z0-9 ]',' ')) > 1 THEN
                              CASE WHEN UPPER(REGEXP_REPLACE(o.override_source,'[^A-Za-z0-9 ]',' ')) LIKE 'PAPER%' THEN 'Paper Application'
                                ELSE UPPER(REGEXP_REPLACE(o.override_source,'[^A-Za-z0-9 ]',' ')) END
                            WHEN da.previous_source IS NOT NULL AND LENGTH(REGEXP_REPLACE(da.previous_source,'[^A-Za-z0-9 ]',' ')) > 1 THEN 
                              CASE WHEN UPPER(REGEXP_REPLACE(da.previous_source,'[^A-Za-z0-9 ]',' ')) LIKE 'PAPER%' THEN 'Paper Application'
                                ELSE UPPER(REGEXP_REPLACE(da.previous_source,'[^A-Za-z0-9 ]',' ')) END
                         ELSE CASE WHEN UPPER(COALESCE(am.am_source,cmd.cm043_source,rp.rp190_source,cp.channel)) LIKE 'FFM_%' 
                                       THEN UPPER(REPLACE(COALESCE(am.am_source,cmd.cm043_source,rp.rp190_source,cp.channel),'_',' ')) 
                                    WHEN UPPER(COALESCE(am.am_source,cmd.cm043_source,rp.rp190_source,cp.channel)) LIKE 'COMMON%' THEN 'CommonHelp' 
                                ELSE COALESCE(am.am_source,cmd.cm043_source,rp.rp190_source,cp.channel) END
                        END application_source  
                    FROM (SELECT tracking_number, event_date,previous_source,dmas_application_id
                          FROM (SELECT tracking_number,file_inventory_date event_date,dmas_application_id,
                                   COALESCE(source,LEAD(source) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_source,
                                   RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                 FROM coverva_dmas.dmas_application_v3_inventory                                   
                                  ) d 
                           WHERE rnk = 1 ) da 
                      LEFT JOIN (SELECT *
                                 FROM(SELECT tracking_number,source override_source, CAST(f.file_date AS DATE) file_date,
                                    ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY f.file_date DESC,recent_submission_date DESC,app_override_id DESC) rnk 
                                 FROM coverva_dmas.application_override_full_load o 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) 
                                 WHERE 1=1)
                                 --AND LENGTH(source) > 0
                                 WHERE rnk = 1 ) o ON da.tracking_number = o.tracking_number
                      LEFT JOIN (SELECT tracking_number, application_source am_source,CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.app_metric_v2_full_load am 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                 WHERE 1=1
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,appmetric_data_id DESC) = 1 
                                 UNION
                                 SELECT tracking_number, application_source am_source,CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.app_metric_full_load am 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                 WHERE 1=1
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,appmetric_data_id DESC) = 1 ) am ON da.tracking_number = am.tracking_number 
                      LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN length(source) > 0 THEN source ELSE NULL END cm043_source,CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.cm043_data_full_load cmd 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)
                                 WHERE 1=1
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,cm043_data_id DESC) = 1 )  cmd ON da.tracking_number = cmd.tracking_number 
                      LEFT JOIN (SELECT tracking_number,channel 
                                 FROM(SELECT DISTINCT tracking_number,channel, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk 
                                      FROM coverva_dmas.cp_application_inventory) 
                                  WHERE rnk = 1 
                                  AND channel IS NOT NULL) cp ON da.tracking_number = cp.tracking_number               
                      LEFT JOIN (SELECT DISTINCT tracking_number,
                                   CASE WHEN length(source) > 0 THEN
                                     CASE WHEN UPPER(source) = 'RDE-TELEPHONE' THEN 'RDE' ELSE source END
                                    ELSE NULL END rp190_source,CAST(f.file_date AS DATE) file_date 
                                 FROM coverva_dmas.rp190_data_full_load rp 
                                   JOIN coverva_dmas.dmas_file_log f ON UPPER(rp.filename) = UPPER(f.filename)
                                 WHERE 1=1
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY f.file_date DESC,rp190_data_id DESC) = 1 )  rp ON da.tracking_number = rp.tracking_number              
                      LEFT JOIN(SELECT DISTINCT tracking_number,case_number,lf.file_id, CAST(lf.file_date AS DATE) file_date,'Paper Application' cvl_source                                               
                                FROM coverva_dmas.cviu_liaison_data_full_load cvl
                                  JOIN coverva_dmas.dmas_file_log lf ON UPPER(cvl.filename) = lf.filename 
                                WHERE 1=1
                                AND UPPER(paper_application) LIKE 'PAPER%'
                                AND tracking_number IS NOT NULL
                                QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY lf.file_date DESC,cviu_liaison_id DESC) = 1) cvl ON da.tracking_number = cvl.tracking_number
                   ) da
                  WHERE dmas.dmas_application_id = da.dmas_application_id AND (dmas.source IS NULL OR dmas.source != da.application_source) ;`;            
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;