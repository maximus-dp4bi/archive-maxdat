CREATE OR REPLACE VIEW PUBLIC.PM_F_APPLICATION_INSTANCE_BY_STATUS_BY_DAY_SV
AS
WITH curinv AS(
SELECT dd.d_date,
       pcbd.application_id,
       pcbd.provider_type,
       pcbd.provider_type_code_mmis,
       pcbd.operational_group,
       pcbd.process_id,
       CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE) THEN pcbd.application_status ELSE NULL END AS application_status,
       CASE WHEN     d_date = CAST(pcbd.process_start_dt AS DATE) THEN 1 ELSE 0 END AS    creation_count,  
       CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE) THEN 0 ELSE 1 END AS    inventory_count,
       CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE) AND pcbd.cancel_notice_dt IS NULL THEN 1 ELSE 0 END AS completion_count,
       CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE) AND pcbd.cancel_notice_dt IS NOT NULL THEN 1 ELSE 0 END AS cancellation_count,
       CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE) THEN DATEDIFF(DAY,CAST(pcbd.process_start_dt AS DATE),CAST(pcbd.process_end_dt AS DATE))
         ELSE DATEDIFF(DAY, CAST(pcbd.process_start_dt AS DATE) ,d_date) END AS application_age_in_caldays
FROM (SELECT  r.reg_id application_id, 
               wc.process_id,
               cn.cancel_notice_dt,      
               COALESCE(rpt.provider_type_name,'Unavailable') AS provider_type,
               rpt.mmis_provider_type_id AS provider_type_code_mmis,
               CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group,
               COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS  process_start_dt, 
               COALESCE(cn.cancel_notice_dt,comp.application_process_end_dt) AS  process_end_dt,
               RANK() OVER(PARTITION BY r.reg_id ORDER BY COALESCE(cn.cancel_notice_dt,comp.application_process_end_dt, wc.end_date_time) ) prnk,
               CASE WHEN COALESCE(cn.cancel_notice_dt,comp.application_process_end_dt, wc.end_date_time) IS NOT NULL THEN ra.application_status ELSE NULL END application_status               
       FROM  ohpnm_dp4bi_dev.registration r 
         JOIN ohpnm_dp4bi_dev.reg_provider rp ON r.reg_id = rp.reg_id
         LEFT JOIN ohpnm_dp4bi_dev.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id
         JOIN  (SELECT *
                FROM (SELECT wc.process_id, parameter_value,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.start_date_time) start_date_time,
                             CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.end_date_time) end_date_time,
                             RANK() OVER (PARTITION BY parameter_value ORDER BY wp.process_id DESC) prnk
                       FROM ohpnm_dp4bi_dev.wf_parameter wp
                         JOIN ohpnm_dp4bi_dev.wf_process wc  ON wc.process_id = wp.process_id AND wc.workflow_id = 1
                       WHERE parameter_name = 'REGISTRATION_ID')
                WHERE prnk = 1) wc ON wc.parameter_value = TO_CHAR(r.reg_id)                      
         LEFT JOIN (SELECT *
                    FROM(SELECT ra.reg_id, ras.application_status_desc application_status, RANK() OVER (PARTITION BY ra.reg_id ORDER BY ra.reg_application_id) srnk
                         FROM ohpnm_dp4bi_dev.reg_application ra
                           JOIN ohpnm_dp4bi_dev.application_status ras ON ra.pnm_application_status_id = ras.application_status_id)
                    WHERE srnk = 1) ra ON r.reg_id = ra.reg_id                                     
         LEFT JOIN (SELECT *
                    FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_received_notice_sent_dt, 
		                        RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			              FROM ohpnm_dp4bi_dev.wf_step s  
			                JOIN ohpnm_dp4bi_dev.wf_task t ON s.task_id = t.task_id
			              WHERE t.name = 'Application Received Notice') tmp
			        WHERE rnk = 1) arn ON arn.process_id = wc.process_id
         LEFT JOIN(SELECT cec.reg_id,cec.communication_event_id, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',cec.communication_event_date_time) cancel_notice_dt  
                   FROM ohpnm_dp4bi_dev.communication_event cec  
                      LEFT JOIN ohpnm_dp4bi_dev.email e  ON e.communication_event_id = cec.communication_event_id
                      LEFT JOIN ohpnm_dp4bi_dev.mail m  ON m.communication_event_id = cec.communication_event_id                   
                   WHERE COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt' ) cn ON r.reg_id = cn.reg_id AND cn.cancel_notice_dt > COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time)                     
         LEFT JOIN (SELECT *
                    FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_process_end_dt, 
		                          RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
		                  FROM ohpnm_dp4bi_dev.wf_step s  
			                JOIN ohpnm_dp4bi_dev.wf_task t ON s.task_id = t.task_id
			              WHERE UPPER(t.name) IN('COMPLETE WORKFLOW','COMPLETEWORKFLOW')) tmp
			        WHERE rnk = 1) comp ON wc.process_id = comp.process_id         
                ) pcbd
  JOIN d_dates dd ON dd.d_date >= CAST(pcbd.process_start_dt AS DATE) AND dd.d_date <= CAST(COALESCE(pcbd.process_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)
WHERE prnk = 1)
SELECT curinv.d_date,
       curinv.application_id,
       curinv.provider_type,
       curinv.provider_type_code_mmis,
       curinv.operational_group,       
       curinv.application_status,
       curinv.creation_count,  
       curinv.inventory_count,
       curinv.completion_count,
       curinv.cancellation_count,    
       CASE WHEN wiq.d_date IS NOT NULL THEN 1 ELSE 0 END AS waiting_in_queue,
       curtask.task_name AS inventory_task_name,
       curinv.application_age_in_caldays
FROM curinv       
  LEFT JOIN (SELECT dd.d_date,process_id,t.step_id,t.name,t.start_date_time,t.date_of_action,assigned_to_dt
             FROM(SELECT *
                  FROM(SELECT t.process_id,t.step_id,t.task_id, tt.name, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ht.start_date_time) start_date_time,
                   CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ht.DateofAction) date_of_action, RANK() OVER(PARTITION BY t.process_id,t.step_id ORDER BY ht.a_wf_step_id) hrnk,
                   CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',FIRST_VALUE(ht.DateofAction) OVER (PARTITION BY ht.process_id,ht.step_id,ht.owner_id ORDER BY ht.a_wf_step_id)) assigned_to_dt
                  FROM ohpnm_dp4bi_dev.wf_step t
                    JOIN ohpnm_dp4bi_dev.wf_task tt ON t.task_id = tt.task_id
                    JOIN ohpnm_dp4bi_dev.a_wf_step ht ON t.step_id = ht.step_id
                 WHERE tt.task_type = 'Queue')  
             WHERE hrnk = 1)  t
          JOIN d_dates dd ON   dd.d_date >= CAST(COALESCE(t.start_date_time,date_of_action) AS DATE) AND dd.d_date < CAST(COALESCE(t.assigned_to_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)) wiq ON wiq.process_id = curinv.process_id AND wiq.d_date = curinv.d_date 
  LEFT JOIN (SELECT *
             FROM(SELECT dd.d_date,t.*, RANK() OVER (PARTITION BY t.process_id,dd.d_date ORDER BY t.step_id DESC) rnk
                  FROM (SELECT p.process_id, t.step_id, tt.name task_name, tt.task_type,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time)) start_date_time, 
                          CASE WHEN t.end_date_time IS NULL AND LEAD(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time))) OVER (PARTITION BY t.process_id ORDER BY t.step_id) IS NOT NULL THEN
                            LEAD(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(t.start_date_time,t.create_date_time))) OVER (PARTITION BY t.process_id ORDER BY t.step_id)  ELSE CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',t.end_date_time) END end_date_time
                        FROM ohpnm_dp4bi_dev.wf_process p
                          JOIN ohpnm_dp4bi_dev.wf_step t ON p.process_id = t.process_id
                          JOIN ohpnm_dp4bi_dev.wf_task tt ON t.task_id = tt.task_id                                    
                        WHERE tt.task_type = 'Queue' ) t
                    JOIN d_dates dd ON   dd.d_date >= CAST(t.start_date_time AS DATE) AND dd.d_date <=  CAST(COALESCE(t.end_date_time, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE) 
                  )
             WHERE rnk = 1) curtask ON curtask.process_id = curinv.process_id AND curtask.d_date = curinv.d_date;