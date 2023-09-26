USE SCHEMA PUBLIC;
--pbi_rpt_lastdispositions
CREATE OR REPLACE VIEW mio_d_cases_last_disposition_sv AS
SELECT CONCAT(e.first_name,' ' ,e.last_name) AS full_name,
s.supervisor,
e.ldap_id,
cp.case_number,
cp.task_status,
cp.denial_reason,
cp.transferred_to,
cp.location,
cp.why,
cp.additional_case_outcomes,
cp.number_approved,
cp.vcl_doc_type_requested,
cp.vcl_due,
CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) as disposition_date
FROM coverva_mio.case_pool_log cp 
  JOIN (SELECT max(id) as maxid 
        FROM coverva_mio.case_pool_log 
        WHERE CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date) > DATEADD(DAY,-30,current_date())
        AND action <> 'delete'  
        GROUP BY case_number) cls ON cp.id = cls.maxid
  LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to 
  LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
;