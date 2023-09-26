create or replace view OHIO_PROVIDER_DP4BI_PROD_DB.PUBLIC.D_PM_PROVIDER_CREDENTIAL_PROCESS_HISTORY_SV(
	APPLICATION_ID,
	PROCESS_ID,
	STEP_HISTORY_ID,
	CURRENT_STEP_ID,
	CURRENT_TASK_ID,
	CURRENT_TASK_NAME,
	CURRENT_TASK_TYPE,
	CURRENT_STEP_START_DT,
	CURRENT_STEP_END_DT,
	NEXT_STEP_ID,
	NEXT_TASK_ID,
	NEXT_TASK_NAME,
	NEXT_TASK_TYPE,
	STEP_UPDATE_DT,
	OWNER_ID,
	ASSIGNED_TO,
	STEP_CREATE_DT,
	TASK_ACTION,
	CHANGE_OPERATION,
	APPLICATION_ID_WITH_ACTION,
	USER_ACTION_TAT,
	ASSIGNED_TO_DT,
	OPERATIONAL_GROUP,
	CS_REASSIGNED_TO,
	RETURN_TO_PROVIDER_COUNTER,
	RTP_RESPONSE_RECEIVED_TAT,
	RECOMMENDED_RISK_LEVEL,
	DERIVED_TASK_ACTION,
	ACTION_COUNTER,
	PREVIOUS_TASK_NAME,
	PREVIOUS_TASK_ACTION,
	USER_ACTION_TAT_BUS_DAYS,
	RETURN_TO_NONPROVIDER_TAT,
	NONRTP_RESPONSE_RECEIVED_TAT,
	QS_FAIL_TO_APPROVE_TAT,
	QS_APP_RECEIVED_TO_APPROVE_TAT,
	QS_INITIAL_FAILED_BY_USER,
	QS_INITIAL_FAIL_DT,
	DATE_CREDENTIALING,
	QS_APPROVAL_DT,
	QS_APPROVED_BY_USER,
	PROVIDER_RISK_LEVEL_ID
) as
WITH hist AS(SELECT 
    r.reg_id AS application_id
    ,awst.process_id
	  ,awst.step_history_id
	  ,awst.current_step_id
	  ,awst.current_task_id
	  ,awst.current_task_name
	  ,awst.current_task_type
	  ,awst.current_step_start_dt
	  ,awst.current_step_end_dt	  
	  ,awst.next_step_id
	  ,awst.next_task_id
	  ,awst.next_task_name
	  ,awst.next_task_type	  
	  ,awst.step_update_dt
	  ,awst.owner_id
	  ,uai.contact_name	AS assigned_to
	  ,awst.step_create_dt
	  ,awst.task_action	  
	  ,awst.change_operation	  
	  ,CASE WHEN awst.current_step_end_dt IS NOT NULL AND awst.task_action IS NOT NULL THEN r.reg_id ELSE null END AS application_id_with_action
    ,CASE WHEN awst.current_step_end_dt IS NOT NULL AND awst.task_action IS NOT NULL THEN 
         DATEDIFF(second,FIRST_VALUE(awst.step_update_dt) OVER (PARTITION BY awst.process_id,awst.current_step_id,awst.owner_id ORDER BY awst.step_history_id), awst.current_step_end_dt)  
       ELSE NULL END AS user_action_tat
    ,FIRST_VALUE(awst.step_update_dt) OVER (PARTITION BY awst.process_id,awst.current_step_id,awst.owner_id ORDER BY awst.step_history_id) assigned_to_dt  
    ,CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group 
    ,CASE WHEN awst.current_task_name IN('Credentialing Supervisor Review','ODM Credentialing Supervisor Review') AND awst.task_action = 'Return To Credentialing Specialist'
	     AND LEAD(awst.current_task_name) OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id) = awst.next_task_name
		  THEN LEAD(uai.contact_name) IGNORE NULLS OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id ) ELSE NULL END AS cs_reassigned_to    
    ,CASE WHEN awst.current_task_name IN('Provider Credentialing','Provider Credentialing ODM') AND awst.task_action = 'Return to Provider' THEN 
       CASE WHEN awst.current_step_end_dt IS NULL THEN 0 ELSE RANK() OVER(PARTITION BY awst.process_id,awst.current_task_name,awst.task_action, CASE WHEN awst.current_step_end_dt IS NULL THEN 0 ELSE 1 END ORDER BY awst.step_history_id) END 
     ELSE NULL END AS return_to_provider_counter    
    ,CASE WHEN awst.current_task_name IN('Provider Credentialing','Provider Credentialing ODM') THEN
        CASE WHEN awst.current_step_end_dt IS NOT NULL AND awst.task_action IS NOT NULL THEN DATEDIFF(second, awst.current_step_end_dt, nextq.next_step_dt) ELSE NULL END
      ELSE NULL END AS rtp_response_received_tat    
    ,CASE WHEN awst.current_step_end_dt IS NOT NULL THEN 
            CASE WHEN ((awst.risk_level_id = 0 AND awst.cred_current_risk_level_id != 0) OR awst.risk_level_id IS NULL) THEN prlcur.provider_risk_level_name ELSE prl.provider_risk_level_name END ELSE NULL END AS recommended_risk_level 
    ,CASE WHEN awst.current_task_name IN('Provider Credentialing','Provider Credentialing ODM') AND awst.task_action = 'Approve' 
             THEN CONCAT(awst.task_action,' (',CASE WHEN awst.current_step_end_dt IS NOT NULL THEN 
                                                 CASE WHEN ((awst.risk_level_id = 0 AND awst.cred_current_risk_level_id != 0) OR awst.risk_level_id IS NULL) THEN prlcur.provider_risk_level_name ELSE prl.provider_risk_level_name END ELSE NULL END ,')') 
          WHEN awst.current_task_name IN('Credentialing Supervisor Review','ODM Credentialing Supervisor Review') AND awst.task_action = 'Approve' AND LEAD(awst.current_task_name) OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id) = awst.next_task_name
            AND LEAD(awst.task_action) OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id) = 'Send to Credential Committee' THEN 'Approve for Chair' 
          WHEN awst.current_task_name IN('Credentialing Supervisor Review','ODM Credentialing Supervisor Review') AND awst.task_action = 'Approve' AND LEAD(awst.current_task_name) OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id) = awst.next_task_name 
            AND LEAD(awst.task_action) OVER (PARTITION BY awst.process_id ORDER BY awst.step_history_id) = 'Send to Credential Quality' THEN 'Approve for Quality' 
      ELSE awst.task_action END AS derived_task_action
    --,CASE WHEN awst.current_step_end_dt IS NULL THEN 0 ELSE RANK() OVER(PARTITION BY awst.process_id,awst.current_task_name, CASE WHEN awst.current_step_end_dt IS NULL THEN 0 ELSE 1 END ORDER BY awst.current_step_id,awst.step_history_id) END AS action_counter
    ,awst.action_counter
    ,prevws.previous_task_name
    ,prevws.previous_task_action    
    ,CASE WHEN awst.current_step_end_dt IS NOT NULL THEN nextq.next_step_dt ELSE NULL END next_step_dt
    ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review' AND awst.task_action IN('QA Approve','QA Fail') THEN DATEDIFF(second,qws.qs_fail_dt, qwsappr.qs_approval_dt)                 
          WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action IN('Return to Credentialing', 'Approve for Committee') THEN DATEDIFF(second,afc.ocr_fail_dt, afcappr.ocr_approval_dt)               
        ELSE NULL END AS qs_fail_to_approve_tat                
     ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review'  AND awst.task_action IN('QA Approve','QA Fail') THEN DATEDIFF(second,awfp.awfp_assigned_to_dt, qwsappr.qs_approval_dt) 
           WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action IN('Return to Credentialing', 'Approve for Committee') THEN DATEDIFF(second,awfp.awfp_assigned_to_dt, afcappr.ocr_approval_dt)
        ELSE NULL END AS qs_app_received_to_approve_tat        
    ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review' AND awst.task_action = 'QA Approve' THEN qws.qs_failed_by
          WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action = 'Approve for Committee' THEN afc.ocr_failed_by
       ELSE NULL END AS qs_initial_failed_by_user
    ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review' AND awst.task_action = 'QA Approve' THEN qws.qs_fail_dt
          WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action = 'Approve for Committee' THEN afc.ocr_fail_dt
       ELSE NULL END AS qs_initial_fail_dt
    ,awfp.awfp_assigned_to_dt AS date_credentialing   
    ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review' AND awst.task_action = 'QA Fail' THEN qwsappr.qs_approved_by
          WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action = 'Return to Credentialing Specialist' THEN afcappr.ocr_approved_by
       ELSE NULL END AS qs_approved_by_user
    ,CASE WHEN awst.current_task_name = 'Credentialing Quality Review' AND awst.task_action = 'QA Fail' THEN qwsappr.qs_approval_dt
          WHEN awst.current_task_name = 'ODM Credentialing Review' AND awst.task_action = 'Return to Credentialing Specialist' THEN afcappr.ocr_approval_dt
       ELSE NULL END AS qs_approval_dt 
    ,rp.provider_risk_level_id	   
FROM ohpnm_dp4bi.registration r
  JOIN (SELECT curws.process_id, rgc.reg_id
               ,awst.a_wf_step_id AS step_history_id
               ,curws.step_id  AS current_step_id
               ,curws.task_id AS current_task_id
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) AS current_step_start_dt
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.end_date_time) AS current_step_end_dt
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) AS step_create_dt
               ,curwt.name AS current_task_name
               ,curwt.task_type AS current_task_type
               ,wa.name AS task_action
               ,nextws.step_id AS next_step_id
               ,nextws.task_id AS next_task_id
               ,nextsk.name  AS next_task_name
               ,nextsk.task_type AS next_task_type
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.DateOfAction) AS step_update_dt
               ,awst.owner_id
               ,awst.operation AS change_operation
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.end_date_time) AS hist_end_dt                                          
               ,aac.risk_level_id
               ,rgc.risk_level_id cred_current_risk_level_id     
               ,CASE WHEN awst.end_date_time IS NULL THEN 0 ELSE RANK() OVER(PARTITION BY curws.process_id,curwt.name, CASE WHEN awst.end_date_time IS NULL THEN 0 ELSE 1 END ORDER BY curws.step_id,awst.a_wf_step_id) END AS action_counter
          FROM (SELECT *
                FROM (SELECT r.reg_id,r.credentialing_id, risk_level_id, cr.workflow_id,p.process_id
                            ,CASE WHEN cs.credentialing_status_name = 'Administrative Termination' THEN 'Admin Terminate' 
                                  WHEN cs.credentialing_status_name = 'Administrative Denial' THEN 'Admin Deny' ELSE NULL END status_action_xref
                            ,RANK() OVER (PARTITION BY r.reg_id ORDER BY p.process_id DESC) prnk
                       FROM ohpnm_dp4bi.reg_credentialing r
                        JOIN ohpnm_dp4bi.credentialing cr ON r.credentialing_id = cr.credentialing_id
                        JOIN ohpnm_dp4bi.credentialing_status cs ON cr.credentialing_status_id = cs.credentialing_status_id
                        JOIN ohpnm_dp4bi.wf_step ws ON cr.step_id = ws.step_id
                        JOIN ohpnm_dp4bi.wf_process p ON ws.process_id = p.process_id )
                 WHERE prnk = 1) rgc
             LEFT JOIN ohpnm_dp4bi.wf_step curws ON rgc.process_id = curws.process_id --current task
             LEFT JOIN ohpnm_dp4bi.wf_task curwt ON curws.task_id = curwt.task_id
             LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
             LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id              
             LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON curws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id -- current task action
               AND (wa.name = rgc.status_action_xref OR (wa.name NOT IN('Admin Terminate','Admin Deny') AND wa.action_rnk = 1)) 
             LEFT JOIN ohpnm_dp4bi.a_wf_step awst ON curws.step_id = awst.step_id --current task history
             LEFT JOIN (SELECT *
                        FROM (SELECT aac.credentialing_id,aac.DateOfAction,aac.risk_level_id, aac.step_id,RANK() OVER (PARTITION BY aac.credentialing_id,aac.step_id ORDER BY aac.a_credentialing_id DESC) rnk 
                              FROM ohpnm_dp4bi.a_credentialing aac) 
                        WHERE rnk = 1) aac ON rgc.credentialing_id = aac.credentialing_id AND aac.step_id = awst.step_id  
             LEFT JOIN (SELECT *
                        FROM (SELECT mws.process_id, MIN(mws.step_id) OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) min_step_id,RANK() OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) rnk
                              FROM ohpnm_dp4bi.wf_step mws 
                               JOIN ohpnm_dp4bi.wf_task mwt ON mws.task_id = mwt.task_id
                              WHERE mwt.name IN('Initiate Provider Credentialing'))
                        WHERE rnk = 1)  mws ON mws.process_id = rgc.process_id
               WHERE curws.step_id >= mws.min_step_id         
        
          UNION
          SELECT curws.process_id, rgc.reg_id
               ,awst.a_wf_step_id AS step_history_id
               ,curws.step_id  AS current_step_id
               ,curws.task_id AS current_task_id
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) AS current_step_start_dt
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.end_date_time) AS current_step_end_dt
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) AS step_create_dt
               ,curwt.name AS current_task_name
               ,curwt.task_type AS current_task_type
               ,'Return to Non-Provider' action_name
               ,nextws.step_id AS next_step_id
               ,nextws.task_id AS next_task_id
               ,nextsk.name  AS next_task_name
               ,nextsk.task_type AS next_task_type
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.DateOfAction) AS step_update_dt
               ,awst.owner_id
               ,awst.operation AS change_operation
               ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',awst.end_date_time) AS hist_end_dt                                          
               ,aac.risk_level_id
               ,rgc.risk_level_id cred_current_risk_level_id       
               ,CASE WHEN awst.end_date_time IS NULL THEN 0 ELSE RANK() OVER(PARTITION BY curws.process_id,curwt.name, CASE WHEN awst.end_date_time IS NULL THEN 0 ELSE 1 END ORDER BY curws.step_id,awst.a_wf_step_id) END AS action_counter
          FROM (SELECT *
                FROM (SELECT r.reg_id,r.credentialing_id, risk_level_id, cr.workflow_id,p.process_id
                            ,CASE WHEN cs.credentialing_status_name = 'Administrative Termination' THEN 'Admin Terminate' 
                                  WHEN cs.credentialing_status_name = 'Administrative Denial' THEN 'Admin Deny' ELSE NULL END status_action_xref
                            ,RANK() OVER (PARTITION BY r.reg_id ORDER BY p.process_id DESC) prnk
                       FROM ohpnm_dp4bi.reg_credentialing r
                        JOIN ohpnm_dp4bi.credentialing cr ON r.credentialing_id = cr.credentialing_id
                        JOIN ohpnm_dp4bi.credentialing_status cs ON cr.credentialing_status_id = cs.credentialing_status_id
                        JOIN ohpnm_dp4bi.wf_step ws ON cr.step_id = ws.step_id
                        JOIN ohpnm_dp4bi.wf_process p ON ws.process_id = p.process_id )
                 WHERE prnk = 1) rgc
             LEFT JOIN ohpnm_dp4bi.wf_step curws ON rgc.process_id = curws.process_id --current task
             LEFT JOIN ohpnm_dp4bi.wf_task curwt ON curws.task_id = curwt.task_id
             LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
             LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id                            
             LEFT JOIN ohpnm_dp4bi.a_wf_step awst ON curws.step_id = awst.step_id --current task history                 
             JOIN (SELECT *
                   FROM(SELECT aac.credentialing_id,aac.step_id,acs.credentialing_status_name,aac.DateOfAction,aac.risk_level_id, aac.last_modified_user
                               ,RANK() OVER (PARTITION BY aac.credentialing_id,aac.step_id,acs.credentialing_status_name ORDER BY aac.a_credentialing_id DESC) rnk                        
                        FROM ohpnm_dp4bi.a_credentialing aac 
                         JOIN ohpnm_dp4bi.credentialing_status acs ON acs.credentialing_status_id = aac.credentialing_status_id
                        WHERE acs.credentialing_status_name = 'Pending Process')
                    WHERE rnk = 1 ) aac ON rgc.credentialing_id = aac.credentialing_id AND awst.step_id = aac.step_id
             LEFT JOIN (SELECT *
                        FROM (SELECT mws.process_id, MIN(mws.step_id) OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) min_step_id,RANK() OVER(PARTITION BY mws.process_id ORDER BY mws.step_id) rnk
                              FROM ohpnm_dp4bi.wf_step mws 
                               JOIN ohpnm_dp4bi.wf_task mwt ON mws.task_id = mwt.task_id
                              WHERE mwt.name IN('Initiate Provider Credentialing'))
                        WHERE rnk = 1)  mws ON mws.process_id = rgc.process_id
             WHERE curws.step_id >= mws.min_step_id   
             AND curwt.name = 'Provider Credentialing'  ) awst ON r.reg_id = awst.reg_id
 JOIN ohpnm_dp4bi.reg_provider rp ON r.reg_id = rp.reg_id
 LEFT JOIN ohpnm_dp4bi.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id
 LEFT JOIN ohpnm_dp4bi.provider_risk_level prl ON awst.risk_level_id = prl.provider_risk_level_id
 LEFT JOIN ohpnm_dp4bi.provider_risk_level prlcur ON awst.cred_current_risk_level_id = prlcur.provider_risk_level_id
 LEFT JOIN ohpnm_dp4bi.user_account_information uai ON awst.owner_id = uai.UserId 
 LEFT JOIN(SELECT curws.process_id,curws.step_id,curws.calling_step_id,curws.task_id,curwt.name,curwt.task_type
           ,LAG(wa.name) OVER(PARTITION BY curws.process_id ORDER BY curws.step_id) AS previous_task_action
           ,LAG(curwt.name) OVER(PARTITION BY curws.process_id ORDER BY curws.step_id) AS previous_task_name
           ,LAG(curws.step_id) OVER(PARTITION BY curws.process_id ORDER BY curws.step_id) AS previous_step_id
           FROM ohpnm_dp4bi.wf_step curws
            LEFT JOIN ohpnm_dp4bi.wf_task curwt ON curws.task_id = curwt.task_id
            LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
            LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
            LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w)  wa ON curws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
           WHERE curwt.task_type = 'Queue'  ) prevws ON prevws.step_id = awst.current_step_id AND prevws.process_id = awst.process_id   
 LEFT JOIN(SELECT curws.process_id,curws.step_id,curws.calling_step_id,curws.task_id,curwt.name,curwt.task_type          
           ,LEAD(curws.step_id) OVER(PARTITION BY curws.process_id ORDER BY curws.step_id) AS next_step_id
           ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',LEAD(curws.start_date_time) OVER(PARTITION BY curws.process_id ORDER BY curws.step_id) ) AS next_step_dt
           FROM ohpnm_dp4bi.wf_step curws
            LEFT JOIN ohpnm_dp4bi.wf_task curwt ON curws.task_id = curwt.task_id
            LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
            LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
            LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON curws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
           WHERE curwt.task_type = 'Queue'  ) nextq ON nextq.step_id = awst.current_step_id AND prevws.process_id = awst.process_id
 LEFT JOIN(SELECT *
          FROM (SELECT qws.process_id,qws.step_id,qws.calling_step_id,qws.task_id,qwt.name,qwt.task_type, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',qws.end_date_time) qs_fail_dt,uai.contact_name qs_failed_by
                  ,RANK() OVER (PARTITION BY qws.process_id ORDER BY qws.step_id) qrnk       
                FROM ohpnm_dp4bi.wf_step qws
                 LEFT JOIN ohpnm_dp4bi.wf_task qwt ON qws.task_id = qwt.task_id
                 LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = qws.step_id --next task
                 LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
                 LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON qws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
                 LEFT JOIN ohpnm_dp4bi.user_account_information uai ON qws.owner_id = uai.UserId 
                WHERE qwt.name = 'Credentialing Quality Review'
                AND wa.name = 'QA Fail') tmp
          WHERE qrnk = 1) qws ON qws.process_id = awst.process_id
LEFT JOIN(SELECT *
          FROM (SELECT afc.process_id,afc.step_id,afc.calling_step_id,afc.task_id,awt.name,awt.task_type, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',afc.end_date_time) ocr_fail_dt,uai.contact_name ocr_failed_by
                  ,RANK() OVER (PARTITION BY afc.process_id ORDER BY afc.step_id) ornk       
                FROM ohpnm_dp4bi.wf_step afc
                 LEFT JOIN ohpnm_dp4bi.wf_task awt ON afc.task_id = awt.task_id
                 LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = afc.step_id --next task
                 LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
                 LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON afc.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
                 LEFT JOIN ohpnm_dp4bi.user_account_information uai ON afc.owner_id = uai.UserId 
                WHERE awt.name = 'ODM Credentialing Review'
                AND wa.name = 'Return to Credentialing') tmp
          WHERE ornk = 1) afc ON afc.process_id = awst.process_id 
LEFT JOIN(SELECT *
          FROM (SELECT qws.process_id, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',qws.end_date_time) qs_approval_dt,uai.contact_name qs_approved_by
                  ,RANK() OVER (PARTITION BY qws.process_id ORDER BY qws.step_id) qrnk       
                FROM ohpnm_dp4bi.wf_step qws
                 LEFT JOIN ohpnm_dp4bi.wf_task qwt ON qws.task_id = qwt.task_id
                 LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = qws.step_id --next task
                 LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
                 LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON qws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
                 LEFT JOIN ohpnm_dp4bi.user_account_information uai ON qws.owner_id = uai.UserId 
                WHERE qwt.name = 'Credentialing Quality Review'
                AND wa.name = 'QA Approve') tmp
          WHERE qrnk = 1) qwsappr ON qwsappr.process_id = awst.process_id
LEFT JOIN(SELECT *
          FROM (SELECT afc.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',afc.end_date_time) ocr_approval_dt,uai.contact_name ocr_approved_by
                  ,RANK() OVER (PARTITION BY afc.process_id ORDER BY afc.step_id) ornk       
                FROM ohpnm_dp4bi.wf_step afc
                 LEFT JOIN ohpnm_dp4bi.wf_task awt ON afc.task_id = awt.task_id
                 LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = afc.step_id --next task
                 LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id 
                 LEFT JOIN (SELECT w.*, RANK() OVER (PARTITION BY task_id, next_task_id ORDER BY action_id) action_rnk
                         FROM ohpnm_dp4bi.wf_action w) wa ON afc.task_id = wa.task_id AND wa.next_task_id = nextws.task_id AND wa.action_rnk = 1
                 LEFT JOIN ohpnm_dp4bi.user_account_information uai ON afc.owner_id = uai.UserId 
                WHERE awt.name = 'ODM Credentialing Review'
                AND wa.name = 'Approve for Committee') tmp
          WHERE ornk = 1) afcappr ON afcappr.process_id = awst.process_id 
 LEFT JOIN(SELECT *
           FROM(SELECT hwf.step_id,hwf.owner_id, ua.contact_name,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',hwf.DateOfAction) awfp_assigned_to_dt,hwf.process_id,
           		    RANK() OVER (PARTITION BY hwf.process_id ORDER BY hwf.a_wf_step_id) rnk
                FROM ohpnm_dp4bi.a_wf_step hwf
                 JOIN ohpnm_dp4bi.wf_task wf ON hwf.task_id = wf.task_id
                 JOIN ohpnm_dp4bi.user_account_information ua ON hwf.owner_id = ua.UserId
                WHERE wf.name IN('Initiate Provider Credentialing','Provider Credentialing','Provider Credentialing ODM')  ) ua
            WHERE rnk = 1) awfp ON awfp.process_id = awst.process_id  
)
 SELECT hist.application_id
      ,hist.process_id
	  ,hist.step_history_id
	  ,hist.current_step_id
	  ,hist.current_task_id
	  ,hist.current_task_name
	  ,hist.current_task_type
	  ,hist.current_step_start_dt
	  ,hist.current_step_end_dt	  
	  ,hist.next_step_id
	  ,hist.next_task_id
	  ,hist.next_task_name
	  ,hist.next_task_type	  
	  ,hist.step_update_dt
	  ,hist.owner_id
	  ,hist.assigned_to
	  ,hist.step_create_dt
	  ,hist.task_action	  
	  ,hist.change_operation	  
	  ,hist.application_id_with_action
    ,hist.user_action_tat
    ,hist.assigned_to_dt  
    ,hist.operational_group 
    ,hist.cs_reassigned_to    
    ,hist.return_to_provider_counter      
    ,hist.rtp_response_received_tat            
    ,CASE WHEN hist.recommended_risk_level = 'Undefined' THEN NULL ELSE hist.recommended_risk_level END AS recommended_risk_level
    ,hist.derived_task_action
    ,hist.action_counter
    ,hist.previous_task_name
    ,hist.previous_task_action    
    ,CASE WHEN current_step_end_dt IS NOT NULL AND task_action IS NOT NULL THEN           
         DATEDIFF(second,hist.assigned_to_dt, current_step_end_dt)  - COALESCE((SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END FROM D_DATES
                                                                 WHERE business_day_flag = 'N'
                                                                 AND d_date BETWEEN DATE_TRUNC('DAY',hist.assigned_to_dt) AND DATE_TRUNC('DAY', hist.current_step_end_dt)),0) *86400 -- exclude weekends/holidays
        ELSE NULL END AS user_action_tat_bus_days     
   ,CASE WHEN hist.current_task_name IN('Provider Credentialing','Provider Credentialing ODM') AND hist.task_action = 'Return to Non-Provider' THEN user_action_tat ELSE NULL END AS return_to_nonprovider_tat
   ,CASE WHEN hist.current_task_name IN('Provider Credentialing','Provider Credentialing ODM') AND hist.task_action = 'Return to Non-Provider' THEN DATEDIFF(second,hist.current_step_end_dt, hist.next_step_dt) ELSE NULL END AS nonrtp_response_received_tat
   ,hist.qs_fail_to_approve_tat
   ,hist.qs_app_received_to_approve_tat
   ,hist.qs_initial_failed_by_user
   ,hist.qs_initial_fail_dt
   ,hist.date_credentialing
   ,hist.qs_approval_dt
   ,hist.qs_approved_by_user
   ,hist.provider_risk_level_id
 FROM hist ;