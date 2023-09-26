CREATE OR REPLACE VIEW PUBLIC.PM_F_PROVIDER_CREDENTIAL_BY_DAY_SV
AS
SELECT d_date,
  COUNT(DISTINCT creation_reg_id) creation_count,
  COUNT(DISTINCT inventory_reg_id) inventory_count,
  COUNT(DISTINCT completion_reg_id) completion_count,
  0 cancellation_count,
  COUNT(DISTINCT termination_reg_id) termination_count,
  COUNT(DISTINCT assigned_to_reg_id) assigned_count,  
  COUNT(DISTINCT unassigned_reg_id) unassigned_count,
  COUNT(DISTINCT reassigned_reg_id) reassigned_count,
  COUNT(DISTINCT rtp_reg_id) return_to_provider_count  
  --end stubbed fields
FROM(
SELECT dd.d_date,pcbd.*,
  CASE WHEN CAST(pcbd.pc_start_dt AS DATE)= dd.d_date THEN pcbd.reg_id ELSE NULL END creation_reg_id,  
  CASE WHEN d_date = CAST(pcbd.pc_end_dt AS DATE) THEN NULL ELSE pcbd.reg_id END AS inventory_reg_id,
  CASE WHEN d_date = CAST(pcbd.pc_end_dt AS DATE) THEN pcbd.reg_id ELSE NULL END AS completion_reg_id,
  CASE WHEN d_date = CAST(pcbd.pc_end_dt AS DATE) THEN pcbd.reg_id ELSE NULL END AS termination_reg_id,
  CASE WHEN d_date = CAST(pcbd.start_date_time AS DATE) AND pcbd.owner_id IS NOT NULL THEN pcbd.reg_id ELSE NULL END assigned_to_reg_id,
  CASE WHEN d_date = CAST(pcbd.start_date_time AS DATE) AND pcbd.owner_id IS NULL THEN pcbd.reg_id ELSE NULL END unassigned_reg_id,
  CASE WHEN d_date = CAST(pcbd.reassigned_to_ts AS DATE) AND pcbd.reassigned_to IS NOT NULL THEN pcbd.reg_id ELSE NULL END reassigned_reg_id,
  CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) AND pcbd.cs_action_rtp IS NOT NULL THEN pcbd.reg_id ELSE NULL END rtp_reg_id
FROM (SELECT r.reg_id, convert_timezone('UTC', 'America/Los_Angeles',c.start_date_time) pc_start_dt, convert_timezone('UTC', 'America/Los_Angeles',c.end_date_time) pc_end_dt,
             convert_timezone('UTC', 'America/Los_Angeles',ws.assigned_to_ts) start_date_time,convert_timezone('UTC', 'America/Los_Angeles',ws.end_date_time) end_date_time,ws.owner_id,
             --CASE WHEN ws.cs_credentialing_type = cws.credentialing_type THEN NULL ELSE cws.reassigned_to END reassigned_to,
             --CASE WHEN ws.cs_credentialing_type = cws.credentialing_type THEN NULL ELSE convert_timezone('UTC', 'America/Los_Angeles',cws.reassigned_to_ts) END reassigned_to_ts
             CASE WHEN csp.process_id IS NOT NULL THEN csp.csp_assigned_to ELSE NULL END reassigned_to,
             CASE WHEN csp.process_id IS NOT NULL THEN csp.csp_cr_end_dt ELSE NULL END reassigned_to_ts,
             CASE WHEN ws.cs_action = 'Return to Provider' THEN ws.cs_action ELSE NULL END cs_action_rtp
      FROM ohpnm_dp4bi.registration r
        JOIN ohpnm_dp4bi.wf_parameter wp ON wp.parameter_value = r.reg_id AND parameter_name = 'REGISTRATION_ID' 
        JOIN ohpnm_dp4bi.reg_credentialing rc ON r.reg_id = rc.reg_id 
        JOIN ohpnm_dp4bi.credentialing c ON rc.credentialing_id = c.credentialing_id
        --start CS queue
        LEFT JOIN (SELECT *
                   FROM (SELECT curws.process_id,curws.owner_id,curws.start_date_time assigned_to_ts,
	                        curtsk.name cs_credentialing_type, curws.end_date_time, wa.name cs_action,
	                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
	                     FROM ohpnm_dp4bi.wf_step curws -- current task 			    
					        JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
					        JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					        JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
					        JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action			   
                        WHERE curtsk.name IN('Provider Credentialing','Provider Credentialing ODM')   ) s 
                    WHERE s.rnk = 1) ws ON wp.process_id = ws.process_id
        --current queue 
        LEFT JOIN (SELECT *
                   FROM(SELECT s.process_id,s.owner_id,s.start_date_time reassigned_to_ts,s.owner_id reassigned_to, t.name credentialing_type,
	                            RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id DESC) rnk			       
	                    FROM ohpnm_dp4bi.wf_step s
			              JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id			   			    
                        WHERE t.task_type = 'Queue'  ) s                    
	                WHERE s.rnk = 1) cws ON wp.process_id = cws.process_id
        LEFT JOIN (SELECT *
                   FROM (SELECT curws.process_id,curws.start_date_time csp_cr_start_dt
                               ,convert_timezone('UTC', 'America/Los_Angeles',curws.end_date_time) csp_cr_end_dt
                               ,wa.name csp_action, ua.contact_name csp_assigned_to
                               ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk					
				         FROM ohpnm_dp4bi.wf_step  curws -- current task 			    
					        JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
					        JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					        JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
					        JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action	
					        LEFT JOIN ohpnm_dp4bi.user_account_information ua ON curws.owner_id = ua.UserId						
				        WHERE curtsk.name IN ('Credentialing Supervisor Review')
                        AND wa.name = 'Return To Credentialing Specialist')
                   WHERE rnk = 1) csp ON wp.process_id = csp.process_id 
      
      
      
) pcbd
JOIN d_dates dd ON dd.d_date >= CAST(pcbd.pc_start_dt AS DATE) AND dd.d_date <= CAST(COALESCE(pcbd.pc_end_dt,CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)
) t
GROUP BY d_date;