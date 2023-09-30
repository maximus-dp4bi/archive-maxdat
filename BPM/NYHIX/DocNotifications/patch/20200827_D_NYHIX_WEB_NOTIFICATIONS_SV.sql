
CREATE or Replace VIEW MAXDAT.D_NYHIX_WEB_NOTIFICATIONS_SV AS
 SELECT DISTINCT a12.complete_date  complete_date_time, 
  a11.kofax_dcn,
  (CASE WHEN a12.task_type_id IN (2013019) AND a11.create_dt <=  a12.complete_date THEN 1 ELSE 0 END)  godwflag2_1,
  (CASE WHEN a12.task_type_id IN (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) AND a11.create_dt >= a12.create_date THEN 1 ELSE 0 END)  godwflag4_1,
  TRUNC(a12.complete_date) complete_date,
  'Consumer Documents (Web)' AS document_type, --Updating label to match billing report requirements.
  'Web' AS channel,
  (CASE WHEN a12.task_type_id IN (2013019) AND a11.create_dt <=  a12.complete_date THEN 1 ELSE 0 END)   +
  (CASE WHEN a12.task_type_id IN (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) AND a11.create_dt >= a12.create_date THEN 1 ELSE 0 END) AS 
   completed_count
FROM d_nyhix_doc_notif_current a11
INNER JOIN d_mw_v2_current a12
ON a12.source_process_instance_id = a11.process_instance_id
WHERE a11.kofax_dcn LIKE 'U%'
AND a12.curr_task_status = 'COMPLETED'
AND ( ( a12.task_type_id IN (2016306,2013054,2016308,2013051,2013050,2016307,2013052) AND a11.create_dt >= a12.create_date) 
  OR  (a12.task_type_id = 2013019 AND a11.create_dt <= a12.complete_date ) );
  
  
GRANT   SELECT ON   MAXDAT.D_NYHIX_WEB_NOTIFICATIONS_SV  TO   MAXDAT_READ_ONLY;

  Commit;