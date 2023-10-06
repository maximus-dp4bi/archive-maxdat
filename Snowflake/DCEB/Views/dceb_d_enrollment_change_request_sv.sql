CREATE OR REPLACE VIEW dceb.dceb_d_enrollment_change_request_sv 
AS
WITH cldtl AS(
SELECT cnvw.project_id,cnvw.consumer_id,
       cin.external_consumer_id medical_assistance_id,
       civw.external_case_id case_number,
       cnvw.consumer_first_name,
       cnvw.consumer_last_name,
       ccvw.case_id       
FROM marsdb.marsdb_consumer_vw cnvw
  JOIN marsdb.marsdb_project_vw p ON p.project_id = cnvw.project_id
  LEFT JOIN marsdb.marsdb_case_consumer_vw ccvw ON cnvw.consumer_id = ccvw.consumer_id AND cnvw.project_id = ccvw.project_id
  LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON cnvw.consumer_id = cin.consumer_id AND cnvw.project_id = cin.project_id 
      AND cin.identification_number_type = 'MEDICAID'
  LEFT JOIN marsdb.marsdb_case_identification_number_vw civw ON ccvw.case_id = civw.case_id AND ccvw.project_id = civw.project_id 
      AND civw.identification_number_type = 'MEDICAID'    
WHERE p.project_name = 'DC-EB'
QUALIFY ROW_NUMBER() OVER (PARTITION BY cnvw.consumer_id ORDER BY ccvw.effective_end_date DESC NULLS FIRST) = 1),
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,CAST(disenrl.txn_status_date AS DATE) disenrl_txn_status_date
   ,disenrl.start_date prior_start_date
   ,disenrl.plan_code transfer_from_plan_code 
   ,rvw.report_label plan_transfer_reason
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
  JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date 
    AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason = '90_DAY_TRANSFER'
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw rvw ON disenrl.plan_end_date_reason = rvw.value
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED','SUBMITTED_TO_STATE')
AND enrl.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','STATE_ELIGIBILITY_SYSTEM')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
)
SELECT enrl.enrollment_id   
   ,enrl.consumer_id
   ,enrl.created_on_date
   ,DATE_TRUNC(MONTH,prior_start_date) n90_day_period_start
   ,LAST_DAY(DATE_TRUNC(MONTH,prior_start_date) + 90) n90_day_period_end   
   ,enrl.sub_program_type_cd
   ,stvw.report_label sub_program_type      
   ,enrl.start_date
   ,enrl.end_date
   ,enrl.channel
   ,enrl.plan_code   
   ,pnvw.report_label plan_name
   ,enrl.plan_end_date_reason
   ,enrl.transfer_from_plan_code   
   ,trnsvw.report_label transfer_from_plan_name   
   ,cldtl.medical_assistance_id
   ,cldtl.case_number
   ,1 eligible_count
   ,CASE WHEN enrl.plan_code <> enrl.transfer_from_plan_code THEN 1 ELSE 0 END transfer_count
   ,enrl.prior_start_date status_begin_date
   ,enrl.plan_transfer_reason
FROM enrl
  JOIN marsdb.marsdb_project_vw p ON enrl.project_id = p.project_id
  JOIN cldtl ON cldtl.consumer_id = enrl.consumer_id AND cldtl.project_id = enrl.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) stvw ON enrl.sub_program_type_cd = stvw.value AND enrl.project_id = stvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON enrl.plan_code = pnvw.value AND enrl.project_id = pnvw.project_id  
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw trnsvw ON enrl.transfer_from_plan_code = trnsvw.value AND enrl.project_id = trnsvw.project_id  
WHERE p.project_name = 'DC-EB';