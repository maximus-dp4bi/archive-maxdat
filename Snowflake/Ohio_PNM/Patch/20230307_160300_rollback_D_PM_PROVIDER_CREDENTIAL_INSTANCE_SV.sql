create or replace view D_PM_PROVIDER_CREDENTIAL_INSTANCE_SV(
	APPLICATION_ID,
	PROCESS_ID,
	FILE_ID,
	FILE_AGE,
	ASSIGNED_TO_USER_NAME,
	ASSIGNED_TO_USER_TYPE,
	ASSIGNED_TO_TS,
	PROVIDER_ID,
	OPERATIONAL_GROUP,
	CREDENTIALING_STATUS,
	CREDENTIALING_TYPE,
	RESPONSIBLE_PARTY,
	DATE_CREDENTIALING,
	TIME_CREDENTIALING,
	REASSIGNED_NAME,
	REASSIGNED_TYPE,
	REASSIGNED_TS,
	ACTION_TIME,
	REQUEST_NUMBER,
	RECOMMENDED_LEVEL,
	FINAL_DECISION,
	FINAL_DECISION_DT,
	FIRST_INPROCESS_DT,
	CREDENTIALING_END_DATETIME,
	ODM_CREDENTIALING_REVIEW_START_DT,
	ODM_CREDENTIALING_REVIEW_END_DT,
	COMMITTEE_REVIEW_START_DT,
	COMMITTEE_REVIEW_END_DT,
	QUALITY_REVIEW_START_DT,
	QUALITY_REVIEW_END_DT,
	PRIOR_CREDENTIALING_STATUS,
	PRIOR_CREDENTIALING_QUEUE,
	SUPERVISOR_REASSIGNED_TO,
	CS_ACTION,
	CS_ACTION_DT,
	QS_ASSIGNED_TO,
	QS_ACTION,
	QS_ACTION_DT,
	CSP_ASSIGNED_TO,
	CSP_ACTION,
	CSP_ACTION_DT,
	ODM_CREDENTIAL_ASSIGNED_TO,
	PRIOR_QUEUE_BEFORE_ODM,
	ODM_ACTION,
	ODM_ACTION_DT,
	INITIAL_QA_RESULT_DT,
	INITIAL_QA_RESULT,
	INITIAL_FAILED_BY_USER,
	APPROVED_BY_AFTER_FAIL,
	SUPERVISOR_REVIEW_START_DT,
	SUPERVISOR_REVIEW_END_DT,
	RECOMMENDED_RISK_LEVEL_DT,
	PENDING_VERIFICATION_CHECKED_DT,
	PENDING_VERIFICATION_UNCHECKED_DT,
	IN_PROCESS_AFTER_PEND_VERIFICATION_START_DT,
	IN_PROCESS_AFTER_PEND_VERIFICATION_END_DT,
	SLA_CYCLE_TIME,
	CS_QUEUE_FINAL_DECISION_TAT,
	CS_ASSIGNED_FINAL_DECISION_TAT,
	CURRENT_CREDENTIALING_QUEUE_TAT,
	CURRENT_CREDENTIALING_STATUS_TAT,
	CS_QUEUE_TO_ASSIGNED_TAT,
	CS_QUEUE_UNASSIGNED_TAT,
	CREDQUEUE_CREDENTIALING_SPECIALIST_INDICATOR,
	CURRENT_QUEUE_CREDENTIALING_SPECIALIST_INDICATOR,
	SLA_CYCLE_TIME_GROUP
) as 
WITH provider_credential AS(
SELECT r.reg_id application_id  
   ,rc.process_id
  ,rc.reg_credentialing_id file_id  
  ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
      OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
    THEN DATEDIFF(second,COALESCE(minstepid.ipcs_start_date_time,wspc.cs_start_date_time,rc.start_date_time),COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time))
   ELSE DATEDIFF(second,COALESCE(minstepid.ipcs_start_date_time,wspc.cs_start_date_time,rc.start_date_time),CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) END AS file_age
  ,wspc.assigned_to_user_name
  ,NULL AS assigned_to_user_type 
  --,wspc.RoleName AS assigned_to_user_type 
  ,CASE WHEN wspc.assigned_to_user_name IS NOT NULL THEN wspc.assigned_to_ts ELSE NULL END AS assigned_to_ts
  ,rp.reg_id provider_id
  ,CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group 
  --,CASE WHEN wspc.cs_credentialing_type = 'Provider Credentialing ODM' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END operational_group
  ,rc.credentialing_status_name AS credentialing_status
  ,ws.credentialing_type    
  ,CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS responsible_party 
  --,c.start_date_time date_credentialing
  ,COALESCE(minstepid.ipcs_start_date_time,wspc.cs_start_date_time,rc.start_date_time) AS date_credentialing
  ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
      OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
    THEN DATEDIFF(second,COALESCE(minstepid.ipcs_start_date_time,wspc.cs_start_date_time,rc.start_date_time),COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time))   
   ELSE NULL END AS time_credentialing
  ,CASE WHEN ws.credentialing_type = wspc.cs_credentialing_type THEN NULL ELSE ws.reassigned_to_user_name END reassigned_name
  ,NULL AS reassigned_type
  --,ws.reassigned_to_user_type AS reassigned_type
  ,CASE WHEN ws.credentialing_type = wspc.cs_credentialing_type THEN NULL ELSE ws.reassigned_to_ts END AS reassigned_ts
  ,DATEDIFF(second,ws.reassigned_to_ts,cur_user_action_dt) action_time  
  ,crq.request_number
  ,CASE WHEN prl.provider_risk_level_name = 'Undefined' THEN NULL ELSE prl.provider_risk_level_name END AS recommended_level
  ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
      OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
    THEN rc.credentialing_status_name ELSE NULL END AS final_decision
  ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
     OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
    THEN COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time) ELSE NULL END AS final_decision_dt
  ,acip.first_inprocess_dt
  ,wspc.cs_end_date_time AS credentialing_end_datetime
  ,ocr.odm_cr_start_dt AS odm_credentialing_review_start_dt
  ,ocr.odm_cr_end_dt AS odm_credentialing_review_end_dt
  ,ccr.cc_cr_start_dt AS committee_review_start_dt
  ,ccr.cc_cr_end_dt AS committee_review_end_dt
  ,cqr.cqr_cr_start_dt AS quality_review_start_dt
  ,cqr.cqr_cr_end_dt AS quality_review_end_dt
  ,pcs.prior_credentialing_status
  ,ws.prior_credentialing_queue
  ,CASE WHEN csr.csp_action = 'Return To Credentialing Specialist' THEN csr.csp_assigned_to ELSE NULL END AS supervisor_reassigned_to  
  ,wspc.cs_action
  ,wspc.cs_end_date_time AS cs_action_dt
  ,cqr.qs_assigned_to  
  ,COALESCE(cqr.qs_action,cqr.initial_qs_action) AS qs_action
  ,COALESCE(cqr.qs_action_dt,cqr.cqr_cr_end_dt) AS qs_action_dt
  ,csr.csp_assigned_to
  ,csr.csp_action
  ,csr.csp_cr_end_dt AS csp_action_dt
  ,ocr.odm_credential_assigned_to
  ,ocr.prior_queue_before_odm
  ,ocr.odm_action
  ,ocr.odm_cr_end_dt AS odm_action_dt  
  ,cqr.cqr_cr_end_dt AS initial_qa_result_dt
  ,cqr.initial_qs_action AS initial_qa_result
  ,cqr.initial_failed_by_user
  ,cqr.qs_assigned_to AS approved_by_after_fail  
  ,csr.csp_cr_start_dt AS supervisor_review_start_dt
  ,csr.csp_cr_end_dt AS supervisor_review_end_dt  
  ,rl.recommended_risk_level_dt
  ,acpp.pending_verification_checked_dt
  ,acpp.ip_after_pending_process_start_dt AS pending_verification_unchecked_dt
  ,acpp.ip_after_pending_process_start_dt AS in_process_after_pend_verification_start_dt
  ,acpp.ip_after_pending_process_end_dt AS in_process_after_pend_verification_end_dt
  ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
                 OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
        THEN (DATEDIFF(second,COALESCE(rc.start_date_time,minstepid.ipcs_start_date_time,wspc.cs_start_date_time),COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time)) - COALESCE(DATEDIFF(second,ocr.odm_cr_start_dt,ocr.odm_cr_end_dt),0))
   ELSE NULL END AS sla_cycle_time
  --,DATEDIFF(second,wspc.cs_start_date_time,
   ,DATEDIFF(second,COALESCE(minstepid.ipcs_start_date_time,wspc.cs_start_date_time),
              CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
                 OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
               THEN COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time)  ELSE NULL END) AS cs_queue_final_decision_tat
  ,DATEDIFF(second,CASE WHEN wspc.assigned_to_user_name IS NOT NULL THEN wspc.assigned_to_ts ELSE NULL END,
              CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
                 OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') 
               THEN COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time)  ELSE NULL END) AS cs_assigned_final_decision_tat
  ,DATEDIFF(second,ws.cur_queue_start_dt, COALESCE(ws.cur_queue_end_dt,CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))) AS current_credentialing_queue_tat
  ,DATEDIFF(second,pcs.cur_status_start_dt, CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
                 OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') THEN cur_status_end_dt ELSE CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()) END) AS current_credentialing_status_tat
  ,CASE WHEN ws.reassigned_to_user_name IS NOT NULL THEN DATEDIFF(second,ws.cur_queue_start_dt, ws.reassigned_to_ts) ELSE NULL END AS cs_queue_to_assigned_tat
  ,CASE WHEN ws.reassigned_to_user_name IS NULL THEN DATEDIFF(second,ws.cur_queue_start_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) ELSE NULL END AS cs_queue_unassigned_tat
  ,wspc.credqueue_Credentialing_Specialist_Indicator --CS 
  ,ws.current_queue_Credentialing_Specialist_Indicator
FROM OHPNM_DP4BI.registration r
 JOIN (SELECT *
   FROM (SELECT r.reg_id,r.reg_credentialing_id,r.credentialing_id, cr.credentialing_status_id,cs.credentialing_status_name,risk_level_id, cr.workflow_id,p.process_id,ws.step_id
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',cr.start_date_time) start_date_time
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',cr.end_date_time) end_date_time
               ,RANK() OVER (PARTITION BY r.reg_id ORDER BY p.process_id DESC) prnk
               ,CASE WHEN cs.credentialing_status_name = 'Administrative Termination' THEN 'Admin Terminate' 
                                  WHEN cs.credentialing_status_name = 'Administrative Denial' THEN 'Admin Deny' ELSE NULL END status_action_xref
         FROM OHPNM_DP4BI.reg_credentialing r
           JOIN OHPNM_DP4BI.credentialing cr ON r.credentialing_id = cr.credentialing_id
           JOIN OHPNM_DP4BI.credentialing_status cs ON cr.credentialing_status_id = cs.credentialing_status_id
           JOIN OHPNM_DP4BI.wf_step ws ON cr.step_id = ws.step_id
           JOIN OHPNM_DP4BI.wf_process p ON ws.process_id = p.process_id )
    WHERE prnk = 1) rc ON r.reg_id = rc.reg_id
 JOIN OHPNM_DP4BI.provider_risk_level prl ON rc.risk_level_id = prl.provider_risk_level_id
 JOIN OHPNM_DP4BI.reg_provider rp ON r.reg_id = rp.reg_id
 LEFT JOIN OHPNM_DP4BI.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id
 --current queue
 LEFT JOIN (SELECT s.*,pt.name prior_credentialing_queue
       FROM (SELECT s.process_id,s.owner_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.create_date_time) cur_queue_start_dt
                   ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) cur_queue_end_dt
                   ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ua.DateOfAction) reassigned_to_ts,ua.contact_name reassigned_to_user_name,t.name credentialing_type
                   ,CASE WHEN wa.name IS NOT NULL THEN CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) ELSE NULL END cur_user_action_dt
                   ,RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id DESC, wa.action_id DESC,ua.a_wf_step_id) rnk
                   ,LAG(s.step_id) OVER (PARTITION BY s.process_id ORDER BY s.step_id) prior_step		   
                   ,current_queue_Credentialing_Specialist_Indicator
	         FROM OHPNM_DP4BI.wf_step s
			   JOIN OHPNM_DP4BI.wf_task t ON s.task_id = t.task_id		
               LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = s.step_id --next task
               LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
               LEFT JOIN OHPNM_DP4BI.wf_action wa ON wa.task_id = t.task_id AND wa.next_task_id = nextsk.task_id 
			   LEFT JOIN (SELECT hwf.a_wf_step_id,hwf.step_id,hwf.owner_id, ua.contact_name,hwf.DateOfAction--,RANK() OVER (PARTITION BY hwf.step_id ORDER BY hwf.a_wf_step_id) rnk
                           , CASE WHEN EXISTS(SELECT 1 FROM OHPNM_DP4BI.aspnet_usersinroles ur LEFT JOIN OHPNM_DP4BI.aspnet_roles r on ur.roleid = r.roleid WHERE ua.userid = ur.userid AND (r.rolename = 'CredentialingSpecialist' or r.rolename = 'CredentialingQualityAssurance' or r.rolename = 'CredentialingSupervisor'))
                                  THEN 'Y' ELSE 'N' END current_queue_Credentialing_Specialist_Indicator
						  FROM OHPNM_DP4BI.a_wf_step hwf
							JOIN OHPNM_DP4BI.wf_task wf ON hwf.task_id = wf.task_id
							JOIN OHPNM_DP4BI.user_account_information ua ON hwf.owner_id = ua.UserId) ua ON s.step_id = ua.step_id AND s.owner_id = ua.owner_id			   
             WHERE t.task_type = 'Queue'
			   ) s 
          LEFT JOIN OHPNM_DP4BI.wf_step ps ON s.prior_step = ps.step_id
		  LEFT JOIN OHPNM_DP4BI.wf_task pt ON ps.task_id = pt.task_id
	   WHERE s.rnk = 1) ws ON rc.process_id = ws.process_id
 --CS queue    
 LEFT JOIN (SELECT *
       FROM (SELECT curws.process_id,credqueue_Credentialing_Specialist_Indicator,curws.owner_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ua.DateOfAction) assigned_to_ts,ua.contact_name assigned_to_user_name
                    ,curtsk.name cs_credentialing_type,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) cs_start_date_time
                    ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) cs_end_date_time, wa.name cs_action
                    ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
             FROM OHPNM_DP4BI.wf_step curws -- current task 			    
              LEFT JOIN OHPNM_DP4BI.wf_task curtsk ON curws.task_id = curtsk.task_id 
              LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
              LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
              LEFT JOIN OHPNM_DP4BI.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action
              LEFT JOIN (SELECT *
                          FROM(SELECT hwf.step_id,hwf.owner_id, ua.contact_name,hwf.DateOfAction,
                      			RANK() OVER (PARTITION BY hwf.step_id ORDER BY hwf.a_wf_step_id) rnk,
                                 CASE WHEN EXISTS(SELECT 1 FROM OHPNM_DP4BI.aspnet_usersinroles ur LEFT JOIN OHPNM_DP4BI.aspnet_roles r on ur.roleid = r.roleid WHERE ua.userid = ur.userid AND (r.rolename = 'CredentialingSpecialist' or r.rolename = 'CredentialingQualityAssurance' or r.rolename = 'CredentialingSupervisor'))
                                  THEN 'Y' ELSE 'N' END credqueue_Credentialing_Specialist_Indicator
                    		FROM OHPNM_DP4BI.a_wf_step hwf
                    			JOIN OHPNM_DP4BI.wf_task wf ON hwf.task_id = wf.task_id
                    			JOIN OHPNM_DP4BI.user_account_information ua ON hwf.owner_id = ua.UserId
                                -- LEFT JOIN aspnet_usersinroles ur on ua.userid = ur.userid
                                -- LEFT JOIN aspnet_roles r on ur.roleid = r.roleid AND r.rolename = 'CredentialingSpecialist'
                                ) ua                                
                    		WHERE rnk = 1)	ua ON curws.step_id = ua.step_id			                
              WHERE curtsk.name IN('Provider Credentialing','Provider Credentialing ODM')
                ) s 
        WHERE s.rnk = 1) wspc ON rc.process_id = wspc.process_id 
--In Process Status
LEFT JOIN (SELECT *
            FROM (SELECT aac.credentialing_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',aac.DateOfAction) first_inprocess_dt
                     ,RANK() OVER (PARTITION BY aac.credentialing_id ORDER BY aac.a_credentialing_id) rnk
                  FROM OHPNM_DP4BI.a_credentialing aac 
                   JOIN OHPNM_DP4BI.credentialing_status acs ON acs.credentialing_status_id = aac.credentialing_status_id
                  WHERE acs.credentialing_status_name = 'In Process') aac
			WHERE rnk = 1) acip ON rc.credentialing_id = acip.credentialing_id
--Pending Process Status      
LEFT JOIN (SELECT *
            FROM (SELECT aac.credentialing_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',aac.DateOfAction) pending_verification_checked_dt
			         ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',nip.ip_after_pending_process_start_dt) ip_after_pending_process_start_dt               
					 ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',nip.ip_after_pending_process_end_dt) ip_after_pending_process_end_dt
				     ,RANK() OVER (PARTITION BY aac.credentialing_id ORDER BY aac.a_credentialing_id) rnk
                  FROM OHPNM_DP4BI.a_credentialing aac 
                   JOIN OHPNM_DP4BI.credentialing_status acs ON acs.credentialing_status_id = aac.credentialing_status_id	
				   LEFT JOIN (SELECT *
							  FROM (SELECT aac.credentialing_id,aac.DateOfAction ip_after_pending_process_start_dt
                    ,COALESCE(LEAD(aac.DateOfAction) OVER(PARTITION BY aac.credentialing_id ORDER BY aac.a_credentialing_id),aac.DateOfAction) ip_after_pending_process_end_dt
									  ,RANK() OVER (PARTITION BY aac.credentialing_id ORDER BY aac.a_credentialing_id DESC) rnk
									FROM OHPNM_DP4BI.a_credentialing aac 
									 JOIN OHPNM_DP4BI.credentialing_status acs ON acs.credentialing_status_id = aac.credentialing_status_id				   
									WHERE acs.credentialing_status_name = 'In Process') aac
							  WHERE rnk = 1) nip ON nip.credentialing_id = aac.credentialing_id AND nip.ip_after_pending_process_start_dt > aac.DateOfAction
                  WHERE acs.credentialing_status_name = 'Pending Process') aac
			WHERE rnk = 1) acpp ON rc.credentialing_id = acpp.credentialing_id 
--Number of Addtl info sent      
 LEFT JOIN (SELECT ws.process_id,count(1) request_number
			FROM OHPNM_DP4BI.wf_step ws 
			    LEFT JOIN OHPNM_DP4BI.wf_step cws ON ws.calling_step_id = cws.step_id
				LEFT JOIN OHPNM_DP4BI.wf_task t ON cws.task_id = t.task_id
				LEFT JOIN OHPNM_DP4BI.wf_task nt ON ws.task_id = nt.task_id
			WHERE t.name IN ('Provider Credentialing','Provider Credentialing ODM')
			AND nt.name = 'Send Request for Additional Information (RTP Notice)'
			GROUP BY ws.process_id) crq ON crq.process_id =	rc.process_id	
--ODM Cred Review Queue      
 LEFT JOIN (SELECT *
            FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) odm_cr_start_dt
                       ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) odm_cr_end_dt
                       ,wa.name odm_action,prevtsk.name prior_queue_before_odm, ua.contact_name odm_credential_assigned_to
                       ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
				  FROM OHPNM_DP4BI.wf_step curws -- current task 			    
					LEFT JOIN OHPNM_DP4BI.wf_task curtsk ON curws.task_id = curtsk.task_id 
					LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
					LEFT JOIN OHPNM_DP4BI.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action
					LEFT JOIN OHPNM_DP4BI.wf_step prevws ON prevws.step_id = curws.calling_step_id --previous task
					LEFT JOIN OHPNM_DP4BI.wf_task prevtsk ON prevws.task_id = prevtsk.task_id
					LEFT JOIN OHPNM_DP4BI.user_account_information ua ON curws.owner_id = ua.UserId	
				  WHERE curtsk.name IN ('ODM Credentialing Review')	) tmp
			WHERE rnk = 1) ocr ON ocr.process_id =	rc.process_id	
--Committee Review Queue
 LEFT JOIN (SELECT *
            FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) cc_cr_start_dt
                    ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) cc_cr_end_dt, wa.name ccr_action
                    ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
				  FROM OHPNM_DP4BI.wf_step curws -- current task 			    
					LEFT JOIN OHPNM_DP4BI.wf_task curtsk ON curws.task_id = curtsk.task_id 
					LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
					LEFT JOIN OHPNM_DP4BI.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action								
				  WHERE curtsk.name IN ('Credentialing Committee Review')	) tmp
			WHERE rnk = 1) ccr ON ccr.process_id =	rc.process_id	
--Quality Review Queue      
 LEFT JOIN (SELECT *
            FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) cqr_cr_start_dt
                        ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) cqr_cr_end_dt
                        ,wa.name initial_qs_action, CASE WHEN wa.name = 'QA Fail' THEN ua.contact_name ELSE NULL END initial_failed_by_user
                        ,LEAD(wa.name) OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) qs_action
                        ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', LEAD(curws.start_date_time) OVER (PARTITION BY curws.process_id ORDER BY curws.step_id)) qs_action_dt
                        ,LEAD(ua.contact_name) OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) qs_assigned_to
                        ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk					
				  FROM OHPNM_DP4BI.wf_step curws -- current task 			    
					LEFT JOIN OHPNM_DP4BI.wf_task curtsk ON curws.task_id = curtsk.task_id 
					LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
					LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM OHPNM_DP4BI.wf_action w) wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id AND wa.action_rnk = 1--current task action	
					LEFT JOIN OHPNM_DP4BI.user_account_information ua ON curws.owner_id = ua.UserId						
				  WHERE curtsk.name IN ('Credentialing Quality Review')	) tmp
			WHERE rnk = 1) cqr ON cqr.process_id =	rc.process_id	
--Supervisor Review Queue      
 LEFT JOIN (SELECT *
            FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) csp_cr_start_dt
                    ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', curws.end_date_time) csp_cr_end_dt
                    ,wa.name csp_action, ua.contact_name csp_assigned_to,action_rnk
                    ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk					
				  FROM OHPNM_DP4BI.wf_step curws -- current task 			    
					LEFT JOIN OHPNM_DP4BI.wf_task curtsk ON curws.task_id = curtsk.task_id 
					LEFT JOIN OHPNM_DP4BI.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					LEFT JOIN OHPNM_DP4BI.wf_task nextsk ON nextws.task_id = nextsk.task_id
					LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM OHPNM_DP4BI.wf_action w) wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action	
					LEFT JOIN OHPNM_DP4BI.user_account_information ua ON curws.owner_id = ua.UserId						
				  WHERE curtsk.name IN ('Credentialing Supervisor Review')	) tmp
			WHERE rnk = 1) csr ON csr.process_id =	rc.process_id AND (csr.csp_action = rc.status_action_xref OR (csr.csp_action NOT IN('Admin Terminate','Admin Deny') AND csr.action_rnk = 1))
--First Risk Level Date
 LEFT JOIN (SELECT *
			FROM (SELECT credentialing_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', DateOfAction) recommended_risk_level_dt,step_id,risk_level_id, RANK() OVER(PARTITION BY credentialing_id, step_id ORDER BY a_credentialing_id) rlrnk
				  FROM OHPNM_DP4BI.a_credentialing ) rl
		   WHERE rl.rlrnk = 1) rl ON rl.credentialing_id = rc.credentialing_id AND rl.step_id = rc.step_id
 LEFT JOIN (SELECT *
			FROM (SELECT credentialing_id, ac.credentialing_status_id,cs.credentialing_status_name, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ac.DateOfAction) cur_status_start_dt
                    ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',COALESCE(LEAD(ac.DateOfAction) OVER(PARTITION BY ac.credentialing_id ORDER BY ac.a_credentialing_id),ac.DateOfAction) ) cur_status_end_dt                    
                    ,RANK() OVER(PARTITION BY credentialing_id ORDER BY a_credentialing_id DESC) prnk
			        ,LAG(cs.credentialing_status_name) OVER(PARTITION BY credentialing_id ORDER BY a_credentialing_id) prior_credentialing_status
				  FROM OHPNM_DP4BI.a_credentialing  ac
				    JOIN OHPNM_DP4BI.credentialing_status cs ON ac.credentialing_status_id = cs.credentialing_status_id) pcs
		   WHERE pcs.prnk = 1) pcs ON pcs.credentialing_id = rc.credentialing_id AND rc.credentialing_status_id = pcs.credentialing_status_id
           LEFT JOIN (SELECT *
                        FROM (SELECT mws.process_id, MIN(mws.step_id) OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) min_step_id,RANK() OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) rnk,
                                CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',mws.create_date_time) ipcs_start_date_time
                                ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',mws.end_date_time) ipcs_end_date_time
                              FROM OHPNM_DP4BI.wf_step mws 
                               JOIN OHPNM_DP4BI.wf_task mwt ON mws.task_id = mwt.task_id
                              WHERE mwt.name IN('Initiate Provider Credentialing'))
                        WHERE rnk = 1)  minstepid ON minstepid.process_id = rc.process_id          
WHERE minstepid.min_step_id IS NOT NULL
)
SELECT pr.*
,CASE WHEN sla_cycle_time/86400 <= 30 THEN 'SLA in 30 Days'
        WHEN sla_cycle_time/86400 > 30 AND sla_cycle_time/86400 <= 60 THEN 'SLA in 60 Days'
		WHEN sla_cycle_time/86400 > 60 AND sla_cycle_time/86400 <= 90 THEN 'SLA in 90 Days'
        WHEN sla_cycle_time/86400 > 90 THEN 'SLA greater than 90 Days' 
	ELSE NULL END sla_cycle_time_group    
FROM provider_credential pr;