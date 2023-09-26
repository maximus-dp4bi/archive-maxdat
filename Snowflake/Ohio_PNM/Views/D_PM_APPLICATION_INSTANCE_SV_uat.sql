CREATE OR REPLACE VIEW PUBLIC.D_PM_APPLICATION_INSTANCE_SV AS
SELECT r.reg_id application_id    
	   --,wp.process_id   
	   ,ce.communication_event_id AS application_notice_id
	   ,ce.latest_notice_type AS application_notice_type
	   ,s.provider_de_start AS application_received_dt	   
	   ,s_arn.application_received_notice_sent_dt AS application_received_notice_sent_dt
	   ,s.provider_de_start AS application_start_dt
	   ,CASE WHEN wp.end_date_time IS NULL THEN 'Active' ELSE 'Complete' END AS application_status
	   ,CASE WHEN DATEDIFF(day,s.provider_de_start,COALESCE(s.provider_de_end,CAST(CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()) AS DATE))) >= s.elapsed_event_time_hours/24 THEN s.provider_de_end 
         ELSE DATEADD(day,s.elapsed_event_time_hours/24,s.provider_de_start) END AS application_timed_out_to_cancel_dt
	   --,CASE WHEN DATEDIFF(day,s.provider_de_start,COALESCE(s.provider_de_end,CAST(CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()) AS DATE))) >= s.elapsed_event_time_hours/24 AND ce_cnt.reg_id IS NOT NULL THEN 'Y' ELSE 'N' END AS application_timed_out_to_cancel_flag
     ,CASE WHEN ce_cnt.reg_id IS NOT NULL THEN 'Y' ELSE 'N' END AS application_timed_out_to_cancel_flag
	   ,ce.latest_notice_create_dt AS notice_create_dt
	   ,s_rtp.start_date_time AS rtp_notices_sent_request_more_info_dt
	   --,CASE WHEN DATEDIFF(day,s.provider_de_start,COALESCE(s.provider_de_end,CAST(CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()) AS DATE))) >= s.elapsed_event_time_hours/24 AND ce_cnt.reg_id IS NOT NULL THEN s.provider_de_end  ELSE NULL END AS application_cancellation_notice_sent_dt 
	   ,CASE WHEN ce_cnt.reg_id IS NOT NULL THEN COALESCE(s.provider_de_end,ce_cnt.application_cancel_notices_triggered_dt) ELSE NULL END AS application_cancel_notice_sent_dt 
     ,ce_cnt.application_cancel_notices_triggered_dt
	   ,CASE WHEN prview.provider_review_action IN('Approve','Application Complete') THEN 'Y' ELSE 'N' END AS application_approved_status_flag
	   ,rs.screening_result_name AS application_screening_outcome_status	   
	   ,CASE WHEN rs.screening_method_name = 'Manual' THEN 'Y'
	         WHEN rs.screening_method_name = 'System' THEN 'N'
	      ELSE NULL END AS application_manually_screened
	   ,CASE WHEN prview.provider_review_action IN('Return to Provider') THEN 'Y' ELSE 'N' END AS application_reviewed_need_moreinfo
	   ,rm.medicaid_id AS assign_medicaid_id
	   ,CASE WHEN rbc.reg_background_check_id IS NOT NULL THEN 'Y' ELSE 'N' END AS background_check_required
	   ,bin.bcii_fbi_fp_notice_sent_dt
	   ,CASE WHEN s_rtc.step_id IS NOT NULL THEN 'Y' ELSE 'N' END AS compliance_review_required	
     ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
      OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') THEN 'Y' ELSE 'N' END AS  provider_credentialed_flag
     ,CASE WHEN mmis_provider_type_id IN('86','88','89') THEN 'Y' ELSE 'N' END AS ltc_applications_submitted    	   
     ,prl.provider_risk_level_name AS moderate_high_risk_level
     --stubbed out, no mapping
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP) AS provider_received_dt
     ,0 provider_received_id
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP)  AS provider_received_response_dt
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP)  AS received_response_create_dt
     ,0 received_response_id
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP)  AS received_response_processed_dt
     ,0 received_response_type
      --end stubbed out, no mapping       
     ,CASE WHEN prcred.step_id IS NOT NULL THEN 'Y' ELSE 'N' END requiring_credentialing
     ,'X' response_status --stubbed out, no mapping
     ,CASE WHEN s_svr.step_id IS NOT NULL THEN 'Y' ELSE 'N' END AS site_visit_required     
	   ,wl.welcome_letter_or_revalidation_letter_dt   
	   ,apt.application_type_name AS application_type
     ,CASE WHEN prl.provider_risk_level_name IN('High','Moderate') OR mmis_provider_type_id IN('25','26','38','55') THEN 'Y' ELSE 'N' END AS moderate_high_risk_level_or_pt_flag	 
     ,sacn.affiliation_confirm_notice_to_group_dt
     --stubbed out, no mapping
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP)  AS affiliation_received_dt
     ,0 AS affiliation_received_id
     ,CAST('01/01/1900 00:00:00' AS TIMESTAMP)  AS affiliation_received_response_dt
     --end stubbed out, no mapping       
     ,DATEDIFF(second,s.provider_de_start, s.provider_de_end) AS time_to_submit
     ,DATEDIFF(second,s.provider_de_end, s_arn.application_received_notice_sent_dt) AS time_app2app_received_notice_sent
     ,CASE WHEN ce_cnt.reg_id IS NOT NULL THEN DATEDIFF(second,s.provider_de_start, s.provider_de_end) ELSE NULL END time_app2app_cancellation
     ,CASE WHEN prscreen.owner_id IS NOT NULL AND prscreen.provider_screening_end IS NULL THEN 'Y' ELSE 'N' END AS application_waiting_screen
     ,CASE WHEN prview.owner_id IS NOT NULL AND prview.provider_review_end IS NULL THEN 'Y' ELSE 'N' END AS application_waiting_review     
     ,CASE WHEN casgm.step_id IS NOT NULL THEN 'Y' ELSE 'N' END change_affiliation_confirm_group_member_flag
     ,DATEDIFF(second,prscreen.provider_screening_start, COALESCE(prscreen.provider_screening_end,CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))) AS application_screen_time_in_queue
     ,DATEDIFF(second,prscreen.provider_screening_start, prscreen.provider_screening_end) AS application_screen_time_to_complete     
     ,s_arn.application_received_notice_sent_dt  AS application_process_start_dt
     ,comp.application_process_end_dt  AS application_process_end_dt
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN DATEDIFF(second,s_arn.application_received_notice_sent_dt, comp.application_process_end_dt) 
        ELSE NULL END AS app_process_tat_rtp_caldays
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN DATEDIFF(second,s_arn.application_received_notice_sent_dt, comp.application_process_end_dt) - COALESCE(rtpd.app_process_num_rtp_caldays,0)
        ELSE NULL END  AS app_process_tat_wo_rtp_caldays
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN DATEDIFF(second,s_arn.application_received_notice_sent_dt, comp.application_process_end_dt) 
        - COALESCE((SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END 
                    FROM D_DATES
                    WHERE business_day_flag = 'N'
                    AND d_date BETWEEN DATE_TRUNC('DAY',s_arn.application_received_notice_sent_dt) AND DATE_TRUNC('DAY', comp.application_process_end_dt)),0) *86400
       ELSE NULL END AS app_process_tat_rtp_busdays
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN (DATEDIFF(second,s_arn.application_received_notice_sent_dt, comp.application_process_end_dt) 
        - COALESCE((SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END 
                    FROM D_DATES
                    WHERE business_day_flag = 'N'
                    AND d_date BETWEEN DATE_TRUNC('DAY',s_arn.application_received_notice_sent_dt) AND DATE_TRUNC('DAY', comp.application_process_end_dt)),0) *86400) - COALESCE(rtpd.app_process_num_rtp_busdays,0)
       ELSE NULL END AS app_process_tat_wo_rtp_busdays
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN COALESCE(rtpd.app_process_num_rtp_caldays,0) ELSE 0 END app_process_num_rtp_caldays
     ,CASE WHEN comp.application_process_end_dt IS NOT NULL THEN COALESCE(rtpd.app_process_num_rtp_busdays,0) ELSE 0 END AS app_process_num_rtp_busdays
     ,CASE WHEN rc.credentialing_status_name IN('Approved','Administrative Denial','Administrative Termination','Credentialing Committee Denial','Credentialing Committee Termination')
        OR (rc.credentialing_status_name = 'Process Discontinued' AND ocr.odm_action = 'Enrollment Approved') THEN 
         DATEDIFF(second,COALESCE(prcred.cs_start_date_time,rc.start_date_time),COALESCE(ccr.cc_cr_end_dt,ocr.odm_cr_end_dt,rc.end_date_time))   
      ELSE NULL END AS application_time_in_credentialing          
FROM ohpnm_dp4bi.registration r 
  JOIN (SELECT *
        FROM (SELECT wpr.parameter_value,wpr.process_id, wp.workflow_id,wp.end_date_time,RANK() OVER(PARTITION BY wpr.parameter_value ORDER BY wpr.process_id DESC) arnk
              FROM ohpnm_dp4bi.wf_parameter wpr 
                JOIN ohpnm_dp4bi.wf_process wp ON wp.process_id = wpr.process_id 
              WHERE wp.workflow_id = 1
              AND wpr.parameter_name = 'REGISTRATION_ID')
        WHERE arnk = 1) wp ON wp.parameter_value = TO_CHAR(r.reg_id)
  LEFT JOIN (SELECT *
             FROM(SELECT ra.reg_id,ra.process_id,aps.application_status_desc, RANK() OVER (PARTITION BY ra.reg_id,ra.process_id ORDER BY ra.reg_application_id DESC) rnk
                  FROM ohpnm_dp4bi.reg_application ra JOIN ohpnm_dp4bi.application_status aps  on ra.application_status = aps.application_status_id)
             WHERE rnk = 1) ra ON r.reg_id = ra.reg_id AND ra.process_id = wp.process_id
  LEFT JOIN (SELECT *
             FROM (SELECT ce.reg_id,ce.communication_event_id, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',ce.communication_event_date_time) latest_notice_create_dt,
			          CASE WHEN COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt' 
					    THEN REPLACE(COALESCE(e.template_name,m.template_name),'.txt','') ELSE COALESCE(e.subject,m.subject) END  latest_notice_type,                   
			          RANK() OVER (PARTITION BY ce.reg_id ORDER BY ce.communication_event_id DESC) rnk
					FROM ohpnm_dp4bi.communication_event ce  
					  LEFT JOIN ohpnm_dp4bi.email e  ON e.communication_event_id = ce.communication_event_id
					  LEFT JOIN ohpnm_dp4bi.mail m  ON m.communication_event_id = ce.communication_event_id
					)  tmp
			 WHERE rnk = 1) ce ON r.reg_id = ce.reg_id 
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.start_date_time) provider_de_start, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) provider_de_end, 
					  t.elapsed_event_time_hours,RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name = 'Provider Data Entry') tmp
			 WHERE rnk = 1) s ON wp.process_id = s.process_id 
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_received_notice_sent_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name = 'Application Received Notice') tmp
			 WHERE rnk = 1) s_arn ON wp.process_id = s_arn.process_id 
  LEFT JOIN (SELECT *
             FROM(SELECT reg_id, medicaid_id, RANK() OVER(PARTITION BY reg_id ORDER BY reg_medicaid_id DESC) rnk
                  FROM ohpnm_dp4bi.reg_medicaid)
             WHERE rnk = 1) rm  ON r.reg_id = rm.reg_id
  LEFT JOIN (SELECT *
             FROM (SELECT reg_id,reg_background_check_id, RANK() OVER(PARTITION BY reg_id ORDER BY reg_background_check_id DESC) rnk
			       FROM ohpnm_dp4bi.reg_background_check ) tmp
			 WHERE rnk = 1) rbc ON r.reg_id = rbc.reg_id
  LEFT JOIN(SELECT *
            FROM (SELECT rs.reg_id, rs.screening_id, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',sc.end_date_time) screening_result_date,scr.screening_result_name,sm.screening_method_name,
			             RANK() OVER(PARTITION BY rs.reg_id ORDER BY rs.screening_id,sca.screening_activity_id DESC) rnk
                  FROM ohpnm_dp4bi.reg_screening rs 
		           LEFT JOIN ohpnm_dp4bi.screening sc  ON rs.screening_id = sc.screening_id
		           LEFT JOIN ohpnm_dp4bi.screening_result scr  ON sc.screening_result_id = scr.screening_result_id 
                   LEFT JOIN ohpnm_dp4bi.screening_activity sca  ON sca.screening_id = sc.screening_id
		           LEFT JOIN ohpnm_dp4bi.screening_activity_type scat  ON sca.screening_activity_type_id = scat.screening_activity_type_id
				   LEFT JOIN ohpnm_dp4bi.screening_method sm  ON scat.screening_method_id = sm.screening_method_id  ) tmp
			WHERE rnk = 1)	rs ON r.reg_id = rs.reg_id  
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.start_date_time) start_date_time, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name = 'Send Request for Additional Information (RTP Notice)') tmp
			 WHERE rnk = 1) s_rtp ON wp.process_id = s_rtp.process_id 
LEFT JOIN (SELECT *
             FROM (SELECT cec.reg_id,cec.communication_event_id,
			         CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',communication_event_date_time) application_cancel_notices_triggered_dt,
			          RANK() OVER (PARTITION BY cec.reg_id ORDER BY cec.communication_event_id) rnk
					FROM ohpnm_dp4bi.communication_event cec  
					  LEFT JOIN ohpnm_dp4bi.email e  ON e.communication_event_id = cec.communication_event_id
					  LEFT JOIN ohpnm_dp4bi.mail m  ON m.communication_event_id = cec.communication_event_id                   
					WHERE COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt') tmp
			 WHERE rnk = 1) ce_cnt  ON r.reg_id = ce_cnt.reg_id
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) bcii_fbi_fp_notice_sent_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name IN('Send Provider Email (FBI Notice)','Send Provider Email (BCII Notice)')) tmp
			 WHERE rnk = 1) bin ON wp.process_id = bin.process_id 
LEFT JOIN (SELECT *       
           FROM(SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) provider_review_start,
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) provider_review_end, wa.name provider_review_action, curws.owner_id,                    
                    RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC, action_id) rnk
                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                 JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                 JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --the calling step id of the next task is the current task’s step id 
                 JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                 JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action	                 
                WHERE curtsk.name IN ('Provider Review')) t
            WHERE rnk = 1) prview ON wp.process_id = prview.process_id   
LEFT JOIN (SELECT *       
           FROM(SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) provider_screening_start,
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) provider_screening_end, wa.name provider_review_action, curws.owner_id,                    
                    RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC, action_id) rnk
                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                 JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                 JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --the calling step id of the next task is the current task’s step id 
                 JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                 JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action	                 
                WHERE curtsk.name IN ('Provider Screening')) t
            WHERE rnk = 1) prscreen ON wp.process_id = prscreen.process_id   
LEFT JOIN (SELECT *       
           FROM(SELECT curws.step_id,curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) start_date_time,
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) end_date_time, wa.name rtc_action,
                    RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC, action_id) rnk
                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                 JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                 JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --the calling step id of the next task is the current task’s step id 
                 JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                 JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action					
                WHERE curtsk.name IN ('Provider Review','Provider Screening')
                AND wa.name = 'Refer To Compliance') t
            WHERE rnk = 1) s_rtc ON wp.process_id = s_rtc.process_id     
LEFT JOIN (SELECT *       
           FROM(SELECT curws.step_id,curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) cs_start_date_time,
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) cs_end_date_time, wa.name provider_cs_action,
                    RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                 JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                 JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --the calling step id of the next task is the current task’s step id 
                 JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                 JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action					
                WHERE curtsk.name IN ('Initiate Provider Credentialing','Provider Credentialing','Provider Credentialing ODM')) t
            WHERE rnk = 1) prcred ON wp.process_id = prcred.process_id                        
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) welcome_letter_or_revalidation_letter_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name IN('Issue Welcome Letter','Send Revalidation Success Notice')) tmp
			 WHERE rnk = 1) wl ON wp.process_id = wl.process_id       
LEFT JOIN (SELECT * 
           FROM(SELECT rc.reg_id, cs.credentialing_status_name, c.workflow_id, 
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',c.start_date_time) start_date_time,
                    CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',c.end_date_time) end_date_time,
                    RANK() OVER (PARTITION BY rc.reg_id, c.workflow_id ORDER BY c.credentialing_id DESC) rnk
           FROM ohpnm_dp4bi.reg_credentialing rc
            JOIN ohpnm_dp4bi.credentialing c ON rc.credentialing_id = c.credentialing_id
            JOIN ohpnm_dp4bi.credentialing_status cs ON c.credentialing_status_id = cs.credentialing_status_id )
           WHERE rnk = 1) rc ON r.reg_id = rc.reg_id AND rc.workflow_id = wp.workflow_id
LEFT JOIN (SELECT *
           FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) odm_cr_start_dt
                       ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) odm_cr_end_dt,wa.name odm_action
                       ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
                 FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                   JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                   JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
                   JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                   JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action              
                 WHERE curtsk.name IN ('ODM Credentialing Review')	) tmp
           WHERE rnk = 1) ocr ON wp.process_id = ocr.process_id 
--Committee Review Queue
 LEFT JOIN (SELECT *
            FROM (SELECT curws.process_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.create_date_time) cc_cr_start_dt
                    ,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) cc_cr_end_dt, wa.name ccr_action
                    ,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
				  FROM ohpnm_dp4bi.wf_step curws -- current task 			    
					JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
					JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
					JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
					JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action								
				  WHERE curtsk.name IN ('Credentialing Committee Review')	) tmp
			WHERE rnk = 1) ccr ON wp.process_id = ccr.process_id
LEFT JOIN (SELECT *       
           FROM(SELECT curws.step_id,curws.process_id,curws.start_date_time , curws.end_date_time, wa.name rtc_action,
                    RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC, action_id) rnk
                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                 JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                 JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --the calling step id of the next task is the current task’s step id 
                 JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                 JOIN ohpnm_dp4bi.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id --current task action					
                WHERE curtsk.name IN ('Check For Site Visit Required')
                AND wa.name IN('Site Visit Done','Needs Site Visit')) t
            WHERE rnk = 1) s_svr ON wp.process_id = s_svr.process_id   
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) affiliation_confirm_notice_to_group_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name IN('Send Affiliation Confirmation Notices')) tmp
			 WHERE rnk = 1) sacn ON wp.process_id = sacn.process_id 
LEFT JOIN (SELECT *
             FROM (SELECT s.step_id,s.process_id, s.task_id,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) change_affiliation_status_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE t.name IN('Change Affiliation Status To Confirm Group Member')) tmp
			 WHERE rnk = 1) casgm ON wp.process_id = casgm.process_id               
LEFT JOIN ohpnm_dp4bi.reg_provider rp  ON r.reg_id = rp.reg_id
LEFT JOIN ohpnm_dp4bi.provider_risk_level prl  on rp.provider_risk_level_id = prl.provider_risk_level_id
LEFT JOIN ohpnm_dp4bi.application_type apt  on rp.application_type_id = apt.application_type_id
LEFT JOIN ohpnm_dp4bi.provider_type pt ON pt.provider_type_id = rp.provider_type_id
LEFT JOIN (SELECT *
             FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_process_end_dt, 
					  RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			       FROM ohpnm_dp4bi.wf_step s  
				     JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
				   WHERE UPPER(t.name) IN('COMPLETE WORKFLOW','COMPLETEWORKFLOW')) tmp
			 WHERE rnk = 1) comp ON wp.process_id = comp.process_id 
LEFT JOIN(SELECT tmp.process_id, SUM(IFF(task_action = 'Return to Provider',rtp_caldays,null)) app_process_num_rtp_caldays
                  , SUM(IFF(task_action = 'Return to Provider',rtp_busdays,null)) app_process_num_rtp_busdays
          FROM(SELECT curws.process_id,curws.step_id,curws.task_name,curws.task_action,curws.start_date_time,curws.end_date_time,credinit.step_id credstep       
                 ,CASE WHEN curws.step_id < credinit.step_id OR credinit.step_id IS NULL THEN DATEDIFF(second,curws.end_date_time, curws.next_task_end_dt) ELSE 0 END rtp_caldays
                 ,CASE WHEN curws.step_id < credinit.step_id OR credinit.step_id IS NULL THEN
                    DATEDIFF(second,curws.end_date_time, curws.next_task_end_dt) - COALESCE((SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END 
                                                                                    FROM D_DATES
                                                                                    WHERE business_day_flag = 'N'
                                                                                    AND d_date BETWEEN DATE_TRUNC('DAY',curws.end_date_time) AND DATE_TRUNC('DAY',  curws.next_task_end_dt)),0) *86400 
                  ELSE 0 END rtp_busdays          
               FROM (SELECT curws.step_id,curws.process_id,curws.task_id,curwt.name task_name,wa.name task_action, 
                        CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.start_date_time) start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',curws.end_date_time) end_date_time,
                        LEAD(CONVERT_TIMEZONE ('UTC', 'America/Los_Angeles',curws.end_date_time)) OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) next_task_end_dt
                   FROM ohpnm_dp4bi.wf_step curws
                    LEFT JOIN ohpnm_dp4bi.wf_task curwt ON curws.task_id = curwt.task_id
                    LEFT JOIN ohpnm_dp4bi.wf_step nextws ON nextws.calling_step_id = curws.step_id --next task
                    LEFT JOIN ohpnm_dp4bi.wf_task nextsk ON nextws.task_id = nextsk.task_id
                    LEFT JOIN ohpnm_dp4bi.wf_action wa ON curws.task_id = wa.task_id AND wa.next_task_id = nextws.task_id  
                   WHERE curwt.task_type = 'Queue') curws
                LEFT JOIN (SELECT *       
                           FROM(SELECT curws.step_id,curws.process_id,curtsk.name,RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id) rnk
                                FROM ohpnm_dp4bi.wf_step curws -- current task 			    
                                  JOIN ohpnm_dp4bi.wf_task curtsk ON curws.task_id = curtsk.task_id 
                                WHERE curtsk.name IN ('Initiate Provider Credentialing','Provider Credentialing','Provider Credentialing ODM')) t
                           WHERE rnk = 1) credinit ON credinit.process_id = curws.process_id ) tmp
    GROUP BY process_id ) rtpd ON wp.process_id = rtpd.process_id        
       ;