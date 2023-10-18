CREATE OR REPLACE VIEW dceb.dceb_d_auto_assignment_details_sv
AS
WITH cldtl AS(
SELECT cnvw.project_id,cnvw.consumer_id,cnvw.consumer_date_of_birth,   
       cin.external_consumer_id medical_assistance_id,
       civw.external_case_id case_number,
       cnvw.consumer_first_name,
       cnvw.consumer_last_name,
       ccvw.case_id,
       ccvw.consumer_role,
       ccvw.effective_end_date,
       lcvw.report_label consumer_language_preference
FROM marsdb.marsdb_consumer_vw cnvw
  JOIN marsdb.marsdb_project_vw p ON p.project_id = cnvw.project_id
  LEFT JOIN marsdb.marsdb_case_consumer_vw ccvw ON cnvw.consumer_id = ccvw.consumer_id AND cnvw.project_id = ccvw.project_id
  LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON cnvw.consumer_id = cin.consumer_id AND cnvw.project_id = cin.project_id 
      AND cin.identification_number_type = 'MEDICAID'
  LEFT JOIN marsdb.marsdb_case_identification_number_vw civw ON ccvw.case_id = civw.case_id AND ccvw.project_id = civw.project_id 
      AND civw.identification_number_type = 'MEDICAID'  
  LEFT JOIN marsdb.marsdb_consumer_attribute_v2_vw cavw ON cnvw.consumer_id = cavw.profile_id AND cnvw.project_id = cavw.project_id AND cavw.attr_key = 'LANGUAGE_PREFERENCE'  
  LEFT JOIN marsdb.marsdb_enum_language_code_v2_vw lcvw ON cavw.attr_value = lcvw.value AND cavw.project_id = lcvw.project_id
WHERE p.project_name = 'DC-EB'
QUALIFY ROW_NUMBER() OVER (PARTITION BY cnvw.consumer_id ORDER BY ccvw.effective_end_date DESC NULLS FIRST) = 1),
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code,CASE WHEN disenrl.enrollment_id IS NOT NULL THEN 'T' ELSE 'N' END transfer_or_new_enroll
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,enrl.selection_reason
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason IS NOT NULL
WHERE p.project_name = 'DC-EB'
AND enrl.status = 'ACCEPTED'
AND enrl.channel IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION')
AND enrl.selection_reason IN('Round Robin','ROUND_ROBIN','Family Plan','FAMILY_PLAN','NEWBORN_DEFAULT')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
),
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,cbvw.population program_population,enrollment_scenario
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN (SELECT b.project_id,consumer_id,population,enrollment_scenario
             FROM marsdb.marsdb_consumer_benefit_status_vw b
               JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
             WHERE p.project_name = 'DC-EB'
             QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY consumer_benefit_status_id DESC) =1 ) cbvw ON ce.consumer_id = cbvw.consumer_id AND ce.project_id = cbvw.project_id
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date
QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1)
SELECT cldtl.consumer_id,
  cldtl.medical_assistance_id,
  cldtl.consumer_first_name,
  cldtl.consumer_last_name,
  cldtl.consumer_date_of_birth,
  --FLOOR((CAST(enrl.created_on_date AS DATE) - CAST(cldtl.consumer_date_of_birth AS DATE))/365) consumer_age,
  FLOOR(MONTHS_BETWEEN(CAST(enrl.created_on_date AS DATE), CAST(cldtl.consumer_date_of_birth AS DATE))) consumer_age_in_months,
  CASE WHEN selection_reason = 'NEWBORN_DEFAULT' THEN 'E' ELSE NULL END transaction_type,
  --enrl.created_on_date enrollment_accepted_date,  
  enrl.txn_status_date enrollment_accepted_date, 
  CASE WHEN enrl.selection_reason = 'NEWBORN_DEFAULT' AND FLOOR(MONTHS_BETWEEN(CAST(enrl.created_on_date AS DATE), CAST(cldtl.consumer_date_of_birth AS DATE))) < 12 THEN
     CASE WHEN UPPER(ce.program_population) = 'ALLIANCE-CHILD' THEN 'Alliance Mom' 
          WHEN UPPER(ce.program_population) = 'DCHF-CHILD' THEN 'Medicaid Mom' 
     ELSE NULL END  
  ELSE NULL END newborn_type,
  CASE WHEN UPPER(ce.program_population) IN ('DCHF-CHILD','ALLIANCE-CHILD') THEN
          CASE WHEN enrl.selection_reason = 'NEWBORN_DEFAULT' AND FLOOR(MONTHS_BETWEEN(CAST(enrl.created_on_date AS DATE), CAST(cldtl.consumer_date_of_birth AS DATE))) < 12 
                  THEN 'Newborn'
               WHEN enrl.selection_reason IN('Round Robin','ROUND_ROBIN') THEN 'Random'
               WHEN enrl.selection_reason IN('Family Plan','FAMILY_PLAN') THEN 'Family Plan'
            ELSE NULL END
       WHEN enrl.selection_reason IN('Round Robin','ROUND_ROBIN') THEN 'Random'
       WHEN enrl.selection_reason IN('Family Plan','FAMILY_PLAN') THEN 'Family Plan'
    ELSE NULL END assignment_type
FROM cldtl 
  JOIN marsdb.marsdb_project_vw p ON cldtl.project_id = p.project_id
  JOIN (SELECT enrl.project_id,consumer_id,enrollment_id,plan_code,pvw.report_label plan_name,enrl.created_on_date, enrl.sub_program_type_cd,enrl.selection_reason,
               enrl.txn_status_date
        FROM enrl
          JOIN marsdb.marsdb_enum_plan_name_vw pvw ON enrl.plan_code = pvw.value AND enrl.project_id = pvw.project_id ) enrl ON cldtl.consumer_id = enrl.consumer_id AND cldtl.project_id = enrl.project_id
  JOIN ce ON cldtl.consumer_id = ce.consumer_id AND cldtl.project_id = ce.project_id
WHERE p.project_name = 'DC-EB'
;