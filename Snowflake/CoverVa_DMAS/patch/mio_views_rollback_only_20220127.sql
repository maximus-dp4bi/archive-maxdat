USE SCHEMA PUBLIC;
--pbi_pending_vde_cases
CREATE OR REPLACE VIEW mio_d_pending_vde_cases_sv AS
SELECT unit
,case_number
,CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date) sent_vde_date_time
,MARSDB.get_business_difference_days(DATE_TRUNC('DAY',CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date)), current_date(),117) days_pending_busdays
,DATEDIFF(DAY,DATE_TRUNC('DAY',CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date)), current_date()) days_pending_caldays
,COUNT(id) AS Pending_VDE_Cases 
,task_status
FROM coverva_mio.case_pool 
WHERE bucket_date IS NOT NULL 
AND validate_bucket_date IS NULL 
AND COALESCE(why,'X') NOT IN ('Question', 'Help Desk', 'Emergency Services')  
AND COALESCE(additional_case_outcomes,'X') NOT IN ('ECPR Tool Needed', 'Re Registration Needed')
AND unit NOT IN ('CVIU')
GROUP BY unit,case_number,bucket_date,task_status;

CREATE OR REPLACE VIEW mio_d_staff_assignment_sv 
AS
SELECT m.manager,s.supervisor
  ,sf.employee_id, CONCAT(e.first_name, ' ', e.last_name) employee_name
  ,CASE WHEN sf.category_hierarchy1 = 'Application' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_applications
  ,CASE WHEN sf.category_hierarchy1 = 'Renewal' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_renewals
  ,CASE WHEN ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_vde
  ,CASE WHEN sf.specialty = 'None' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_none
  ,CASE WHEN sf.specialty = 'Pregnant Women' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_pw
  ,CASE WHEN sf.specialty = 'Manual' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_manual
  ,CASE WHEN sf.specialty = 'Worker Manual' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_worker_manual
FROM coverva_mio.safe sf
  JOIN coverva_mio.employees e ON e.id = sf.employee_id
  LEFT JOIN coverva_mio.employees_look_functional_area ef ON e.functional_area = ef.id
  LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
  LEFT JOIN mio_d_manager_sv m ON e.manager = m.id;