use schema coverva_dmas;
create or replace procedure SP_POPULATE_CDC_V3_TABLE()
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  var fileCount= 0;
  var strInvErrMsg = "";  
  var strStartDate=  Date();
  var invStartDate = Date();
  
  //snowflake.execute( {sqlText: "BEGIN;"} );
   try {  
   
     /* update config control if there are older files not processed */
     
    var strSQLText = ` UPDATE coverva_dmas.dmas_file_log fl 
                     SET cdc_v3_processed = 'N',cdc_v3_processed_date = null 
                     FROM(SELECT COALESCE(LEAST(fl.file_date,CAST(cc.config_value AS DATE)),CAST(cc.config_value AS DATE)) min_file_date, 
                            CASE WHEN COALESCE(LEAST(fl.file_date,CAST(cc.config_value AS DATE)),CAST(cc.config_value AS DATE)) <> CAST(cc.config_value AS DATE) THEN 'Y' ELSE 'N' END upd_cdc 
                          FROM coverva_dmas.dmas_config_control cc 
                             JOIN (SELECT MIN(CAST(fl.file_date AS DATE)) file_date 
                                   FROM coverva_dmas.dmas_file_load_lkup ll 
                                     JOIN coverva_dmas.dmas_file_log fl ON fl.filename_prefix = ll.filename_prefix  
                                   WHERE ll.use_in_v3_inventory = 'Y' 
                                   AND ll.file_day_received NOT IN('WEEKLY','MONTHLY')
                                   AND fl.load_status = 'COMPLETED' AND fl.cdc_v3_processed = 'N' 
                                   AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_file_log pfl WHERE pfl.filename_prefix = fl.filename_prefix AND CAST(pfl.file_date AS DATE) = CAST(fl.file_date AS DATE) AND pfl.cdc_v3_processed = 'Y') ) fl  
                           WHERE cc.config_name = 'INVENTORY_V3_FILE_DATE' ) mf WHERE fl.file_date >= mf.min_file_date AND cdc_v3_processed = 'Y' AND mf.upd_cdc = 'Y'; `;
      var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      var ret_value = strSQLStmt.execute();  
     
     strSQLText = `UPDATE coverva_dmas.dmas_config_control cc SET cc.config_value = mf.min_file_date 
                     FROM(SELECT cc.config_name,TO_CHAR(COALESCE(LEAST(fl.file_date,CAST(cc.config_value AS DATE)),CAST(cc.config_value AS DATE)),'MM/DD/YYYY') min_file_date 
                          FROM coverva_dmas.dmas_config_control cc 
                             JOIN (SELECT MIN(CAST(fl.file_date AS DATE)) file_date 
                                   FROM coverva_dmas.dmas_file_load_lkup ll 
                                     JOIN coverva_dmas.dmas_file_log fl ON fl.filename_prefix = ll.filename_prefix  
                                   WHERE ll.use_in_v3_inventory = 'Y' AND fl.load_status = 'COMPLETED' AND fl.cdc_v3_processed = 'N' 
                                   AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_file_log pfl WHERE pfl.filename_prefix = fl.filename_prefix AND CAST(pfl.file_date AS DATE) = CAST(fl.file_date AS DATE) AND pfl.cdc_v3_processed = 'Y') ) fl   
                           WHERE cc.config_name = 'INVENTORY_V3_FILE_DATE') mf WHERE cc.config_name = mf.config_name AND cc.config_value != mf.min_file_date; `;
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute();  
   
      strSQLText = `SELECT DISTINCT d_date,COALESCE(file_count,0) file_count 
                        FROM public.d_dates dd JOIN coverva_dmas.dmas_config_control ccd ON ccd.config_name = 'INVENTORY_DAYS_TO_PROCESS' 
                          JOIN coverva_dmas.dmas_config_control cc 
                           ON d_date >= CAST(cc.config_value AS DATE) 
                           AND d_date <= CASE WHEN ccd.config_value != 0 THEN LEAST(DATEADD(DAY,ccd.config_value,CAST(cc.config_value AS DATE)),CURRENT_DATE()) ELSE CURRENT_DATE() END 
                          LEFT JOIN (SELECT CAST(fl.file_date AS DATE) file_date,COUNT(DISTINCT fl.filename_prefix) file_count 
                                     FROM coverva_dmas.dmas_file_load_lkup ll JOIN coverva_dmas.dmas_file_log fl ON fl.filename_prefix = ll.filename_prefix 
                                     WHERE ll.use_in_v3_inventory = 'Y' AND fl.load_status = 'COMPLETED' AND fl.cdc_v3_processed = 'N' GROUP BY CAST(fl.file_date AS DATE)) fl ON fl.file_date = dd.d_date 
                        WHERE cc.config_name = 'INVENTORY_V3_FILE_DATE' 
                        ORDER BY d_date; `;  
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      flListDates = strSQLStmt.execute();       
      
      strSQLText = "SELECT config_value numfiles FROM coverva_dmas.dmas_config_control WHERE config_name = 'INVENTORY_NUMBER_OF_FILES';";        
      strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
      ret_value = strSQLStmt.execute();  
      ret_value.next();
      var invNumFile = ret_value.getColumnValue('NUMFILES');          
      
      while (flListDates.next())  {
      
      try{
        fileCount= 0;
        strStartDate = flListDates.getColumnValue('D_DATE'); 
        invStartDate = strStartDate.toISOString();
        fileCount = flListDates.getColumnValue('FILE_COUNT');
        
        snowflake.execute( {sqlText: "BEGIN;"} );
        
        if (fileCount >= invNumFile)          
          {      
               /* STEP 1: Get list of application IDs */
               strSQLText = "CALL SP_POPULATE_APPLICATION_V3_LIST(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               var ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_CREATE_APPLICATION_V3_EVENT(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               var ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_SOURCE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               /* App Received stored proc also updates the Maximus Source Date*/
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_RECEIVED_DATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_UNIT(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_TYPE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_CASE_TYPE_STAGE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_IN_CP(:1);";                   
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               /* Current State stored proc also updates the App End Date, CM44 verified, Non Maximus Initial and Returned dates*/
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_CURRENT_STATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_REVIEW_DATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
                     
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_WORKER(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_VCL_DUEDATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_RENEWAL_CLOSURE_DATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_NOA_GENERATION_DATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_UPDATE_APPLICATION_V3_CURRENT_STATE_FIRST_DATE(:1);";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = "CALL SP_POPULATE_APPLICATION_V3_CURRENT();";                     
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
               
               strSQLText = `UPDATE COVERVA_DMAS.dmas_file_log fl 
                       SET cdc_v3_processed = 'Y', cdc_v3_processed_date = current_timestamp() 
                       WHERE CAST(file_date AS DATE) = CAST(:1 AS DATE) 
                       AND cdc_v3_processed = 'N' 
                       AND EXISTS(SELECT 1 FROM coverva_dmas.dmas_file_load_lkup ll WHERE fl.filename_prefix = ll.filename_prefix AND ll.use_in_v3_inventory= 'Y'); `;       
               strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [invStartDate]});
               ret_value = strSQLStmt.execute();
    
            }
        /*else     
          {
            strInvErrMsg = "'Not all files are present for Date " + invStartDate + "'";
            strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (error_message) VALUES (" + strInvErrMsg + "); ";
            strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
            var ret_value = strSQLStmt.execute();                    
          }  */
       snowflake.execute( {sqlText: "COMMIT;"} );
       }          
      catch (err)  {     
         strErrMsg = err.message.replace(/'/g,"");       
         snowflake.execute( {sqlText: "ROLLBACK;"} );
                 
         //strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (file_id, filename,error_message) VALUES (" + fileID + ", '" + strFromTableName + "', " + strErrMsg + "); ";
         //strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         //ret_value = strSQLStmt.execute();
                 
         return 1;
        }
      };
    } 
  catch (err)  {     
         strErrMsg = err.message.replace(/'/g,"");       
         snowflake.execute( {sqlText: "ROLLBACK;"} );
                 
         //strSQLText = "INSERT INTO COVERVA_DMAS.DMAS_FILE_ERROR_LOG (file_id, filename,error_message) VALUES (" + fileID + ", '" + strFromTableName + "', " + strErrMsg + "); ";
         //strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
         //ret_value = strSQLStmt.execute();
                 
         return 1;
   }
   
   strSQLText = `UPDATE COVERVA_DMAS.dmas_config_control SET config_value = max_file_date 
               FROM (SELECT TO_CHAR(MAX(file_inventory_date),'MM/DD/YYYY') max_file_date 
                     FROM coverva_dmas.dmas_application_v3_inventory ) 
               WHERE config_name = 'INVENTORY_V3_FILE_DATE';`;                 
   strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
    ret_value = strSQLStmt.execute();
    
   strSQLText = "UPDATE coverva_dmas.dmas_config_control cc SET cc.config_value = 'N' ,update_dt = current_timestamp() WHERE config_name = 'INVENTORY_BYPASS_MISSING_FILES' AND cc.config_value = 'Y' ;" ;
   strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
   ret_value = strSQLStmt.execute();
   
    snowflake.execute( {sqlText: "COMMIT;"} );          
  
    return 0; /* SUCCESS */   
  $$;