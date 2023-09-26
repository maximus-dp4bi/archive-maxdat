CREATE OR REPLACE VIEW OHIO_PROVIDER_DP4BI_DEV_DB.PUBLIC.PM_F_PROVIDER_CREDENTIAL_BY_QUEUE_BY_DAY_SV
AS
SELECT d_date,
  credentialing_queue,
  SUM(creation_count) creation_count,
  SUM(inventory_count) inventory_count,
  SUM(completion_count) completion_count,
  0 cancellation_count,
  SUM(termination_count) termination_count,
  SUM(assigned_to) assigned_count,  
  SUM(unassigned) unassigned_count,   
  SUM(reassigned_count) reassigned_count, 
  SUM(return_to_provider_count) return_to_provider_count  
FROM(
SELECT dd.d_date,pcbd.*,
  CASE WHEN CAST(pcbd.start_date_time AS DATE)= dd.d_date THEN 1 ELSE 0 END creation_count,  
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 0 ELSE 1 END AS inventory_count,
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 1 ELSE 0 END AS completion_count,
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 1 ELSE 0 END AS termination_count,
  CASE WHEN d_date = CAST(pcbd.start_date_time AS DATE) AND pcbd.owner_id IS NOT NULL THEN 1 ELSE 0 END assigned_to,
  CASE WHEN d_date = CAST(pcbd.start_date_time AS DATE) AND pcbd.owner_id IS NULL THEN 1 ELSE 0 END unassigned,
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) AND pcbd.user_action = 'Return to Provider' THEN 1 ELSE 0 END return_to_provider_count,
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) AND pcbd.user_action = 'Return To Credentialing Specialist' THEN 1 ELSE 0 END reassigned_count
FROM (
SELECT r.reg_id, c.start_date_time pc_start_dt, c.end_date_time pc_end_dt, ws.step_id, convert_timezone('UTC', 'America/Los_Angeles',ws.start_date_time) start_date_time
     ,convert_timezone('UTC', 'America/Los_Angeles',ws.end_date_time) end_date_time,ts.name credentialing_queue,ts.task_type, ws.owner_id, wa.name user_action
FROM ohpnm_dp4bi_dev.registration r
 JOIN ohpnm_dp4bi_dev.wf_parameter wp ON wp.parameter_value = r.reg_id AND parameter_name = 'REGISTRATION_ID' 
 JOIN ohpnm_dp4bi_dev.reg_credentialing rc ON r.reg_id = rc.reg_id 
 JOIN ohpnm_dp4bi_dev.credentialing c ON rc.credentialing_id = c.credentialing_id
 JOIN ohpnm_dp4bi_dev.wf_step ws ON wp.process_id = ws.process_id --current task
 JOIN ohpnm_dp4bi_dev.wf_task ts ON ws.task_id = ts.task_id 
 LEFT JOIN ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = ws.step_id --next task
 LEFT JOIN ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
 LEFT JOIN ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = ts.task_id AND wa.next_task_id = nextsk.task_id 
WHERE ts.task_type = 'Queue'
AND UPPER(ts.name) LIKE '%CREDENTIALING%'
) pcbd
JOIN d_dates dd ON dd.d_date >= CAST(pcbd.start_date_time AS DATE) AND dd.d_date <= CAST(COALESCE(pcbd.end_date_time,CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)
) t
GROUP BY d_date,credentialing_queue;