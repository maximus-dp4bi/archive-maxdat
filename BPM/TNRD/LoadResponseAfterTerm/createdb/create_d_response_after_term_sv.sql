CREATE OR REPLACE VIEW D_RESPONSE_AFTER_TERM_SV 
AS
SELECT rspat.*,
       CASE WHEN app_receipt_date > recon_start_date AND app_receipt_date <= recon_end_date THEN 'Y' ELSE 'N' END in_90day_recon_period,
       CASE WHEN app_status_cd IN('COMPLETED','DISREGARDED','TIMEOUT') THEN TRUNC(app_status_date) - COALESCE(reactivation_date,app_receipt_date)
    ELSE TRUNC(sysdate) -  COALESCE(reactivation_date,app_receipt_date) END age_in_cal_days
FROM (       
SELECT tt.priority_flag
  ,tt.as_of_date 	
  ,tt.still_eligible  
  ,tt.cde_reason_desc
  ,tt.cde_source 	
  ,tt.dsc_source 	
  ,tt.aid_end 	
  ,tt.elig_end 
  ,tt.dte_rfi_sent 
  ,tt.dte_rfi_response_due 
  ,tt.dte_dhs_med_app 
  ,tt.nam_last 	
  ,tt.nam_first 	
  ,tt.nam_mid_init
  ,tt.rids_id
  ,tt.prior_group
  ,ai.application_id
  ,ai.case_id
  ,ai.app_status_cd
  ,ai.app_status_date
  ,ai.reactivation_date
  ,fmi.first_mi_added_date
  ,omi.oldest_unsatisfied_mi_date
  ,mw.task_id
  ,mw.task_create_date
  ,mw.curr_task_status
  ,mw.curr_task_owner
  ,mw.staff_type_cd
  ,mw.task_name
  ,mw.business_unit_name    
  ,trm.response_due_date recon_start_date
  ,trm.response_due_date + 90 recon_end_date
  ,TRUNC(COALESCE((SELECT MIN(ds.received_date) 
          FROM document_set_stg ds 
            INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
            INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id 
          WHERE doc_type_cd = 'APPLICATION' AND link_type_cd = 'APPLICATION'               
          AND dl.link_ref_id = ai.application_id
          AND TRUNC(ds.received_date) >= trm.letter_mailed_date),
          (SELECT MIN(ds.received_date) 
          FROM document_set_stg ds 
            INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
            INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id 
          WHERE doc_type_cd = 'APPLICATION' AND link_type_cd = 'APPLICATION'               
          AND dl.link_ref_id = ai.application_id ) )) app_receipt_date
  ,CASE WHEN  mw.curr_task_status NOT IN('CLAIMED','UNCLAIMED') THEN 'No Further Operational Action Needed (system research may be required if member is still in a PEND status in MMIS)'
     ELSE CASE WHEN mw.business_unit_name IN('State Eligibility','HCFA Verifications') THEN 'HCFA Tasks Remaining' ELSE 'Maximus Tasks Remaining' END END task_group 
  ,CASE WHEN app_status_cd = 'COMPLETED' AND elig_outcome_cd IN('APPROVED','STATE APPROVED') THEN 'Approved'
        WHEN app_status_cd = 'COMPLETED' AND elig_outcome_cd IN('REJECTED','STATE REJECTED') THEN 'Denied'
        WHEN mw.business_unit_name = 'State Eligibility' THEN
           CASE WHEN task_name IN('Voluntary Terminations','LTSS+','Other Non-MAGI+','MSP Only','Medically Eligible Review') THEN 'Referral to HCFA' ELSE 'Pending HCFA Verification' END
        WHEN app_status_cd NOT IN('COMPLETED','TIMEOUT','DISREGARDED') AND oldest_unsatisfied_mi_date IS NOT NULL THEN 'In Process Pending Response to AI'
    ELSE 'Other' END app_outcome
  ,ai.ssn
FROM response_after_term_stg tt
  LEFT JOIN (SELECT * FROM 
        (SELECT ai.client_id , ah.application_id,  status_cd app_status_cd, status_date app_status_date,trunc(reactivation_ts) reactivation_date,cl.case_id,eo.elig_outcome_cd, clnt.clnt_ssn ssn,
                ROW_NUMBER() OVER (PARTITION BY ai.client_id ORDER BY ai.app_individual_id DESC) rn
         FROM app_header_stg ah
           JOIN app_case_link_stg cl ON ah.application_id = cl.application_id
           JOIN app_individual_stg ai ON ah.application_id = ai.application_id           
           JOIN client_stg clnt ON ai.client_id = clnt.client_id
           LEFT JOIN app_elig_outcome_stg eo ON ah.application_id = eo.application_id           
         )
        WHERE rn =1) ai  ON tt.client_id = ai.client_id
 LEFT JOIN (SELECT *
            FROM (SELECT  mw.task_id,trunc(mw.create_date) task_create_date ,mw.curr_task_status,s.staff_type_cd,tt.task_name,bu.business_unit_name,mw.source_reference_id,COALESCE(mw.case_id,cl.case_id) case_id
                         ,CASE WHEN mw.curr_task_status = 'CLAIMED' THEN s.Last_name||', '||s.First_Name ELSE NULL END curr_task_owner                         
                         ,ROW_NUMBER() OVER (PARTITION BY COALESCE(mw.case_id,cl.case_id) ORDER BY DECODE(curr_task_status,'CLAIMED',1,'UNCLAIMED',1,'COMPLETED',DECODE(tt.task_name,'Returned Mail',2,'Multiple Applying Members',3,4),5) ASC,task_id DESC) rn
                  FROM d_mw_v2_current mw 
                    JOIN d_task_types tt on mw.task_type_id = tt.task_type_id
                    JOIN d_business_units bu ON mw.curr_business_unit_id = bu.business_unit_id  
                    LEFT JOIN d_staff s on mw.curr_owner_staff_id = s.staff_id
                    LEFT JOIN app_case_link_stg cl ON mw.source_reference_id = cl.application_id AND mw.source_reference_type = 'Application ID' 
                  ) 
             WHERE rn = 1 ) mw
             ON mw.case_id = ai.case_id
 LEFT JOIN (SELECT *
            FROM(
            SELECT al.application_id, al.create_ts first_mi_added_date,ROW_NUMBER() OVER(PARTITION BY al.application_id ORDER BY al.create_ts) rn
            FROM app_event_log_stg al                   
            WHERE al.app_event_cd = 'APP_MI_ADDED')
           WHERE rn =1) fmi ON ai.application_id = fmi.application_id
 LEFT JOIN (SELECT application_id, MIN(create_ts) oldest_unsatisfied_mi_date
            FROM app_missing_info_stg 
            WHERE satisfied_date IS NULL
            GROUP BY application_id) omi ON ai.application_id = omi.application_id
 LEFT JOIN (SELECT *
            FROM (SELECT letter_case_id, letter_mailed_date,response_due_date, reference_id,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn            
                  FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                  WHERE lr.letter_type_cd IN('TN 411', 'TN 408', 'TN 408ftp', 'TN 409', 'TN 409ftp','TN 410msp') 
                  AND lr.letter_status_cd = 'MAIL')
             WHERE rn = 1 ) trm  ON ai.application_id = trm.reference_id
 ) rspat ;
    
GRANT SELECT ON D_RESPONSE_AFTER_TERM_SV TO MAXDAT_READ_ONLY;