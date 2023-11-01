CREATE OR REPLACE VIEW dceb.dceb_d_for_cause_tasks_sv 
AS
WITH stf AS(
SELECT u.user_id, CONCAT(SUBSTR(s.first_name,1,1), '. ',s.last_name) as staff_name
FROM marsdb.marsdb_user_vw u
 JOIN marsdb.marsdb_project_vw p ON p.project_id = u.project_id
 JOIN marsdb.marsdb_staff_vw s ON s.staff_id = u.staff_id
WHERE p.project_name = 'DC-EB'),
tskinfo AS(SELECT tvw.task_id sr_id,
 tvw.project_id,
 tvw.task_type_id,
 tt.task_name,
 tvw.task_status, 
 tvw.created_on,
 tvw.updated_on,
 tvw.default_due_date,
 tvw.hold_reason,
 hrvw.report_label hold_reason_label,
 tvw.staff_assigned_to,
 tvw.created_by,
 stf.staff_name staff_created_by_name,
 tvw.task_info,
 tvw.task_notes,
 xvw.external_ref_id case_id,
 tvw.status_date task_status_date
FROM marsdb.marsdb_tasks_vw tvw 
  JOIN marsdb.marsdb_project_vw p ON p.project_id = tvw.project_id
  JOIN marsdb.cfg_task_type tt ON tvw.task_type_id = tt.task_type_id AND tvw.project_id = tt.project_id  
  LEFT JOIN marsdb.marsdb_enum_hold_reasons_vw hrvw ON tvw.hold_reason = hrvw.value AND tvw.project_id = hrvw.project_id
  LEFT JOIN stf ON tvw.created_by = stf.user_id
  LEFT JOIN marsdb.marsdb_external_links_vw xvw ON tvw.task_id = xvw.internal_id AND tvw.project_id = xvw.project_id 
    AND xvw.internal_ref_type = 'SERVICE_REQUEST' AND xvw.external_ref_type = 'CASE'
WHERE tt.task_name = 'For Cause SR'  
AND p.project_name = 'DC-EB' ),
tskdtl AS(SELECT x.project_id,
 x.task_id,
 x."71" AS disposition,
 x."179" AS caller_name,
 x."186" AS date_state_notified,
 x."679" AS for_cause_reason,
 x."680" AS member_name,
 x."681" AS for_cause_notes,
 x."682" AS requested_plan,
 x."683" AS requested_effective_date,
 x."685" AS district_disposition,
 x."696" AS medicaid_id
FROM (SELECT td.project_id, td.task_id, 
            CASE WHEN td.task_field_id IN(186,683) THEN TO_CHAR(td.selection_date,'MM/DD/YYYY')                            
               ELSE COALESCE(selection_varchar, CAST(selection_date AS VARCHAR()),            
              CAST(selection_boolean AS VARCHAR()), CAST(selection_numeric AS VARCHAR())) END selection,
             task_field_id
              FROM  marsdb.marsdb_task_detail_vw td 
                JOIN marsdb.marsdb_project_vw p ON p.project_id = td.project_id
              WHERE td.task_field_id in (71,179,186,679,680,681,682,683,685,696)
              AND p.project_name = 'DC-EB') PIVOT (MAX(selection) FOR task_field_id IN (71,179,186,679,680,681,682,683,685,696)) x
),
cldtl AS(SELECT cnvw.project_id,cnvw.consumer_id,cnvw.consumer_date_of_birth,   
               cin.external_consumer_id medical_assistance_id,
               civw.external_case_id case_number,
               cnvw.consumer_first_name,
               cnvw.consumer_last_name,
               ccvw.case_id,
               ccvw.consumer_role,
               ccvw.effective_end_date
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
   ,disenrl.plan_code transfer_from_plan_code   
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date 
    AND disenrl.status = 'DISENROLLED' --AND disenrl.plan_end_date_reason IS NOT NULL
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED')
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
SELECT  tskinfo.sr_id,
 tskinfo.project_id,
 tskinfo.task_type_id,
 tskinfo.task_name,
 tskinfo.task_status, 
 tskinfo.created_on,
 tskinfo.updated_on,
 tskinfo.default_due_date,
 tskinfo.hold_reason,
 tskinfo.hold_reason_label,
 tskinfo.staff_assigned_to,
 tskinfo.created_by,
 tskinfo.staff_created_by_name,
 tskinfo.task_info,
 tskinfo.task_notes,
 tskinfo.case_id,
 tskdtl.disposition,
 dvw.report_label disposition_label,
 tskdtl.caller_name,
 tskdtl.date_state_notified,
 tskdtl.for_cause_reason,
 tskdtl.member_name,
 tskdtl.for_cause_notes,
 tskdtl.requested_plan,
 tskdtl.requested_effective_date,
 tskdtl.district_disposition,
 distvw.report_label district_disposition_label,
 tskdtl.medicaid_id,
 rvw.report_label for_cause_reason_label,
 cldtl.consumer_date_of_birth,
 cldtl.case_number,
 cldtl.consumer_role,
 enrl.plan_name,
 enrl.enroll_status,
 enrl.txn_status_date,
 tskinfo.task_status_date task_status_datetime,
 CAST(tskinfo.task_status_date AS DATE) task_status_date
FROM tskinfo  
  LEFT JOIN marsdb.marsdb_enum_hold_reasons_vw hrvw ON tskinfo.hold_reason = hrvw.value AND tskinfo.project_id = hrvw.project_id
  LEFT JOIN tskdtl ON tskinfo.sr_id = tskdtl.task_id AND tskinfo.project_id = tskdtl.project_id  
  LEFT JOIN marsdb.marsdb_enum_disposition_vw dvw ON tskdtl.disposition = dvw.value AND tskdtl.project_id = dvw.project_id
  LEFT JOIN marsdb.marsdb_enum_disposition_vw distvw ON tskdtl.district_disposition = distvw.value AND tskdtl.project_id = distvw.project_id
  LEFT JOIN marsdb.marsdb_enum_request_reason_vw rvw ON rvw.value = tskdtl.for_cause_reason AND rvw.project_id = tskdtl.project_id
  LEFT JOIN cldtl ON tskdtl.medicaid_id = cldtl.medical_assistance_id AND tskinfo.project_id = cldtl.project_id
  LEFT JOIN (SELECT enrl.project_id,enrl.consumer_id,enrl.start_date,enrl.end_date,enrl.txn_status_date,
               enrl.plan_code,pnvw.report_label plan_name,
               COALESCE(tsvw.report_label,enrl.status) enroll_status   
             FROM enrl 
               LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON enrl.plan_code = pnvw.value AND enrl.project_id = pnvw.project_id
               LEFT JOIN marsdb.marsdb_enum_transaction_status_vw tsvw ON enrl.status = tsvw.value AND enrl.project_id = tsvw.project_id
             QUALIFY ROW_NUMBER() OVER (PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) enrl 
    ON enrl.consumer_id = cldtl.consumer_id AND enrl.project_id = cldtl.project_id;