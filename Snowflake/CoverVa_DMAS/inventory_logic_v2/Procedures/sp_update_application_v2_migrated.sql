use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V2_MIGRATED(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 6: Update if app is migrated */         
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas 
               SET dmas.migrated_app_indicator = da.migrated_app_indicator, fp_update_dt = current_timestamp() 
               FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                      ,COALESCE(cp.migrated_app_indicator,'N') migrated_app_indicator 
                     FROM (SELECT tracking_number, event_date 
                           FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                                 FROM coverva_dmas.dmas_application_v2_inventory 
                                 WHERE file_inventory_date = CAST(:1 AS DATE)) d 
                           WHERE rnk = 1 ) da           
                      LEFT JOIN (SELECT tracking_number,'Y' migrated_app_indicator 
                                 FROM(SELECT DISTINCT tracking_number,app_type,sr_create_date created_on, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id DESC) rnk 
                                      FROM coverva_dmas.cp_application_inventory 
                                      WHERE migrated = 'YES') 
                                 WHERE rnk = 1) cp ON da.tracking_number = cp.tracking_number  ) da 
               WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.migrated_app_indicator IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();   
            
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;