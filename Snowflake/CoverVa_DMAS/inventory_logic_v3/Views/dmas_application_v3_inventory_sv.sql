CREATE OR REPLACE VIEW PUBLIC.DMAS_APPLICATION_V3_INVENTORY_SV
AS
WITH inv AS(SELECT da.tracking_number AS t_number
  ,CASE WHEN df.filename_prefix IN('APPMETRIC','APPMETRIC_PW','APPMETRIC_REPORT') THEN 'APPMETRICS'
        WHEN df.filename_prefix LIKE 'CPUREPORT%' THEN 'Running CPU'
        WHEN df.filename_prefix = 'CVIU_INVENTORY' THEN 'LI - CVIU'
        WHEN df.filename_prefix = 'CPU_I_INVENTORY' THEN 'LI - CPU w I' 
        WHEN df.filename_prefix = 'CM_043' THEN 'CM43'
        WHEN df.filename_prefix = 'PPIT' THEN 'PPIT'
    ELSE df.filename_prefix END AS maximus_source 
  ,maximus_source_date 
  ,CASE WHEN UPPER(source) LIKE 'PAPER%' THEN 'Paper Application'
        WHEN UPPER(source) LIKE 'RDE%' THEN 'RDE' 
        WHEN UPPER(source) LIKE 'COMMON%' THEN 'CommonHelp' 
        WHEN UPPER(source) = 'AR' AND da.case_type = 'Renewal' THEN 'CommonHelp'
        WHEN UPPER(source) = 'AR' AND da.case_type != 'Renewal' THEN 'Paper Application' 
    ELSE COALESCE(source,'Other') END source
  ,state_app_received_date app_received_date
  ,UPPER(da.processing_unit) processing_unit
  ,CASE WHEN da.application_type IN('PW','non-PW') THEN da.application_type ELSE 'non-PW' END application_type
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' THEN 'No' ELSE 'Yes' END AS in_cp
  ,CASE WHEN UPPER(current_state) = 'WAITING INITIAL REVIEW' THEN 'Waiting Initial Review' ELSE current_state END current_state
  ,initial_review_complete_date AS initial_review_date
  ,application_processing_end_date
  ,last_employee
  ,migrated_app_indicator
  ,vcl_due_date
  ,CASE WHEN application_processing_end_date IS NOT NULL THEN DATEDIFF(DAY,CAST(state_app_received_date AS DATE),CAST(application_processing_end_date AS DATE)) + 1
     ELSE DATEDIFF(DAY,CAST(state_app_received_date AS DATE),current_date()) + 1 END AS application_age  
  ,CASE WHEN df.filename_prefix = 'CVIU_LIAISON_SMARTSHEET' THEN state_app_received_date 
        WHEN MIN(file_inventory_date) OVER(PARTITION BY da.tracking_number) < state_app_received_date THEN state_app_received_date
     ELSE MIN(file_inventory_date) OVER(PARTITION BY da.tracking_number) END  AS first_inventory_date
  ,MIN(CAST(intake_date AS DATE)) OVER (PARTITION BY da.tracking_number) AS first_intake_date
  ,CASE WHEN application_processing_end_date IS NULL THEN NULL 
     ELSE COALESCE(MIN(application_processing_end_date) OVER(PARTITION BY da.tracking_number),application_processing_end_date,max_file_inv_date) END AS first_complete_date
  ,file_inventory_date
  ,ROW_NUMBER() OVER (PARTITION BY da.tracking_number ORDER BY da.file_inventory_date DESC,da.dmas_application_id DESC) record_sequence 
  ,CASE WHEN initial_review_complete_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM initial_review_complete_date),'/',EXTRACT (DAY FROM initial_review_complete_date),'/', EXTRACT (YEAR FROM initial_review_complete_date)) END AS initial_review_date_char
  ,--CASE WHEN current_state = 'Complete - Needs Research' THEN 'Research' 
    CASE WHEN application_processing_end_date IS NULL THEN NULL
     ELSE CONCAT(EXTRACT(MONTH FROM application_processing_end_date),'/',EXTRACT (DAY FROM application_processing_end_date),'/', EXTRACT (YEAR FROM application_processing_end_date))     
     END AS processing_end_date_char
  ,CASE WHEN vcl_due_date IS NULL THEN NULL 
     ELSE CONCAT(EXTRACT(MONTH FROM vcl_due_date),'/',EXTRACT (DAY FROM vcl_due_date),'/', EXTRACT (YEAR FROM vcl_due_date)) END AS vcl_due_date_char
  ,CASE WHEN maximus_source_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM maximus_source_date),'/',EXTRACT (DAY FROM maximus_source_date),'/', EXTRACT (YEAR FROM maximus_source_date)) END AS maximus_source_date_char
  ,DATEADD(DAY,rtl.review_due_days,da.state_app_received_date) review_due_date
  ,da.cp_application_type
  ,da.app_received_date calculated_app_received_date
  ,CASE WHEN da.cm044_verified = 'Y' THEN 'Yes'
      WHEN da.cm044_verified = 'N' THEN 'No'
    ELSE '--' END cm044_verified
  ,MIN(CAST(da.non_maximus_initial_date AS DATE)) OVER (PARTITION BY da.tracking_number) AS non_maximus_initial_date
  ,MAX(CAST(da.non_maximus_returned_date AS DATE)) OVER (PARTITION BY da.tracking_number) AS non_maximus_returned_date 
  ,MIN(CAST(da.vcl_sent_date AS DATE)) OVER(PARTITION BY da.tracking_number) AS vcl_sent_date
  ,da.case_number
  ,da.case_type
  ,da.sd_stage
  ,da.auto_closure_date
  ,da.renewal_closure_date
  ,da.denial_reason
  ,da.noa_generation_date
  ,CASE WHEN da.noa_generation_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM da.noa_generation_date),'/',EXTRACT (DAY FROM da.noa_generation_date),'/', EXTRACT (YEAR FROM da.noa_generation_date)) END AS noa_generation_date_char  
  ,CASE WHEN da.application_incarcerated_indicator = 'Y' THEN 'Yes' 
        WHEN da.application_incarcerated_indicator = 'N' THEN 'No'
    ELSE '--' END application_incarcerated_indicator
  ,CASE WHEN da.case_incarcerated_indicator = 'Y' THEN 'Yes' 
        WHEN da.case_incarcerated_indicator = 'N' THEN 'No'
    ELSE '--' END case_incarcerated_indicator
  ,intake_state_first_date
  ,wir_state_first_date 
  ,wfvd_state_first_date
  ,irc_state_first_date
  ,approved_state_first_date
  ,denied_state_first_date
  ,ttldss_state_first_date
  ,nma_state_first_date
  ,complete_state_first_date  
  ,CASE WHEN intake_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM intake_state_first_date),'/',EXTRACT (DAY FROM intake_state_first_date),'/', EXTRACT (YEAR FROM intake_state_first_date)) END AS intake_state_first_date_char
  ,CASE WHEN wir_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM wir_state_first_date),'/',EXTRACT (DAY FROM wir_state_first_date),'/', EXTRACT (YEAR FROM wir_state_first_date)) END AS wir_state_first_date_char
  ,CASE WHEN wfvd_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM wfvd_state_first_date),'/',EXTRACT (DAY FROM wfvd_state_first_date),'/', EXTRACT (YEAR FROM wfvd_state_first_date)) END AS wfvd_state_first_date_char    
  ,CASE WHEN irc_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM irc_state_first_date),'/',EXTRACT (DAY FROM irc_state_first_date),'/', EXTRACT (YEAR FROM irc_state_first_date)) END AS irc_state_first_date_char    
  ,CASE WHEN approved_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM approved_state_first_date),'/',EXTRACT (DAY FROM approved_state_first_date),'/', EXTRACT (YEAR FROM approved_state_first_date)) END AS approved_state_first_date_char    
  ,CASE WHEN denied_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM denied_state_first_date),'/',EXTRACT (DAY FROM denied_state_first_date),'/', EXTRACT (YEAR FROM denied_state_first_date)) END AS denied_state_first_date_char    
  ,CASE WHEN ttldss_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM ttldss_state_first_date),'/',EXTRACT (DAY FROM ttldss_state_first_date),'/', EXTRACT (YEAR FROM ttldss_state_first_date)) END AS ttldss_state_first_date_char    
  ,CASE WHEN nma_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM nma_state_first_date),'/',EXTRACT (DAY FROM nma_state_first_date),'/', EXTRACT (YEAR FROM nma_state_first_date)) END AS nma_state_first_date_char
  ,CASE WHEN complete_state_first_date IS NULL THEN NULL 
    ELSE CONCAT(EXTRACT(MONTH FROM complete_state_first_date),'/',EXTRACT (DAY FROM complete_state_first_date),'/', EXTRACT (YEAR FROM complete_state_first_date)) END AS complete_state_first_date_char
FROM coverva_dmas.dmas_application_v3_inventory da
 JOIN coverva_dmas.dmas_file_log df ON da.file_id = df.file_id
 LEFT JOIN coverva_dmas.dmas_review_threshold_lkup rtl ON da.processing_unit = rtl.processing_unit AND da.application_type = rtl.application_type
 LEFT JOIN (SELECT tracking_number,MIN(max_file_inv_date) max_file_inv_date
            FROM(SELECT e.tracking_number,MIN(event_date) max_file_inv_date
                 FROM coverva_dmas.dmas_application_v3_event e
                   LEFT JOIN PUBLIC.D_DATES dd on e.event_date = dd.d_date AND dd.project_id = 117
                 WHERE business_day_flag = 'Y'
                 AND ( ( (in_app_metric = 'N' AND in_cm043 = 'N' AND in_rp190 = 'N')
                 AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_v3_event en WHERE e.tracking_number = en.tracking_number 
                                 AND (en.in_app_metric = 'Y' OR en.in_cm043 = 'Y' OR en.in_rp190 = 'N') AND en.application_event_id > e.application_event_id)
                  AND (in_running_app_metric = 'Y' OR in_running_cm043 = 'Y' OR in_running_rp190 = 'Y') )            
                   OR (e.in_app_metric = 'Y' AND (REGEXP_INSTR(e.am_worker_id, '900') = 0) )  )
                 GROUP BY e.tracking_number
                 UNION
                 SELECT tracking_number,MIN(max_file_inv_date) max_file_inv_date
                 FROM coverva_dmas.dmas_application_v2_min_event
                 WHERE max_file_inv_date IS NOT NULL
                 GROUP BY tracking_number)
            GROUP BY tracking_number) fc ON da.tracking_number = fc.tracking_number 
 LEFT JOIN (SELECT case_number,MAX(fl.file_date) max_auto_closure_date
            FROM coverva_dmas.auto_closure_cases_full_load ccf
               JOIN coverva_dmas.dmas_file_log fl ON UPPER(ccf.filename) = UPPER(fl.filename)
            GROUP BY case_number) clcf ON clcf.case_number = da.case_number            )
SELECT inv.t_number,
 inv.maximus_source,
 inv.maximus_source_date,
 inv.source,
 inv.app_received_date,
 inv.processing_unit,
 inv.application_type,
 inv.in_cp,
 --inv.current_state,
 CASE WHEN inv.current_state = 'Complete - Needs Research' THEN 'Complete' ELSE inv.current_state END current_state,
 inv.initial_review_date,
 inv.application_processing_end_date,
 inv.last_employee,
 inv.migrated_app_indicator,
 inv.vcl_due_date,
 inv.application_age,
 MARSDB.get_business_difference_days(DATE_TRUNC('DAY',first_inventory_date), COALESCE(CAST(initial_review_date AS DATE),current_date()),117) +1 application_age_in_business_days,
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
 inv.cp_application_type,
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
 CASE WHEN first_complete_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM first_complete_date),'/',EXTRACT (DAY FROM first_complete_date),'/', EXTRACT (YEAR FROM first_complete_date)) END AS first_complete_date_char,
 CASE WHEN first_intake_date IS NULL THEN NULL 
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
 inv.calculated_app_received_date,
 inv.cm044_verified,
 inv.non_maximus_initial_date,
 inv.non_maximus_returned_date,
 inv.vcl_sent_date,
 CASE WHEN inv.non_maximus_initial_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.non_maximus_initial_date),'/',EXTRACT (DAY FROM inv.non_maximus_initial_date),'/', EXTRACT (YEAR FROM inv.non_maximus_initial_date)) END AS non_maximus_initial_date_char, 
 CASE WHEN inv.non_maximus_returned_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.non_maximus_returned_date),'/',EXTRACT (DAY FROM inv.non_maximus_returned_date),'/', EXTRACT (YEAR FROM inv.non_maximus_returned_date)) END AS non_maximus_returned_date_char, 
 CASE WHEN inv.current_state NOT IN('Waiting Initial Review','Intake') THEN 
   CASE WHEN inv.vcl_sent_date IS NULL THEN NULL 
     ELSE CONCAT(EXTRACT(MONTH FROM inv.vcl_sent_date),'/',EXTRACT (DAY FROM inv.vcl_sent_date),'/', EXTRACT (YEAR FROM inv.vcl_sent_date)) END 
  ELSE NULL END  AS vcl_sent_date_char, 
  inv.case_number,
  inv.case_type,
  inv.sd_stage,
  inv.auto_closure_date max_auto_closure_date,
  CASE WHEN inv.auto_closure_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.auto_closure_date),'/',EXTRACT (DAY FROM inv.auto_closure_date),'/', EXTRACT (YEAR FROM inv.auto_closure_date)) END AS auto_closure_date_char,
  inv.renewal_closure_date,
  CASE WHEN inv.renewal_closure_date IS NULL THEN NULL 
   ELSE CONCAT(EXTRACT(MONTH FROM inv.renewal_closure_date),'/',EXTRACT (DAY FROM inv.renewal_closure_date),'/', EXTRACT (YEAR FROM inv.renewal_closure_date)) END AS renewal_closure_date_char,
  inv.denial_reason,
  inv.noa_generation_date,
  inv.noa_generation_date_char,
  inv.application_incarcerated_indicator,
  inv.case_incarcerated_indicator,
  inv.intake_state_first_date,
  inv.wir_state_first_date,
  inv.wfvd_state_first_date,
  inv.irc_state_first_date,
  inv.approved_state_first_date,
  inv.denied_state_first_date,
  inv.ttldss_state_first_date,
  inv.nma_state_first_date,
  inv.complete_state_first_date,
  inv.intake_state_first_date_char,
  inv.wir_state_first_date_char,
  inv.wfvd_state_first_date_char,
  inv.irc_state_first_date_char,
  inv.approved_state_first_date_char,
  inv.denied_state_first_date_char,
  inv.ttldss_state_first_date_char,
  inv.nma_state_first_date_char,
  inv.complete_state_first_date_char
FROM  inv;            