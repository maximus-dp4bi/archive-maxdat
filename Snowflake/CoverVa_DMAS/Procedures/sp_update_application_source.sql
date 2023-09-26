use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_SOURCE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 2: Update application source */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application dmas 
             SET dmas.source = da.application_source,dmas.override_value_indicator = da.override_indicator,fp_update_dt = current_timestamp() 
             FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                     ,COALESCE(CASE WHEN UPPER(COALESCE(o.override_source,rcpu.running_cpu_source,cpui.cpui_source,cviu.cviu_source,pp.ppit_source,am.am_source,cmd.cm043_source,pw.pw_source,cp.channel,mcpu.mcpu_source,mcviu.mcviu_source)) LIKE 'FFM_%' 
                        THEN UPPER(REPLACE(COALESCE(o.override_source,rcpu.running_cpu_source,cpui.cpui_source,cviu.cviu_source,pp.ppit_source,am.am_source,cmd.cm043_source,pw.pw_source,cp.channel,mcpu.mcpu_source,mcviu.mcviu_source),'_',' ')) 
                     WHEN UPPER(COALESCE(o.override_source,rcpu.running_cpu_source,cpui.cpui_source,cviu.cviu_source,pp.ppit_source,am.am_source,cmd.cm043_source,pw.pw_source,cp.channel,mcpu.mcpu_source,mcviu.mcviu_source)) LIKE 'COMMON%' THEN 'CommonHelp' 
                        ELSE COALESCE(o.override_source,rcpu.running_cpu_source,cpui.cpui_source,cviu.cviu_source,pp.ppit_source,am.am_source,cmd.cm043_source,pw.pw_source,cp.channel,mcpu.mcpu_source,mcviu.mcviu_source) END,prsrc.prev_source) application_source   
                     ,CASE WHEN o.override_source IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                   FROM (SELECT tracking_number, event_date 
                         FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                               FROM coverva_dmas.dmas_application 
                                WHERE file_inventory_date = CAST(:1 AS DATE)) d 
                         WHERE rnk = 1 ) da 
                      LEFT JOIN(SELECT tracking_number, event_date,prev_source 
                                FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk, 
                                             LAST_VALUE(source) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY  file_inventory_date DESC,dmas_application_id DESC) prev_source 
                                      FROM coverva_dmas.dmas_application ) d 
                                WHERE rnk = 1 ) prsrc ON da.tracking_number = prsrc.tracking_number  
                     LEFT JOIN (SELECT DISTINCT tracking_number, application_source ppit_source,CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.ppit_data_full_load pp 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(pp.filename) = UPPER(f.filename) ) pp ON da.tracking_number = pp.tracking_number AND da.event_date = pp.file_date 
                     LEFT JOIN (SELECT tracking_number, application_source am_source,CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.dmas_app_metric_and_renewal_vw am 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(am.filename) = UPPER(f.filename) 
                                QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number,CAST(f.file_date AS DATE) ORDER BY COALESCE(appmetric_data_id,renewal_data_id) DESC) = 1  ) am ON da.tracking_number = am.tracking_number AND da.event_date = am.file_date 
                     LEFT JOIN (SELECT DISTINCT tracking_number,application_source pw_source,CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.app_metric_pw_full_load pw 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(pw.filename) = UPPER(f.filename)) pw ON da.tracking_number = pw.tracking_number AND da.event_date = pw.file_date 
                     LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN length(source) > 0 THEN source ELSE NULL END cm043_source,CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.cm043_data_full_load cmd 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(cmd.filename) = UPPER(f.filename)) cmd ON da.tracking_number = cmd.tracking_number AND da.event_date = cmd.file_date 
                     LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN length(source) > 0 THEN source ELSE NULL END cviu_source, CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.cviu_data_full_load cviu 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(cviu.filename) = UPPER(f.filename)) cviu ON da.tracking_number = cviu.tracking_number AND da.event_date = cviu.file_date 
                     LEFT JOIN (SELECT DISTINCT tracking_number,CASE WHEN length(source) > 0 THEN source ELSE NULL END cpui_source, CAST(f.file_date AS DATE) file_date 
                                FROM coverva_dmas.cpu_incarcerated_full_load cpui 
                                  JOIN coverva_dmas.dmas_file_log f ON UPPER(cpui.filename) = UPPER(f.filename)) cpui ON da.tracking_number = cpui.tracking_number AND da.event_date = cpui.file_date 
                     LEFT JOIN (SELECT tracking_number,running_cpu_source 
                                FROM(SELECT tracking_number,application_source running_cpu_source, CAST(f.file_date AS DATE) file_date 
                                       ,RANK() OVER(PARTITION BY cpu.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,UPPER(f.filename),cpu.cpu_data_id DESC) rnk 
                                     FROM coverva_dmas.cpu_data_full_load cpu 
                                       JOIN coverva_dmas.dmas_file_log f ON UPPER(cpu.filename) = UPPER(f.filename) )  
                                WHERE rnk = 1) rcpu ON da.tracking_number = rcpu.tracking_number 
                     LEFT JOIN (SELECT tracking_number,channel 
                                FROM(SELECT DISTINCT tracking_number,channel, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk 
                                     FROM coverva_dmas.cp_application_inventory) 
                                WHERE rnk = 1 AND channel IS NOT NULL) cp ON da.tracking_number = cp.tracking_number 
                     LEFT JOIN (SELECT DISTINCT application_number,mcpu_source 
                                FROM(SELECT application_number, source mcpu_source 
                                       ,RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE),record_id) rnk 
                                    FROM coverva_dmas.manual_cpu_tracking) 
                                WHERE rnk = 1) mcpu ON da.tracking_number = mcpu.application_number 
                     LEFT JOIN (SELECT DISTINCT application_number,mcviu_source 
                                FROM(SELECT application_number, source mcviu_source
                                       ,RANK() OVER(PARTITION BY application_number ORDER BY CAST(CONCAT(REVERSE(LEFT(REVERSE(activity_date),4)),'/',EXTRACT(YEAR FROM current_date())) AS DATE),record_id) rnk 
                                    FROM coverva_dmas.manual_cviu_tracking) 
                                WHERE rnk = 1) mcviu ON da.tracking_number = mcviu.application_number 
                     LEFT JOIN (SELECT DISTINCT tracking_number, source override_source,file_date 
                                FROM(SELECT tracking_number,source, CAST(f.file_date AS DATE) file_date, RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                     FROM coverva_dmas.application_override_full_load o 
                                       JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                WHERE rnk = 1 AND LENGTH(source) > 0) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date ) da
             WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.source IS NULL;`;            
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});    
       var ret_value = strSQLStmt.execute();
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;