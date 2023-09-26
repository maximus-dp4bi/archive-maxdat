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
,denial_reason
,transferred_to
,why
,additional_case_outcomes
,number_approved
,CASE WHEN task_status = 'Approved' THEN TO_CHAR(number_approved)
      WHEN task_status = 'Denied' THEN denial_reason
      WHEN task_status = 'Other' THEN additional_case_outcomes
      WHEN task_status = 'Other Transfer' THEN transferred_to
      WHEN task_status IN('Pending','Transferred to LDSS') THEN why
  ELSE COALESCE(additional_case_outcomes,why,transferred_to,denial_reason,TO_CHAR(number_approved)) END action_taken
FROM coverva_mio.case_pool 
WHERE bucket_date IS NOT NULL 
AND validate_bucket_date IS NULL 
AND COALESCE(why,'X') NOT IN ('Question', 'Help Desk', 'Emergency Services','Sup Review')  
AND COALESCE(additional_case_outcomes,'X') NOT IN ('ECPR Tool Needed', 'Re Registration Needed','DMAS Action Needed')
AND assigned_to > 0  
AND unit NOT IN ('CVIU')
AND end_time IS NULL
AND specialty NOT IN ('Escalation')
GROUP BY unit,case_number,bucket_date,task_status,denial_reason,transferred_to,why,additional_case_outcomes,number_approved;

