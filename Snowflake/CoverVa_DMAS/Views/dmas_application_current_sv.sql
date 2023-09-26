CREATE OR REPLACE VIEW PUBLIC.DMAS_APPLICATION_CURRENT_SV
AS
WITH inv AS(SELECT da.tracking_number AS t_number
  ,CASE WHEN df.filename_prefix IN('APPMETRIC','APPMETRIC_PW') THEN 'APPMETRICS'
        WHEN df.filename_prefix LIKE 'CPUREPORT%' THEN 'Running CPU'
        WHEN df.filename_prefix = 'CVIU_INVENTORY' THEN 'LI - CVIU'
        WHEN df.filename_prefix = 'CPU_I_INVENTORY' THEN 'LI - CPU w I' 
        WHEN df.filename_prefix = 'CM_043' THEN 'CM43'
        WHEN df.filename_prefix = 'PPIT' THEN 'PPIT'
    ELSE df.filename_prefix END AS maximus_source 
  ,maximus_source_date 
  ,CASE WHEN UPPER(source) LIKE 'PAPER%' THEN 'Paper Application'
        WHEN UPPER(source) LIKE 'RDE%' THEN 'RDE' 
    ELSE COALESCE(source,'Other') END source
   ,state_app_received_date app_received_date
  ,UPPER(da.processing_unit) processing_unit
  ,da.application_type
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' THEN 'No' ELSE 'Yes' END AS in_cp
  ,CASE WHEN UPPER(current_state) = 'WAITING INITIAL REVIEW' THEN 'Waiting Initial Review' ELSE current_state END current_state
  ,initial_review_complete_date AS initial_review_date
  ,application_processing_end_date
  ,last_employee
  ,migrated_app_indicator
  ,vcl_due_date
  ,CASE WHEN application_processing_end_date IS NOT NULL THEN DATEDIFF(DAY,CAST(state_app_received_date AS DATE),CAST(application_processing_end_date AS DATE)) + 1
     ELSE DATEDIFF(DAY,CAST(state_app_received_date AS DATE),current_date()) + 1 END AS application_age
 -- ,MARSDB.get_business_difference_days(DATE_TRUNC('DAY',state_app_received_date), COALESCE(CAST(initial_review_complete_date AS DATE),current_date()),117) +1 application_age_in_business_days
  ,MARSDB.get_business_difference_days(DATE_TRUNC('DAY',fi.min_file_inv_date), COALESCE(CAST(initial_review_complete_date AS DATE),current_date()),117) +1 application_age_in_business_days
  ,fi.min_file_inv_date AS first_inventory_date
  ,fi.min_intake_date AS first_intake_date
  ,CASE WHEN application_processing_end_date IS NULL THEN NULL  ELSE  COALESCE(application_processing_end_date,max_file_inv_date) END AS first_complete_date
  ,file_inventory_date
  ,1 record_sequence 
  ,CASE WHEN initial_review_dt_null_reason IN('Not found in Application Inventory') THEN '--' 
        WHEN initial_review_dt_null_reason IN('In Application Inventory but waiting initial review') THEN 'No' 
        WHEN initial_review_dt_null_reason IN('Research') THEN 'Research' 
    ELSE CONCAT(EXTRACT(MONTH FROM initial_review_complete_date),'/',EXTRACT (DAY FROM initial_review_complete_date),'/', EXTRACT (YEAR FROM initial_review_complete_date)) END AS initial_review_date_char
  ,--CASE WHEN current_state = 'Complete - Needs Research' THEN 'Research' 
    CASE WHEN application_processing_end_date IS NULL THEN '--'
     ELSE CONCAT(EXTRACT(MONTH FROM application_processing_end_date),'/',EXTRACT (DAY FROM application_processing_end_date),'/', EXTRACT (YEAR FROM application_processing_end_date))     
     END AS processing_end_date_char
  ,CASE WHEN vcl_due_date IS NULL THEN 'N/A' 
     ELSE CONCAT(EXTRACT(MONTH FROM vcl_due_date),'/',EXTRACT (DAY FROM vcl_due_date),'/', EXTRACT (YEAR FROM vcl_due_date)) END AS vcl_due_date_char
  ,CASE WHEN maximus_source_date IS NULL THEN '--' 
    ELSE CONCAT(EXTRACT(MONTH FROM maximus_source_date),'/',EXTRACT (DAY FROM maximus_source_date),'/', EXTRACT (YEAR FROM maximus_source_date)) END AS maximus_source_date_char
  ,DATEADD(DAY,rtl.review_due_days,da.state_app_received_date) review_due_date
  ,edt4.end_date due_date_in_business_days5
  ,edt7.end_date due_date_in_business_days8  
  ,DATEADD(DAY,6,da.state_app_received_date) due_date_in_calendar_days7  
  ,DATEADD(DAY,44,da.state_app_received_date) due_date_in_calendar_days45
  ,CASE WHEN UPPER(source) = 'RDE' THEN 1 ELSE 0 END rde_application
  ,CASE WHEN UPPER(source) = 'COMMONHELP' THEN 1 ELSE 0 END common_help_application
  ,CASE WHEN UPPER(source) LIKE 'PAPER%' THEN 1 ELSE 0 END paper_application
  ,CASE WHEN COALESCE(UPPER(source),'X') NOT LIKE 'FFM%' AND COALESCE(UPPER(source),'X') NOT LIKE 'PAPER%' AND COALESCE(UPPER(source),'X') NOT IN('RDE','COMMONHELP') THEN 1 ELSE 0 END other_application
  ,CASE WHEN UPPER(source) LIKE 'FFM%' THEN 1 ELSE 0 END all_ffm_application
  ,CASE WHEN UPPER(source) = 'FFM' THEN 1 ELSE 0 END ffm_application
  ,CASE WHEN UPPER(source) = 'FFM D' THEN 1 ELSE 0 END ffmd_application
  ,CASE WHEN UPPER(source) = 'FFM R' THEN 1 ELSE 0 END ffmr_application
  ,CASE WHEN UPPER(source) = 'FFM C' THEN 1 ELSE 0 END ffmc_application
  ,CASE WHEN current_state IN('Intake', 'Waiting Initial Review') THEN 1 ELSE 0 END pending_no_vcl  
  ,CASE WHEN current_state IN('Waiting for Verification Documents','Initial Review Complete') THEN 1 ELSE 0 END pending_vcl_sent  
  ,CASE WHEN current_state IN('Waiting Initial Review','Waiting for Verification Documents','Intake','Initial Review Complete') THEN 1 ELSE 0 END pending
  ,CASE WHEN current_state = 'Transferred to LDSS' THEN 1 ELSE 0 END transferred_to_ldss
  ,CASE WHEN current_state = 'Approved' THEN 1 ELSE 0 END approved
  ,CASE WHEN current_state = 'Denied' THEN 1 ELSE 0 END denied
  ,CASE WHEN current_state = 'Complete - Needs Research' THEN 1 ELSE 0 END needs_research  
  ,CASE WHEN current_state IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research') THEN 1 ELSE 0 END final_determination
  ,CASE WHEN current_state != 'Non Maximus Assigned' THEN CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' THEN 1 ELSE 0 END ELSE 0 END requires_cp_intake
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' AND current_state IN('Waiting Initial Review','Waiting for Verification Documents','Intake','Initial Review Complete') THEN 1 ELSE 0 END inprocess_app_intake
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' AND current_state NOT IN('Waiting Initial Review','Waiting for Verification Documents','Intake','Initial Review Complete','Non Maximus Assigned') THEN 1 ELSE 0 END complete_app_intake
  ,da.cp_application_type
  ,CASE WHEN current_state NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research') THEN 
     CASE WHEN da.application_type = 'PW' AND application_age >= 7 THEN 1 
          WHEN da.application_type = 'non-PW' AND application_age >= 45 THEN 1
     ELSE 0 END
   ELSE 0 END needs_extend_pend_letter
  ,0 reevaluation_app    
  ,edtfid4.end_date due_date_in_busdays5_first_invdt
  ,edtfid7.end_date due_date_in_busdays8_first_invdt 
  ,da.app_received_date calculated_app_received_date
  ,CASE WHEN da.cm044_verified = 'Y' THEN 'Yes'
      WHEN da.cm044_verified = 'N' THEN 'No'
    ELSE '--' END cm044_verified
  ,fi.min_non_maximus_initial_date non_maximus_initial_date 
  ,fi.max_non_maximus_returned_date non_maximus_returned_date 
  ,fi.min_vcl_sent_date vcl_sent_date
  ,CASE WHEN current_state = 'Waiting for Verification Documents' AND COALESCE(previous_current_state,'X') != 'Waiting for Verification Documents' THEN 1 ELSE 0 END vcl_sent_weeklyprod
  ,da.case_number
  ,da.case_type
  ,da.sd_stage
  ,da.auto_closure_date
  ,DATEADD(DAY,29,da.state_app_received_date) due_date_in_calendar_days30
  ,da.renewal_closure_date
  ,da.denial_reason
FROM coverva_dmas.dmas_application_current da
 JOIN coverva_dmas.dmas_file_log df ON da.file_id = df.file_id
 LEFT JOIN coverva_dmas.dmas_review_threshold_lkup rtl ON da.processing_unit = rtl.processing_unit AND da.application_type = rtl.application_type
 LEFT JOIN (SELECT e.tracking_number,MIN(event_date) max_file_inv_date
            FROM coverva_dmas.dmas_application_event e
              LEFT JOIN PUBLIC.D_DATES dd on e.event_date = dd.d_date AND dd.project_id = 117
            WHERE business_day_flag = 'Y'
            AND ( ( (in_app_metric = 'N' AND in_ppit = 'N' AND in_app_metric_pw = 'N' AND in_cviu = 'N' AND in_cpu_incarcerated = 'N' AND in_cm043 = 'N')
            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event en WHERE e.tracking_number = en.tracking_number 
                            AND (en.in_app_metric = 'Y' OR en.in_ppit = 'Y' OR en.in_app_metric_pw = 'Y' OR en.in_cviu = 'Y' OR en.in_cpu_incarcerated = 'Y' OR en.in_cm043 = 'Y') AND en.event_id > e.event_id)
            AND (in_running_am = 'Y' OR in_running_ppit = 'Y' OR in_running_pw = 'Y' OR in_running_cviu = 'Y' OR in_running_cpui = 'Y' OR in_running_cm043 = 'Y') )            
             OR ( (e.in_app_metric = 'Y' AND (REGEXP_INSTR(e.am_worker, '900') = 0) )
                         OR (e.in_ppit = 'Y' AND (REGEXP_INSTR(e.ppit_worker, '900') = 0) )                         
                         OR (e.in_cviu = 'Y'AND (REGEXP_INSTR(e.cviu_worker, '900') = 0) ) 
                         OR (e.in_cpu_incarcerated = 'Y' AND ( REGEXP_INSTR(e.cpui_worker, '900') = 0) ) ) )
            GROUP BY e.tracking_number) fc ON da.tracking_number = fc.tracking_number
 LEFT JOIN (SELECT d.tracking_number,MIN(file_inventory_date) min_file_inv_date,MIN(CAST(intake_date AS DATE)) min_intake_date,
                MIN(CAST(non_maximus_initial_date AS DATE)) min_non_maximus_initial_date, MAX(CAST(non_maximus_returned_date AS DATE)) max_non_maximus_returned_date,
                MIN(CAST(vcl_sent_date AS DATE)) min_vcl_sent_date
            FROM coverva_dmas.dmas_application d                          
            GROUP BY d.tracking_number) fi ON da.tracking_number = fi.tracking_number  
 LEFT JOIN (SELECT d.tracking_number,ROW_NUMBER() OVER (PARTITION BY d.tracking_number ORDER BY d.file_inventory_date DESC,d.dmas_application_id DESC) record_sequence,
                 current_state previous_current_state
            FROM coverva_dmas.dmas_application d) prevcs ON da.tracking_number = prevcs.tracking_number AND prevcs.record_sequence = 2 
 LEFT JOIN (SELECT case_number,MAX(fl.file_date) max_auto_closure_date
            FROM coverva_dmas.auto_closure_cases_full_load ccf
               JOIN coverva_dmas.dmas_file_log fl ON UPPER(ccf.filename) = UPPER(fl.filename)
            GROUP BY case_number) clcf ON clcf.case_number = da.case_number   
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edt4 ON CAST(da.state_app_received_date AS DATE) = edt4.ini_date AND edt4.count_bd = 5 AND edt4.project_id = 117
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edt7 ON CAST(da.state_app_received_date AS DATE)= edt7.ini_date AND edt7.count_bd = 8 AND edt7.project_id = 117    
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edtfid4 ON CAST(fi.min_file_inv_date AS DATE) = edtfid4.ini_date AND edtfid4.count_bd = 5 AND edtfid4.project_id = 117
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edtfid7 ON CAST(fi.min_file_inv_date AS DATE) = edtfid7.ini_date AND edtfid7.count_bd = 8 AND edtfid7.project_id = 117 
           )
SELECT  inv.t_number,
 inv.maximus_source,
 inv.maximus_source_date,
 inv.source,
 inv.app_received_date,
 inv.processing_unit,
 inv.application_type,
 inv.in_cp,
-- inv.current_state, 
 CASE WHEN inv.current_state = 'Complete - Needs Research' THEN 'Complete' ELSE inv.current_state END current_state,  
 inv.initial_review_date,
 inv.application_processing_end_date,
 inv.last_employee,
 inv.migrated_app_indicator,
 inv.vcl_due_date,
 inv.application_age,
 inv.application_age_in_business_days,
 inv.first_inventory_date,
 inv.first_intake_date,
 inv.first_complete_date,
 inv.file_inventory_date,
 inv.record_sequence,
 inv.initial_review_date_char,
 inv.processing_end_date_char,
 inv.vcl_due_date_char,
 inv.maximus_source_date_char,
 inv.review_due_date,
 inv.due_date_in_business_days5,
 inv.due_date_in_business_days8,
 inv.due_date_in_calendar_days7,
 inv.due_date_in_calendar_days45,
 inv.rde_application,
 inv.common_help_application,
 inv.paper_application,
 inv.other_application,
 inv.all_ffm_application,
 inv.ffm_application,
 inv.ffmd_application,
 inv.ffmr_application,
 inv.ffmc_application,
 inv.pending_no_vcl,
 inv.pending_vcl_sent,
 inv.pending,
 inv.transferred_to_ldss,
 inv.approved,
 inv.denied,
 inv.needs_research,
 inv.final_determination,
 inv.requires_cp_intake,
 inv.inprocess_app_intake,
 inv.complete_app_intake,
 inv.cp_application_type,
 inv.needs_extend_pend_letter,
 inv.reevaluation_app, 
 CASE WHEN application_age = 45 AND vcl_due_date IS NOT NULL AND CAST(vcl_due_date AS DATE) <= current_date() THEN '1'
      WHEN application_age >= 34 AND application_age <= 35 AND vcl_due_date IS NULL THEN '2'
      WHEN application_age = 45 AND vcl_due_date IS NULL THEN '3'
      WHEN application_age >= 36 AND application_age <= 44 AND vcl_due_date IS NULL THEN '4'
      WHEN application_age >= 45 AND vcl_due_date > current_date() AND DATEDIFF(DAY,current_date(),CAST(vcl_due_date AS DATE)) <= 10 THEN '5'
      WHEN application_age >= 30 AND application_age <= 33 AND vcl_due_date IS NULL THEN '6'      
      WHEN application_age_in_business_days = 5 AND vcl_due_date IS NOT NULL AND CAST(vcl_due_date AS DATE) <= current_date() THEN '7'
      WHEN application_age_in_business_days >= 1 AND application_age_in_business_days <= 4 AND vcl_due_date IS NOT NULL AND CAST(vcl_due_date AS DATE) <= current_date() THEN '8'
      WHEN application_age >= 16 AND application_age <= 29 AND vcl_due_date > current_date() AND DATEDIFF(DAY,current_date(),CAST(vcl_due_date AS DATE)) <= 10 THEN '9'
      WHEN application_age >= 6 AND application_age <= 15 AND vcl_due_date > current_date() AND DATEDIFF(DAY,current_date(),CAST(vcl_due_date AS DATE)) <= 10 THEN '10'
      WHEN vcl_due_date IS NOT NULL AND DATEDIFF(DAY,current_date(),CAST(vcl_due_date AS DATE)) > 10 THEN 'F' ELSE NULL END distro,
 CASE WHEN first_complete_date IS NULL THEN 'N/A' 
   ELSE CONCAT(EXTRACT(MONTH FROM first_complete_date),'/',EXTRACT (DAY FROM first_complete_date),'/', EXTRACT (YEAR FROM first_complete_date)) END AS first_complete_date_char,
 CASE WHEN first_intake_date IS NULL THEN 'N/A' 
   ELSE CONCAT(EXTRACT(MONTH FROM first_intake_date),'/',EXTRACT (DAY FROM first_intake_date),'/', EXTRACT (YEAR FROM first_intake_date)) END AS first_intake_date_char, 
 CASE WHEN application_type = 'PW' THEN
    CASE WHEN application_age >= 0 AND application_age <= 1 THEN '0-1 days'
         WHEN application_age >= 2 AND application_age <= 3 THEN '2-3 days'
         WHEN application_age >= 4 AND application_age <= 5 THEN '4-5 days'
         WHEN application_age >= 6 AND application_age <= 7 THEN '6-7 days'
         WHEN application_age >= 8 AND application_age <= 14 THEN '8-14 days'
         WHEN application_age >= 15 AND application_age <= 21 THEN '15-21 days'
         WHEN application_age >= 22 AND application_age <= 45 THEN '22-45 days'
         WHEN application_age >= 46 THEN '46+ days'
    ELSE '--' END ELSE '--' END AS pw_application_age_group,
 CASE WHEN application_type = 'non-PW' THEN
   CASE WHEN application_age >= 0 AND application_age <= 5 THEN '0-5 days'
         WHEN application_age >= 6 AND application_age <= 10 THEN '6-10 days'
         WHEN application_age >= 11 AND application_age <= 20 THEN '11-20 days'
         WHEN application_age >= 21 AND application_age <= 30 THEN '21-30 days'
         WHEN application_age >= 31 AND application_age <= 35 THEN '31-35 days'
         WHEN application_age >= 36 AND application_age <= 40 THEN '36-40 days'
         WHEN application_age >= 41 AND application_age <= 45 THEN '41-45 days'
         WHEN application_age >= 46 THEN '46+ days'
     ELSE '--' END ELSE '--' END nonpw_application_age_group,
 CASE WHEN current_state IN('Approved','Denied','Transferred to LDSS','Complete - Needs Research') THEN 'Yes' ELSE 'No' END AS determined,
 CASE WHEN application_age <= 1 THEN 1 ELSE 0 END age_group_calendar_1,
 CASE WHEN application_age >= 2 AND application_age <= 3 THEN 1 ELSE 0 END age_group_calendar2_3,
 CASE WHEN application_age >= 4 AND application_age <= 5 THEN 1 ELSE 0 END age_group_calendar4_5,
 CASE WHEN application_age >= 6 AND application_age <= 7 THEN 1 ELSE 0 END age_group_calendar6_7,
 CASE WHEN application_age >= 8 AND application_age <= 14 THEN 1 ELSE 0 END age_group_calendar8_14,
 CASE WHEN application_age >= 15 AND application_age <= 21 THEN 1 ELSE 0 END age_group_calendar15_21,
 CASE WHEN application_age >= 22 AND application_age <= 34 THEN 1 ELSE 0 END age_group_calendar22_34,
 CASE WHEN application_age >= 35 AND application_age <= 45 THEN 1 ELSE 0 END age_group_calendar35_45,
 CASE WHEN application_age >= 46 THEN 1 ELSE 0 END age_group_calendar46,
 CASE WHEN application_age_in_business_days <=5 THEN 1 ELSE 0 END age_group_bus_days5,
 CASE WHEN application_age_in_business_days > 5 AND application_age <= 45 THEN 1 ELSE 0 END age_group_bus_cal_days5_45,
 CASE WHEN application_age_in_business_days <=1 THEN 1 ELSE 0 END age_group_bus_days_1,
 CASE WHEN application_age_in_business_days >= 2 AND application_age_in_business_days <= 3 THEN 1 ELSE 0 END age_group_bus_days2_3,
 CASE WHEN application_age_in_business_days >= 4 AND application_age_in_business_days <= 5 THEN 1 ELSE 0 END age_group_bus_days4_5,
 CASE WHEN application_age_in_business_days > 5 THEN 1 ELSE 0 END age_group_bus_days6,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_business_days5 >= CAST(COALESCE(initial_review_date,application_processing_end_date) AS DATE) THEN 1 ELSE 0 END ELSE 0 END timely_5_busdays,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_business_days5 < CAST(COALESCE(initial_review_date,application_processing_end_date) AS DATE) THEN 1 ELSE 0 END ELSE 0 END untimely_5_busdays,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_calendar_days45 >= CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END ELSE 0 END timely_45_caldays,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_calendar_days45 < CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END ELSE 0 END untimely_45_caldays,
 CASE WHEN needs_extend_pend_letter = 1 THEN CASE WHEN EXISTS(SELECT 1 FROM coverva_dmas.extend_pend_letters_full_load x WHERE x.tracking_number = inv.t_number) THEN 1 ELSE 0 END ELSE 0 END extend_pend_letter_sent,
 --CASE WHEN initial_review_date IS NULL AND application_processing_end_date IS NULL THEN 1 ELSE 0 END pending_5_sla, 
 CASE WHEN current_state IN('Intake', 'Waiting Initial Review') THEN 1 ELSE 0 END pending_5_sla,
 inv.due_date_in_busdays5_first_invdt,
 inv.due_date_in_busdays8_first_invdt, 
 inv.calculated_app_received_date,   
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_busdays5_first_invdt >= CAST(COALESCE(initial_review_date,application_processing_end_date) AS DATE) THEN 1 ELSE 0 END ELSE 0 END first_invdt_timely_5_busdays,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN due_date_in_busdays5_first_invdt < CAST(COALESCE(initial_review_date,application_processing_end_date) AS DATE) THEN 1 ELSE 0 END ELSE 0 END first_invdt_untimely_5_busdays,
 inv.cm044_verified,
 inv.non_maximus_initial_date,
 inv.non_maximus_returned_date,
 inv.vcl_sent_date,
 CASE WHEN inv.non_maximus_initial_date IS NULL THEN '--' 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.non_maximus_initial_date),'/',EXTRACT (DAY FROM inv.non_maximus_initial_date),'/', EXTRACT (YEAR FROM inv.non_maximus_initial_date)) END AS non_maximus_initial_date_char, 
 CASE WHEN inv.non_maximus_returned_date IS NULL THEN '--' 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.non_maximus_returned_date),'/',EXTRACT (DAY FROM inv.non_maximus_returned_date),'/', EXTRACT (YEAR FROM inv.non_maximus_returned_date)) END AS non_maximus_returned_date_char,
 CASE WHEN inv.current_state NOT IN('Waiting Initial Review','Intake') THEN 
   CASE WHEN inv.vcl_sent_date IS NULL THEN '--' 
     ELSE CONCAT(EXTRACT(MONTH FROM inv.vcl_sent_date),'/',EXTRACT (DAY FROM inv.vcl_sent_date),'/', EXTRACT (YEAR FROM inv.vcl_sent_date)) END 
  ELSE '--' END  AS vcl_sent_date_char,
 CASE WHEN inv.current_state = 'Non Maximus Assigned' THEN 1 ELSE 0 END non_maximus_assigned,
 CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN 1 ELSE 0 END application_count,
 inv.vcl_sent_weeklyprod ,
 inv.case_number,
 inv.case_type,
 inv.sd_stage,
 inv.auto_closure_date max_auto_closure_date,
 CASE WHEN inv.auto_closure_date IS NULL THEN '--' 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.auto_closure_date),'/',EXTRACT (DAY FROM inv.auto_closure_date),'/', EXTRACT (YEAR FROM inv.auto_closure_date)) END AS auto_closure_date_char,
 inv.due_date_in_calendar_days30,   
 CASE WHEN inv.case_type = 'Renewal' THEN CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN inv.due_date_in_calendar_days30 >= CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END ELSE 0 END ELSE 0 END timely_30_caldays,
 CASE WHEN inv.case_type = 'Renewal' THEN CASE WHEN inv.current_state != 'Non Maximus Assigned' THEN CASE WHEN inv.due_date_in_calendar_days30 < CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END ELSE 0 END ELSE 0 END untimely_30_caldays,
 inv.renewal_closure_date,
 CASE WHEN inv.renewal_closure_date IS NULL THEN '--' 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.renewal_closure_date),'/',EXTRACT (DAY FROM inv.renewal_closure_date),'/', EXTRACT (YEAR FROM inv.renewal_closure_date)) END AS renewal_closure_date_char,
 inv.denial_reason
FROM inv ;