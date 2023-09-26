CREATE OR REPLACE VIEW dceb.dceb_d_assessment_details_sv
AS
WITH svy AS (   
SELECT svw.project_id 
       ,svw.survey_id             
       ,svw.reference_id consumer_id
       ,svw.survey_template_id
       ,parse_json (svw.survey_response) as payload
       ,CAST(svw.create_ts AS DATE) survey_create_date
       ,CAST(svw.survey_date AS DATE) survey_date
       ,svw.status survey_status
       ,CASE WHEN COALESCE(tvw.description,'N/A') = 'HRA' THEN 'Health Risk Assessment' ELSE COALESCE(tvw.description,'N/A') END survey_template_label
       ,tvw.description survey_template_code
FROM marsdb.marsdb_survey_vw svw
  JOIN marsdb.marsdb_project_vw p ON p.project_id = svw.project_id
  LEFT JOIN marsdb.marsdb_survey_template_vw tvw ON svw.survey_template_id = tvw.survey_template_id AND svw.project_id = tvw.project_id
WHERE p.project_name = 'DC-EB'
AND UPPER(reference_type) = 'CONSUMER'),    
svyflt AS(
SELECT svy.project_id, svy.survey_id, survey_template_id,consumer_id,survey_create_date,survey_date,survey_status,survey_template_label,survey_template_code,
f.key,f.value,
REPLACE(REPLACE(f.value:answerText,'["'),'"]') answer_text,
f.value:parentSurveyDetailId parent_survey_detail_id,
REPLACE(f.value:questionNumber,'"') question_number,
f.value:surveyDetailsId survey_detail_id
FROM svy, lateral flatten(input=>payload,recursive=>false) f),
fnl AS(
SELECT svyflt.project_id,
 svyflt.survey_id,
 svyflt.survey_template_id,
 svyflt.survey_template_code,
 svyflt.survey_template_label,
 survey_status,
 svyflt.consumer_id,
 svyflt.survey_create_date,
 svyflt.survey_date,
 sdvw.question_number,
 sdvw.question_text,
 sdvw.question_type,
 svyflt.answer_text,
 sdvw.survey_details_id,
 sdvw.parent_survey_detail_id,
 svyflt.survey_detail_id,
 CASE WHEN UPPER(svyflt.answer_text) = 'NO' THEN 1 ELSE 0 END answer_no,
 CASE WHEN UPPER(svyflt.answer_text) = 'YES' THEN 1 ELSE 0 END answer_yes,
 CASE WHEN (svyflt.answer_text IS NULL OR TRIM(svyflt.answer_text) = '' OR svyflt.answer_text LIKE 'DO%N%KNOW' 
  OR UPPER(svyflt.answer_text) NOT IN('NO','YES')) THEN 1 ELSE 0 END answer_unknown
FROM svyflt
 JOIN (SELECT * FROM marsdb.marsdb_survey_details_vw ) sdvw 
   ON svyflt.survey_detail_id = sdvw.survey_details_id AND svyflt.survey_template_id = sdvw.survey_template_id
   AND svyflt.project_id = sdvw.project_id AND svyflt.question_number = sdvw.question_number 
WHERE 1=1 
AND survey_status != 'WITHDRAWN'
UNION ALL
SELECT svy.project_id,
 svy.survey_id,
 svy.survey_template_id,
 svy.survey_template_code,
 svy.survey_template_label,
 svy.survey_status,
 svy.consumer_id,
 svy.survey_create_date,
 svy.survey_date,
 sdvw.question_number,
 sdvw.question_text,
 sdvw.question_type,
 NULL answer_text,
 sdvw.survey_details_id,
 sdvw.parent_survey_detail_id,
 sdvw.survey_details_id survey_detail_id,
 0 answer_no,
 0 answer_yes,
 1 answer_unknown
FROM svy
 JOIN (SELECT * FROM marsdb.marsdb_survey_details_vw ) sdvw  
   ON svy.survey_template_id = sdvw.survey_template_id AND svy.project_id = sdvw.project_id
WHERE 1=1 
AND survey_status != 'WITHDRAWN'
AND NOT EXISTS(SELECT 1 FROM svyflt WHERE svyflt.survey_id = svy.survey_id AND svyflt.survey_template_id = sdvw.survey_template_id AND svyflt.project_id = sdvw.project_id AND svyflt.question_number = sdvw.question_number )
),
fnlsvy AS(SELECT project_id,
 survey_id,
 survey_template_id,
 survey_template_code,
 survey_template_label,
 survey_status,
 consumer_id,
 survey_create_date,
 survey_date,
 question_number,
 question_text,
 question_type,
 answer_text,
 survey_details_id,
 parent_survey_detail_id,
 survey_detail_id,
 MAX(answer_no) answer_no,
 MAX(answer_yes) answer_yes,
 MAX(answer_unknown) answer_unknown
FROM fnl
GROUP BY project_id,
 survey_id,
 survey_template_id,
 survey_template_code,
 survey_template_label,
 survey_status,
 consumer_id,
 survey_create_date,
 survey_date,
 question_number,
 question_text,
 question_type,
 answer_text,
 survey_details_id,
 parent_survey_detail_id,
 survey_detail_id),
cldtl AS(
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
claddr AS(
SELECT b.*,co.external_ref_type,co.external_ref_id  
FROM marsdb.marsdb_address_vw b                      
  JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
  JOIN marsdb.marsdb_contacts_owner_vw co ON b.address_id = co.contact_owner_id AND co.project_id = b.project_id   
WHERE p.project_name = 'DC-EB'
--AND b.address_type = 'Physical'
AND UPPER(co.external_ref_type) = 'CONSUMER'                          
QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id,b.address_type ORDER BY b.effective_end_date DESC NULLS FIRST,address_id DESC ) =1),
clphn AS(SELECT p.*,co.external_ref_type,co.external_ref_id                   
                 FROM marsdb.marsdb_phone_vw p  
                   JOIN marsdb.marsdb_contacts_owner_vw co ON p.phone_id = co.contact_owner_id AND co.project_id = p.project_id 
                   JOIN marsdb.marsdb_project_vw pr ON pr.project_id = p.project_id
                 WHERE pr.project_name = 'DC-EB'
                 AND UPPER(co.external_ref_type) = 'CONSUMER'
                 AND p.phone_type = 'Home'
                 QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY p.effective_end_date DESC NULLS FIRST,phone_id DESC ) =1),
enrl AS(
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
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date
QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1)
SELECT fnlsvy.*,
  cldtl.medical_assistance_id,
  cldtl.case_number,
  cldtl.consumer_first_name,
  cldtl.consumer_last_name,
  FLOOR((CAST(fnlsvy.survey_date AS DATE) - CAST(cldtl.consumer_date_of_birth AS DATE))/365) consumer_age,
  cldtl.consumer_date_of_birth,
  hoh.consumer_first_name hoh_first_name,
  hoh.consumer_last_name hoh_last_name,
  res.address_street_1 res_address_street_1,
  res.address_street_2 res_address_street_2,
  res.address_city res_address_city,
  res.address_state res_address_state,
  res.address_zip res_address_zip,
  res.address_zip_four res_address_zip_four,
  res.address_county res_address_county, 
  mail.address_street_1 mail_address_street_1,
  mail.address_street_2 mail_address_street_2,
  mail.address_city mail_address_city,
  mail.address_state mail_address_state,
  mail.address_zip mail_address_zip,
  mail.address_zip_four mail_address_zip_four,
  mail.address_county mail_address_county,
  clphn.phone_number,
  enrl.plan_name,
  ce.eligibility_start_date
FROM fnlsvy
  JOIN (SELECT enrl.project_id,consumer_id,enrollment_id,plan_code,pvw.report_label plan_name,enrl.created_on_date
        FROM enrl
          JOIN marsdb.marsdb_enum_plan_name_vw pvw ON enrl.plan_code = pvw.value AND enrl.project_id = pvw.project_id 
        QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) enrl 
    ON fnlsvy.consumer_id = enrl.consumer_id AND fnlsvy.project_id = enrl.project_id AND CAST(fnlsvy.survey_date AS DATE) >= enrl.created_on_date
  LEFT JOIN ce ON fnlsvy.consumer_id = ce.consumer_id AND fnlsvy.project_id = ce.project_id
  LEFT JOIN cldtl ON fnlsvy.consumer_id = cldtl.consumer_id AND fnlsvy.project_id = cldtl.project_id
  LEFT JOIN cldtl hoh ON fnlsvy.consumer_id = hoh.consumer_id AND fnlsvy.project_id = hoh.project_id AND hoh.consumer_role = 'Primary Individual'
  LEFT JOIN claddr res ON cldtl.consumer_id = res.external_ref_id AND cldtl.project_id = res.project_id AND res.address_type = 'Physical'
  LEFT JOIN claddr mail ON cldtl.consumer_id = mail.external_ref_id AND cldtl.project_id = mail.project_id AND mail.address_type = 'Mailing'
  LEFT JOIN clphn ON cldtl.consumer_id = clphn.external_ref_id AND cldtl.project_id = clphn.project_id   ;