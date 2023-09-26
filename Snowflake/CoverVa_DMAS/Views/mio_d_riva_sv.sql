USE SCHEMA PUBLIC;
--pbi_riva
CREATE OR REPLACE VIEW mio_d_riva_sv AS
WITH riva AS(
SELECT r.id,
r.case_pool_log_id ,
r.case_number ,
CASE WHEN Category = 'APD' THEN null ELSE Date_Dispositioned END AS Date_Dispositioned ,
r.Category ,
r.EmployeeName ,
r.Supervisor ,
r.Manager ,
r.max_emp_id  ,
r.case_type ,
r.completions_bucket ,
r.pending_bucket  ,
r.transfers_bucket  ,
r.employees_table_id  ,
r.unit  ,
r.type ,
r.updated ,
r.duration,
DATEADD(SECOND,-r.duration,r.date_dispositioned) start_date,
cpl.transferred_to transferred_to_unit,
CASE WHEN r.date_dispositioned IS NULL THEN NULL
     WHEN e.hist_training_status = 'Production' THEN CONCAT('Week',e.week_num) 
     WHEN e.hist_training_status IS NOT NULL THEN e.hist_training_status
 ELSE ts.training_status END emp_training_week_status
FROM coverva_mio.rpt_riva r
  JOIN coverva_mio.case_pool_log cpl ON r.case_pool_log_id = cpl.id
  JOIN coverva_mio.employees emp ON r.employees_table_id = emp.id
  JOIN coverva_mio.employees_look_training_status ts ON emp.training_status = ts.id
  LEFT JOIN mio_d_employee_status_week_sv e ON r.employees_table_id = e.id 
    AND ( (CAST(CASE WHEN Category = 'APD' THEN null ELSE Date_Dispositioned END AS DATE) BETWEEN e.d_week_start AND e.d_week_end) ) )
SELECT r.*, ps.standard_in_minutes,ps.standard_percent
FROM riva r
  LEFT JOIN coverva_mio.cfg_productivity_standard ps ON UPPER(r.case_type) = UPPER(ps.case_type)  
    AND r.emp_training_week_status = ps.training_status AND CAST(r.date_dispositioned AS DATE) BETWEEN CAST(ps.start_date AS DATE) AND CAST(ps.end_date AS DATE);
  