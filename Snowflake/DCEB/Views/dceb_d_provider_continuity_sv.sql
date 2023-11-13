CREATE OR REPLACE VIEW dceb.dceb_d_provider_continuity_sv AS
WITH enrl AS(
SELECT enrl.project_id,enrl.enrollment_id
   ,enrl.consumer_id
   ,enrl.start_date
   ,enrl.end_date,enrl.status
   ,CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type
   ,enrl.sub_program_type_cd
   ,enrl.channel
   ,enrl.service_region_code
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,stvw.report_label sub_program_type
   ,pnvw.report_label mco
   ,epv.provider_first_name||' '||epv.provider_last_name as pcp
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id  
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) stvw ON enrl.sub_program_type_cd = stvw.value AND enrl.project_id = stvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON enrl.plan_code = pnvw.value AND enrl.project_id = pnvw.project_id  
  LEFT JOIN marsdb.marsdb_enrollment_provider_vw epv on epv.enrollment_id = enrl.enrollment_id and epv.project_id = enrl.project_id and epv.provider_type in ('M','P')
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED')
AND enrl.generic_field_text_1 = 'F'),
ltr AS(SELECT DISTINCT novw.id notification_order_id, novw.project_id,covw.case_id, crvw.consumer_id, svw.code, novw.status_datetime ,CAST(novw.created_datetime as date) notif_order_createdate
              FROM marsdb.marsdb_notification_order_vw novw
              JOIN marsdb.marsdb_project_vw p ON p.project_id = novw.project_id
              JOIN marsdb.marsdb_correspondence_recipient_vw crvw ON novw.correspondence_recipient_id = crvw.id AND novw.project_id = crvw.project_id
              JOIN marsdb.marsdb_correspondence_order_vw covw ON covw.id = crvw.correspondence_order_id AND covw.project_id = crvw.project_id
              JOIN marsdb.marsdb_correspondence_definition_vw cdvw ON cdvw.mms_id = covw.definition_name AND cdvw.project_id = covw.project_id
              JOIN marsdb.marsdb_status_vw svw ON novw.status_id = svw.id AND novw.project_id = svw.project_id
              WHERE p.project_name = 'DC-EB'
              AND cdvw.correspondence_name LIKE '%Continuity of Service Notice%'
              AND svw.code != 'Canceled'),
cldtl AS(
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
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,ervw.report_label eligibility_end_reason_label
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw ervw ON ce.eligibility_end_reason = ervw.value AND ce.project_id = ervw.project_id
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date)
SELECT enrl.consumer_id, cldtl.case_id, cldtl.case_number, cldtl.medical_assistance_id, enrl.sub_program_type, enrl.mco, enrl.pcp
     , ce.eligibility_end_date as elig_term_date, enrl.start_date as reenroll_date
FROM enrl  
  JOIN cldtl ON enrl.consumer_id = cldtl.consumer_id AND enrl.project_id = cldtl.project_id
  LEFT JOIN ltr ON enrl.consumer_id = ltr.consumer_id AND enrl.project_id = ltr.project_id AND enrl.created_on_date BETWEEN ltr.notif_order_createdate -1 AND ltr.notif_order_createdate + 1
  LEFT JOIN ltr csltr ON cldtl.case_id = csltr.case_id AND cldtl.project_id = csltr.project_id AND enrl.created_on_date BETWEEN csltr.notif_order_createdate -1 AND csltr.notif_order_createdate + 1
   JOIN ce ON enrl.consumer_id = ce.consumer_id AND enrl.project_id = ce.project_id AND CAST(ce.eligibility_end_date AS DATE)+1 <= CAST(enrl.start_date AS DATE)
WHERE  COALESCE(ltr.notif_order_createdate,csltr.notif_order_createdate) IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY enrl.enrollment_id ORDER BY enrl.enrollment_id,ce.core_eligibility_segments_id DESC,COALESCE(ltr.notification_order_id,csltr.notification_order_id)) = 1;
