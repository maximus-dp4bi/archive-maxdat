CREATE OR REPLACE VIEW dceb.dceb_f_pcp_choice_by_plan_sv
AS
WITH t1 AS 
(
SELECT ep.consumer_id
      ,ep.enrollment_id
      ,ep.provider_id
      ,ep.provider_npi
      ,ep.provider_type
      ,pt.report_label  as provider_type_desc    
      ,en.enrollment_type
      ,en.plan_code
      ,pn.report_label as plan_name
      ,en.sub_program_type_cd
      ,en.txn_status      
      ,en.start_date as coverage_start
      ,en.end_date as coverage_end
      ,en.txn_status_date
      ,en.created_on enrollment_create_date
FROM  marsdb.marsdb_enrollment_provider_vw ep
  LEFT JOIN marsdb.marsdb_enrollments_vw en on (ep.enrollment_id = en.enrollment_id and en.project_id = ep.project_id)
  LEFT JOIN marsdb.marsdb_enum_provider_type_vw pt on (ep.provider_type = pt.value and pt.project_id = ep.project_id)
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn on (en.plan_code = pn.value and pn.project_id = en.project_id)
  JOIN marsdb.marsdb_project_vw p on (p.project_id = ep.project_id)
WHERE p.project_name = 'DC-EB'
AND  ep.provider_type <> 'D'
AND  en.status IN ('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE')
)
SELECT CAST(txn_status_date AS DATE) txn_status_date, CAST(enrollment_create_date AS DATE) enrollment_create_date, t1.plan_name, COUNT(DISTINCT consumer_id) member_count
FROM t1
GROUP BY CAST(txn_status_date AS DATE), CAST(enrollment_create_date AS DATE), t1.plan_name
;