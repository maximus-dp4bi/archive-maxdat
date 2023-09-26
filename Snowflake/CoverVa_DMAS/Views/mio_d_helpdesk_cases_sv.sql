USE SCHEMA PUBLIC;
--pbi_rpt_helpdeskcases
CREATE OR REPLACE VIEW mio_d_helpdesk_cases_sv AS
SELECT CONCAT(e.first_name,' ' ,e.last_name) AS employee_name,
s.supervisor,
cp.case_number,
cp.task_status,
cp.why,
CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) as disposition_date,
notes,
unit,
type
FROM coverva_mio.case_pool cp 
LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to 
LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
WHERE cp.task_status = 'Pending' 
AND  cp.why = 'Help Desk';