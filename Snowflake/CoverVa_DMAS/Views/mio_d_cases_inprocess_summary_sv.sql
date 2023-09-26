USE SCHEMA PUBLIC;
--pbi_cpr
CREATE OR REPLACE VIEW mio_d_cases_inprocess_summary_sv AS
SELECT 
ls.Supervisor,
c.request_type, 
c.status, 
COUNT(c.id) AS TotalCases 
FROM coverva_mio.cate_unprocessed c
  LEFT JOIN coverva_mio.employees e ON c.employee_table_id = e.id
  LEFT JOIN mio_d_supervisor_sv ls ON e.supervisor = ls.id 
WHERE status NOT IN ('Completed', 'Denied')
GROUP BY ls.supervisor,request_type,status;