USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_vde_returned_to_worker_sv
AS
SELECT 
xx.Supervisor,
xx.EmployeeName,
xx.Disposition,
xx.unit,
xx.type,
xx.date_vde_sent_back,
xx.case_number,
COUNT(Disposition) AS Total_VDE_Sent_Back
FROM(SELECT ls.Supervisor,
       CONCAT(e.first_name,' ', e.last_name) AS EmployeeName,
       c.task_status AS Disposition,
       unit,
       type,
       case_number,
       CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.validate_bucket_date) as DATE) as date_vde_sent_back
     FROM coverva_mio.case_pool_log c
     LEFT JOIN coverva_mio.employees e ON c.assigned_to = e.id
     LEFT JOIN mio_d_supervisor_sv ls ON e.supervisor = ls.id
     WHERE c.valid IN ('Return to worker')
     GROUP BY ls.Supervisor,
       CONCAT(e.first_name,' ', e.last_name),
       c.task_status ,
       unit,
       type,
       case_number,
       CONVERT_TIMEZONE('UTC', 'America/New_York',c.validate_bucket_date) ) xx 
GROUP BY 
xx.Supervisor,
xx.EmployeeName,
xx.Disposition,
xx.unit,
xx.type,
xx.date_vde_sent_back,
xx.case_number;