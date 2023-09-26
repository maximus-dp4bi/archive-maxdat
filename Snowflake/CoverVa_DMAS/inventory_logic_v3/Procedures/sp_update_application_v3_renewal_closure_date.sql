use schema coverva_dmas;
create or replace procedure SP_UPDATE_APPLICATION_V3_RENEWAL_CLOSURE_DATE(INV_FILE_DATE VARCHAR)
  returns variant not null
  language javascript
  as
  $$
  
  /* Declare Variables */    
  var strErrMsg = "";
  
   try {  
       /* STEP : Update renewal closure date */
       
       var strSQLText = `UPDATE coverva_dmas.dmas_application_v3_inventory dmas 
                SET dmas.renewal_closure_date = da.renewal_closure_date, dmas.auto_closure_date = da.max_auto_closure_date, dmas.denial_reason = da.denial_reason,fp_update_dt = current_timestamp()
                FROM (SELECT rapp.tracking_number, rapp.dmas_application_id,rapp.case_number,rapp.event_date,autc.max_auto_closure_date, current_state,case_type,
                            CASE WHEN autc.case_number IS NOT NULL THEN autc.auto_renewal_closure_date
                                 WHEN crc.case_number IS NOT NULL THEN crc.crc_renewal_closure_date
                                 WHEN inv.cp_renewal_closure_date IS NOT NULL THEN inv.cp_renewal_closure_date
                                 WHEN mioc.mio_renewal_closure_date IS NOT NULL THEN mioc.mio_renewal_closure_date
                            ELSE NULL END renewal_closure_date,
                            COALESCE(cp_denial_reason,mio_denial_reason,cm_denial_reason) denial_reason
                      FROM(SELECT *
                           FROM(SELECT tracking_number, dmas_application_id, case_number, current_state,case_type,file_inventory_date event_date,cm044_verified
                                FROM coverva_dmas.dmas_application_v3_inventory 
                                WHERE 1=1
                                --AND case_type = 'Renewal'                           
                                QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) = 1)
                           WHERE current_state NOT IN('Waiting Initial Review','Waiting for Verification Documents','Intake')     ) rapp
                       LEFT JOIN(SELECT acc.case_number, CAST(fl.file_date AS DATE) max_auto_closure_date,DATE_TRUNC('MONTH', CAST(fl.file_date AS DATE))-1 auto_renewal_closure_date
                                 FROM coverva_dmas.auto_closure_cases_full_load acc 
                                   JOIN coverva_dmas.dmas_file_log fl ON UPPER(acc.filename) = UPPER(fl.filename)
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY case_number ORDER BY fl.file_date DESC,auto_closure_case_id DESC) = 1) autc ON autc.case_number = rapp.case_number
                       LEFT JOIN(SELECT crc.case_number,
                                     CASE WHEN renewal_completion_date > LAST_DAY(renewal_due_date) THEN LAST_DAY(renewal_completion_date) ELSE LAST_DAY(renewal_due_date) END crc_renewal_closure_date
                                 FROM coverva_dmas.rp274_data_full_load crc
                                   JOIN coverva_dmas.dmas_file_log fl ON UPPER(crc.filename) = UPPER(fl.filename)
                                 WHERE COALESCE(crc.renewal_completion_date,crc.renewal_due_date) IS NOT NULL
                                 QUALIFY ROW_NUMBER() OVER (PARTITION BY crc.case_number ORDER BY fl.file_date DESC,crc.rp274_data_id DESC) = 1) crc ON crc.case_number = rapp.case_number
                       LEFT JOIN(SELECT tracking_number,LAST_DAY(renewal_due_date) cp_renewal_closure_date,denial_reason cp_denial_reason
                                 FROM coverva_dmas.cp_application_inventory
                                 WHERE (closed_renewal = 'Y' OR denial_reason IS NOT NULL)
                                 QUALIFY ROW_NUMBER() OVER(PARTITION BY tracking_number ORDER BY sr_id DESC,sr_status_date DESC, renewal_due_date DESC NULLS LAST) = 1
                                ) inv ON inv.tracking_number = rapp.tracking_number
                       LEFT JOIN(SELECT case_number tracking_number,
                                   CASE WHEN SUBSTR(case_put_on_hold,1,2) != '20' THEN NULL
                                       WHEN CAST(case_put_on_hold AS DATE) <= DATE_TRUNC('MONTH', CAST(case_put_on_hold AS DATE)) + 15 THEN LAST_DAY(CAST(case_put_on_hold AS DATE)) 
                                     ELSE LAST_DAY(ADD_MONTHS(CAST(case_put_on_hold AS DATE),1)) END mio_renewal_closure_date,denial_reason mio_denial_reason
                                 FROM coverva_mio.mio_inventory_full_load_vw mio
                                 WHERE mio_term_state = 'Denied'
                                 AND case_type = 'R'
                                 AND latest_dispo_rank = 1) mioc ON mioc.tracking_number = rapp.tracking_number
                       LEFT JOIN(SELECT tracking_number,denial_closure_reason cm_denial_reason
                                 FROM coverva_dmas.cm_processing_time_full_load cm
                                   JOIN coverva_dmas.dmas_file_log fl ON UPPER(cm.filename) = UPPER(fl.filename)
                                 WHERE UPPER(status) LIKE '%DENIED%'
                                 QUALIFY ROW_NUMBER() OVER(PARTITION BY cm.tracking_number ORDER BY fl.file_date DESC,cm.cm_pt_data_id DESC) = 1) cm ON cm.tracking_number = rapp.tracking_number AND rapp.cm044_verified = 'Y'         
                                 ) da
                WHERE dmas.dmas_application_id = da.dmas_application_id;`;
       /*var strSQLStmt = snowflake.createStatement({sqlText: strSQLText,binds: [INV_FILE_DATE]});*/
       var strSQLStmt = strSQLStmt = snowflake.createStatement({sqlText: strSQLText});
       var ret_value = strSQLStmt.execute();
       
      } 
  catch (err)  {     
	   strErrMsg = err.message.replace(/'/g,"");                    
     return 1;
  }
    return 0; /* SUCCESS */   
  $$;