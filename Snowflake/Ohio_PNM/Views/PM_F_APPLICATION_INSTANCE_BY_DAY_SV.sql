CREATE OR REPLACE VIEW OHIO_PROVIDER_DP4BI_DEV_DB.PUBLIC.PM_F_APPLICATION_INSTANCE_BY_DAY_SV 
AS
SELECT  d_date                                              AS  d_date,
        application_id                                      AS  application_id,        
        SUM(application_cancel_sent_count)                  AS  application_cancel_sent_count,
        SUM(application_received_notice_sent_count)         AS  application_received_notice_sent_count,
        SUM(application_in_q_tobe_reviewed_count)           AS  application_in_q_tobe_reviewed_count,
        SUM(application_in_q_tobe_screened_count)           AS  application_in_q_tobe_screened_count,
        SUM(application_received_count)                     AS  application_received_count,
        SUM(application_timedout2cancel_count)              AS  application_timedout2cancel_count,
        SUM(ltc_application_submitted_count)                AS  ltc_application_submitted_count,
        SUM(application_review_completed_count)             AS  application_review_completed_count,
        SUM(application_rtp_notice_sent_count)              AS  application_rtp_notice_sent_count,
        SUM(application_screening_completed_count)          AS  application_screening_completed_count,
        SUM(standard_application_submitted_count)           AS  standard_application_submitted_count,
        SUM(affil_confirm_notice_group_sent_count)          AS  affil_confirm_notice_group_sent_count,
        0                                                   AS  affiliation_received_responses_sent_count,
        0                                                   AS  affiliation_received_count,
        SUM(application_approval_outcome_count)             AS  application_approval_outcome_count,
        SUM(application_screening_approved_count)           AS  application_screening_approved_count,
        SUM(application_screening_denied_count)             AS  application_screening_denied_count,
        SUM(application_screening_pending_count)            AS  application_screening_pending_count,
        SUM(application_review_need_more_info_count)        AS  application_review_need_more_info_count,
        SUM(application_started_older8day_count)            AS  application_started_older8day_count,
        SUM(application_assigned_medical_id_count)          AS  application_assigned_medical_id_count,
        SUM(background_checks_conducted_count)              AS  background_checks_conducted_count,
        SUM(bciifbi_fingerprint_notice_sent_count)          AS  bciifbi_fingerprint_notice_sent_count,
        0                                                   AS  compliance_review_conducted_count,
        SUM(providers_credentialed_count)                   AS  providers_credentialed_count
  FROM  (
            
            SELECT  dd.d_date,pcbd.*,
                    CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE)                                            
                              AND pcbd.cancel_notice_dt IS NOT NULL                                                   THEN 1 ELSE 0 END AS    application_cancel_sent_count,
                    CASE WHEN     d_date = CAST(pcbd.arns_start_dt   AS DATE)                                         THEN 1 ELSE 0 END AS    application_received_notice_sent_count,
                    CASE WHEN     d_date >= CAST(pcbd.pr_start_dt   AS DATE)
                              AND d_date < CAST(COALESCE(pcbd.pr_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))   AS DATE)              THEN 1 ELSE 0 END AS    application_in_q_tobe_reviewed_count,
                    CASE WHEN     d_date >= CAST(pcbd.ips_start_dt   AS DATE)
                              AND d_date < CAST(COALESCE(pcbd.ips_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))   AS DATE)             THEN 1 ELSE 0 END AS    application_in_q_tobe_screened_count,
                    CASE WHEN     d_date = CAST(pcbd.pde_end_dt   AS DATE)                                            THEN 1 ELSE 0 END AS    application_received_count,
                    CASE WHEN     d_date = CAST(pcbd.pde_end_dt   AS DATE)                                            
                              AND datediff(
                                                day, 
                                                pcbd.pde_start_dt::DATE, 
                                                COALESCE(pcbd.pde_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))::DATE
                                          ) >= 10                                                                     THEN 1 ELSE 0 END AS    application_timedout2cancel_count,
                    CASE WHEN     d_date = CAST(pcbd.pde_end_dt   AS DATE)                                            
                              AND datediff(
                                                day, 
                                                pcbd.pde_start_dt::DATE, 
                                                COALESCE(pcbd.pde_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp()))::DATE
                                          ) > 8                                                                       THEN 1 ELSE 0 END AS    application_started_older8day_count,
                    CASE WHEN     d_date = CAST(pcbd.pde_end_dt   AS DATE) 
                              AND pcbd.pt = 'LTC'                                                                     THEN 1 ELSE 0 END AS    ltc_application_submitted_count,
                    CASE WHEN     d_date = CAST(pcbd.pr_end_dt AS DATE)                                               THEN 1 ELSE 0 END AS    application_review_completed_count,
                    CASE WHEN     d_date = CAST(pcbd.pr_end_dt AS DATE)                                               
                              AND COALESCE(pcbd.app_review_approved, 'N') = 'Y'                                       THEN 1 ELSE 0 END AS    application_approval_outcome_count,
                    CASE WHEN     d_date = CAST(pcbd.pr_end_dt AS DATE)                                               
                              AND COALESCE(pcbd.app_review_nmi, 'N') = 'Y'                                            THEN 1 ELSE 0 END AS    application_review_need_more_info_count,
                    CASE WHEN     d_date = CAST(pcbd.rtpns_end_dt AS DATE)                                            THEN 1 ELSE 0 END AS    application_rtp_notice_sent_count,
                    CASE WHEN     d_date = CAST(pcbd.sr_end_dt AS DATE)                                               THEN 1 ELSE 0 END AS    application_screening_completed_count,
                    CASE WHEN     d_date = CAST(pcbd.sr_end_dt AS DATE)                                               
                              AND sr = 'Approved'                                                                     THEN 1 ELSE 0 END AS    application_screening_approved_count,    
                    CASE WHEN     d_date = CAST(pcbd.sr_end_dt AS DATE)                                               
                              AND sr = 'Denied'                                                                       THEN 1 ELSE 0 END AS    application_screening_denied_count,    
                    CASE WHEN     d_date = CAST(pcbd.sr_end_dt AS DATE)                                               
                              AND sr = 'Pending'                                                                      THEN 1 ELSE 0 END AS    application_screening_pending_count,    
                    CASE WHEN     d_date = CAST(pcbd.pde_end_dt   AS DATE) 
                              AND pcbd.pt = 'STANDARD'                                                                THEN 1 ELSE 0 END AS    standard_application_submitted_count,
                    CASE WHEN     d_date = CAST(pcbd.santg_end_dt AS DATE)                                            THEN 1 ELSE 0 END AS    affil_confirm_notice_group_sent_count,
                    CASE WHEN     d_date = CAST(pcbd.rc_end_dt AS DATE)                                               THEN 1 ELSE 0 END AS    providers_credentialed_count,        
                    CASE WHEN     d_date = CAST(pcbd.ami_end_dt AS DATE)                                              THEN 1 ELSE 0 END AS    application_assigned_medical_id_count,
                    CASE WHEN     d_date = CAST(pcbd.rbc_end_dt AS DATE)                                              
                              AND COALESCE(pcbd.bcc, 'N') = 'Y'                                                       THEN 1 ELSE 0 END AS    background_checks_conducted_count,
                    CASE WHEN     d_date = CAST(pcbd.fpn_end_dt AS DATE)                                              THEN 1 ELSE 0 END AS    bciifbi_fingerprint_notice_sent_count
              FROM  (
                        SELECT  r.reg_id                                                                AS  application_id,     
                                CASE    WHEN    pt.mmis_provider_type_id IN ('86','88','89')
                                        THEN    'LTC' 
                                        ELSE    'STANDARD' 
                                END                                                                     AS  pt,
                                rst.registration_status_type                                            AS  rst,
                                wp.process_id                                                           AS  process_id,
                                wc.start_date_time                                                      AS  process_start_dt, 
                                COALESCE(cn.cancel_notice_dt, wc.end_date_time)                         AS  process_end_dt, 
                                cn.cancel_notice_dt                                                     AS  cancel_notice_dt,
                                arns.start_date_time                                                    AS  arns_start_dt,
                                arns.end_date_time                                                      AS  arns_end_dt,
                                pr.start_date_time                                                      AS  pr_start_dt,
                                pr.end_date_time                                                        AS  pr_end_dt,
                                pr.app_review_approved                                                  AS  app_review_approved,
                                pr.app_review_nmi                                                       AS  app_review_nmi,
                                ips.start_date_time                                                     AS  ips_start_dt,
                                ips.end_date_time                                                       AS  ips_end_dt,
                                pde.start_date_time                                                     AS  pde_start_dt,
                                pde.end_date_time                                                       AS  pde_end_dt,
                                rtpns.start_date_time                                                   AS  rtpns_start_dt,
                                rtpns.end_date_time                                                     AS  rtpns_end_dt,
                                rsr.screening_result_name                                               AS  sr,
                                rsr.end_date_time                                                       AS  sr_end_dt, 
                                rbc.start_date_time                                                     AS  rbc_start_dt,
                                rbc.end_date_time                                                       AS  rbc_end_dt,
                                rbc.bcc                                                                 AS  bcc,
                                fpn.start_date_time                                                     AS  fpn_start_dt,
                                fpn.end_date_time                                                       AS  fpn_end_dt,
                                santg.start_date_time                                                   AS  santg_start_dt,
                                santg.end_date_time                                                     AS  santg_end_dt,  
                                rc.end_date_time                                                        AS  rc_end_dt,
                                ami.start_date_time                                                     AS  ami_start_dt,
                                ami.end_date_time                                                       AS  ami_end_dt,
                                RANK() OVER(PARTITION BY r.reg_id, wc.process_id ORDER BY wc.process_id DESC, cn.cancel_notice_dt) prnk
                          FROM  ohpnm_dp4bi_dev.registration        r 
                          JOIN  ohpnm_dp4bi_dev.wf_parameter        wp  ON wp.parameter_value = r.reg_id AND parameter_name = 'REGISTRATION_ID' 
                          JOIN  ohpnm_dp4bi_dev.wf_process          wc  ON wc.process_id = wp.process_id 
                          LEFT JOIN
                          (
                              SELECT        rp.reg_id,
                                            pt.mmis_provider_type_id
                                FROM        ohpnm_dp4bi_dev.reg_provider                rp
                                JOIN        ohpnm_dp4bi_dev.provider_type               pt      ON rp.provider_type_id = pt.provider_type_id
                          ) pt
                          ON pt.reg_id = r.reg_id 
                          LEFT JOIN         ohpnm_dp4bi_dev.registration_status_type    rst     ON rst.registration_status_type_id = r.registration_status_type_id
                          LEFT JOIN
                          (
                              SELECT        rs.reg_id,
                                            sr.screening_result_name,
                                            s.end_date_time
                                FROM        ohpnm_dp4bi_dev.reg_screening                               rs
                                LEFT JOIN   ohpnm_dp4bi_dev.screening                                   s       ON rs.screening_id = s.screening_id
                                LEFT JOIN   ohpnm_dp4bi_dev.screening_result                            sr      ON  s.screening_result_id = sr.screening_result_id
                          ) rsr
                          ON rsr.reg_id = r.reg_id
                          LEFT JOIN
                          (
                              SELECT        cec.reg_id,cec.communication_event_id, 
                                            cec.communication_event_date_time                                       AS  cancel_notice_dt  
                                FROM        ohpnm_dp4bi_dev.communication_event             cec  
                                LEFT JOIN   ohpnm_dp4bi_dev.email e     ON e.communication_event_id = cec.communication_event_id
                                LEFT JOIN   ohpnm_dp4bi_dev.mail m      ON m.communication_event_id = cec.communication_event_id                   
                              WHERE         COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt'                  
                          ) cn
                          ON r.reg_id = cn.reg_id AND cn.cancel_notice_dt > wc.start_date_time  
                          LEFT JOIN
                          (

                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Application Received Notice')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                                                                                                                                            
                          ) arns
                          ON        arns.process_id = wp.process_id 
                          LEFT JOIN
                          (
                                SELECT  t.*,
                                        CASE    WHEN    NVL(cs_action, '?') IN ('Approved', 'Application Complete')
                                                THEN    'Y'
                                                ELSE    'N'
                                        END app_review_approved,
                                        CASE    WHEN    NVL(cs_action, '?') IN ('Return to Provider')
                                                THEN    'Y'
                                                ELSE    'N'
                                        END app_review_nmi                                                        
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Provider Review')
                                    
                                        ) t
                                 WHERE  rnk = 1 

                          ) pr  
                          ON        pr.process_id = wp.process_id
                          LEFT JOIN
                          (

                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Initiate Provider Screening')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                            
                          ) ips
                          ON        ips.process_id = wp.process_id
                          LEFT JOIN
                          (

                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Provider Data Entry')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                                                        
                          ) pde
                          ON        pde.process_id = wp.process_id
                          LEFT JOIN
                          (

                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Send Request for Additional Information (RTP Notice)')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                                                        
                          ) rtpns
                          ON        rtpns.process_id = wp.process_id
                          LEFT JOIN
                          (
                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Send Provider Email (BCII Notice)', 'Send Provider Email (FBI Notice)')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                            
                          ) fpn
                          ON        fpn.process_id = wp.process_id    
                          LEFT JOIN
                          (

                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Send Affiliation Notice To Group')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                                                        
                          ) santg
                          ON        santg.process_id = wp.process_id
                          LEFT JOIN
                          (
                              SELECT        rc.reg_id,
                                            c.end_date_time
                                FROM        ohpnm_dp4bi_dev.reg_credentialing                           rc
                                LEFT JOIN   ohpnm_dp4bi_dev.credentialing                               c       ON rc.credentialing_id = c.credentialing_id
                          ) rc
                          ON rc.reg_id = r.reg_id
                          LEFT JOIN
                          (
                                SELECT  t.*
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Assign Med ID')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                            
                          ) ami
                          ON        ami.process_id = wp.process_id
                          LEFT JOIN
                          (
                                SELECT  t.*,
                                        CASE    WHEN    NVL(cs_action, '?') IN ('Background Check Complete')
                                                THEN    'Y'
                                                ELSE    'N'
                                        END bcc
                                  FROM  (
                                          SELECT        curws.process_id,
                                                        curws.start_date_time,
                                                        curws.end_date_time,
                                                        wa.name cs_action,
                                                        RANK() OVER (PARTITION BY curws.process_id ORDER BY curws.step_id DESC) rnk
                                           FROM         ohpnm_dp4bi_dev.wf_step curws -- current task                       
                                           JOIN         ohpnm_dp4bi_dev.wf_task curtsk ON curws.task_id = curtsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_step nextws ON nextws.calling_step_id = curws.step_id 
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_task nextsk ON nextws.task_id = nextsk.task_id
                                           LEFT JOIN    ohpnm_dp4bi_dev.wf_action wa ON wa.task_id = curtsk.task_id AND wa.next_task_id = nextsk.task_id
                                          WHERE         curtsk.name IN ('Fingerprint and Background Check Pending', 'Fingerprint and Background Entry')
                                    
                                        ) t
                                 WHERE  rnk = 1 
                            
                          ) rbc
                          ON        rbc.process_id = wp.process_id
                    ) pcbd
                JOIN public.d_dates dd ON dd.d_date >= CAST(pcbd.process_start_dt AS DATE) AND 
                     dd.d_date <= CAST(COALESCE(pcbd.process_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)                                  
            WHERE prnk = 1
)
group by d_date, application_id;
