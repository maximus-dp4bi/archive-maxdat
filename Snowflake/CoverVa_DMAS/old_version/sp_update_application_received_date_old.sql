use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_RECEIVED_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       
       /* STEP 3: Update app received date */         
       var strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + "SET dmas.app_received_date = cpu.app_received_date, dmas.state_app_received_date = cpu.state_app_received_date, fp_update_dt = current_timestamp() "
            + "FROM (SELECT tracking_number, CAST(lf.file_date AS DATE) file_date,MIN(rundate) app_received_date, MIN(app_received_date) state_app_received_date "
            +"       FROM coverva_dmas.cpu_data_full_load cpu " 
            +"         JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename "            
            +"       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) "
            +"       AND application_source = 'RDE' "
            +"       AND (assigned_to IS NOT NULL OR status IS NOT NULL) "            
            +"       GROUP BY tracking_number,CAST(lf.file_date AS DATE) file_date "
            +"       UNION ALL "
            +"       SELECT tracking_number, CAST(lf.file_date AS DATE) file_date,MIN(rundate) app_received_date, MIN(app_received_date) state_app_received_date "
            +"       FROM coverva_dmas.cpu_data_full_load cpu " 
            +"         JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename "            
            +"       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) "
            +"       AND COALESCE(application_source,'X') != 'RDE' "
            +"       GROUP BY tracking_number,CAST(lf.file_date AS DATE) file_date ) cpu "
            +" WHERE dmas.tracking_number = cpu.tracking_number AND dmas.file_inventory_date = cpu.file_date AND cpu.app_received_date IS NOT NULL;";
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute(); 
       
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.app_received_date = rd.app_received_date, dmas.state_app_received_date = rd.app_received_date, fp_update_dt = current_timestamp() "
            + "  FROM(SELECT tracking_number,file_date,MIN(app_received_date) app_received_date "
            + "       FROM(SELECT tracking_number,date_received app_received_date,file_date "
            + "            FROM (SELECT DISTINCT tracking_number, CAST(REPLACE(TO_CHAR(date_received),'0021','2021') AS DATE) date_received,CAST(lf.file_date AS DATE) file_date "
            + "                  FROM coverva_dmas.cpu_incarcerated_full_load cpui JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpui.filename) = lf.filename "
            + "                  WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cpui "
            + "            UNION SELECT tracking_number,date_received,file_date "
            + "                  FROM (SELECT DISTINCT tracking_number, CAST(REPLACE(TO_CHAR(date_received),'0021','2021') AS DATE) date_received,CAST(lf.file_date AS DATE) file_date "
            + "                        FROM coverva_dmas.cviu_data_full_load cviu JOIN coverva_dmas.dmas_file_log lf ON UPPER(cviu.filename) = lf.filename "
            + "                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cviu "
            + "            UNION SELECT tracking_number,app_received_date,file_date "
            + "                  FROM (SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(app_received_date),'0021','2021') AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date "
            + "                        FROM coverva_dmas.app_metric_full_load amfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(amfl.filename) = lf.filename "
            + "                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) amfl "
            + "            UNION SELECT tracking_number,application_received_date,file_date "
            + "                  FROM (SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(application_received_date),'0021','2021') AS DATE) application_received_date,CAST(lf.file_date AS DATE) file_date "
            + "                        FROM coverva_dmas.app_metric_pw_full_load ampfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(ampfl.filename) = lf.filename "
            + "                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) pw "
            + "            UNION SELECT tracking_number, app_received_date ,file_date "
            + "                  FROM (SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(app_received_date),'0021','2021') AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date "
            + "                        FROM coverva_dmas.ppit_data_full_load pdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(pdfl.filename) = lf.filename "
            + "                        WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) pdfl  "
            + "            UNION SELECT tracking_number,app_received_date,file_date "
            + "                  FROM(SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(app_received_date),'0021','2021') AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date "
            + "                       FROM coverva_dmas.cpu_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename "
            + "                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cdfl  "
            + "            UNION SELECT tracking_number,app_received_date,file_date "
            + "                  FROM(SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(date_received),'0021','2021') AS DATE) app_received_date,CAST(lf.file_date AS DATE) file_date "
            + "                       FROM coverva_dmas.cm043_data_full_load cdfl JOIN coverva_dmas.dmas_file_log lf ON UPPER(cdfl.filename) = lf.filename "
            + "                       WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE)) cm  ) "
            + "     GROUP BY tracking_number,file_date) rd WHERE dmas.tracking_number = rd.tracking_number AND dmas.file_inventory_date = rd.file_date AND rd.app_received_date IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute(); 
       
       /* update maximus source date from CP my workspace date*/
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
         /*   + "SET dmas.app_received_date = mwd.my_workspace_date, maximus_source_date = mwd.my_workspace_date,fp_update_dt = current_timestamp() "*/
            + " SET maximus_source_date = mwd.my_workspace_date,fp_update_dt = current_timestamp() "
            + "  FROM(SELECT tracking_number,MIN(my_workspace_date) my_workspace_date "
            + "       FROM coverva_dmas.cp_application_inventory "
            + "       GROUP BY tracking_number) mwd WHERE dmas.tracking_number = mwd.tracking_number AND dmas.file_inventory_date = CAST(:1 AS DATE) AND mwd.my_workspace_date IS NOT NULL;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                  
      
       /* Override value */                 
       strSQLText = "UPDATE coverva_dmas.dmas_application dmas "
            + " SET dmas.app_received_date = aofl.app_received_date,fp_update_dt = current_timestamp(),override_value_indicator = 'Y' "
            + " FROM (SELECT tracking_number,app_received_date,file_date "
            + "       FROM(SELECT DISTINCT tracking_number,CAST(REPLACE(TO_CHAR(app_received_date),'0021','2021') AS DATE) app_received_date, CAST(lf.file_date AS DATE) AS file_date"
            + "            FROM coverva_dmas.application_override_full_load aofl JOIN coverva_dmas.dmas_file_log lf ON UPPER(aofl.filename) = lf.filename "
            + "            WHERE CAST(lf.file_date AS DATE) = CAST(:1 AS DATE) ) aofl "
            + "        WHERE  app_received_date IS NOT NULL ) aofl "
            + " WHERE dmas.tracking_number = aofl.tracking_number AND dmas.file_inventory_date = aofl.file_date;";
       strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       ret_value = strSQLStmt.execute();                      
            
       } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;