CREATE OR REPLACE VIEW dceb.dceb_d_enrollment_assessment_sv 
AS
WITH enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CASE WHEN disenrl.enrollment_id IS NOT NULL AND enrl.status IN('SELECTION_MADE','SUBMITTED_TO_STATE') THEN 'Pending_Transfer'
         WHEN disenrl.enrollment_id IS NOT NULL AND enrl.status IN('ACCEPTED') THEN 'Transfer'
         WHEN disenrl.enrollment_id IS NULL AND enrl.status IN('SELECTION_MADE','SUBMITTED_TO_STATE') THEN 'Pending_Enrollment'
     ELSE 'New Enrolled' END transaction_type
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code   
FROM marsdb.marsdb_enrollments_vw enrl
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason IS NOT NULL
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
UNION ALL
SELECT disenrl.project_id,disenrl.enrollment_id, disenrl.consumer_id, disenrl.start_date, disenrl.end_date,disenrl.status, CAST(disenrl.txn_status_date AS DATE) txn_status_date
   ,disenrl.plan_code,disenrl.enrollment_type,disenrl.sub_program_type_cd,disenrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,disenrl.service_region_code,'Disenrolled' transaction_type
   ,CAST(disenrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code
FROM marsdb.marsdb_enrollments_vw disenrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = disenrl.project_id
WHERE p.project_name = 'DC-EB'
AND disenrl.status = 'DISENROLLED'
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND enrl.status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE'))
),
svy AS (   
SELECT project_id 
       ,survey_id             
       ,reference_id consumer_id
       ,survey_template_id
       --,parse_json (survey_response) as payload
       ,CAST(create_ts AS DATE) survey_create_date
       ,CAST(survey_date AS DATE) survey_date
FROM marsdb.marsdb_survey_vw
WHERE project_id = 120 
AND UPPER(reference_type) = 'CONSUMER'
AND UPPER(status) != 'WITHDRAWN'
AND survey_template_id IS NOT NULL),    
enrldetail AS(
SELECT evw.project_id,
evw.enrollment_id,
evw.consumer_id,
evw.sub_program_type_cd,
stvw.report_label sub_program_type,
evw.txn_status_date,
evw.created_on_date,
evw.enrollment_type,
evw.plan_code,
evw.transfer_from_plan_code,
pnvw.report_label plan_name,
disenrl_pnvw.report_label transfer_from_plan_name,
evw.transaction_type, 
evw.plan_end_date_reason transfer_reason_code,
CASE WHEN uvw.report_label IS NULL AND evw.transaction_type IN('New Enrolled','Pending_Enrollment') THEN 'Enrollment Choice - Non-Newborn'
     WHEN uvw.report_label IS NULL AND evw.transaction_type IN('Disenrolled') THEN 'Not Available' 
   ELSE uvw.report_label END transfer_reason,
cvw.report_label channel_label,
evw.start_date enrollment_start_date,
evw.end_date enrollment_end_date,
cnvw.consumer_date_of_birth,
CASE WHEN FLOOR((CAST(evw.created_on_date AS DATE) - CAST(cnvw.consumer_date_of_birth AS DATE))/365) <=20 THEN 'Yes' ELSE 'No' END child_indicator,
cnvw.medical_assistance_id,
cnvw.case_number,
cnvw.consumer_first_name,
cnvw.consumer_last_name,
COALESCE(tvw.description,'N/A') cahmi_hra_indicator,
CASE WHEN COALESCE(tvw.description,'N/A') = 'HRA' THEN 'Health Risk Assessment' ELSE COALESCE(tvw.description,'N/A') END cahmi_hra_label,
svw.survey_date,
svw.survey_create_date,
evw.status enrollment_status,
COUNT(*) rec_count
FROM enrl evw  
  JOIN marsdb.marsdb_project_vw p ON p.project_id = evw.project_id
  LEFT JOIN svy svw ON evw.consumer_id = svw.consumer_id AND svw.survey_date >= CAST(evw.created_on_date AS DATE)
  LEFT JOIN marsdb.marsdb_survey_template_vw tvw ON svw.survey_template_id = tvw.survey_template_id AND svw.project_id = tvw.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) stvw ON evw.sub_program_type_cd = stvw.value AND evw.project_id = stvw.project_id
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw uvw ON evw.plan_end_date_reason = uvw.value AND evw.project_id = uvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_selection_channels_vw cvw ON evw.channel = cvw.value AND evw.project_id = cvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON evw.plan_code = pnvw.value AND evw.project_id = pnvw.project_id  
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw disenrl_pnvw ON evw.transfer_from_plan_code = disenrl_pnvw.value AND evw.project_id = disenrl_pnvw.project_id  
  LEFT JOIN (SELECT cnvw.project_id,cnvw.consumer_id,cnvw.consumer_date_of_birth,   
               cin.external_consumer_id medical_assistance_id,
               civw.external_case_id case_number,
               cnvw.consumer_first_name,
               cnvw.consumer_last_name
             FROM marsdb.marsdb_consumer_vw cnvw
               LEFT JOIN marsdb.marsdb_case_consumer_vw ccvw ON cnvw.consumer_id = ccvw.consumer_id AND cnvw.project_id = ccvw.project_id
               LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON cnvw.consumer_id = cin.consumer_id AND cnvw.project_id = cin.project_id 
                 AND cin.identification_number_type = 'MEDICAID'
               LEFT JOIN marsdb.marsdb_case_identification_number_vw civw ON ccvw.case_id = civw.case_id AND ccvw.project_id = civw.project_id 
                 AND civw.identification_number_type = 'MEDICAID'  
             WHERE cnvw.project_id = 120
             QUALIFY ROW_NUMBER() OVER (PARTITION BY cnvw.consumer_id ORDER BY ccvw.effective_end_date DESC NULLS FIRST) = 1
   ) cnvw ON cnvw.consumer_id = evw.consumer_id AND cnvw.project_id = evw.project_id
WHERE p.project_name = 'DC-EB'
GROUP BY 
evw.project_id,
evw.enrollment_id,
evw.consumer_id,
evw.sub_program_type_cd,
stvw.report_label,
evw.txn_status_date,
evw.created_on_date,
evw.enrollment_type,
evw.plan_code,
evw.transfer_from_plan_code,
evw.plan_end_date_reason,
evw.start_date,
evw.end_date,
pnvw.report_label,
disenrl_pnvw.report_label,
transaction_type, 
uvw.report_label,
cvw.report_label,
cnvw.consumer_date_of_birth,
cnvw.medical_assistance_id,
cnvw.case_number,
cnvw.consumer_first_name,
cnvw.consumer_last_name,
COALESCE(tvw.description,'N/A'),
svw.survey_date,
svw.survey_create_date,
evw.status
)
SELECT project_id,
enrollment_id,
consumer_id,
sub_program_type_cd,
sub_program_type,
txn_status_date,
created_on_date,
enrollment_type,
enrollment_start_date,
enrollment_end_date,
plan_code,
plan_name,
transaction_type, 
transfer_reason_code,
transfer_reason,
channel_label,
consumer_date_of_birth,
medical_assistance_id,
case_number,
consumer_first_name,
consumer_last_name,
cahmi_hra_indicator,
cahmi_hra_label,
transfer_from_plan_code,
transfer_from_plan_name,
child_indicator,
survey_date,
survey_create_date,
enrollment_status
FROM enrldetail
;