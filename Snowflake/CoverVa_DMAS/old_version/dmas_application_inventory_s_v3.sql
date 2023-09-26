CREATE OR REPLACE VIEW PUBLIC.DMAS_APPLICATION_INVENTORY_SV
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
  --,MARSDB.get_business_difference_days(DATE_TRUNC('DAY',state_app_received_date), COALESCE(CAST(initial_review_complete_date AS DATE),current_date()),117) +1 application_age_in_business_days  
  ,MIN(file_inventory_date) OVER(PARTITION BY da.tracking_number) AS first_inventory_date
  ,MIN(CAST(intake_date AS DATE)) OVER (PARTITION BY da.tracking_number) AS first_intake_date
  ,CASE WHEN application_processing_end_date IS NULL THEN NULL  ELSE  COALESCE(max_file_inv_date,application_processing_end_date) END AS first_complete_date
  ,file_inventory_date
  ,ROW_NUMBER() OVER (PARTITION BY da.tracking_number ORDER BY da.file_inventory_date DESC,da.dmas_application_id DESC) record_sequence 
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
  ,da.cp_application_type
  ,da.app_received_date calculated_app_received_date
FROM coverva_dmas.dmas_application da
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
            GROUP BY e.tracking_number) fc ON da.tracking_number = fc.tracking_number )
SELECT inv.t_number,
 inv.maximus_source,
 inv.maximus_source_date,
 inv.source,
 inv.app_received_date,
 inv.processing_unit,
 inv.application_type,
 inv.in_cp,
 inv.current_state,
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
 inv.calculated_app_received_date
FROM  inv;            