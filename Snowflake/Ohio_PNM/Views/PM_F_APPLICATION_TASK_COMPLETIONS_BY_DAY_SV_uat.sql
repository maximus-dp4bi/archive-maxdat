CREATE OR REPLACE VIEW PUBLIC.PM_F_APPLICATION_TASK_COMPLETIONS_BY_DAY_SV 
AS
WITH task_completions AS(
SELECT COALESCE(rpt.provider_type_name,'Unavailable') AS provider_type,
     rpt.mmis_provider_type_id AS provider_type_code_mmis,
     CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group,
     CAST(tsk.end_date_time AS DATE) task_completion_date,
     tsk.task_name,
     COUNT(r.reg_id) task_completion_count
FROM ohpnm_dp4bi.registration r 
  JOIN ohpnm_dp4bi.reg_provider rp ON r.reg_id = rp.reg_id
  JOIN  (SELECT *
                FROM (SELECT wc.process_id, parameter_value,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.start_date_time) start_date_time,
                             CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.end_date_time) end_date_time,
                             RANK() OVER (PARTITION BY parameter_value ORDER BY wp.process_id DESC) prnk
                       FROM ohpnm_dp4bi.wf_parameter wp
                         JOIN ohpnm_dp4bi.wf_process wc  ON wc.process_id = wp.process_id AND wc.workflow_id = 1
                       WHERE parameter_name = 'REGISTRATION_ID')
                WHERE prnk = 1) wc ON wc.parameter_value = TO_CHAR(r.reg_id) 
  LEFT JOIN ohpnm_dp4bi.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id  
  JOIN (SELECT t.*
             FROM (SELECT p.process_id, t.step_id, tt.name task_name, tt.task_type,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time)) start_date_time, 
                         CASE WHEN t.end_date_time IS NULL AND LEAD(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time))) OVER (PARTITION BY t.process_id ORDER BY t.step_id) IS NOT NULL THEN
                            LEAD(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time))) OVER (PARTITION BY t.process_id ORDER BY t.step_id)  ELSE CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',t.end_date_time) END end_date_time
                   FROM ohpnm_dp4bi.wf_process p
                     JOIN ohpnm_dp4bi.wf_step t ON p.process_id = t.process_id
                     JOIN ohpnm_dp4bi.wf_task tt ON t.task_id = tt.task_id                                    
                   WHERE tt.task_type = 'Queue' ) t                  
             WHERE end_date_time IS NOT NULL) tsk ON wc.process_id = tsk.process_id
GROUP BY COALESCE(rpt.provider_type_name,'Unavailable'),
     rpt.mmis_provider_type_id,
     CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END,
     tsk.task_name,
     CAST(tsk.end_date_time AS DATE)  
  )
SELECT dd.d_date,
 tc.provider_type,
 tc.provider_type_code_mmis,
 tc.operational_group,
 tc.task_name,
 COALESCE(tc.task_completion_count,0) task_completion_count
FROM d_dates dd
 LEFT JOIN task_completions tc ON dd.d_date = tc.task_completion_date
WHERE d_date >= DATEADD(MONTH,-12,DATE_TRUNC('MONTH',current_date()))
AND d_date <= current_date()
;

          
