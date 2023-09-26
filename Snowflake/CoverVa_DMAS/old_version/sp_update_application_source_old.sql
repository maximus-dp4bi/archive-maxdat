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
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.source = cpu.application_source,fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,application_source,file_date "
            + "      FROM(SELECT DISTINCT tracking_number,application_source,CAST(lf.file_date AS DATE) AS file_date "
            + "           FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename "
            + "           WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) cdfl ) cpu "
            + " WHERE dmas.tracking_number = cpu.tracking_number AND dmas.file_inventory_date = cpu.file_date AND dmas.source IS NULL AND cpu.application_source IS NOT NULL;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();     
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.source = cpui.source,fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,source,file_date "
            + "      FROM (SELECT DISTINCT tracking_number, source,CAST(lf.file_date AS DATE) AS file_date "
            + "                  FROM coverva_dmas.cpu_incarcerated_full_load cpui JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = lf.filename "
            + "             WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)  ) cpui ) cpui "
            + " WHERE dmas.tracking_number = cpui.tracking_number AND dmas.source IS NULL AND cpui.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();     

       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = cviu.source,fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,source,file_date "
            + "      FROM (SELECT DISTINCT tracking_number, source,CAST(lf.file_date AS DATE) AS file_date "
            + "            FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) cviu ) cviu "
            + " WHERE dmas.tracking_number = cviu.tracking_number AND dmas.file_inventory_date = cviu.file_date AND dmas.source IS NULL AND cviu.source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                  
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = amfl.application_source,dmas.case_number = amfl.case_number, fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,application_source,case_number,file_date "
            + "      FROM (SELECT DISTINCT tracking_number,application_source,case_number,CAST(lf.file_date AS DATE) AS file_date "
            + "            FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl ) amfl "
            + " WHERE dmas.tracking_number = amfl.tracking_number AND dmas.file_inventory_date = amfl.file_date AND dmas.source IS NULL AND amfl.application_source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();   
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = ampfl.application_source, fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,application_source,file_date "
            + "      FROM (SELECT DISTINCT tracking_number,application_source,CAST(lf.file_date AS DATE) AS file_date "
            + "            FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl ) ampfl "
            + " WHERE dmas.tracking_number = ampfl.tracking_number AND dmas.file_inventory_date = ampfl.file_date AND dmas.source IS NULL AND ampfl.application_source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();  
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.source = cm.application_source, fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,application_source,file_date "
            + "      FROM (SELECT DISTINCT tracking_number, source application_source,CAST(lf.file_date AS DATE) AS file_date "
            + "            FROM coverva_dmas.cm043_data_full_load cm JOIN coverva_dmas.dmas_file_log lf ON UPPER(cm.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cm ) cm "
            + " WHERE dmas.tracking_number = cm.tracking_number AND dmas.file_inventory_date = cm.file_date AND dmas.source IS NULL AND cm.application_source IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
              
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "            
            + " SET dmas.source = ch.channel, fp_update_dt = current_timestamp() "
            + " FROM (SELECT tracking_number,channel "
            + "      FROM(SELECT DISTINCT tracking_number,channel, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk "
            + "           FROM coverva_dmas.cp_application_inventory) "
            + "      WHERE rnk = 1 AND channel IS NOT NULL) ch "
            + " WHERE dmas.tracking_number = ch.tracking_number AND dmas.source IS NULL AND dmas.file_inventory_date = CAST(:1 AS DATE);";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();
       
       /* Override source value */
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.source = aofl.source,fp_update_dt = current_timestamp(),override_value_indicator = 'Y' "
            + " FROM (SELECT tracking_number,source,file_date "
            + "       FROM(SELECT DISTINCT tracking_number,source, CAST(lf.file_date AS DATE) AS file_date "
            + "            FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) aofl "
            + "       WHERE LENGTH(source) > 0 ) aofl "
            + " WHERE dmas.tracking_number = aofl.tracking_number AND dmas.file_inventory_date = aofl.file_date ;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});    
       ret_value = strSQLStmt.execute();
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;