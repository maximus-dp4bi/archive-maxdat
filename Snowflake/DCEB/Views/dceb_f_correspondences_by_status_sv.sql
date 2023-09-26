CREATE OR REPLACE VIEW dceb.dceb_f_correspondences_by_status_sv
AS
SELECT TRIM(SUBSTR(cdvw.correspondence_name,1,REGEXP_INSTR(cdvw.correspondence_name,' ',1,1))) sub_program_type,
  cdvw.correspondence_name,
  svw.code status,
  CAST(novw.created_datetime AS DATE) create_date,
  CAST(novw.status_datetime AS DATE) status_date,
  COUNT(DISTINCT novw.id) correspondence_count
FROM marsdb.marsdb_notification_order_vw novw
  JOIN marsdb.marsdb_project_vw p ON p.project_id = novw.project_id
  JOIN marsdb.marsdb_correspondence_recipient_vw crvw ON novw.correspondence_recipient_id = crvw.id AND novw.project_id = crvw.project_id
  JOIN marsdb.marsdb_correspondence_order_vw covw ON covw.id = crvw.correspondence_order_id AND covw.project_id = crvw.project_id
  JOIN marsdb.marsdb_correspondence_definition_vw cdvw ON cdvw.mms_id = covw.definition_name AND cdvw.project_id = covw.project_id
  JOIN marsdb.marsdb_status_vw svw ON novw.status_id = svw.id AND novw.project_id = svw.project_id
WHERE p.project_name = 'DC-EB'
AND novw.type = 'Mail' 
GROUP BY cdvw.correspondence_name,svw.code,CAST(novw.created_datetime AS DATE), CAST(novw.status_datetime AS DATE);  
