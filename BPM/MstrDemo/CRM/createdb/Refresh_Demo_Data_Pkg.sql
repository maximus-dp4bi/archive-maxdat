CREATE OR REPLACE PACKAGE REFRESH_DATA_PKG AS
 
  PROCEDURE REFRESH_CRM_TABLES;  
  PROCEDURE REFRESH_MFD_TABLE;  
  PROCEDURE REFRESH_MFB_TABLES;  
  PROCEDURE REFRESH_PI_TABLE;  
END;
/
CREATE OR REPLACE PACKAGE BODY REFRESH_DATA_PKG AS

PROCEDURE REFRESH_CRM_TABLES AS
  
  v_min_date DATE := NULL;  
  v_crm_run_date DATE;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_crm_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_CRM_RUNDATE';

  IF v_crm_run_date = TRUNC(sysdate) THEN
    FOR x IN(SELECT * FROM d_months
             WHERE d_month_start >=  ADD_MONTHS(TRUNC(sysdate,'mm'),-3)
             AND d_month_end <= TRUNC(sysdate,'mm')-1
             ORDER BY d_month_start) LOOP
    
      v_min_date := NULL;
      
      SELECT MIN(create_dt)
      INTO v_min_date
      FROM d_sci_current
      WHERE TRUNC(create_dt,'mm') = x.d_month_start;
    
      IF v_min_date IS NULL THEN
        UPDATE d_sci_current
        SET create_dt = ADD_MONTHS(create_dt,3)
           ,complete_dt = ADD_MONTHS(complete_dt,3)
           ,contact_start_dt = ADD_MONTHS(contact_start_dt,3)
           ,contact_end_dt = ADD_MONTHS(contact_end_dt,3)
           ,last_update_date = ADD_MONTHS(last_update_date,3)
        WHERE TRUNC(create_dt) >= ADD_MONTHS(x.d_month_start,-3)
        AND TRUNC(create_dt) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-3));
      END IF;  
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(ADD_MONTHS(TRUNC(sysdate),1),'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_CRM_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_CRM_TABLES;


PROCEDURE REFRESH_MFD_TABLE AS
  
  v_min_date DATE := NULL;  
  v_mfd_run_date DATE;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_mfd_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_MFD_RUNDATE';

  IF v_mfd_run_date = TRUNC(sysdate) THEN
    FOR x IN(SELECT * FROM d_months
             WHERE d_month_start >=  ADD_MONTHS(TRUNC(sysdate,'mm'),-4)
             AND d_month_end <= TRUNC(sysdate,'mm')-1
             ORDER BY d_month_start) LOOP
    
      v_min_date := NULL;
      
      SELECT MIN(create_dt)
      INTO v_min_date
      FROM d_mfd_current
      WHERE TRUNC(create_dt,'mm') = x.d_month_start;
    
      IF v_min_date IS NULL THEN
        UPDATE d_mfd_current
        SET stg_extract_date = ADD_MONTHS(stg_extract_date,4)
            ,stg_last_update_date = ADD_MONTHS(stg_last_update_date,4)
            ,timeliness_date = ADD_MONTHS(timeliness_date,4)
            ,jeopardy_date = ADD_MONTHS(jeopardy_date,4)
            ,sla_received_date = ADD_MONTHS(sla_received_date,4)
            ,link_dt = ADD_MONTHS(link_dt,4)
            ,instance_start_date = ADD_MONTHS(instance_start_date,4)
            ,instance_end_date = ADD_MONTHS(instance_end_date,4)
            ,complete_dt = ADD_MONTHS(complete_dt,4)
            ,cancel_dt = ADD_MONTHS(cancel_dt,4)
            ,create_dt = ADD_MONTHS(create_dt,4)
            ,received_dt = ADD_MONTHS(received_dt,4)
            ,doc_status_dt = ADD_MONTHS(doc_status_dt,4)
            ,doc_update_dt = ADD_MONTHS(doc_update_dt,4)
            ,scan_dt = ADD_MONTHS(scan_dt,4)
            ,release_dt = ADD_MONTHS(release_dt,4)
            ,env_status_dt = ADD_MONTHS(env_status_dt,4)
            ,sla_complete_dt = ADD_MONTHS(sla_complete_dt,4)
            ,env_update_dt = ADD_MONTHS(env_update_dt,4)
            ,maxe_origination_dt = ADD_MONTHS(maxe_origination_dt,4)
            ,trashed_dt = ADD_MONTHS(trashed_dt,4)
        WHERE TRUNC(create_dt) >= ADD_MONTHS(x.d_month_start,-4)
        AND TRUNC(create_dt) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-4))
        AND TRUNC(create_dt,'mm') = TRUNC(stg_last_update_date,'mm');
      END IF;  
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(ADD_MONTHS(TRUNC(sysdate),1),'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_MFD_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_MFD_TABLE;

PROCEDURE REFRESH_MFB_TABLES AS
  
  v_min_date DATE := NULL;    
  v_mfb_run_date DATE;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_mfb_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_MFB_RUNDATE';

  IF v_mfb_run_date = TRUNC(sysdate) THEN
    FOR x IN(SELECT * FROM d_months
             WHERE d_month_start >=  ADD_MONTHS(TRUNC(sysdate,'mm'),-4)
             AND d_month_end <= TRUNC(sysdate,'mm')-1
             ORDER BY d_month_start) LOOP
    
      v_min_date := NULL;     
      
      SELECT MIN(create_dt)
      INTO v_min_date
      FROM d_mfb_current
      WHERE TRUNC(create_dt,'mm') = x.d_month_start;
    
      IF v_min_date IS NULL         
      THEN
        UPDATE d_mfb_current
        SET extract_date = ADD_MONTHS(extract_date,1) --extract date is 6/3 for all records
            ,create_dt = ADD_MONTHS(create_dt,4)
            ,complete_dt = ADD_MONTHS(complete_dt,4)
            ,instance_status_dt = ADD_MONTHS(instance_status_dt,4)
            ,cancel_dt = ADD_MONTHS(cancel_dt,4)
            ,perform_qc_end = ADD_MONTHS(perform_qc_end,4)
            ,timeliness_dt = ADD_MONTHS(timeliness_dt,4)
            ,jeopardy_dt = ADD_MONTHS(jeopardy_dt,4)
            ,batch_complete_dt = ADD_MONTHS(batch_complete_dt,4)
            ,current_batch_module_start_dt = ADD_MONTHS(current_batch_module_start_dt,4)
            ,current_batch_module_end_dt = ADD_MONTHS(current_batch_module_end_dt,4)            
            ,perform_scan_start = ADD_MONTHS(perform_scan_start,4)
            ,perform_scan_end = ADD_MONTHS(perform_scan_end,4)
            ,perform_qc_start = ADD_MONTHS(perform_qc_start,4)
            ,classification_start = ADD_MONTHS(classification_start,4)
            ,classification_end = ADD_MONTHS(classification_end,4)
            ,classification_dt = ADD_MONTHS(classification_dt,4)
            ,recognition_start = ADD_MONTHS(recognition_start,4)
            ,recognition_end = ADD_MONTHS(recognition_end,4)
            ,recognition_dt = ADD_MONTHS(recognition_dt,4)
            ,validate_data_start = ADD_MONTHS(validate_data_start,4)
            ,validate_data_end = ADD_MONTHS(validate_data_end,4)
            ,validation_dt = ADD_MONTHS(validation_dt,4)
            ,create_pdfs_start = ADD_MONTHS(create_pdfs_start,4)
            ,create_pdfs_end = ADD_MONTHS(create_pdfs_end,4)
            ,populate_reports_data_start = ADD_MONTHS(populate_reports_data_start,4)
            ,populate_reports_data_end = ADD_MONTHS(populate_reports_data_end,4)
            ,release_to_dms_start = ADD_MONTHS(release_to_dms_start,4)
            ,release_to_dms_end = ADD_MONTHS(release_to_dms_end,4)
        WHERE TRUNC(create_dt) >= ADD_MONTHS(x.d_month_start,-4)
        AND TRUNC(create_dt) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-4)) ;
        
        UPDATE d_mfb_events
        SET module_start_dt = ADD_MONTHS(module_start_dt,4)
           ,module_end_dt = ADD_MONTHS(module_end_dt,4)
        WHERE TRUNC(module_start_dt) >= ADD_MONTHS(x.d_month_start,-4)
        AND TRUNC(module_start_dt) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-4)) ;   
        
        UPDATE d_mfb_reporting
        SET batch_create_date = ADD_MONTHS(batch_create_date,4)
            ,batch_export_date = ADD_MONTHS(batch_export_date,4)
        WHERE TRUNC(batch_create_date) >= ADD_MONTHS(x.d_month_start,-4)
        AND TRUNC(batch_create_date) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-4)) ; 

        UPDATE f_mfb_by_date
        SET d_date =  ADD_MONTHS(d_date,4)           
        WHERE TRUNC(d_date) >= ADD_MONTHS(x.d_month_start,-4)
        AND TRUNC(d_date) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-4)) ; 
        
      END IF;  
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(ADD_MONTHS(TRUNC(sysdate),1),'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_MFB_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_MFB_TABLES;

PROCEDURE REFRESH_PI_TABLE AS
  
  v_min_date DATE := NULL;    
  v_pi_run_date DATE;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_pi_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_PI_RUNDATE';

  IF v_pi_run_date = TRUNC(sysdate) THEN
    FOR x IN(SELECT * FROM d_months
             WHERE d_month_start >=  ADD_MONTHS(TRUNC(sysdate,'mm'),-6)
             AND d_month_end <= TRUNC(sysdate,'mm')-1
             ORDER BY d_month_start) LOOP
    
      v_min_date := NULL;     
      
      SELECT MIN(create_date)
      INTO v_min_date
      FROM d_pi_current
      WHERE TRUNC(create_date,'mm') = x.d_month_start;
    
      IF v_min_date IS NULL         
      THEN
        UPDATE d_pi_current
        SET cancel_date =  ADD_MONTHS(cancel_date,6)
            ,create_date =  ADD_MONTHS(create_date,6)
            ,receipt_date =  ADD_MONTHS(receipt_date,6)
            ,three_way_call_date =  ADD_MONTHS(three_way_call_date,6)
            ,escalate_date =  ADD_MONTHS(escalate_date,6)
            ,return_to_mms_dt =  ADD_MONTHS(return_to_mms_dt,6)
            ,complete_incident_end_dt =  ADD_MONTHS(complete_incident_end_dt,6)
            ,complete_incident_st_dt =  ADD_MONTHS(complete_incident_st_dt,6)
            ,process_incident_end_dt =  ADD_MONTHS(process_incident_end_dt,6)
            ,process_incident_st_dt =  ADD_MONTHS(process_incident_st_dt,6)
            ,research_incident_end_dt =  ADD_MONTHS(research_incident_end_dt,6)
            ,research_incident_st_dt =  ADD_MONTHS(research_incident_st_dt,6)
            ,hearing_date =  ADD_MONTHS(hearing_date,6)
            ,state_received_appeal_date =  ADD_MONTHS(state_received_appeal_date,6)
            ,escalate_to_state_dt =  ADD_MONTHS(escalate_to_state_dt,6)
            ,process_clnt_notify_end_dt =  ADD_MONTHS(process_clnt_notify_end_dt,6)
            ,process_clnt_notify_start_dt =  ADD_MONTHS(process_clnt_notify_start_dt,6)
            ,cur_last_update_date =  ADD_MONTHS(cur_last_update_date,6)
            ,complete_date =  ADD_MONTHS(complete_date,6)
            ,jeopardy_status_date =  ADD_MONTHS(jeopardy_status_date,6)
            ,cur_incident_status_date =  ADD_MONTHS(cur_incident_status_date,6)
        WHERE TRUNC(create_date) >= ADD_MONTHS(x.d_month_start,-6)
        AND TRUNC(create_date) <= LAST_DAY(ADD_MONTHS(x.d_month_start,-6)) 
        AND TRUNC(create_date,'mm') = TRUNC(complete_date,'mm');       
        
      END IF;  
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(ADD_MONTHS(TRUNC(sysdate),1),'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_PI_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_PI_TABLE;
     
END;
/