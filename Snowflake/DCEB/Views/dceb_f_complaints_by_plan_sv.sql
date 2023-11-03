CREATE OR REPLACE VIEW dceb.dceb_f_complaints_by_plan_sv
AS
WITH enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code   
FROM marsdb.marsdb_enrollments_vw enrl
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date 
    AND disenrl.status = 'DISENROLLED' --AND disenrl.plan_end_date_reason IS NOT NULL
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
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date
  AND enrl.status IN('ACCEPTED'))
),
t1 AS (
SELECT t.task_id
      ,t.task_status
      ,DATE(t.status_date) as status_date      
      ,DATE(t.created_on) as complaint_create_date
      ,t.task_type_id
      ,td.selection_varchar as complaint_type
      ,el.external_ref_id as consumer_id
      ,en.plan_code
      ,COALESCE(pn.report_label,'PLAN NOT FOUND') as plan_name
FROM  marsdb.marsdb_tasks_vw t
LEFT JOIN marsdb.marsdb_project_vw p ON (t.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_external_links_vw el ON (el.internal_id = t.task_id AND el.project_id = t.project_id AND el.internal_ref_type = 'TASK' AND el.external_ref_type = 'CONSUMER')
LEFT JOIN marsdb.marsdb_task_detail_vw td ON (t.task_id = td.task_id AND td.project_id = t.project_id AND td.task_field_id = 126)
LEFT JOIN (SELECT enrl.project_id,consumer_id,enrollment_id,plan_code,pvw.report_label plan_name,enrl.created_on_date
             FROM enrl
               JOIN marsdb.marsdb_enum_plan_name_vw pvw ON enrl.plan_code = pvw.value AND enrl.project_id = pvw.project_id 
             WHERE enrl.status IN('ACCEPTED')
             QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) en ON (en.consumer_id = el.external_ref_id AND en.project_id = el.project_id)
LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn ON (en.plan_code = pn.value AND pn.project_id = en.project_id)
WHERE p.project_name = 'DC-EB'
AND t.task_type_id = 16519
AND t.task_status <> 'Cancelled'
)
SELECT t1.plan_name AS plan_name
     ,complaint_create_date
     ,SUM(CASE WHEN t1.complaint_type = 'TRANSPORTATION' THEN 1 ELSE 0 END) AS transportation
     ,SUM(CASE WHEN t1.complaint_type IN('PERSCRIPTION','PRESCRIPTION') THEN 1 ELSE 0 END) AS rx
     ,SUM(CASE WHEN t1.complaint_type = 'EB'             THEN 1 ELSE 0 END) AS eb
     ,SUM(CASE WHEN t1.complaint_type = 'MCO'            THEN 1 ELSE 0 END) AS mco
     ,SUM(CASE WHEN t1.complaint_type = 'DENTAL'         THEN 1 ELSE 0 END) AS dental
     ,SUM(CASE WHEN t1.complaint_type = 'PROVIDER'       THEN 1 ELSE 0 END) AS provider
FROM t1
GROUP BY t1.plan_name,complaint_create_date
;