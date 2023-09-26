use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_TYPE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP 5: Update application type */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
                SET dmas.application_type = da.application_type,dmas.override_value_indicator = da.override_indicator,fp_update_dt = current_timestamp() 
                FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                        ,COALESCE(o.override_app_type,pw.pw_app_type,rpw.rpw_app_type,cm.cm044_app_type,cviu.cviu_app_type,cpui.cpui_app_type,cpu.cpu_app_type,'non-PW') application_type 
                       ,CASE WHEN o.override_app_type IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                      FROM (SELECT tracking_number, event_date 
                            FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                  FROM coverva_dmas.dmas_application 
                                  WHERE file_inventory_date = CAST(:1 AS DATE)) d 
                            WHERE rnk = 1 ) da
                        LEFT JOIN (SELECT tracking_number,'PW' rpw_app_type,CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.dmas_app_metric_and_renewal_vw pw 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename)
                                     WHERE UPPER(ma_pg_indicator) IN('YES','Y')
                                     AND application_type = 'Renewal'
                                     QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1) rpw ON da.tracking_number = rpw.tracking_number AND da.event_date = rpw.file_date     
                        LEFT JOIN (SELECT DISTINCT tracking_number,'PW' pw_app_type,CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.app_metric_pw_full_load pw 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename)) pw ON da.tracking_number = pw.tracking_number AND da.event_date = pw.file_date 
                        LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN potential_pregnancy = 'Y' THEN 'PW' ELSE 'non-PW' END cm044_app_type,file_date 
                                   FROM(SELECT tracking_number,potential_pregnancy, CAST(f.file_date AS DATE) file_date 
                                          ,RANK() OVER(PARTITION BY cm.tracking_number ORDER BY  CAST(f.file_date AS DATE) DESC, cm044_data_id DESC) rnk 
                                        FROM coverva_dmas.cm044_data_full_load cm 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(cm.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1 ) cm ON da.tracking_number = cm.tracking_number 
                        LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN UPPER(switch) LIKE '%PREGNANCY IND%' THEN 'PW' ELSE 'non-PW' END cviu_app_type, CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.cviu_data_full_load cviu 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date 
                        LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN UPPER(switch) LIKE '%PREGNANCY IND%' THEN 'PW' ELSE 'non-PW' END cpui_app_type, CAST(f.file_date AS DATE) file_date 
                                   FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                     JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date 
                        LEFT JOIN (SELECT tracking_number, cpu_app_type,file_date 
                                   FROM(SELECT  tracking_number,CASE WHEN preg_switch = 'Y' THEN 'PW' ELSE 'non-PW' END cpu_app_type,CAST(f.file_date AS DATE) file_date 
                                            ,RANK() OVER(PARTITION BY cpu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,UPPER(f.filename),cpu.cpu_data_id DESC) rnk 
                                        FROM coverva_dmas.cpu_data_full_load cpu 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1) cpu ON da.tracking_number = cpu.tracking_number 
                        LEFT JOIN (SELECT DISTINCT tracking_number, CASE WHEN UPPER(type) LIKE 'NON%' THEN 'non-PW' ELSE UPPER(type) END override_app_type,file_date 
                                   FROM(SELECT tracking_number,type, CAST(f.file_date AS DATE) file_date, RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                        FROM coverva_dmas.application_override_full_load o 
                                          JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                   WHERE rnk = 1 AND LENGTH(type) > 0) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date ) da 
                WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.application_type IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;