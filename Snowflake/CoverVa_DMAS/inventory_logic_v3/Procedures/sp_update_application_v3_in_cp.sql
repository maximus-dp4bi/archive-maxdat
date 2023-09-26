use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_IN_CP(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       
       /* STEP 6: Update if app is in ConnectionPoint */         
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
             SET dmas.in_cp_indicator = da.in_cp_indicator ,dmas.intake_date = da.intake_date,cp_application_type = da.cp_application_type, fp_update_dt = current_timestamp() 
             FROM (SELECT DISTINCT da.tracking_number, da.event_date ,dmas_application_id
                      ,COALESCE(o.override_in_cp,cp.in_cp,'N') in_cp_indicator ,CASE WHEN previous_intake_date IS NOT NULL THEN previous_intake_date ELSE COALESCE(o.ovr_intake_date,cp.created_on) END intake_date ,cp.app_type cp_application_type                      
                   FROM (SELECT tracking_number, event_date,dmas_application_id,previous_intake_date 
                         FROM (SELECT tracking_number,file_inventory_date event_date,dmas_application_id,
                                 RANK() OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) rnk,
                                 COALESCE(intake_date,LEAD(intake_date) IGNORE NULLS OVER(PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC)) previous_intake_date 
                               FROM coverva_dmas.dmas_application_v3_inventory) d 
                         WHERE rnk = 1 ) da          
                      LEFT JOIN (SELECT tracking_number,app_type,created_on, 'Y' in_cp 
                                 FROM(SELECT DISTINCT tracking_number,app_type,sr_create_date created_on, RANK() OVER (PARTITION BY tracking_number ORDER BY sr_id) rnk 
                                      FROM coverva_dmas.cp_application_inventory) 
                                 WHERE rnk = 1) cp ON da.tracking_number = cp.tracking_number 
                      LEFT JOIN (SELECT DISTINCT tracking_number, in_cp override_in_cp,file_date,ovr_intake_date 
                                 FROM(SELECT tracking_number,UPPER(LEFT(o.in_cp,1)) in_cp, CAST(f.file_date AS DATE) AS file_date, 
                                          CASE WHEN UPPER(LEFT(o.in_cp,1)) = 'Y' THEN CAST(f.file_date AS DATE) ELSE NULL END ovr_intake_date,
                                          RANK() OVER(PARTITION BY tracking_number ORDER BY recent_submission_date DESC,app_override_id DESC) rnk 
                                      FROM coverva_dmas.application_override_full_load o 
                                        JOIN coverva_dmas.dmas_file_log f ON UPPER(o.filename) = UPPER(f.filename) ) 
                                 WHERE rnk = 1 AND override_in_cp IS NOT NULL) o ON da.tracking_number = o.tracking_number ) da 
              WHERE dmas.dmas_application_id = da.dmas_application_id AND (dmas.in_cp_indicator IS NULL OR dmas.in_cp_indicator != da.in_cp_indicator);`;
       var strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();   
            
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;