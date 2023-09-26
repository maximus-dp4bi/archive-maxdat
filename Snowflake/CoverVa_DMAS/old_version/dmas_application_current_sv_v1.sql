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
  ,source
  ,app_received_date
  ,UPPER(da.processing_unit) processing_unit
  ,da.application_type
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' THEN 'No' ELSE 'Yes' END AS in_cp
  ,CASE WHEN UPPER(current_state) = 'WAITING INITIAL REVIEW' THEN 'Waiting Initial Review' ELSE current_state END current_state
  ,initial_review_complete_date AS initial_review_date
  ,application_processing_end_date
  ,last_employee
  ,migrated_app_indicator
  ,vcl_due_date
  ,CASE WHEN application_processing_end_date IS NOT NULL THEN DATEDIFF(DAY,CAST(app_received_date AS DATE),CAST(application_processing_end_date AS DATE)) + 1
     ELSE DATEDIFF(DAY,CAST(app_received_date AS DATE),current_date()) + 1 END AS application_age
  ,MARSDB.get_business_difference_days(DATE_TRUNC('DAY',app_received_date), COALESCE(CAST(initial_review_complete_date AS DATE),current_date()),117) +1 application_age_in_business_days
  ,fi.min_file_inv_date AS first_inventory_date
  ,fi.min_intake_date AS first_intake_date
  ,CASE WHEN application_processing_end_date IS NULL THEN NULL
     ELSE CASE WHEN file_inventory_date < max_file_inv_date THEN NULL ELSE max_file_inv_date END END AS first_complete_date
  ,file_inventory_date
  ,1 record_sequence 
  ,CASE WHEN initial_review_dt_null_reason IN('Not found in Application Inventory') THEN '--' 
        WHEN initial_review_dt_null_reason IN('In Application Inventory but waiting initial review') THEN 'No' 
        WHEN initial_review_dt_null_reason IN('Research') THEN 'Research' 
    ELSE TO_CHAR(initial_review_complete_date,'MM/DD/YYYY') END AS initial_review_date_char
  ,CASE WHEN current_state = 'Complete - Needs Research' THEN 'Research' 
        WHEN application_processing_end_date IS NULL THEN '--'
     ELSE TO_CHAR(application_processing_end_date,'MM/DD/YYYY') END AS processing_end_date_char
  ,CASE WHEN vcl_due_date IS NULL THEN 'N/A' ELSE TO_CHAR(vcl_due_date,'MM/DD/YYYY') END AS vcl_due_date_char
  ,CASE WHEN maximus_source_date IS NULL THEN '--' ELSE TO_CHAR(maximus_source_date,'MM/DD/YYYY') END AS maximus_source_date_char
  ,DATEADD(DAY,rtl.review_due_days,da.app_received_date) review_due_date
  ,edt4.end_date due_date_in_business_days5
  ,edt7.end_date due_date_in_business_days8
  ,DATEADD(DAY,6,da.app_received_date) due_date_in_calendar_days7
  ,DATEADD(DAY,44,da.app_received_date) due_date_in_calendar_days45
  ,CASE WHEN UPPER(source) = 'RDE' THEN 1 ELSE 0 END rde_application
  ,CASE WHEN UPPER(source) = 'COMMONHELP' THEN 1 ELSE 0 END common_help_application
  ,CASE WHEN UPPER(source) = 'PAPER APPLICATION' THEN 1 ELSE 0 END paper_application
  ,CASE WHEN UPPER(source) NOT IN('RDE','COMMONHELP','PAPER APPLICATION') THEN 1 ELSE 0 END other_application
  ,CASE WHEN current_state = 'Waiting Initial Review' THEN 1 ELSE 0 END pending_no_vcl  
  ,CASE WHEN current_state = 'Waiting for Verification Documents' THEN 1 ELSE 0 END pending_vcl_sent
  ,CASE WHEN current_state IN('Waiting Initial Review','Waiting for Verification Documents') THEN 1 ELSE 0 END pending
  ,CASE WHEN current_state = 'Transferred to LDSS' THEN 1 ELSE 0 END transferred_to_ldss
  ,CASE WHEN current_state = 'Approved' THEN 1 ELSE 0 END approved
  ,CASE WHEN current_state = 'Denied' THEN 1 ELSE 0 END denied
  ,CASE WHEN current_state = 'Complete - Needs Research' THEN 1 ELSE 0 END needs_research  
  ,CASE WHEN current_state IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research') THEN 1 ELSE 0 END final_determination
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' THEN 1 ELSE 0 END requires_cp_intake
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' AND current_state IN('Waiting Initial Review','Waiting for Verification Documents') THEN 1 ELSE 0 END inprocess_app_intake
  ,CASE WHEN COALESCE(in_cp_indicator,'N') = 'N' AND current_state NOT IN('Waiting Initial Review','Waiting for Verification Documents') THEN 1 ELSE 0 END complete_app_intake
  ,da.cp_application_type
  ,CASE WHEN current_state NOT IN('Transferred to LDSS','Approved','Denied','Complete - Needs Research') THEN 
     CASE WHEN da.application_type = 'PW' AND application_age >= 7 THEN 1 
          WHEN da.application_type = 'non-PW' AND application_age >= 45 THEN 1
     ELSE 0 END
   ELSE 0 END needs_extend_pend_letter
  ,0 reevaluation_app
FROM coverva_dmas.dmas_application_current da
 JOIN coverva_dmas.dmas_file_log df ON da.file_id = df.file_id
 LEFT JOIN coverva_dmas.dmas_review_threshold_lkup rtl ON da.processing_unit = rtl.processing_unit AND da.application_type = rtl.application_type
 LEFT JOIN (SELECT e.tracking_number,MIN(event_date) max_file_inv_date
            FROM coverva_dmas.dmas_application_event e
              LEFT JOIN PUBLIC.D_DATES dd on e.event_date = dd.d_date AND dd.project_id = 117
            WHERE in_app_metric = 'N'           
            AND business_day_flag = 'Y'
            AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_application_event en WHERE e.tracking_number = en.tracking_number AND en.in_app_metric = 'Y' AND en.event_id > e.event_id)
            AND EXISTS(SELECT 1 FROM coverva_dmas.app_metric_full_load am WHERE e.tracking_number = am.tracking_number)
            GROUP BY e.tracking_number) fc ON da.tracking_number = fc.tracking_number
 LEFT JOIN (SELECT d.tracking_number,MIN(file_inventory_date) min_file_inv_date,MIN(CAST(intake_date AS DATE)) min_intake_date
            FROM coverva_dmas.dmas_application d                          
            GROUP BY d.tracking_number) fi ON da.tracking_number = fi.tracking_number            
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edt4 ON CAST(da.app_received_date AS DATE) = edt4.ini_date AND edt4.count_bd = 5 AND edt4.project_id = 117
 LEFT JOIN marsdb.AUX_BUSINESS_DAYS_COUNT_VW edt7 ON CAST(da.app_received_date AS DATE)= edt7.ini_date AND edt7.count_bd = 8 AND edt7.project_id = 117           
           )
SELECT inv.*,
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
 CASE WHEN first_complete_date IS NULL THEN 'N/A' ELSE TO_CHAR(first_complete_date,'MM/DD/YYYY') END AS first_complete_date_char,
 CASE WHEN first_intake_date IS NULL THEN 'N/A' ELSE TO_CHAR(first_intake_date,'MM/DD/YYYY') END AS first_intake_date_char,
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
 CASE WHEN due_date_in_business_days5 >= CAST(initial_review_date AS DATE) THEN 1 ELSE 0 END timely_5_busdays,
 CASE WHEN due_date_in_business_days5 < CAST(initial_review_date AS DATE) THEN 1 ELSE 0 END untimely_5_busdays,
 CASE WHEN due_date_in_calendar_days45 >= CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END timely_45_caldays,
 CASE WHEN due_date_in_calendar_days45 < CAST(application_processing_end_date AS DATE) THEN 1 ELSE 0 END untimely_45_caldays,
 CASE WHEN needs_extend_pend_letter = 1 THEN CASE WHEN EXISTS(SELECT 1 FROM coverva_dmas.extend_pend_letters_full_load x WHERE x.tracking_number = inv.t_number) THEN 1 ELSE 0 END ELSE 0 END extend_pend_letter_sent 
FROM inv ;