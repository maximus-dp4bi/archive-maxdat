CREATE OR REPLACE VIEW D_PA_CURRENT_SV
AS
SELECT ah.application_id app_id
       ,COALESCE(ah.app_form_cd,'UD') app_type_code
       ,COALESCE(ah.app_media_cd,'UD') doc_source_code
       ,ah.create_ts app_create_dt
       ,ah.receipt_date app_receipt_dt
       ,COALESCE(ah.status_cd,'UD') app_status_code
       ,sh_comp.status_date app_status_dt   
       ,CASE WHEN ah.status_cd NOT IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN 
        (SELECT
          CASE
            WHEN (COUNT(*) -1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM maxdat_support.d_dates
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN TRUNC(sh_comp.status_date) AND TRUNC(sysdate)) END app_status_age_bd
       ,CASE WHEN  ah.status_cd NOT IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN TRUNC(sysdate) - TRUNC(sh_comp.status_date) END app_status_age_cd
       ,COALESCE(o.program_subtype_cd,'UD') subprogram_code
       ,CASE WHEN app_form_cd = 'HARMONY' THEN 'Y' ELSE 'N' END harmony_flag
       ,sh_rs.status_date app_initial_contact
       ,sh_sched.status_date visit_first_contact
       ,he.cmi_assessment_complete_date visit_attended_date
       ,he.cmi_assessment_schedule_date visit_scheduled_dt  
       ,TRUNC(he.app_start_date) app_start_dt 
       ,pa600_ltr.sent_date pa600_sent_date
       ,pa600_doc.received_date pa600_received_date
       ,lcd_ltr.sent_date loca_date_sent       
       ,lcd_doc.received_date loca_date_received
       ,COALESCE(he.lcd_level_care,'UD') loca_level_care_code
       ,COALESCE(he.lcd_len_care,'UD') loca_length_care_code
       ,pc_ltr.sent_date pc_sent_date
       ,COALESCE(he.phy_level_care,'UD')  pc_level_care_code
       ,COALESCE(he.phy_len_care,'UD') pc_length_care_code
       ,pc_doc.received_date pc_date_received
       ,TRUNC(he.cmi_assessment_complete_date) - TRUNC(he.app_start_date) open_to_visit       
       ,TRUNC(sh_enr.status_date) - TRUNC(he.app_start_date) open_to_enrolled
       ,TRUNC(sh_comp.status_date) - TRUNC(he.app_start_date) open_to_status
       ,TRUNC(pc_ltr.sent_date) - TRUNC(he.app_start_date) open_to_pcsent
       ,TRUNC(pc_doc.received_date) - TRUNC(he.app_start_date) open_to_pcrec
       ,TRUNC(lcd_ltr.sent_date) - TRUNC(he.app_start_date) open_to_locasent
       ,TRUNC(lcd_doc.received_date) - TRUNC(he.app_start_date) open_to_locarec
       ,TRUNC(pa600_doc.received_date) - TRUNC(he.app_start_date) open_to_pa600rec
       ,TRUNC(pa600_ltr.sent_date) - TRUNC(he.app_start_date) open_to_pa600sent
       ,COALESCE(he.mfp_cd,'UD') level_of_need_code
       ,he.potential_discharge_date transition_date
       ,sh_fd.status_date ma162_rec_dt
       ,d1768_ltr.sent_date app_dispatched_cao       
       --,CASE WHEN sh_enr.status_date IS NOT NULL THEN e_enr.report_label ELSE NULL END enrollment_status       
       --,sh_enr.status_date enrollment_status_date
       ,COALESCE(ah.status_cd, 'UD') disposition_status_code
       ,sh_comp.status_date disposition_dt
       ,sh_rvw.status_date app_review_start_dt
       ,sh_elig.status_date eligibility_det_dt
       ,sh_enr.status_date enrolled_dt  -- is this app status ENROLLED ?  specs says OLTL_READY
       ,(SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(sh_enr.status_date) AND TRUNC(sysdate)) enrollment_status_age_bd
       ,TRUNC(sysdate) - TRUNC(sh_enr.status_date) enrollment_status_age_cd
       ,COALESCE(he.reason_delay_cd,'UD') reason_delay_code 
       ,COALESCE(he.enroll_delayed_reason_cd,'UD') enroll_delayed_reason_cd          
       ,CASE WHEN TRUNC(lcd_doc.received_date) - TRUNC(he.app_start_date) > 15 THEN 'Delayed LCD'  -- LOCA Delay
             WHEN TRUNC(pc_doc.received_date) - TRUNC(he.app_start_date) >= 24 THEN 'Delayed PC'   --PC Delay
             WHEN TRUNC(he.cmi_assessment_complete_date) - TRUNC(he.app_start_date) > 30 THEN 'Delayed IVA - Applicant' --Delayed IVA
             WHEN TRUNC(sh_fd.status_date) - TRUNC(he.app_start_date) > 60 THEN 'Delayed PA162' --Delayed PA162
             WHEN he.reason_delay_cd IN('1','2','3','4','5') THEN 'Delayed Enrollment'  --Delayed Enrollment
             WHEN he.reason_delay_cd = '6' THEN 'Delayed OLTL Approval' -- delayed_oltl_approval      
             WHEN he.reason_delay_cd = '8' THEN 'SC Agency response/choice delay' --no SC agency response
             WHEN he.reason_delay_cd = '7' THEN 'Unable to access HCSIS Plan' -- no access to HCSIS plan
             WHEN TRUNC(lcd_ltr.sent_date) - TRUNC(he.app_start_date) > 5 THEN 'Delayed Dispatch of LCD' --LCD Dispatch delay
             WHEN TRUNC(he.cmi_assessment_complete_date) - GREATEST(TRUNC(lcd_doc.received_date),TRUNC(pc_doc.received_date)) > 20 THEN 'Delayed IVA - Maximus' --Delayed IVA Maximus
         ELSE null END delay_excuse
      /* --delay exceptions start
       ,CASE WHEN TRUNC(sh_fd.status_date) - TRUNC(he.app_start_date) > 60 THEN 'Y' ELSE 'N' END delayed_pa162
       ,CASE WHEN TRUNC(he.cmi_assessment_complete_date) - TRUNC(he.app_start_date) > 30 THEN 'Y' ELSE 'N' END delayed_iva --Delayed IVA
       ,CASE WHEN TRUNC(lcd_doc.received_date) - TRUNC(lcd_ltr.sent_date) > 15 THEN 'Y' ELSE 'N' END loca_delay -- LOCA Delay
       ,CASE WHEN TRUNC(pc_doc.received_date) - TRUNC(pc_ltr.sent_date) >= 24 THEN 'Y' ELSE 'N' END pc_delay  --PC Delay
       ,CASE WHEN TRUNC(he.cmi_assessment_complete_date) - GREATEST(TRUNC(lcd_doc.received_date),TRUNC(pc_doc.received_date)) > 20 THEN 'Y' ELSE 'N' END delayed_iva_max -- Delayed IVA Maximus
       ,CASE WHEN TRUNC(lcd_ltr.sent_date) - TRUNC(he.app_start_date) > 5 THEN 'Y' ELSE 'N' END delayed_dispatch_loca -- Delayed dispatch of LOCA
       ,CASE WHEN he.reason_delay_cd IN(1,2,3,4,5) THEN 'Y' ELSE 'N' END delayed_enrollment ---Delayed Enrollment
       ,CASE WHEN he.reason_delay_cd = 7 THEN 'Y' ELSE 'N' END delay_noaccess_hcsis_plan
       ,CASE WHEN he.reason_delay_cd = 8 THEN 'Y' ELSE 'N' END scagency_resp_choice_delay
       ,CASE WHEN he.reason_delay_cd = 6 THEN 'Y' ELSE 'N' END delayed_oltl_approval
       --delay exceptions end*/
       ,final_ltr.sent_date sc_entity_dt
       ,sh_oltl.status_date oltl_ready_dt 
       ,CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN sh_comp.status_date ELSE NULL END complete_dt
       ,COALESCE(he.close_app_reason_cd,'UD') close_reason_code 
       ,COALESCE(sh_elig.status_cd,'UD') elig_app_status_code 
       ,CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN 
          (SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
              ELSE COUNT(*)-1
             END
           FROM maxdat_support.d_dates
           WHERE business_day_flag = 'Y'
           AND d_date BETWEEN TRUNC(ah.create_ts) AND TRUNC(sh_comp.status_date))
         ELSE
           (SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(ah.create_ts) AND TRUNC(sysdate)) END app_age_bd
       ,CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN TRUNC(sh_comp.status_date) - TRUNC(ah.create_ts) 
             ELSE TRUNC(sysdate) - TRUNC(ah.create_ts) END app_age_cd                   
       ,he.enroll_delayed_ind nf_flag
       ,CASE WHEN he.mfp_cd IS NULL THEN 0 ELSE 1 END mfp_flag
       ,TRUNC(he.app_start_date)+90 anticipated_determination          
       ,30 eli_sla_days
       ,'C' eli_sla_days_type
       ,  (SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(he.app_start_date) AND TRUNC(COALESCE(sh_elig.status_date,sysdate))) eli_app_cycle_bus_days
       ,TRUNC(COALESCE(sh_elig.status_date,sysdate)) - TRUNC(he.app_start_date) eli_app_cycle_cal_days       
       ,25 eli_sla_jeopardy_days
       ,25 eli_sla_target_days
       ,TRUNC(he.app_start_date) + 25 eli_sla_jeopardy_dt
       ,CASE WHEN  TRUNC(COALESCE(sh_elig.status_date,sysdate)) - TRUNC(he.app_start_date) >= 25 THEN 'Y' ELSE 'N' END eli_sla_jeopardy_flag       
       ,CASE WHEN sh_elig.status_date IS NOT NULL AND he.app_start_date IS NOT NULL THEN
          CASE WHEN  TRUNC(sh_elig.status_date) - TRUNC(he.app_start_date) <= 30 THEN 'Timely' ELSE 'Untimely' END 
        ELSE 'Not Processed' END eli_timeliness_status
       ,60 app_sla_days
       ,'C' app_sla_days_type
       , (SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(he.app_start_date) AND TRUNC((CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN sh_comp.status_date ELSE sysdate END))) app_cycle_bus_days
       ,TRUNC(CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN sh_comp.status_date ELSE sysdate END) - TRUNC(he.app_start_date) app_cycle_cal_days       
       ,50 app_sla_jeopardy_days
       ,50 app_sla_target_days
       ,TRUNC(he.app_start_date) + 50 app_sla_jeopardy_dt
       ,CASE WHEN TRUNC(CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN sh_comp.status_date ELSE sysdate END) - TRUNC(he.app_start_date) >= 50 THEN 'Y' ELSE 'N' END app_jeopardy_flag       
       ,CASE WHEN (CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN sh_comp.status_date ELSE NULL END) IS NOT NULL AND he.app_start_date IS NOT NULL
          THEN CASE WHEN TRUNC(sh_comp.status_date) - TRUNC(he.app_start_date) <= 60 THEN 'Timely'  ELSE 'Untimely' END
        ELSE 'Not Processed' END app_timeliness_status
       ,1 trans_sla_days
       ,'B' trans_sla_days_type
       ,(SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(sh_enr.status_date) AND TRUNC(COALESCE(final_ltr.sent_date,sysdate))) trans_app_cycle_bus_days
       ,TRUNC(COALESCE(final_ltr.sent_date,sysdate)) - TRUNC(sh_enr.status_date) trans_app_cycle_cal_days       
       ,null trans_sla_jeopardy_days --no sla jeopardy set, so these 4 columns are null
       ,null trans_sla_target_days
       ,null trans_sla_jeopardy_dt
       ,null trans_jeopardy_flag       
       ,CASE WHEN final_ltr.sent_date IS NOT NULL AND sh_enr.status_date IS NOT NULL THEN
          CASE WHEN (SELECT
             CASE
              WHEN (COUNT(*) -1) < 0
              THEN 0
             ELSE COUNT(*)-1
             END
            FROM maxdat_support.d_dates
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(sh_enr.status_date) AND TRUNC(final_ltr.sent_date)) = 1 THEN 'Timely' ELSE 'Untimely' END
        ELSE 'Not Processed' END trans_timeliness_status   
       ,CASE WHEN mi_cert_count >= 1 AND mi_data_count >=1 THEN 'Both'
             WHEN mi_cert_count >= 1 THEN 'Document'
             WHEN mi_data_count >= 1 THEN 'Data' 
        ELSE NULL END pending_mi_type
       ,mi_ltr.lmreq_id mi_letter_id
       ,he.app_header_ext_id open_id
       ,CASE WHEN ah.ref_type_1 = 'COMPASS_APPLICATION_NUMBER' THEN ah.ref_value_1 ELSE NULL END compass_application_id
       ,CASE WHEN sh_elig.status_cd = 'DENIED_INCOMPLETE' THEN COALESCE(hcbsden_doc.received_date,sh_elig.status_date) 
          ELSE COALESCE(sh_fa.status_date,sh_fd.status_date)-1 END determination_notice_dt    
       ,CASE WHEN stf.last_name IS NULL THEN NULL ELSE stf.first_name||' '||stf.last_name END app_created_by 
       ,CASE WHEN he.options = 1 THEN 'Y'
             WHEN he.options = 0 THEN 'N'
        ELSE null END options          
--app
FROM app_header ah 
  LEFT JOIN app_header_ext he ON ah.application_id = he.application_id
  LEFT JOIN app_elig_outcome o ON ah.application_id = o.application_id  
  LEFT JOIN (SELECT *
             FROM (SELECT sh.application_id,sh.status_date,sh.status_cd,ROW_NUMBER() OVER (PARTITION BY sh.application_id ORDER BY app_status_history_id DESC) rn
             FROM app_status_history sh
             WHERE sh.status_cd = 'APP_REVIEW' )
             WHERE rn = 1) sh_rvw  ON ah.application_id = sh_rvw.application_id 
  LEFT JOIN app_status_history sh_sched  ON ah.application_id = sh_sched.application_id AND sh_sched.status_cd = 'SCHEDULED'     
  LEFT JOIN (SELECT *
             FROM (SELECT sh.application_id,sh.status_date,sh.status_cd,ROW_NUMBER() OVER (PARTITION BY sh.application_id ORDER BY app_status_history_id DESC) rn
             FROM app_status_history sh)
             WHERE rn = 1) sh_comp  ON ah.application_id = sh_comp.application_id
  LEFT JOIN app_status_history sh_enr  ON ah.application_id = sh_enr.application_id AND sh_enr.status_cd = 'ENROLLED'     
  LEFT JOIN enum_app_status e_enr ON sh_enr.status_cd = e_enr.value
  LEFT JOIN app_status_history sh_oltl ON ah.application_id = sh_oltl.application_id AND sh_oltl.status_cd = 'OLTL_READY'  
  LEFT JOIN app_status_history sh_fd ON ah.application_id = sh_fd.application_id AND sh_fd.status_cd = 'FINANCIAL_DENIAL'    
  LEFT JOIN app_status_history sh_rs ON ah.application_id = sh_rs.application_id AND sh_rs.status_cd = 'READY_ASSESSMENT'    
  LEFT JOIN app_status_history sh_fa ON ah.application_id = sh_fa.application_id AND sh_fa.status_cd = 'FINANCIAL_APPROVAL'    
  LEFT JOIN (SELECT *
             FROM (SELECT sh.application_id,sh.status_date,sh.status_cd,ROW_NUMBER() OVER (PARTITION BY sh.application_id ORDER BY app_status_history_id DESC) rn
             FROM app_status_history sh
             WHERE sh.status_cd IN('DENIED_INCOMPLETE','DENIED_INELIGIBLE','APPROVED') )
             WHERE rn = 1) sh_elig   ON ah.application_id = sh_elig.application_id
  LEFT JOIN (SELECT i.application_id
                    ,SUM(CASE WHEN mi_category = 'certificate' THEN 1 ELSE 0 END) mi_cert_count
                    ,SUM(CASE WHEN mi_category != 'certificate' THEN 1 ELSE 0 END) mi_data_count       
             FROM app_missing_info i
              INNER JOIN enum_app_mi_type t
                ON i.mi_type_cd = t.value
            WHERE satisfied_date IS NULL  
            GROUP BY application_id) mi_type ON ah.application_id = mi_type.application_id             
  LEFT JOIN staff stf ON TO_CHAR(stf.staff_id) = ah.created_by  
  --LEFT JOIN harmony_conv.openclose oc ON oc.openid = ah.application_id
  --app  
  --letter
  LEFT JOIN (SELECT lr.lmreq_id, lr.sent_on sent_date, lrl.reference_id
             FROM letter_request lr
               INNER JOIN letter_request_link lrl 
                 ON lr.lmreq_id = lrl.lmreq_id
               INNER JOIN letter_definition ld
                 ON lr.lmdef_id = ld.lmdef_id
              WHERE reference_type = 'APP_HEADER'
              AND ld.name = 'LCDETER'
              AND lr.request_type = 'L'
              AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) lcd_ltr ON ah.application_id = lcd_ltr.reference_id         
    LEFT JOIN (SELECT lr.lmreq_id, lr.sent_on sent_date, lrl.reference_id
             FROM letter_request lr
               INNER JOIN letter_request_link lrl 
                 ON lr.lmreq_id = lrl.lmreq_id
               INNER JOIN letter_definition ld
                 ON lr.lmdef_id = ld.lmdef_id
              WHERE reference_type = 'APP_HEADER'
              AND ld.name = 'PA600'
              AND lr.request_type = 'L'
              AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) pa600_ltr ON ah.application_id = pa600_ltr.reference_id              
    LEFT JOIN (SELECT *
             FROM(
               SELECT lr.lmreq_id, lrl.reference_id, lr.sent_on sent_date, ROW_NUMBER() OVER (PARTITION BY lrl.reference_id ORDER BY lr.sent_on DESC) rn
               FROM letter_request lr
                 INNER JOIN letter_request_link lrl 
                   ON lr.lmreq_id = lrl.lmreq_id
                 INNER JOIN letter_definition ld
                   ON lr.lmdef_id = ld.lmdef_id
               WHERE reference_type = 'APP_HEADER'
               AND ld.name LIKE 'PH%'
               AND lr.request_type = 'L'
               AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) 
             WHERE rn = 1  ) pc_ltr ON ah.application_id = pc_ltr.reference_id 
   LEFT JOIN (SELECT *
             FROM(SELECT lr.lmreq_id, lrl.reference_id, lr.sent_on sent_date, ROW_NUMBER() OVER (PARTITION BY lrl.reference_id ORDER BY lr.sent_on DESC) rn
                  FROM letter_request lr
                   INNER JOIN letter_request_link lrl 
                     ON lr.lmreq_id = lrl.lmreq_id
                   INNER JOIN letter_definition ld
                     ON lr.lmdef_id = ld.lmdef_id
                   WHERE reference_type = 'APP_HEADER'
                   AND ld.name IN('A1768','D1768','T1768')
                   AND lr.request_type = 'L'
                   AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS'))
              WHERE rn = 1  )  d1768_ltr ON ah.application_id = d1768_ltr.reference_id           
   LEFT JOIN (SELECT *
              FROM(SELECT lr.lmreq_id, lrl.reference_id, lr.sent_on sent_date, ROW_NUMBER() OVER (PARTITION BY lrl.reference_id ORDER BY lr.sent_on DESC) rn
                   FROM letter_request lr
                    INNER JOIN letter_request_link lrl 
                     ON lr.lmreq_id = lrl.lmreq_id
                    INNER JOIN letter_definition ld
                     ON lr.lmdef_id = ld.lmdef_id
                   WHERE reference_type = 'APP_HEADER'
                   AND ld.name IN('PHCC','PHCP','PCREM','LCDETER') -- are these MI letters too 'PCINCOMP','MIREM' ?
                   AND lr.request_type = 'L'
                   AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) 
               WHERE rn = 1  )    mi_ltr ON ah.application_id = mi_ltr.reference_id 
   LEFT JOIN (SELECT lr.lmreq_id, lr.sent_on sent_date, lrl.reference_id
             FROM letter_request lr
               INNER JOIN letter_request_link lrl 
                 ON lr.lmreq_id = lrl.lmreq_id
               INNER JOIN letter_definition ld
                 ON lr.lmdef_id = ld.lmdef_id
              WHERE reference_type = 'APP_HEADER'
              AND ld.name = 'FINALPACKET'
              AND lr.request_type = 'L'
              AND lr.status_cd IN('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) final_ltr              
     ON ah.application_id = final_ltr.reference_id        
  --letter  
 --doc received 
 LEFT JOIN (SELECT *FROM (
                SELECT link_ref_id,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                FROM document d 
                INNER JOIN document_set s 
                  ON d.document_set_id = s.document_set_id 
                INNER JOIN doc_link dl 
                  ON d.document_id = dl.document_id  
                INNER JOIN enum_document_source ds
                  ON s.doc_source_cd = ds.value
                WHERE doc_type_cd = 'OTHER'
                AND doc_form_type = 'APP_REQUEST'
                AND link_type_cd = 'APPLICATION')
           WHERE rn = 1) pa600_doc ON pa600_doc.link_ref_id = ah.application_id     
 LEFT JOIN (SELECT * FROM (
                SELECT link_ref_id,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                FROM document d 
                INNER JOIN document_set s 
                  ON d.document_set_id = s.document_set_id 
                INNER JOIN doc_link dl 
                  ON d.document_id = dl.document_id  
                INNER JOIN enum_document_source ds
                  ON s.doc_source_cd = ds.value
                WHERE doc_type_cd = 'MEDICAL_INFORMATION'
                AND doc_form_type = 'LCD'
                AND link_type_cd = 'APPLICATION')
           WHERE rn = 1) lcd_doc ON lcd_doc.link_ref_id = ah.application_id 
LEFT JOIN (SELECT * FROM (
                SELECT link_ref_id,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                FROM document d 
                INNER JOIN document_set s 
                  ON d.document_set_id = s.document_set_id 
                INNER JOIN doc_link dl 
                  ON d.document_id = dl.document_id  
                INNER JOIN enum_document_source ds
                  ON s.doc_source_cd = ds.value
                WHERE doc_type_cd = 'MEDICAL_INFORMATION'
                AND doc_form_type = 'PC'
                AND link_type_cd = 'APPLICATION')
           WHERE rn = 1) pc_doc ON pc_doc.link_ref_id = ah.application_id
LEFT JOIN (SELECT * FROM (
                SELECT link_ref_id,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                FROM document d 
                INNER JOIN document_set s 
                  ON d.document_set_id = s.document_set_id 
                INNER JOIN doc_link dl 
                  ON d.document_id = dl.document_id  
                INNER JOIN enum_document_source ds
                  ON s.doc_source_cd = ds.value
                WHERE doc_type_cd = 'OTHER'
                AND doc_form_type = 'HCBS_DENIAL_FORM'
                AND link_type_cd = 'APPLICATION')
           WHERE rn = 1) hcbsden_doc ON hcbsden_doc.link_ref_id = ah.application_id  ;


GRANT SELECT ON D_PA_CURRENT_SV TO MAXDAT_REPORTS;