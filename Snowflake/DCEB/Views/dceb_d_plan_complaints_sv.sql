CREATE OR REPLACE VIEW dceb.dceb_d_plan_complaints_sv
AS
WITH stf AS(
SELECT p.project_id,u.user_id, s.staff_id,s.maximus_id,CONCAT(s.first_name, ' ',s.last_name) as staff_name,tvw.team_name
FROM marsdb.marsdb_user_vw u 
 JOIN marsdb.marsdb_project_vw p ON p.project_id = u.project_id
 JOIN marsdb.marsdb_staff_vw s ON s.staff_id = u.staff_id
 LEFT JOIN marsdb.marsdb_team_user_vw tuvw ON tuvw.user_id = u.user_id AND tuvw.project_id = u.project_id
 LEFT JOIN marsdb.marsdb_team_vw tvw ON tuvw.team_id = tvw.team_id AND tuvw.project_id = tvw.project_id
WHERE p.project_name = 'DC-EB'
QUALIFY ROW_NUMBER() OVER (PARTITION BY p.project_id,u.user_id ORDER BY tuvw.effective_end_date DESC NULLS FIRST, tuvw.team_user_id) = 1 ),
t1 AS (
SELECT t.task_id
      ,t.task_status
      ,DATE(t.status_date) as status_date      
      ,DATE(t.created_on) as complaint_create_date
      ,t.task_type_id
      ,td.selection_varchar as complaint_type
      ,el.external_ref_id as consumer_id      
      ,t.task_notes
      ,t.project_id
      ,t.created_by
      ,stf.staff_name created_by_name
FROM  marsdb.marsdb_tasks_vw t
LEFT JOIN stf ON t.created_by = stf.user_id
LEFT JOIN marsdb.marsdb_project_vw p ON (t.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_external_links_vw el ON (el.internal_id = t.task_id AND el.project_id = t.project_id AND el.internal_ref_type = 'TASK' AND el.external_ref_type = 'CONSUMER')
LEFT JOIN marsdb.marsdb_task_detail_vw td ON (t.task_id = td.task_id AND td.project_id = t.project_id AND td.task_field_id = 126)
WHERE p.project_name = 'DC-EB'
AND t.task_type_id = 16519
AND t.task_status <> 'Cancelled'),
tskdtl AS(SELECT x.project_id,
 x.task_id,
 x."71" AS complaint_disposition,
 x."126" AS complaint_type,
 x."90" AS complaint_reason,
 x."179" AS caller_name 
FROM (SELECT td.project_id, td.task_id, 
            selection_varchar selection,
             task_field_id
              FROM  marsdb.marsdb_task_detail_vw td 
                JOIN marsdb.marsdb_project_vw p ON p.project_id = td.project_id
              WHERE td.task_field_id in (126,90,71,179)
              AND p.project_name = 'DC-EB') PIVOT (MAX(selection) FOR task_field_id IN (126,90,71,179)) x
),
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
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code   
FROM marsdb.marsdb_enrollments_vw enrl
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason IS NOT NULL
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
WHERE p.project_name = 'DC-EB'
AND enrl.status = 'ACCEPTED'
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
UNION ALL
SELECT disenrl.project_id,disenrl.enrollment_id, disenrl.consumer_id, disenrl.start_date, disenrl.end_date,disenrl.status, CAST(disenrl.txn_status_date AS DATE) txn_status_date
   ,disenrl.plan_code,disenrl.enrollment_type,disenrl.sub_program_type_cd,disenrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,disenrl.service_region_code
   ,CAST(disenrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code
FROM marsdb.marsdb_enrollments_vw disenrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = disenrl.project_id
WHERE p.project_name = 'DC-EB'
AND disenrl.status = 'DISENROLLED'
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND enrl.status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE'))
)
SELECT t.task_id
      ,t.task_status
      ,t.status_date      
      ,t.complaint_create_date
      ,t.task_type_id
      ,td.complaint_type
      ,td.complaint_reason
      ,td.complaint_disposition
      ,td.caller_name
      ,t.consumer_id
      ,cldtl.consumer_first_name
      ,cldtl.consumer_last_name
      ,cldtl.case_number
      ,cldtl.case_id
      ,cldtl.medical_assistance_id AS MAID
      ,en.plan_code
      ,COALESCE(en.plan_name,'PLAN NOT FOUND') AS plan_name
      ,t.task_notes
      ,edvw.report_label complaint_disposition_label
      ,cavw.report_label complaint_reason_label
      ,ctvw.report_label complaint_type_label
      ,t.created_by
      ,t.created_by_name AS agent_name
FROM  t1 t
  JOIN marsdb.marsdb_project_vw p ON (t.project_id = p.project_id AND p.project_name = 'DC-EB')
  LEFT JOIN tskdtl td ON (t.task_id = td.task_id AND t.project_id = td.project_id)
  LEFT JOIN cldtl ON (t.consumer_id = cldtl.consumer_id and t.project_id = cldtl.project_id)
  LEFT JOIN (SELECT enrl.project_id,consumer_id,enrollment_id,plan_code,pvw.report_label plan_name,enrl.created_on_date
             FROM enrl
               JOIN marsdb.marsdb_enum_plan_name_vw pvw ON enrl.plan_code = pvw.value AND enrl.project_id = pvw.project_id 
             WHERE enrl.status IN('ACCEPTED')
             QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) en ON t.consumer_id = en.consumer_id AND t.project_id = en.project_id
  LEFT JOIN marsdb.marsdb_enum_disposition_vw edvw ON edvw.value = td.complaint_disposition AND edvw.project_id = td.project_id
  LEFT JOIN marsdb.marsdb_enum_complaint_about_vw cavw ON cavw.value = td.complaint_reason AND cavw.project_id = td.project_id
  LEFT JOIN marsdb.marsdb_enum_complaint_type_vw ctvw ON ctvw.value = td.complaint_type AND ctvw.project_id = td.project_id 
WHERE p.project_name = 'DC-EB'  ;