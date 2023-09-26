use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V2_IN_CP(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 6: Update if app is in ConnectionPoint */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v2_inventory dmas 
             SET dmas.in_cp_indicator = da.in_cp_indicator ,dmas.intake_date = da.intake_date,cp_application_type = da.cp_application_type, dmas.override_value_indicator = da.override_indicator, fp_update_dt = current_timestamp() 
             FROM (SELECT DISTINCT da.tracking_number, da.event_date 
                      ,COALESCE(o.override_in_cp,cp.in_cp,'N') in_cp_indicator ,COALESCE(o.file_date,cp.created_on) intake_date ,cp.app_type cp_application_type 
                     ,CASE WHEN o.override_in_cp IS NOT NULL THEN 'Y' ELSE NULL END override_indicator 
                   FROM (SELECT tracking_number, event_date 
                         FROM (SELECT tracking_number,file_inventory_date event_date,RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk 
                               FROM coverva_dmas.dmas_application_v2_inventory 
                                WHERE file_inventory_date = CAST(:1 AS DATE)) d 
                         WHERE rnk = 1 ) da          
                      LEFT JOIN (SELECT tracking_number,app_type,created_on, 'Y' in_cp 
                                 FROM(SELECT DISTINCT tracking_number,app_type,sr_create_date created_on, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk 
                                      FROM coverva_dmas.cp_application_inventory) 
                                 WHERE rnk = 1) cp ON da.tracking_number = cp.tracking_number 
                      LEFT JOIN (SELECT DISTINCT tracking_number, in_cp override_in_cp,file_date 
                                 FROM(SELECT tracking_number,UPPER(LEFT(o.in_cp,1)) in_cp, CAST(f.file_date AS DATE) AS file_date, 
                                          RANK() OVER(PARTITION BY tracking_number,f.file_date ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                      FROM coverva_dmas.application_override_full_load o 
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                 WHERE rnk = 1 AND override_in_cp IS NOT NULL) o ON da.tracking_number = o.tracking_number AND da.event_date = o.file_date ) da 
              WHERE dmas.tracking_number = da.tracking_number AND dmas.file_inventory_date = da.event_date AND dmas.in_cp_indicator IS NULL;`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});
       var ret_value = strSQLStmt.execute();   
            
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;