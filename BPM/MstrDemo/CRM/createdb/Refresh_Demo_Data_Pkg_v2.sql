CREATE OR REPLACE PACKAGE REFRESH_DATA_PKG AS
 
  PROCEDURE REFRESH_CRM_TABLES;  
  PROCEDURE REFRESH_MFD_TABLE;  
  PROCEDURE REFRESH_MFB_TABLES;  
  PROCEDURE REFRESH_PI_TABLE;  
  PROCEDURE REFRESH_PL_TABLE;
END;
/
CREATE OR REPLACE PACKAGE BODY REFRESH_DATA_PKG AS

PROCEDURE REFRESH_CRM_TABLES AS
  
  v_min_date DATE := NULL;  
  v_crm_run_date DATE;
  v_today DATE ;
  v_diff NUMBER;
  v_count_data NUMBER;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_crm_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_CRM_RUNDATE';
  
  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_today
  FROM corp_etl_control
  WHERE name = 'REFRESH_CRM_DATA_CURDATE';

  IF v_crm_run_date = TRUNC(sysdate) THEN
    WHILE v_today <= TRUNC(sysdate)  LOOP
      v_diff := 0;
      v_count_data := 0;
      v_min_date := NULL;
      
      SELECT COUNT(1)
      INTO v_count_data
      FROM d_sci_current
      WHERE TRUNC(create_dt) = v_today;
      
      IF v_count_data = 0 THEN      
        SELECT MIN(TRUNC(create_dt)), v_today - MIN(TRUNC(create_dt)) 
        INTO v_min_date, v_diff
        FROM d_sci_current;
     
        UPDATE d_sci_current
        SET create_dt = create_dt + v_diff
           ,complete_dt = complete_dt + v_diff
           ,contact_start_dt = contact_start_dt + v_diff
           ,contact_end_dt = contact_end_dt + v_diff
           ,last_update_date = last_update_date + v_diff
        WHERE TRUNC(create_dt) = v_min_date;
      END IF;  
      v_today := v_today + 1;
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(TRUNC(sysdate)+1,'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_CRM_RUNDATE';
    
    UPDATE corp_etl_control
    SET value = TO_CHAR(v_today,'MM/DD/YYYY')
    WHERE name = 'REFRESH_CRM_DATA_CURDATE';
    
    COMMIT;  
  END IF;
  
END REFRESH_CRM_TABLES;


PROCEDURE REFRESH_MFD_TABLE AS
  v_mfd_run_date DATE;
  v_today DATE ;  
  v_count_data NUMBER;  
  
  v_min_complete_date DATE := NULL;  
  v_completdt_diff NUMBER;
  v_min_instance_end_date DATE := NULL;
  v_instend_diff NUMBER;  
  v_min_sla_complete_dt DATE := NULL;
  v_slacomp_diff NUMBER;
  v_min_last_update_date DATE := NULL;
  v_updatedt_diff NUMBER;
  
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_mfd_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_MFD_RUNDATE';
  
  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_today
  FROM corp_etl_control
  WHERE name = 'REFRESH_MFD_DATA_CURDATE';  

  IF v_mfd_run_date = TRUNC(sysdate) THEN
    WHILE v_today <= TRUNC(sysdate)  LOOP      
      v_count_data := 0;
      
      v_min_complete_date := NULL;  
      v_completdt_diff := 0;
      v_min_instance_end_date := NULL;
      v_instend_diff := 0;  
      v_min_sla_complete_dt := NULL;
      v_slacomp_diff := 0;
      v_min_last_update_date := NULL;
      v_updatedt_diff := 0;
            
      SELECT COUNT(1)
      INTO v_count_data
      FROM d_mfd_current
      WHERE TRUNC(complete_dt) = v_today
        OR TRUNC(sla_complete_dt) = v_today
        OR TRUNC(instance_end_date) = v_today
        OR TRUNC(stg_last_update_date) = v_today;
      
      IF v_count_data = 0 THEN      
        SELECT MIN(TRUNC(complete_dt)), v_today - MIN(TRUNC(complete_dt)) 
             , MIN(TRUNC(instance_end_date)), v_today - MIN(TRUNC(instance_end_date)) 
             , MIN(TRUNC(sla_complete_dt)), v_today - MIN(TRUNC(sla_complete_dt)) 
             , MIN(TRUNC(stg_last_update_date)), v_today - MIN(TRUNC(stg_last_update_date)) 
        INTO v_min_complete_date, v_completdt_diff,
             v_min_instance_end_date, v_instend_diff,
             v_min_sla_complete_dt, v_slacomp_diff,
             v_min_last_update_date, v_updatedt_diff
        FROM d_mfd_current;
   
        UPDATE d_mfd_current
        SET stg_extract_date = stg_extract_date + v_completdt_diff
            ,stg_last_update_date = stg_last_update_date + v_completdt_diff 
            ,timeliness_date = timeliness_date + v_completdt_diff 
            ,jeopardy_date = jeopardy_date + v_completdt_diff 
            ,sla_received_date = sla_received_date + v_completdt_diff
            ,link_dt = link_dt + v_completdt_diff
            ,instance_start_date = instance_start_date + v_completdt_diff
            ,instance_end_date = instance_end_date + v_completdt_diff 
            ,complete_dt =  complete_dt + v_completdt_diff
            ,cancel_dt = cancel_dt + v_completdt_diff
            ,create_dt = create_dt + v_completdt_diff
            ,received_dt = received_dt + v_completdt_diff
            ,doc_status_dt = doc_status_dt + v_completdt_diff
            ,doc_update_dt = doc_update_dt + v_completdt_diff
            ,scan_dt = scan_dt + v_completdt_diff
            ,release_dt = release_dt + v_completdt_diff
            ,env_status_dt = env_status_dt + v_completdt_diff
            ,sla_complete_dt = sla_complete_dt + v_completdt_diff
            ,env_update_dt = env_update_dt + v_completdt_diff
            ,maxe_origination_dt =  maxe_origination_dt + v_completdt_diff
            ,trashed_dt = trashed_dt + v_completdt_diff
        WHERE complete_dt IS NOT NULL
        AND TRUNC(complete_dt) = v_min_complete_date ;
        
        UPDATE d_mfd_current
        SET stg_extract_date = stg_extract_date + v_slacomp_diff
            ,stg_last_update_date = stg_last_update_date + v_slacomp_diff 
            ,timeliness_date = timeliness_date + v_slacomp_diff 
            ,jeopardy_date = jeopardy_date + v_slacomp_diff 
            ,sla_received_date = sla_received_date + v_slacomp_diff
            ,link_dt = link_dt + v_slacomp_diff
            ,instance_start_date = instance_start_date + v_slacomp_diff
            ,instance_end_date = instance_end_date + v_slacomp_diff 
            ,complete_dt =  complete_dt + v_slacomp_diff
            ,cancel_dt = cancel_dt + v_slacomp_diff
            ,create_dt = create_dt + v_slacomp_diff
            ,received_dt = received_dt + v_slacomp_diff
            ,doc_status_dt = doc_status_dt + v_slacomp_diff
            ,doc_update_dt = doc_update_dt + v_slacomp_diff
            ,scan_dt = scan_dt + v_slacomp_diff
            ,release_dt = release_dt + v_slacomp_diff
            ,env_status_dt = env_status_dt + v_slacomp_diff
            ,sla_complete_dt = sla_complete_dt + v_slacomp_diff
            ,env_update_dt = env_update_dt + v_slacomp_diff
            ,maxe_origination_dt =  maxe_origination_dt + v_slacomp_diff
            ,trashed_dt = trashed_dt + v_slacomp_diff
        WHERE complete_dt IS NULL
        AND sla_complete_dt IS NOT NULL
        AND TRUNC(sla_complete_dt) = v_min_sla_complete_dt ;
        
        UPDATE d_mfd_current
        SET stg_extract_date = stg_extract_date + v_instend_diff
            ,stg_last_update_date = stg_last_update_date + v_instend_diff 
            ,timeliness_date = timeliness_date + v_instend_diff 
            ,jeopardy_date = jeopardy_date + v_instend_diff 
            ,sla_received_date = sla_received_date + v_instend_diff
            ,link_dt = link_dt + v_instend_diff
            ,instance_start_date = instance_start_date + v_instend_diff
            ,instance_end_date = instance_end_date + v_instend_diff 
            ,complete_dt =  complete_dt + v_instend_diff
            ,cancel_dt = cancel_dt + v_instend_diff
            ,create_dt = create_dt + v_instend_diff
            ,received_dt = received_dt + v_instend_diff
            ,doc_status_dt = doc_status_dt + v_instend_diff
            ,doc_update_dt = doc_update_dt + v_instend_diff
            ,scan_dt = scan_dt + v_instend_diff
            ,release_dt = release_dt + v_instend_diff
            ,env_status_dt = env_status_dt + v_instend_diff
            ,sla_complete_dt = sla_complete_dt + v_instend_diff
            ,env_update_dt = env_update_dt + v_instend_diff
            ,maxe_origination_dt =  maxe_origination_dt + v_instend_diff
            ,trashed_dt = trashed_dt + v_instend_diff
        WHERE complete_dt IS NULL
        AND sla_complete_dt IS NULL
        AND instance_end_date IS NOT NULL
        AND TRUNC(instance_end_date) = v_min_instance_end_date ;
        
        UPDATE d_mfd_current
        SET stg_extract_date = stg_extract_date + v_updatedt_diff
            ,stg_last_update_date = stg_last_update_date + v_updatedt_diff 
            ,timeliness_date = timeliness_date + v_updatedt_diff 
            ,jeopardy_date = jeopardy_date + v_updatedt_diff 
            ,sla_received_date = sla_received_date + v_updatedt_diff
            ,link_dt = link_dt + v_updatedt_diff
            ,instance_start_date = instance_start_date + v_updatedt_diff
            ,instance_end_date = instance_end_date + v_updatedt_diff 
            ,complete_dt =  complete_dt + v_updatedt_diff
            ,cancel_dt = cancel_dt + v_updatedt_diff
            ,create_dt = create_dt + v_updatedt_diff
            ,received_dt = received_dt + v_updatedt_diff
            ,doc_status_dt = doc_status_dt + v_updatedt_diff
            ,doc_update_dt = doc_update_dt + v_updatedt_diff
            ,scan_dt = scan_dt + v_updatedt_diff
            ,release_dt = release_dt + v_updatedt_diff
            ,env_status_dt = env_status_dt + v_updatedt_diff
            ,sla_complete_dt = sla_complete_dt + v_updatedt_diff
            ,env_update_dt = env_update_dt + v_updatedt_diff
            ,maxe_origination_dt =  maxe_origination_dt + v_updatedt_diff
            ,trashed_dt = trashed_dt + v_updatedt_diff
        WHERE complete_dt IS NULL
        AND sla_complete_dt IS NULL
        AND instance_end_date IS NULL
        AND stg_last_update_date IS NOT NULL
        AND TRUNC(stg_last_update_date) = v_min_last_update_date ;
        
      END IF;
      v_today := v_today + 1;
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(v_today,'MM/DD/YYYY')
    WHERE name = 'REFRESH_MFD_DATA_CURDATE';
    
    UPDATE corp_etl_control
    SET value = TO_CHAR(TRUNC(sysdate)+1,'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_MFD_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_MFD_TABLE;

PROCEDURE REFRESH_MFB_TABLES AS
  
  v_min_complete_date DATE := NULL;    
  v_min_cancel_date DATE := NULL; 
  v_min_module_end_date DATE := NULL;
  v_min_export_date DATE := NULL;
  v_min_fact_date DATE := NULL;
  v_mfb_run_date DATE;
  v_today DATE ;
  v_completedt_diff NUMBER;
  v_canceldt_diff NUMBER;
  v_modenddt_diff NUMBER;
  v_exportdt_diff NUMBER;
  v_fdt_diff NUMBER;
  v_count_data NUMBER; 
  v_count_events_data NUMBER; 
  v_count_report_data NUMBER;
  v_count_fact_data NUMBER;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_mfb_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_MFB_RUNDATE';
  
  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_today
  FROM corp_etl_control
  WHERE name = 'REFRESH_MFB_DATA_CURDATE';

  IF v_mfb_run_date = TRUNC(sysdate) THEN      
    WHILE v_today <= TRUNC(sysdate)  LOOP
      v_completedt_diff := 0;
      v_canceldt_diff := 0;
      v_modenddt_diff := 0;
      v_exportdt_diff := 0;
      v_fdt_diff := 0;
      v_count_data := 0;      
      v_count_events_data := 0;
      v_count_report_data := 0;
      v_count_fact_data := 0;
      v_min_complete_date := NULL;
      v_min_cancel_date := NULL;
      v_min_module_end_date := NULL;
      v_min_export_date := NULL;
      v_min_fact_date := NULL;
      
      SELECT COUNT(1)
      INTO v_count_data
      FROM d_mfb_current
      WHERE TRUNC(complete_dt) = v_today OR TRUNC(cancel_dt) = v_today;
      
      IF v_count_data = 0 THEN
        SELECT MIN(TRUNC(complete_dt)), v_today - MIN(TRUNC(complete_dt)) 
              ,MIN(TRUNC(cancel_dt)), v_today - MIN(TRUNC(cancel_dt)) 
        INTO v_min_complete_date, v_completedt_diff,v_min_cancel_date,v_canceldt_diff
        FROM d_mfb_current; 
      
        UPDATE d_mfb_current
        SET extract_date = extract_date + v_completedt_diff
            ,create_dt = create_dt + v_completedt_diff
            ,complete_dt = complete_dt + v_completedt_diff
            ,instance_status_dt = instance_status_dt + v_completedt_diff
            ,cancel_dt = cancel_dt + v_completedt_diff
            ,perform_qc_end = perform_qc_end + v_completedt_diff
            ,timeliness_dt = timeliness_dt + v_completedt_diff
            ,jeopardy_dt = jeopardy_dt + v_completedt_diff
            ,batch_complete_dt = batch_complete_dt + v_completedt_diff
            ,current_batch_module_start_dt = current_batch_module_start_dt + v_completedt_diff
            ,current_batch_module_end_dt = current_batch_module_end_dt + v_completedt_diff           
            ,perform_scan_start = perform_scan_start + v_completedt_diff
            ,perform_scan_end = perform_scan_end + v_completedt_diff
            ,perform_qc_start = perform_qc_start + v_completedt_diff
            ,classification_start = classification_start + v_completedt_diff
            ,classification_end = classification_end + v_completedt_diff
            ,classification_dt = classification_dt + v_completedt_diff
            ,recognition_start = recognition_start + v_completedt_diff
            ,recognition_end = recognition_end + v_completedt_diff
            ,recognition_dt = recognition_dt + v_completedt_diff
            ,validate_data_start = validate_data_start + v_completedt_diff
            ,validate_data_end = validate_data_end + v_completedt_diff
            ,validation_dt = validation_dt + v_completedt_diff
            ,create_pdfs_start = create_pdfs_start + v_completedt_diff
            ,create_pdfs_end = create_pdfs_end + v_completedt_diff
            ,populate_reports_data_start = populate_reports_data_start + v_completedt_diff
            ,populate_reports_data_end = populate_reports_data_end + v_completedt_diff
            ,release_to_dms_start = release_to_dms_start + v_completedt_diff
            ,release_to_dms_end = release_to_dms_end + v_completedt_diff
        WHERE TRUNC(complete_dt) = v_min_complete_date ;
        
        UPDATE d_mfb_current
        SET extract_date = extract_date + v_canceldt_diff
            ,create_dt = create_dt + v_canceldt_diff
            ,complete_dt = complete_dt + v_canceldt_diff
            ,instance_status_dt = instance_status_dt + v_canceldt_diff
            ,cancel_dt = cancel_dt + v_canceldt_diff
            ,perform_qc_end = perform_qc_end + v_canceldt_diff
            ,timeliness_dt = timeliness_dt + v_canceldt_diff
            ,jeopardy_dt = jeopardy_dt + v_canceldt_diff
            ,batch_complete_dt = batch_complete_dt + v_canceldt_diff
            ,current_batch_module_start_dt = current_batch_module_start_dt + v_canceldt_diff
            ,current_batch_module_end_dt = current_batch_module_end_dt + v_canceldt_diff           
            ,perform_scan_start = perform_scan_start + v_canceldt_diff
            ,perform_scan_end = perform_scan_end + v_canceldt_diff
            ,perform_qc_start = perform_qc_start + v_canceldt_diff
            ,classification_start = classification_start + v_canceldt_diff
            ,classification_end = classification_end + v_canceldt_diff
            ,classification_dt = classification_dt + v_canceldt_diff
            ,recognition_start = recognition_start + v_canceldt_diff
            ,recognition_end = recognition_end + v_canceldt_diff
            ,recognition_dt = recognition_dt + v_canceldt_diff
            ,validate_data_start = validate_data_start + v_canceldt_diff
            ,validate_data_end = validate_data_end + v_canceldt_diff
            ,validation_dt = validation_dt + v_canceldt_diff
            ,create_pdfs_start = create_pdfs_start + v_canceldt_diff
            ,create_pdfs_end = create_pdfs_end + v_canceldt_diff
            ,populate_reports_data_start = populate_reports_data_start + v_canceldt_diff
            ,populate_reports_data_end = populate_reports_data_end + v_canceldt_diff
            ,release_to_dms_start = release_to_dms_start + v_canceldt_diff
            ,release_to_dms_end = release_to_dms_end + v_canceldt_diff
        WHERE complete_dt IS NULL
        AND TRUNC(cancel_dt) = v_min_cancel_date ;
     END IF;
     
     SELECT COUNT(1)
     INTO v_count_events_data
     FROM d_mfb_events
     WHERE TRUNC(module_end_dt) = v_today;
     
     IF v_count_events_data = 0 THEN
        SELECT MIN(TRUNC(module_end_dt)), v_today - MIN(TRUNC(module_end_dt))              
        INTO v_min_module_end_date, v_modenddt_diff
        FROM d_mfb_events; 
        
        UPDATE d_mfb_events
        SET module_start_dt = module_start_dt + v_modenddt_diff
           ,module_end_dt = module_end_dt + v_modenddt_diff
        WHERE TRUNC(module_end_dt) = v_min_module_end_date ;        
     END IF;
     
     SELECT COUNT(1)
     INTO v_count_report_data
     FROM d_mfb_reporting
     WHERE TRUNC(batch_export_date) = v_today;
     
     IF v_count_report_data = 0 THEN
      SELECT MIN(TRUNC(batch_export_date)), v_today - MIN(TRUNC(batch_export_date))              
      INTO v_min_export_date, v_exportdt_diff
      FROM d_mfb_reporting; 
     
        UPDATE d_mfb_reporting
        SET batch_create_date = batch_create_date + v_exportdt_diff
            ,batch_export_date = batch_export_date + v_exportdt_diff
        WHERE TRUNC(batch_export_date) = v_min_export_date; 
     END IF;
     
     SELECT COUNT(1)
     INTO v_count_fact_data
     FROM f_mfb_by_date
     WHERE TRUNC(d_date) = v_today;
     
     IF v_count_fact_data = 0 THEN
       SELECT MIN(TRUNC(d_date)), v_today - MIN(TRUNC(d_date))              
       INTO v_min_fact_date, v_fdt_diff
       FROM f_mfb_by_date; 
      
        UPDATE f_mfb_by_date
        SET d_date =  d_date + v_fdt_diff           
        WHERE TRUNC(d_date) = v_min_fact_date ; 
     END IF;   
     v_today := v_today + 1; 
    END LOOP;  

    UPDATE corp_etl_control
    SET value = TO_CHAR(v_today,'MM/DD/YYYY')
    WHERE name = 'REFRESH_MFB_DATA_CURDATE';
    
    UPDATE corp_etl_control
    SET value = TO_CHAR(TRUNC(sysdate) +1,'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_MFB_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_MFB_TABLES;

PROCEDURE REFRESH_PI_TABLE AS
  
  v_min_date DATE := NULL;    
  v_pi_run_date DATE;
  v_today DATE ;
  v_diff NUMBER;
  v_count_data NUMBER;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_pi_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_PI_RUNDATE';
  
  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_today
  FROM corp_etl_control
  WHERE name = 'REFRESH_PI_DATA_CURDATE';  

  IF v_pi_run_date = TRUNC(sysdate) THEN
    WHILE v_today <= TRUNC(sysdate)  LOOP
      v_diff := 0;
      v_count_data := 0;
      v_min_date := NULL;
      
      SELECT COUNT(1)
      INTO v_count_data
      FROM d_pi_current
      WHERE TRUNC(cur_last_update_date) = v_today;
    
      IF v_count_data = 0 THEN      
        SELECT MIN(TRUNC(cur_last_update_date)), v_today - MIN(TRUNC(cur_last_update_date)) 
        INTO v_min_date, v_diff
        FROM d_pi_current;         
      
        UPDATE d_pi_current
        SET cancel_date =  cancel_date + v_diff
            ,create_date =  create_date + v_diff
            ,receipt_date =  receipt_date + v_diff
            ,three_way_call_date =  three_way_call_date + v_diff
            ,escalate_date =  escalate_date + v_diff
            ,return_to_mms_dt = return_to_mms_dt + v_diff
            ,complete_incident_end_dt =  complete_incident_end_dt + v_diff
            ,complete_incident_st_dt =  complete_incident_st_dt + v_diff
            ,process_incident_end_dt =  process_incident_end_dt + v_diff
            ,process_incident_st_dt =  process_incident_st_dt + v_diff
            ,research_incident_end_dt =  research_incident_end_dt + v_diff
            ,research_incident_st_dt =  research_incident_st_dt + v_diff
            ,hearing_date =  hearing_date + v_diff
            ,state_received_appeal_date =  state_received_appeal_date + v_diff
            ,escalate_to_state_dt =  escalate_to_state_dt + v_diff
            ,process_clnt_notify_end_dt =  process_clnt_notify_end_dt + v_diff
            ,process_clnt_notify_start_dt =  process_clnt_notify_start_dt + v_diff
            ,cur_last_update_date =  cur_last_update_date + v_diff
            ,complete_date =  complete_date + v_diff
            ,jeopardy_status_date =  jeopardy_status_date + v_diff
            ,cur_incident_status_date =  cur_incident_status_date + v_diff
        WHERE TRUNC(cur_last_update_date) = v_min_date;  
      END IF;  
      v_today := v_today + 1;
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(v_today,'MM/DD/YYYY')
    WHERE name = 'REFRESH_PI_DATA_CURDATE';
    
    UPDATE corp_etl_control
    SET value = TO_CHAR(TRUNC(sysdate)+1,'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_PI_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_PI_TABLE;

PROCEDURE REFRESH_PL_TABLE AS
  
  v_min_date DATE := NULL;    
  v_pl_run_date DATE;
  v_today DATE ;
  v_diff NUMBER;
  v_count_data NUMBER;
BEGIN

  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_pl_run_date
  FROM corp_etl_control
  WHERE name = 'REFRESH_DEMO_PL_RUNDATE';
  
  SELECT TO_DATE(value,'MM/DD/YYYY')
  INTO v_today
  FROM corp_etl_control
  WHERE name = 'REFRESH_PL_DATA_CURDATE';  

  IF v_pl_run_date = TRUNC(sysdate) THEN
    WHILE v_today <= TRUNC(sysdate)  LOOP
      v_diff := 0;
      v_count_data := 0;
      v_min_date := NULL;
      
      SELECT COUNT(1)
      INTO v_count_data
      FROM d_pl_current
      WHERE TRUNC(last_update_date) = v_today;
    
      IF v_count_data = 0 THEN      
        SELECT MIN(TRUNC(last_update_date)), v_today - MIN(TRUNC(last_update_date)) 
        INTO v_min_date, v_diff
        FROM d_pl_current;        
       
        UPDATE d_pl_current
        SET create_date =  create_date + v_diff
            ,last_update_date =  last_update_date + v_diff
            ,complete_date =  complete_date + v_diff
            ,mailed_date =  mailed_date + v_diff
            ,letter_status_date = letter_status_date + v_diff
            ,send_to_mail_house_start_date =  send_to_mail_house_start_date + v_diff
            ,send_to_mail_house_end_date =  send_to_mail_house_end_date + v_diff
            ,receive_confirm_end_date =  receive_confirm_end_date + v_diff            
        WHERE TRUNC(last_update_date) = v_min_date;  
      END IF;  
      v_today := v_today + 1;
    END LOOP;  
  
    UPDATE corp_etl_control
    SET value = TO_CHAR(v_today,'MM/DD/YYYY')
    WHERE name = 'REFRESH_PL_DATA_CURDATE';
    
    UPDATE corp_etl_control
    SET value = TO_CHAR(TRUNC(sysdate)+1,'MM/DD/YYYY')
    WHERE name = 'REFRESH_DEMO_PL_RUNDATE';
    COMMIT;  
  END IF;
  
END REFRESH_PL_TABLE;

     
END;
/