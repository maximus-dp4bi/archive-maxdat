####################################################
D_PA_CURRENT_SV :
####################################################

CREATE OR REPLACE VIEW D_PA_CURRENT_SV AS
SELECT /*+ parallel(5) */
           ah.application_id
               app_id,
           COALESCE (ah.app_form_cd, 'UD')
               app_type_code,
           COALESCE (ah.app_media_cd, 'UD')
               doc_source_code,
           ah.create_ts
               app_create_dt,
           ah.receipt_date
               app_receipt_dt,
           COALESCE (ah.status_cd, 'UD')
               app_status_code,
           sh_comp.status_dt
               app_status_dt,
           CASE
               WHEN ah.status_cd NOT IN ('CLOSED',
                                         'COMPLETED',
                                         'TIMEOUT',
                                         'DISREGARDED',
                                         'ENROLLED')
               THEN
                   (SELECT CASE
                               WHEN (COUNT (*) - 1) < 0 THEN 0
                               ELSE COUNT (*) - 1
                           END
                      FROM PAIEB_PRD.d_dates
                     WHERE     business_day_flag = 'Y'
                           AND d_date BETWEEN CAST (sh_comp.status_dt AS DATE)
                                          AND CAST (CURRENT_DATE() AS DATE)
                   )
           END
               app_status_age_bd,
           CASE
               WHEN ah.status_cd NOT IN ('CLOSED',
                                         'COMPLETED',
                                         'TIMEOUT',
                                         'DISREGARDED',
                                         'ENROLLED')
               THEN
                   CAST (CURRENT_DATE() AS DATE) - CAST (sh_comp.status_dt AS DATE)
           END
               app_status_age_cd,
           o.elig_outcome_cd,
           o.elig_outcome_reason_cd,
           o.create_ts
               AS elig_outcome_create_ts,
           o.created_by
               AS elig_outcome_created_by,
           o.update_ts
               AS elig_outcome_update_ts,
           o.updated_by
               AS elig_outcome_updated_by,
           COALESCE (o.program_subtype_cd, 'UD')
               subprogram_code,
           CASE WHEN app_form_cd = 'HARMONY' THEN 'Y' ELSE 'N' END
               harmony_flag,
           he.cmi_assessment_complete_date
               visit_attended_date,
           he.cmi_assessment_schedule_date
               visit_scheduled_dt,
           CAST (he.app_start_date AS DATE)
               app_start_dt,
           NULL as pa600_received_date,
           NULL as loca_date_sent,
           NULL as loca_date_received,
           COALESCE (he.lcd_level_care, 'UD')
               loca_level_care_code,
           COALESCE (he.lcd_len_care, 'UD')
               loca_length_care_code,
           NULL as pc_sent_date,
           
           COALESCE (he.phy_level_care, 'UD')
               pc_level_care_code,
           COALESCE (he.phy_len_care, 'UD')
               pc_length_care_code,
           NULL as pc_date_received,
             
             CAST (he.cmi_assessment_complete_date AS DATE)
           - CAST (he.app_start_date AS DATE)
               open_to_visit,
           CAST (sh_comp.status_dt AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_status,
           CAST (pc_ltr.sent_date AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_pcsent,
           CAST (app_doc.pc_received_date AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_pcrec,
           CAST (lcd_ltr.sent_date AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_locasent,
           CAST (app_doc.lcd_received_date AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_locarec,
           CAST (app_doc.pa600_received_date AS DATE) - CAST (he.app_start_date AS DATE)
               open_to_pa600rec,
           COALESCE (he.mfp_cd, 'UD')
               level_of_need_code,
           he.potential_discharge_date
               transition_date,
           d1768_ltr.sent_date
               app_dispatched_cao,
           CAST (p1768_ltr.sent_date AS DATE)
               P1768_SENT_DT,
           COALESCE (ah.status_cd, 'UD')
               disposition_status_code,
           COALESCE (he.reason_delay_cd, 'UD')
               reason_delay_code,
           COALESCE (he.enroll_delayed_reason_cd, 'UD')
               enroll_delayed_reason_cd,
           CASE
               WHEN   CAST (app_doc.lcd_received_date AS DATE)
                    - CAST (he.app_start_date AS DATE) >
                    15
               THEN
                   'Delayed LCD'                                 -- LOCA Delay
               WHEN   CAST (app_doc.pc_received_date AS DATE)
                    - CAST (he.app_start_date AS DATE) >=
                    24
               THEN
                   'Delayed PC'                                     --PC Delay
               WHEN   CAST (he.cmi_assessment_complete_date AS DATE)
                    - CAST (he.app_start_date AS DATE) >
                    30
               THEN
                   'Delayed IVA - Applicant'                     --Delayed IVA
               WHEN   CAST (ash.fin_denial_status_dt AS DATE)
                    - CAST (he.app_start_date AS DATE) >
                    60
               THEN
                   'Delayed PA162'                             --Delayed PA162
               WHEN he.reason_delay_cd IN ('1',
                                           '2',
                                           '3',
                                           '4',
                                           '5')
               THEN
                   'Delayed Enrollment'                   --Delayed Enrollment
               WHEN he.reason_delay_cd = '6'
               THEN
                   'Delayed OLTL Approval'            -- delayed_oltl_approval
               WHEN he.reason_delay_cd = '8'
               THEN
                   'SC Agency response/choice delay'   --no SC agency response
               WHEN he.reason_delay_cd = '7'
               THEN
                   'Unable to access HCSIS Plan'    -- no access to HCSIS plan
               WHEN CAST (lcd_ltr.sent_date AS DATE) - CAST (he.app_start_date AS DATE) > 5
               THEN
                   'Delayed Dispatch of LCD'              --LCD Dispatch delay
               WHEN   CAST (he.cmi_assessment_complete_date AS DATE)
                    - GREATEST (CAST (app_doc.lcd_received_date AS DATE),
                                CAST (app_doc.pc_received_date AS DATE)) >
                    20
               THEN
                   'Delayed IVA - Maximus'               --Delayed IVA Maximus
               ELSE
                   NULL
           END
               delay_excuse,
           final_ltr.sent_date
               sc_entity_dt,
           CASE
               WHEN he.close_app_ts IS NOT NULL
               THEN
                   he.close_app_ts
               WHEN ah.status_cd IN ('CLOSED',
                                     'COMPLETED',
                                     'TIMEOUT',
                                     'DISREGARDED',
                                     'ENROLLED')
               THEN
                   sh_comp.status_dt
               ELSE
                   NULL
           END
               complete_dt,
           COALESCE (he.close_app_reason_cd, 'UD')
               close_reason_code,
           CASE
               WHEN     COALESCE (approved_ash_id, 0) >
                        COALESCE (denied_inelig_ash_id, 0)
                    AND COALESCE (approved_ash_id, 0) >
                        COALESCE (denied_incomp_ash_id, 0)
               THEN
                   'APPROVED'
               WHEN     COALESCE (denied_inelig_ash_id, 0) >
                        COALESCE (approved_ash_id, 0)
                    AND COALESCE (denied_inelig_ash_id, 0) >
                        COALESCE (denied_incomp_ash_id, 0)
               THEN
                   'DENIED_INELIGIBLE'
               WHEN     COALESCE (denied_incomp_ash_id, 0) >
                        COALESCE (denied_inelig_ash_id, 0)
                    AND COALESCE (denied_incomp_ash_id, 0) >
                        COALESCE (approved_ash_id, 0)
               THEN
                   'DENIED_INCOMPLETE'
               ELSE
                   'UD'
           END
               elig_app_status_code,
           CASE
               WHEN ah.status_cd IN ('CLOSED',
                                     'COMPLETED',
                                     'TIMEOUT',
                                     'DISREGARDED',
                                     'ENROLLED')
               THEN
                   (SELECT CASE
                               WHEN (COUNT (*) - 1) < 0 THEN 0
                               ELSE COUNT (*) - 1
                           END
                      FROM PAIEB_PRD.d_dates
                     WHERE     business_day_flag = 'Y'
                           AND d_date BETWEEN CAST (ah.create_ts AS DATE)
                                          AND CAST (sh_comp.status_dt AS DATE))
               ELSE
                   (SELECT CASE
                               WHEN (COUNT (*) - 1) < 0 THEN 0
                               ELSE COUNT (*) - 1
                           END
                      FROM PAIEB_PRD.d_dates
                     WHERE     business_day_flag = 'Y'
                           AND d_date BETWEEN CAST (ah.create_ts AS DATE)
                                          AND CAST (CURRENT_DATE() AS DATE))
           END
               app_age_bd,
           CASE
               WHEN     ah.created_by = 'DATA_CONVERSION'
                    AND ah.status_cd NOT IN ('CLOSED',
                                             'COMPLETED',
                                             'TIMEOUT',
                                             'DISREGARDED',
                                             'ENROLLED')
                    AND ah.create_ts IS NULL
               THEN
                  NULL-- CAST (CURRENT_DATE() AS DATE) - CAST (oc.opendate AS DATE)
               WHEN     ah.created_by <> 'DATA_CONVERSION'
                    AND ah.status_cd IN ('CLOSED',
                                         'COMPLETED',
                                         'TIMEOUT',
                                         'DISREGARDED',
                                         'ENROLLED')
               THEN
                   CAST (sh_comp.status_dt AS DATE) - CAST (ah.create_ts AS DATE)
               ELSE
                   CAST (CURRENT_DATE() AS DATE) - CAST (ah.create_ts AS DATE)
           END
               app_age_cd,
           COALESCE (he.enroll_delayed_ind, 0)
               nf_flag,
           CASE WHEN he.mfp_cd IS NULL THEN 0 ELSE 1 END
               mfp_flag,
           CAST (he.app_start_date AS DATE) + 90
               anticipated_determination,
           30
               eli_sla_days,
           'C'
               eli_sla_days_type,
           25
               eli_sla_jeopardy_days,
           25
               eli_sla_target_days,
           CAST (he.app_start_date AS DATE) + 25
               eli_sla_jeopardy_dt,
           60
               app_sla_days,
           'C'
               app_sla_days_type,
           (SELECT CASE
                       WHEN (COUNT (*) - 1) < 0 THEN 0
                       ELSE COUNT (*) - 1
                   END
              FROM PAIEB_PRD.d_dates
             WHERE     business_day_flag = 'Y'
                   AND d_date BETWEEN CAST (he.app_start_date AS DATE)
                                  AND CAST (
                                          (CASE
                                               WHEN ah.status_cd IN
                                                        ('CLOSED',
                                                         'COMPLETED',
                                                         'TIMEOUT',
                                                         'DISREGARDED',
                                                         'ENROLLED')
                                               THEN
                                                   sh_comp.status_dt
                                               ELSE
                                                   CURRENT_DATE()
                                           END) AS DATE))
               app_cycle_bus_days,
             CAST (CASE
                        WHEN ah.status_cd IN ('CLOSED',
                                              'COMPLETED',
                                              'TIMEOUT',
                                              'DISREGARDED',
                                              'ENROLLED')
                        THEN
                            sh_comp.status_dt
                        ELSE
                            CURRENT_DATE
                    END AS DATE)
           - CAST (he.app_start_date AS DATE)
               app_cycle_cal_days,
           50
               app_sla_jeopardy_days,
           50
               app_sla_target_days,
           CAST (he.app_start_date AS DATE) + 50
               app_sla_jeopardy_dt,
           CASE
               WHEN   CAST (CASE
                                 WHEN ah.status_cd IN ('CLOSED',
                                                       'COMPLETED',
                                                       'TIMEOUT',
                                                       'DISREGARDED',
                                                       'ENROLLED')
                                 THEN
                                     sh_comp.status_dt
                                 ELSE
                                     CURRENT_DATE()
                             END AS DATE )
                    - CAST (he.app_start_date AS DATE) >= 50
               THEN
                   'Y'
               ELSE
                   'N'
           END
               app_jeopardy_flag,
           CASE
               WHEN     (CASE
                             WHEN ah.status_cd IN ('CLOSED',
                                                   'COMPLETED',
                                                   'TIMEOUT',
                                                   'DISREGARDED',
                                                   'ENROLLED')
                             THEN
                                 sh_comp.status_dt
                             ELSE
                                 NULL
                         END)
                            IS NOT NULL
                    AND he.app_start_date IS NOT NULL
               THEN
                   CASE
                       WHEN   CAST (sh_comp.status_dt AS DATE)
                            - CAST (he.app_start_date AS DATE) <=
                            60
                       THEN
                           'Timely'
                       ELSE
                           'Untimely'
                   END
               ELSE
                   'Not Processed'
           END
               app_timeliness_status,
           1
               trans_sla_days,
           'B'
               trans_sla_days_type,
           NULL
               trans_sla_jeopardy_days --no sla jeopardy set, so these 4 columns are null
                                      ,
           NULL
               trans_sla_target_days,
           NULL
               trans_sla_jeopardy_dt,
           NULL
               trans_jeopardy_flag,
           CASE
               WHEN mi_type.mi_cert_count >= 1 AND mi_data_count >= 1
               THEN
                   'Both'
               WHEN mi_type.mi_cert_count >= 1
               THEN
                   'Document'
               WHEN mi_type.mi_data_count >= 1
               THEN
                   'Data'
               ELSE
                   NULL
           END
               pending_mi_type,
           mi_ltr.lmreq_id
               mi_letter_id,
           he.app_header_ext_id
               open_id,
           CASE
               WHEN ah.ref_type_1 = 'COMPASS_APPLICATION_NUMBER'
               THEN
                   ah.ref_value_1
               ELSE
                   NULL
           END
               compass_application_id,
           CASE
               WHEN ah.created_by = 'DATA_CONVERSION' THEN 'DATA_CONVERSION'
               WHEN stf.last_name IS NULL THEN NULL
               ELSE stf.first_name || ' ' || stf.last_name
           END
               app_created_by,
           CASE
               WHEN he.options = 1 THEN 'Y'
               WHEN he.options = 0 THEN 'N'
               ELSE NULL
           END
               options,
           ah.mi_ind,
           ah.first_mi_added_date,
           ah.overall_mi_ind,
           he.actual_discharge_date,
           he.applicant_med_assistance_ind,
           he.applicant_receive_waiver_ind,
           he.oth_waiver_cd,
           he.cmi_sc_agency_1,
           he.cmi_sc_agency_2,
           he.cmi_sc_agency_3,
           he.cmi_nh_tran_coordinator_1,
           he.cmi_nh_tran_coordinator_2,
           he.cmi_nh_tran_coordinator_3,
           he.phy_sign_date,
           he.phy_cert_status,
           he.lcd_supervisor_sign_date,
           he.lcd_status,
           --SUBSTR (he.approval_denial_1768_comment, 4000, 1)
           --    AS approval_denial_1768_comment,
           pa600_ltr.sent_date
               AS pa600_letter_date,
           CAST (pa600_ltr.sent_date AS DATE) - CAST (he.app_start_date AS DATE)
               AS open_to_pa600_sent,
           final_ltr.lmreq_id
               AS final_packet_letter_id,
           he.md_review_ind,
           he.chc_zone_ind--Status dates
                          ,
           sh_comp.status_dt
               disposition_dt --this is the date of the most recent app_status_history record
                             ,
           ash.app_review_status_dt
               app_review_start_dt,
           ash.app_review_end_dt,
           ash.approved_status_dt
               approved_dt,
           ash.approved_end_dt
               xapproved_dt,
           ash.assess_in_proc_status_dt
               assess_in_proc_start_dt,
           ash.assess_in_proc_end_dt,
           ash.fin_appr_status_dt
               fin_appr_start_dt,
           ash.fin_appr_end_dt,
           ash.fin_appr_mismatch_status_dt
               fin_appr_mismatch_start_dt,
           ash.fin_appr_mismatch_end_dt,
           ash.fin_denial_status_dt
               ma162_rec_dt,
           ash.fin_denial_end_dt,
           COALESCE (ash.approved_status_dt,
                     ash.ready_trans_status_dt,
                     ash.mms_ready_status_dt)
               mms_dt,
           COALESCE (ash.fin_appr_status_dt,
                     ash.fin_denial_status_dt,
                     ash.fin_appr_mismatch_status_dt)
               xmms_dt,
           ash.oltl_ready_status_dt
               oltl_ready_dt,
           ash.oltl_ready_end_dt,
           ash.pc_lcd_pending_status_dt
               pc_lcd_pending_dt,
           ash.pc_lcd_pending_end_dt
               xpc_lcd_pending_dt,
           ash.ready_assess_status_dt
               app_initial_contact,
           ash.ready_assess_end_dt,
           ash.ready_trans_status_dt
               ready_trans_start_dt,
           ash.ready_trans_end_dt,
           ash.scheduled_status_dt
               visit_first_contact,
           ash.scheduled_end_dt,
           ash.pending_status_dt,
           ash.pending_end_dt,
           COALESCE (ash.approved_status_dt,
                     ash.denied_inelig_status_dt,
                     ash.denied_incomp_status_dt)
               eligibility_det_dt,
           COALESCE (ash.completed_status_dt, ash.enrolled_status_dt)
               enrolled_dt --we are looking for completed really, so that goes first
                          ,
           COALESCE (ash.scheduled_status_dt,
                     ash.ready_assess_status_dt,
                     ash.assess_in_proc_status_dt)
               eb_iva_start_dt,
           COALESCE (ash.fin_appr_status_dt,
                     ash.fin_denial_status_dt,
                     ash.fin_appr_mismatch_status_dt)
               fin_appr_cycle_start_dt,
           ash.oltl_ready_status_dt
               data_entry_cycle_start_dt--Calculations based on Status Dates
                                        ,
             CAST (
                 COALESCE (ash.completed_status_dt, ash.enrolled_status_dt) AS DATE)
           - CAST (he.app_start_date AS DATE)
               open_to_enrolled,
           CASE
               WHEN ash.pc_lcd_pending_status_dt IS NULL
               THEN
                   NULL
               WHEN     ash.pc_lcd_pending_end_dt IS NULL
                    AND COALESCE (mi_dates.pc_date, mi_dates.pc_date)--oc.pcdatereceived)
                            IS NULL
               THEN
                   CAST (CURRENT_DATE() AS DATE) - CAST (ash.pc_lcd_pending_status_dt AS DATE)
               WHEN     ash.pc_lcd_pending_end_dt IS NOT NULL
                    AND COALESCE (mi_dates.pc_date, mi_dates.pc_date)--oc.pcdatereceived)
                            IS NULL
               THEN
                   0
               ELSE
                     CAST (COALESCE (mi_dates.pc_date, mi_dates.pc_date) AS DATE)--oc.pcdatereceived) AS DATE)
                   - CAST (ash.pc_lcd_pending_status_dt AS DATE)
           END
               AS pc_lcd_to_pc_rcvd,
           CASE
               WHEN ash.pc_lcd_pending_status_dt IS NULL
               THEN
                   NULL
               WHEN     ash.pc_lcd_pending_end_dt IS NULL
                    AND COALESCE (mi_dates.lcd_date, mi_dates.lcd_date)--oc.locadatereceived)
                            IS NULL
               THEN
                   CAST (CURRENT_DATE() AS DATE) - CAST (ash.pc_lcd_pending_status_dt AS DATE)
               WHEN     ash.pc_lcd_pending_end_dt IS NOT NULL
                    AND COALESCE (mi_dates.lcd_date, mi_dates.lcd_date)-- oc.locadatereceived)
                            IS NULL
               THEN
                   0
               ELSE
                     CAST (
                         COALESCE (mi_dates.lcd_date, mi_dates.lcd_date) AS DATE)--oc.locadatereceived) AS DATE)
                   - CAST (ash.pc_lcd_pending_status_dt AS DATE)
           END
               AS pc_lcd_to_loca_rcvd,
             CAST (COALESCE (ash.pc_lcd_pending_end_dt, CURRENT_DATE()) AS DATE)
           - CAST (ash.pc_lcd_pending_status_dt AS DATE)
               AS days_in_lcd,
             CAST (COALESCE (ash.mms_ready_end_dt, CURRENT_DATE()) AS DATE)
           - CAST (ash.mms_ready_status_dt AS DATE)
               AS days_in_mms,
             CAST (COALESCE (ash.approved_end_dt, CURRENT_DATE()) AS DATE)
           - CAST (ash.approved_status_dt AS DATE)
               AS days_in_apprv,
           (SELECT CASE
                       WHEN (COUNT (*) - 1) < 0 THEN 0
                       ELSE COUNT (*) - 1
                   END
              FROM PAIEB_PRD.d_dates
             WHERE     business_day_flag = 'Y'
                   AND d_date BETWEEN CAST (
                                          COALESCE (ash.completed_status_dt,
                                                    ash.enrolled_status_dt) AS DATE)
                                  AND CAST (CURRENT_DATE() AS DATE))
               enrollment_status_age_bd,
             CAST (CURRENT_DATE() AS DATE)
           - CAST (
                 COALESCE (ash.completed_status_dt, ash.enrolled_status_dt) AS DATE)
               enrollment_status_age_cd,
           (SELECT CASE
                       WHEN (COUNT (*) - 1) < 0 THEN 0
                       ELSE COUNT (*) - 1
                   END
              FROM PAIEB_PRD.d_dates
             WHERE     business_day_flag = 'Y'
                   AND d_date BETWEEN CAST (he.app_start_date AS DATE)
                                  AND CAST (
                                          COALESCE (
                                              ash.approved_status_dt,
                                              ash.denied_inelig_status_dt,
                                              ash.denied_incomp_status_dt,
                                              CURRENT_DATE()) AS DATE))
               eli_app_cycle_bus_days,
             CAST (COALESCE (ash.approved_status_dt,
                              ash.denied_inelig_status_dt,
                              ash.denied_incomp_status_dt,
                              CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               eli_app_cycle_cal_days,
           CASE
               WHEN   CAST (COALESCE (ash.approved_status_dt,
                                       ash.denied_inelig_status_dt,
                                       ash.denied_incomp_status_dt,
                                       CURRENT_DATE()) AS DATE)
                    - CAST (he.app_start_date AS DATE) >= 25
               THEN
                   'Y'
               ELSE
                   'N'
           END
               eli_sla_jeopardy_flag,
           CASE
               WHEN     COALESCE (ash.approved_status_dt,
                                  ash.denied_inelig_status_dt,
                                  ash.denied_incomp_status_dt)
                            IS NOT NULL
                    AND he.app_start_date IS NOT NULL
               THEN
                   CASE
                       WHEN   CAST (
                                  COALESCE (ash.approved_status_dt,
                                            ash.denied_inelig_status_dt,
                                            ash.denied_incomp_status_dt) AS DATE)
                            - CAST (he.app_start_date AS DATE) <=
                            30
                       THEN
                           'Timely'
                       ELSE
                           'Untimely'
                   END
               ELSE
                   'Not Processed'
           END
               eli_timeliness_status,
           (SELECT CASE
                       WHEN (COUNT (*) - 1) < 0 THEN 0
                       ELSE COUNT (*) - 1
                   END
              FROM PAIEB_PRD.d_dates
             WHERE     business_day_flag = 'Y'
                   AND d_date BETWEEN CAST (
                                          COALESCE (ash.completed_status_dt,
                                                    ash.enrolled_status_dt) AS DATE)
                                  AND CAST (
                                          COALESCE (final_ltr.sent_date,
                                                    CURRENT_DATE()) AS DATE))
               trans_app_cycle_bus_days,
             CAST (COALESCE (final_ltr.sent_date, CURRENT_DATE()) AS DATE)
           - CAST (
                 COALESCE (ash.completed_status_dt, ash.enrolled_status_dt) AS DATE)
               trans_app_cycle_cal_days,
           CASE
               WHEN     final_ltr.sent_date IS NOT NULL
                    AND COALESCE (ash.completed_status_dt,
                                  ash.enrolled_status_dt)
                            IS NOT NULL
               THEN
                   CASE
                       WHEN (SELECT CASE
                                        WHEN (COUNT (*) - 1) < 0 THEN 0
                                        ELSE COUNT (*) - 1
                                    END
                               FROM PAIEB_PRD.d_dates
                              WHERE     business_day_flag = 'Y'
                                    AND d_date BETWEEN CAST (
                                                           COALESCE (
                                                               ash.completed_status_dt,
                                                               ash.enrolled_status_dt) AS DATE)
                                                   AND CAST (
                                                           final_ltr.sent_date AS DATE)) =
                            1
                       THEN
                           'Timely'
                       ELSE
                           'Untimely'
                   END
               ELSE
                   'Not Processed'
           END
               trans_timeliness_status,
           CASE
               WHEN     COALESCE (denied_incomp_ash_id, 0) >
                        COALESCE (denied_inelig_ash_id, 0)
                    AND COALESCE (denied_incomp_ash_id, 0) >
                        COALESCE (approved_ash_id, 0)
               THEN
                   COALESCE (app_doc.hcbsden_received_date,
                             ash.approved_status_dt,
                             ash.denied_inelig_status_dt,
                             ash.denied_incomp_status_dt)
               ELSE
                     COALESCE (ash.fin_appr_status_dt,
                               ash.fin_denial_status_dt)
                   - 1
           END
               determination_notice_dt,--Application Processing Cycle Times
                                      
             CAST (COALESCE (ash.app_review_status_dt, CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               pc_lcd_cycle_age_cd,
             CAST (COALESCE (ash.scheduled_status_dt,
                              ash.ready_assess_status_dt,
                              ash.assess_in_proc_status_dt,
                              CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               app_review_cycle_age_cd,
             CAST (COALESCE (ash.approved_status_dt,
                              ash.mms_ready_status_dt,
                              ash.ready_trans_status_dt,
                              CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               eb_iva_cycle_age_cd,
             CAST (COALESCE (ash.fin_appr_status_dt,
                              ash.fin_denial_status_dt,
                              ash.fin_appr_mismatch_status_dt,
                              CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               mms_cycle_age_cd,
             CAST (COALESCE (ash.oltl_ready_status_dt, CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               fin_appr_cycle_age_cd,
             CAST (COALESCE (ash.enrolled_status_dt, CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               data_entry_cycle_age_cd,
             CAST (
                 COALESCE (ash.completed_status_dt,
                           ash.closed_status_dt,
                           CURRENT_DATE()) AS DATE)
           - CAST (he.app_start_date AS DATE)
               final_mail_cycle_age_cd,
           ash.pending_next_status-- added by James Frick, 8/15/2019
                                  ,
           he.FIRST_CONTACT_DATE,
           he.LAST_IVA_CONTACT_DATE,
           PERMISSION_TO_SHARE_IND,
           ddoc.how_heard_other,
           CASE WHEN ddoc.HOW_HEARD_OTHER LIKE '%DUAL%' THEN 'Y' ELSE 'N' END
               Dual_Household_flag,
      --app
      he.REASON_DELAYED_SCHEDULE,
      he.MD_DETERMINATION
      FROM PAIEB_PRD.app_header  ah
           LEFT JOIN PAIEB_PRD.app_header_ext he
               ON (ah.application_id = he.application_id)
           LEFT JOIN PAIEB_PRD.app_elig_outcome o
               ON (ah.application_id = o.application_id)
           LEFT JOIN
           (SELECT *
              FROM (SELECT dd.application_id,
                           UPPER (dd.how_heard_other)                     how_heard_other,
                           ROW_NUMBER ()
                               OVER (PARTITION BY dd.application_id
                                     ORDER BY dd.app_doc_data_id DESC)    rown
                      FROM PAIEB_PRD.app_doc_data dd
                     WHERE UPPER (dd.how_heard_other) LIKE '%DUAL%')
             WHERE rown = 1) ddoc
               ON (ah.application_id = ddoc.application_id)
           --Pivot the app_status_history records per application, we are taking the most recent record in each status
           LEFT JOIN
           /*
           (SELECT *
              FROM (SELECT sh.application_id,
                           sh.app_status_history_id,
                           sh.status_cd,
                           sh.status_dt,
                           ROW_NUMBER ()
                               OVER (
                                   PARTITION BY sh.application_id,
                                                sh.status_cd
                                   ORDER BY app_status_history_id DESC)
                               rn,
                           LEAD (sh.app_status_history_id, 1)
                               OVER (PARTITION BY sh.application_id
                                     ORDER BY sh.app_status_history_id ASC)
                               next_ash_id,
                           LEAD (sh.status_dt, 1)
                               OVER (PARTITION BY sh.application_id
                                     ORDER BY sh.app_status_history_id ASC)
                               end_dt,
                           LEAD (sh.status_cd, 1)
                               OVER (PARTITION BY sh.application_id
                                     ORDER BY sh.app_status_history_id ASC)
                               next_status
                      FROM PAIEB_PRD.app_status_history sh
                     WHERE sh.app_status_history_id >= 1530000) a
                   PIVOT (MAX (app_status_history_id)  AS ash_id, 
                          MAX (status_date) AS status_dt,
                          MAX (next_ash_id) AS next_ash_id, 
                          MAX (end_dt) AS end_dt, 
                          MAX (next_status) S next_status
                         FOR status_cd
                         IN ('1768_DENIAL' AS "1768_DENIAL",
                            'APPROVED' AS APPROVED,
                            'APP_REVIEW' AS APP_REVIEW,
                            'APP_STARTED' AS APP_STARTED,
                            'ASSESSMENT_INPROCESS' AS ASSESS_IN_PROC,
                            'CLOSED' AS CLOSED,
                            'COMPLETED' AS COMPLETED,
                            'DENIED_INCOMPLETE' AS DENIED_INCOMP,
                            'DENIED_INELIGIBLE' AS DENIED_INELIG,
                            'DISREGARDED' AS DISREGARDED,
                            'ENROLLED' AS ENROLLED,
                            'FINANCIAL_APPROVAL' AS FIN_APPR,
                            'FINANCIAL_APPROVAL_MISMATCH' AS FIN_APPR_MISMATCH,
                            'FINANCIAL_DENIAL' AS FIN_DENIAL,
                            'MMS_READY' AS MMS_READY,
                            'OLTL_READY' AS OLTL_READY,
                            'PC_LCD_PENDING' AS PC_LCD_PENDING,
                            'PC_LCD_PENDING_RCV' AS PC_LCD_PEND_RCV,
                            'PC_LCD_RCV_PENDING' AS PC_LCD_RCV_PEND,
                            'PENDING' AS PENDING,
                            'READY_ASSESSMENT' AS READY_ASSESS,
                            'READY_TRANSITION' AS READY_TRANS,
                            'RECEIVED' AS RECEIVED,
                            'SCHEDULED' AS SCHEDULED,
                            'UD' AS UD)
                         ) P
             WHERE RN = 1) */
         (SELECT T.Application_id,
         T.rn,
         MAX(CASE WHEN T.status_cd = 'APPROVED'    THEN app_status_history_id END) AS APPROVED_ash_id , 
         MAX(CASE WHEN T.status_cd = '1768_DENIAL' THEN app_status_history_id END) AS "1768_DENIAL_ash_id"     , 
         MAX(CASE WHEN T.status_cd = 'APP_REVIEW' THEN app_status_history_id END)  AS APP_REVIEW_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'APP_STARTED' THEN app_status_history_id END) AS APP_STARTED_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'ASSESSMENT_INPROCESS' THEN app_status_history_id END) AS ASSESS_IN_PROC_ash_id    , 
         MAX(CASE WHEN T.status_cd = 'CLOSED' THEN app_status_history_id END) AS CLOSED_ash_id            , 
         MAX(CASE WHEN T.status_cd = 'COMPLETED' THEN app_status_history_id END) AS COMPLETED_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'DENIED_INCOMPLETE' THEN app_status_history_id END) AS DENIED_INCOMP_ash_id     ,
         MAX(CASE WHEN T.status_cd = 'DENIED_INELIGIBLE' THEN app_status_history_id END) AS DENIED_INELIG_ash_id     , 
         MAX(CASE WHEN T.status_cd = 'DISREGARDED' THEN app_status_history_id END) AS DISREGARDED_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'ENROLLED' THEN app_status_history_id END) AS ENROLLED_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL' THEN app_status_history_id END) AS FIN_APPR_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL_MISMATCH' THEN app_status_history_id END) AS FIN_APPR_MISMATCH_ash_id ,
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_DENIAL' THEN app_status_history_id END) AS FIN_DENIAL_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'MMS_READY' THEN app_status_history_id END) AS MMS_READY_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'OLTL_READY' THEN app_status_history_id END) AS OLTL_READY_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING' THEN app_status_history_id END) AS PC_LCD_PENDING_ash_id    , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING_RCV' THEN app_status_history_id END) AS PC_LCD_PEND_RCV_ash_id   , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_RCV_PENDING' THEN app_status_history_id END) AS PC_LCD_RCV_PEND_ash_id   ,
         MAX(CASE WHEN T.status_cd = 'PENDING' THEN app_status_history_id END) AS PENDING_ash_id           , 
         MAX(CASE WHEN T.status_cd = 'READY_ASSESSMENT' THEN app_status_history_id END) AS READY_ASSESS_ash_id      , 
         MAX(CASE WHEN T.status_cd = 'READY_TRANSITION' THEN app_status_history_id END) AS READY_TRANS_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'RECEIVED' THEN app_status_history_id END) AS RECEIVED_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'SCHEDULED' THEN app_status_history_id END) AS SCHEDULED_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'UD' THEN app_status_history_id END) AS UD_ash_id ,
         MAX(CASE WHEN T.status_cd = 'APPROVED'    THEN status_dt END) AS APPROVED_status_dt , 
         MAX(CASE WHEN T.status_cd = '1768_DENIAL' THEN status_dt END) AS "1768_DENIAL_status_dt"     , 
         MAX(CASE WHEN T.status_cd = 'APP_REVIEW' THEN status_dt END)  AS APP_REVIEW_status_dt        , 
         MAX(CASE WHEN T.status_cd = 'APP_STARTED' THEN status_dt END) AS APP_STARTED_status_dt       , 
         MAX(CASE WHEN T.status_cd = 'ASSESSMENT_INPROCESS' THEN status_dt END) AS ASSESS_IN_PROC_status_dt    , 
         MAX(CASE WHEN T.status_cd = 'CLOSED' THEN status_dt END) AS CLOSED_status_dt            , 
         MAX(CASE WHEN T.status_cd = 'COMPLETED' THEN status_dt END) AS COMPLETED_status_dt         , 
         MAX(CASE WHEN T.status_cd = 'DENIED_INCOMPLETE' THEN status_dt END) AS DENIED_INCOMP_status_dt     ,
         MAX(CASE WHEN T.status_cd = 'DENIED_INELIGIBLE' THEN status_dt END) AS DENIED_INELIG_status_dt     , 
         MAX(CASE WHEN T.status_cd = 'DISREGARDED' THEN status_dt END) AS DISREGARDED_status_dt       , 
         MAX(CASE WHEN T.status_cd = 'ENROLLED' THEN status_dt END) AS ENROLLED_status_dt          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL' THEN status_dt END) AS FIN_APPR_status_dt          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL_MISMATCH' THEN status_dt END) AS FIN_APPR_MISMATCH_status_dt ,
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_DENIAL' THEN status_dt END) AS FIN_DENIAL_status_dt        , 
         MAX(CASE WHEN T.status_cd = 'MMS_READY' THEN status_dt END) AS MMS_READY_status_dt         , 
         MAX(CASE WHEN T.status_cd = 'OLTL_READY' THEN status_dt END) AS OLTL_READY_status_dt        , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING' THEN status_dt END) AS PC_LCD_PENDING_status_dt    , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING_RCV' THEN status_dt END) AS PC_LCD_PEND_RCV_status_dt   , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_RCV_PENDING' THEN status_dt END) AS PC_LCD_RCV_PEND_status_dt   ,
         MAX(CASE WHEN T.status_cd = 'PENDING' THEN status_dt END) AS PENDING_status_dt           , 
         MAX(CASE WHEN T.status_cd = 'READY_ASSESSMENT' THEN status_dt END) AS READY_ASSESS_status_dt      , 
         MAX(CASE WHEN T.status_cd = 'READY_TRANSITION' THEN status_dt END) AS READY_TRANS_status_dt       , 
         MAX(CASE WHEN T.status_cd = 'RECEIVED' THEN status_dt END) AS RECEIVED_status_dt          , 
         MAX(CASE WHEN T.status_cd = 'SCHEDULED' THEN status_dt END) AS SCHEDULED_status_dt         , 
         MAX(CASE WHEN T.status_cd = 'UD' THEN status_dt END) AS UD_status_dt  ,
         MAX(CASE WHEN T.status_cd = 'APPROVED'    THEN next_ash_id END) AS APPROVED_next_ash_id , 
         MAX(CASE WHEN T.status_cd = '1768_DENIAL' THEN next_ash_id END) AS "1768_DENIAL_next_ash_id"     , 
         MAX(CASE WHEN T.status_cd = 'APP_REVIEW' THEN next_ash_id END)  AS APP_REVIEW_next_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'APP_STARTED' THEN next_ash_id END) AS APP_STARTED_next_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'ASSESSMENT_INPROCESS' THEN next_ash_id END) AS ASSESS_IN_PROC_next_ash_id    , 
         MAX(CASE WHEN T.status_cd = 'CLOSED' THEN next_ash_id END) AS CLOSED_next_ash_id            , 
         MAX(CASE WHEN T.status_cd = 'COMPLETED' THEN next_ash_id END) AS COMPLETED_next_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'DENIED_INCOMPLETE' THEN next_ash_id END) AS DENIED_INCOMP_next_ash_id     ,
         MAX(CASE WHEN T.status_cd = 'DENIED_INELIGIBLE' THEN next_ash_id END) AS DENIED_INELIG_next_ash_id     , 
         MAX(CASE WHEN T.status_cd = 'DISREGARDED' THEN next_ash_id END) AS DISREGARDED_next_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'ENROLLED' THEN next_ash_id END) AS ENROLLED_next_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL' THEN next_ash_id END) AS FIN_APPR_next_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL_MISMATCH' THEN next_ash_id END) AS FIN_APPR_MISMATCH_next_ash_id ,
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_DENIAL' THEN next_ash_id END) AS FIN_DENIAL_next_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'MMS_READY' THEN next_ash_id END) AS MMS_READY_next_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'OLTL_READY' THEN next_ash_id END) AS OLTL_READY_next_ash_id        , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING' THEN next_ash_id END) AS PC_LCD_PENDING_next_ash_id    , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING_RCV' THEN next_ash_id END) AS PC_LCD_PEND_RCV_next_ash_id   , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_RCV_PENDING' THEN next_ash_id END) AS PC_LCD_RCV_PEND_next_ash_id   ,
         MAX(CASE WHEN T.status_cd = 'PENDING' THEN next_ash_id END) AS PENDING_next_ash_id           , 
         MAX(CASE WHEN T.status_cd = 'READY_ASSESSMENT' THEN next_ash_id END) AS READY_ASSESS_next_ash_id      , 
         MAX(CASE WHEN T.status_cd = 'READY_TRANSITION' THEN next_ash_id END) AS READY_TRANS_next_ash_id       , 
         MAX(CASE WHEN T.status_cd = 'RECEIVED' THEN next_ash_id END) AS RECEIVED_next_ash_id          , 
         MAX(CASE WHEN T.status_cd = 'SCHEDULED' THEN next_ash_id END) AS SCHEDULED_next_ash_id         , 
         MAX(CASE WHEN T.status_cd = 'UD' THEN next_ash_id END) AS UD_next_ash_id,
         MAX(CASE WHEN T.status_cd = 'APPROVED'    THEN end_dt END) AS APPROVED_end_dt , 
         MAX(CASE WHEN T.status_cd = '1768_DENIAL' THEN end_dt END) AS "1768_DENIAL_end_dt"     , 
         MAX(CASE WHEN T.status_cd = 'APP_REVIEW' THEN end_dt END)  AS APP_REVIEW_end_dt        , 
         MAX(CASE WHEN T.status_cd = 'APP_STARTED' THEN end_dt END) AS APP_STARTED_end_dt       , 
         MAX(CASE WHEN T.status_cd = 'ASSESSMENT_INPROCESS' THEN end_dt END) AS ASSESS_IN_PROC_end_dt    , 
         MAX(CASE WHEN T.status_cd = 'CLOSED' THEN end_dt END) AS CLOSED_end_dt            , 
         MAX(CASE WHEN T.status_cd = 'COMPLETED' THEN end_dt END) AS COMPLETED_end_dt         , 
         MAX(CASE WHEN T.status_cd = 'DENIED_INCOMPLETE' THEN end_dt END) AS DENIED_INCOMP_end_dt     ,
         MAX(CASE WHEN T.status_cd = 'DENIED_INELIGIBLE' THEN end_dt END) AS DENIED_INELIG_end_dt     , 
         MAX(CASE WHEN T.status_cd = 'DISREGARDED' THEN end_dt END) AS DISREGARDED_end_dt       , 
         MAX(CASE WHEN T.status_cd = 'ENROLLED' THEN end_dt END) AS ENROLLED_end_dt          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL' THEN end_dt END) AS FIN_APPR_end_dt          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL_MISMATCH' THEN end_dt END) AS FIN_APPR_MISMATCH_end_dt ,
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_DENIAL' THEN end_dt END) AS FIN_DENIAL_end_dt        , 
         MAX(CASE WHEN T.status_cd = 'MMS_READY' THEN end_dt END) AS MMS_READY_end_dt         , 
         MAX(CASE WHEN T.status_cd = 'OLTL_READY' THEN end_dt END) AS OLTL_READY_end_dt        , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING' THEN end_dt END) AS PC_LCD_PENDING_end_dt    , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING_RCV' THEN end_dt END) AS PC_LCD_PEND_RCV_end_dt   , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_RCV_PENDING' THEN end_dt END) AS PC_LCD_RCV_PEND_end_dt   ,
         MAX(CASE WHEN T.status_cd = 'PENDING' THEN end_dt END) AS PENDING_end_dt           , 
         MAX(CASE WHEN T.status_cd = 'READY_ASSESSMENT' THEN end_dt END) AS READY_ASSESS_end_dt      , 
         MAX(CASE WHEN T.status_cd = 'READY_TRANSITION' THEN end_dt END) AS READY_TRANS_end_dt       , 
         MAX(CASE WHEN T.status_cd = 'RECEIVED' THEN end_dt END) AS RECEIVED_end_dt          , 
         MAX(CASE WHEN T.status_cd = 'SCHEDULED' THEN end_dt END) AS SCHEDULED_end_dt         , 
         MAX(CASE WHEN T.status_cd = 'UD' THEN end_dt END) AS UD_end_dt ,
         MAX(CASE WHEN T.status_cd = 'APPROVED'    THEN next_status END) AS APPROVED_next_status , 
         MAX(CASE WHEN T.status_cd = '1768_DENIAL' THEN next_status END) AS "1768_DENIAL_next_status"     , 
         MAX(CASE WHEN T.status_cd = 'APP_REVIEW' THEN next_status END)  AS APP_REVIEW_next_status        , 
         MAX(CASE WHEN T.status_cd = 'APP_STARTED' THEN next_status END) AS APP_STARTED_next_status       , 
         MAX(CASE WHEN T.status_cd = 'ASSESSMENT_INPROCESS' THEN next_status END) AS ASSESS_IN_PROC_next_status    , 
         MAX(CASE WHEN T.status_cd = 'CLOSED' THEN next_status END) AS CLOSED_next_status            , 
         MAX(CASE WHEN T.status_cd = 'COMPLETED' THEN next_status END) AS COMPLETED_next_status         , 
         MAX(CASE WHEN T.status_cd = 'DENIED_INCOMPLETE' THEN next_status END) AS DENIED_INCOMP_next_status     ,
         MAX(CASE WHEN T.status_cd = 'DENIED_INELIGIBLE' THEN next_status END) AS DENIED_INELIG_next_status     , 
         MAX(CASE WHEN T.status_cd = 'DISREGARDED' THEN next_status END) AS DISREGARDED_next_status       , 
         MAX(CASE WHEN T.status_cd = 'ENROLLED' THEN next_status END) AS ENROLLED_next_status          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL' THEN next_status END) AS FIN_APPR_next_status          , 
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_APPROVAL_MISMATCH' THEN next_status END) AS FIN_APPR_MISMATCH_next_status ,
         MAX(CASE WHEN T.status_cd = 'FINANCIAL_DENIAL' THEN next_status END) AS FIN_DENIAL_next_status        , 
         MAX(CASE WHEN T.status_cd = 'MMS_READY' THEN next_status END) AS MMS_READY_next_status         , 
         MAX(CASE WHEN T.status_cd = 'OLTL_READY' THEN next_status END) AS OLTL_READY_next_status        , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING' THEN next_status END) AS PC_LCD_PENDING_next_status    , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_PENDING_RCV' THEN next_status END) AS PC_LCD_PEND_RCV_next_status   , 
         MAX(CASE WHEN T.status_cd = 'PC_LCD_RCV_PENDING' THEN next_status END) AS PC_LCD_RCV_PEND_next_status   ,
         MAX(CASE WHEN T.status_cd = 'PENDING' THEN next_status END) AS PENDING_next_status           , 
         MAX(CASE WHEN T.status_cd = 'READY_ASSESSMENT' THEN next_status END) AS READY_ASSESS_next_status      , 
         MAX(CASE WHEN T.status_cd = 'READY_TRANSITION' THEN next_status END) AS READY_TRANS_next_status       , 
         MAX(CASE WHEN T.status_cd = 'RECEIVED' THEN next_status END) AS RECEIVED_next_status          , 
         MAX(CASE WHEN T.status_cd = 'SCHEDULED' THEN next_status END) AS SCHEDULED_next_status         , 
         MAX(CASE WHEN T.status_cd = 'UD' THEN next_status END) AS UD_next_status 
          
  FROM (SELECT sh.application_id,
               sh.app_status_history_id,
               sh.status_cd,
               sh.status_dt,
               ROW_NUMBER () OVER (PARTITION BY sh.application_id, sh.status_cd ORDER BY app_status_history_id DESC) AS rn,
               LEAD (sh.app_status_history_id, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) AS next_ash_id,
               LEAD (sh.status_dt, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) AS end_dt,
               LEAD (sh.status_cd, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) AS next_status 
            FROM PAIEB_PRD.app_status_history sh
            WHERE sh.app_status_history_id >= 1530000
        ) as T WHERE rn = 1 
   GROUP BY T.Application_id, T.rn     ) ash
               ON (ah.application_id = ash.application_id)
           --Most Recent app_status_history record for Application
           LEFT JOIN
           (SELECT comp.application_id,
                   comp.status_dt,
                   comp.status_cd,
                   comp.rn
              FROM (SELECT sh.application_id,
                           sh.status_dt,
                           sh.status_cd,
                           ROW_NUMBER ()
                               OVER (PARTITION BY sh.application_id
                                     ORDER BY app_status_history_id DESC)    rn
                      FROM PAIEB_PRD.app_status_history sh
                     WHERE sh.app_status_history_id >= 1530000) comp
             WHERE comp.rn = 1) sh_comp
               ON (ah.application_id = sh_comp.application_id)
           LEFT JOIN
           (  SELECT i.application_id,
                     SUM (
                         CASE
                             WHEN mi_category = 'certificate' THEN 1
                             ELSE 0
                         END)    mi_cert_count,
                     SUM (
                         CASE
                             WHEN mi_category <> 'certificate' THEN 1
                             ELSE 0
                         END)    mi_data_count
                FROM PAIEB_PRD.app_missing_info i
                     JOIN PAIEB_PRD.enum_app_mi_type t ON (i.mi_type_cd = t.VALUE)
               WHERE satisfied_date IS NULL
            GROUP BY application_id) mi_type
               ON (ah.application_id = mi_type.application_id)
           LEFT JOIN PAIEB_PRD.staff stf ON (TO_CHAR (stf.staff_id) = ah.created_by)
           --LEFT JOIN harmony_conv.openclose oc
              -- ON (oc.openid = ah.application_id)
           --app
           --letter
           LEFT JOIN
           (SELECT lr.lmreq_id, lr.sent_on sent_date, lrl.reference_id
              FROM PAIEB_PRD.letter_request  lr
                   JOIN PAIEB_PRD.letter_request_link lrl
                       ON (lr.lmreq_id = lrl.lmreq_id)
                   JOIN PAIEB_PRD.letter_definition ld ON (lr.lmdef_id = ld.lmdef_id)
             WHERE     reference_type = 'APP_HEADER'
                   AND ld.name = 'LCDETER'
                   AND lr.request_type = 'L'
                   AND lr.status_cd IN ('PRINT_SUCCESS',
                                        'EMAIL_SUCCESS',
                                        'FAX_SUCCESS',
                                        'DMS_SUCCESS')) lcd_ltr
               ON (ah.application_id = lcd_ltr.reference_id)
           LEFT JOIN
           (SELECT *
              FROM (SELECT lr.lmreq_id,
                           lrl.reference_id,
                           lr.sent_on                             sent_date,
                           ROW_NUMBER ()
                               OVER (PARTITION BY lrl.reference_id
                                     ORDER BY lr.sent_on DESC)    rn
                      FROM PAIEB_PRD.letter_request  lr
                           JOIN PAIEB_PRD.letter_request_link lrl
                               ON (lr.lmreq_id = lrl.lmreq_id)
                           JOIN PAIEB_PRD.letter_definition ld
                               ON (lr.lmdef_id = ld.lmdef_id)
                     WHERE     reference_type = 'APP_HEADER'
                           AND ld.name LIKE 'PH%'
                           AND lr.request_type = 'L'
                           AND lr.status_cd IN ('PRINT_SUCCESS',
                                                'EMAIL_SUCCESS',
                                                'FAX_SUCCESS',
                                                'DMS_SUCCESS'))
             WHERE rn = 1) pc_ltr
               ON (ah.application_id = pc_ltr.reference_id)
           LEFT JOIN
           (SELECT *
              FROM (SELECT notification_request_id,
                           type_cd,
                           status_cd,
                           sent_date,
                           ref_type1,
                           ref_type1_value,
                           ROW_NUMBER ()
                               OVER (PARTITION BY ref_type1_value
                                     ORDER BY sent_date DESC)    rn
                      FROM PAIEB_PRD.notification_request
                     WHERE     type_cd IN ('A1768', 'D1768', 'T1768')
                           AND ref_type1 = 'APP_HEADER'
                           AND status_cd IN ('COMPLETED', 'ACK'))
             WHERE rn = 1) d1768_ltr
               ON (ah.application_id = d1768_ltr.ref_type1_value)
           LEFT JOIN
           (SELECT *
              FROM (SELECT notification_request_id,
                           type_cd,
                           status_cd,
                           sent_date,
                           ref_type4,
                           ref_type4_value,
                           ROW_NUMBER ()
                               OVER (PARTITION BY ref_type4_value
                                     ORDER BY sent_date DESC)    rn
                      FROM PAIEB_PRD.notification_request
                     WHERE     type_cd IN ('P1768')
                           AND ref_type4 = 'APP_HEADER'
                           AND status_cd IN ('COMPLETED', 'ACK'))
             WHERE rn = 1) p1768_ltr
               ON (ah.application_id = P1768_ltr.ref_type4_value)
           LEFT JOIN
           (SELECT *
              FROM (SELECT lr.lmreq_id,
                           lrl.reference_id,
                           lr.sent_on                             sent_date,
                           ROW_NUMBER ()
                               OVER (PARTITION BY lrl.reference_id
                                     ORDER BY lr.sent_on DESC)    rn
                      FROM PAIEB_PRD.letter_request  lr
                           JOIN PAIEB_PRD.letter_request_link lrl
                               ON (lr.lmreq_id = lrl.lmreq_id)
                           JOIN PAIEB_PRD.letter_definition ld
                               ON (lr.lmdef_id = ld.lmdef_id)
                     WHERE     reference_type = 'APP_HEADER'
                           AND ld.name IN ('PHCC',
                                           'PHCP',
                                           'PCREM',
                                           'LCDETER') -- are these MI letters too 'PCINCOMP','MIREM' ?
                           AND lr.request_type = 'L'
                           AND lr.status_cd IN ('PRINT_SUCCESS',
                                                'EMAIL_SUCCESS',
                                                'FAX_SUCCESS',
                                                'DMS_SUCCESS'))
             WHERE rn = 1) mi_ltr
               ON (ah.application_id = mi_ltr.reference_id)
           LEFT JOIN
           (SELECT lr.lmreq_id, lr.sent_on sent_date, lrl.reference_id
              FROM PAIEB_PRD.letter_request  lr
                   JOIN PAIEB_PRD.letter_request_link lrl
                       ON (lr.lmreq_id = lrl.lmreq_id)
                   JOIN PAIEB_PRD.letter_definition ld ON (lr.lmdef_id = ld.lmdef_id)
             WHERE     reference_type = 'APP_HEADER'
                   AND ld.name = 'FINALPACKET'
                   AND lr.request_type = 'L'
                   AND lr.status_cd IN ('PRINT_SUCCESS',
                                        'EMAIL_SUCCESS',
                                        'FAX_SUCCESS',
                                        'DMS_SUCCESS')) final_ltr
               ON (ah.application_id = final_ltr.reference_id)
           LEFT JOIN
           (SELECT i.client_id,
                   ah.application_id,
                   ltr.lmreq_id,
                   CAST (he.app_start_date AS DATE)                                  app_start_date,
                   ltr.sent_date,
                   ROW_NUMBER ()
                       OVER (
                           PARTITION BY i.client_id
                           ORDER BY
                               ltr.sent_date DESC, ah.application_id DESC)    rn
              FROM PAIEB_PRD.app_header  ah
                   LEFT JOIN PAIEB_PRD.app_individual i
                       ON (ah.application_id = i.application_id)
                   LEFT JOIN PAIEB_PRD.app_header_ext he
                       ON i.application_id = he.application_id
                   LEFT JOIN
                   (SELECT lr.lmreq_id, lrl.client_id, lr.sent_on sent_date
                      FROM PAIEB_PRD.letter_request_link  lrl
                           JOIN PAIEB_PRD.letter_request lr
                               ON (    lr.lmreq_id = lrl.lmreq_id
                                   AND lr.request_type = 'L'
                                   AND lr.status_cd = 'COMPLETED')
                           JOIN PAIEB_PRD.letter_definition ld
                               ON (    lr.lmdef_id = ld.lmdef_id
                                   AND ld.name = 'PA600')) ltr
                       ON (    ltr.client_id = i.client_id
                           AND ltr.sent_date >= CAST (he.app_start_date AS DATE))
             WHERE     ah.application_id >= 343555
                   AND ah.status_cd NOT IN
                           ('ENROLLED', 'CLOSED', 'COMPLETED')) pa600_ltr
               ON (    ah.application_id = pa600_ltr.application_id
                   AND pa600_ltr.rn = 1)
           --letter
           --doc received
           LEFT JOIN
           (  SELECT link_ref_id,
                     MAX (pa600_received_date)       pa600_received_date,
                     MAX (lcd_received_date)         lcd_received_date,
                     MAX (pc_received_date)          pc_received_date,
                     MAX (hcbsden_received_date)     hcbsden_received_date
                FROM (SELECT link_ref_id,
                             CASE
                                 WHEN     doc_type_cd = 'OTHER'
                                      AND doc_form_type = 'APP_REQUEST'
                                 THEN
                                     received_date
                                 ELSE
                                     NULL
                             END    pa600_received_date,
                             CASE
                                 WHEN     doc_type_cd = 'MEDICAL_INFORMATION'
                                      AND doc_form_type = 'LCD'
                                 THEN
                                     received_date
                                 ELSE
                                     NULL
                             END    lcd_received_date,
                             CASE
                                 WHEN     doc_type_cd = 'MEDICAL_INFORMATION'
                                      AND doc_form_type = 'PC'
                                 THEN
                                     received_date
                                 ELSE
                                     NULL
                             END    pc_received_date,
                             CASE
                                 WHEN     doc_type_cd = 'OTHER'
                                      AND doc_form_type = 'HCBS_DENIAL_FORM'
                                 THEN
                                     received_date
                                 ELSE
                                     NULL
                             END    hcbsden_received_date
                        FROM (SELECT link_ref_id,
                                     doc_type_cd,
                                     doc_form_type,
                                     link_type_cd,
                                     s.received_date,
                                     ROW_NUMBER ()
                                         OVER (PARTITION BY link_ref_id,
                                                            doc_type_cd,
                                                            doc_form_type,
                                                            link_type_cd
                                               ORDER BY s.received_date)    rn
                                FROM PAIEB_PRD.document d
                                     JOIN PAIEB_PRD.document_set s
                                         ON (d.document_set_id =
                                             s.document_set_id)
                                     JOIN PAIEB_PRD.doc_link dl
                                         ON (d.document_id = dl.document_id)
                                     JOIN PAIEB_PRD.enum_document_source ds
                                         ON (s.doc_source_cd = ds.VALUE)
                               WHERE link_type_cd = 'APPLICATION')
                       WHERE rn = 1)
            GROUP BY link_ref_id) app_doc
               ON (app_doc.link_ref_id = ah.application_id)
           /*  LEFT JOIN (SELECT link_ref_id, received_date FROM (
                           SELECT link_ref_id,doc_type_cd, doc_form_type, link_type_cd, s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id, doc_type_cd, doc_form_type, link_type_cd ORDER BY s.received_date) rn
                           FROM PAIEB_PRD.document d
                           JOIN PAIEB_PRD.document_set s ON (d.document_set_id = s.document_set_id)
                           JOIN PAIEB_PRD.doc_link dl ON (d.document_id = dl.document_id)
                           JOIN PAIEB_PRD.enum_document_source ds ON (s.doc_source_cd = ds.value)
                           )
                      WHERE doc_type_cd = 'OTHER'
                           AND doc_form_type = 'APP_REQUEST'
                           AND link_type_cd = 'APPLICATION'
                           and rn = 1) pa600_doc ON (pa600_doc.link_ref_id = ah.application_id)
             LEFT JOIN (SELECT link_ref_id, received_date FROM (
                           SELECT link_ref_id, doc_type_cd, doc_form_type, link_type_cd,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                           FROM PAIEB_PRD.document d
                           JOIN PAIEB_PRD.document_set s ON (d.document_set_id = s.document_set_id)
                           JOIN PAIEB_PRD.doc_link dl ON (d.document_id = dl.document_id)
                           JOIN PAIEB_PRD.enum_document_source ds ON( s.doc_source_cd = ds.value)
                           )
                           WHERE doc_type_cd = 'MEDICAL_INFORMATION'
                           AND doc_form_type = 'LCD'
                           AND link_type_cd = 'APPLICATION'
                           AND rn = 1) lcd_doc ON (lcd_doc.link_ref_id = ah.application_id)
             LEFT JOIN (SELECT link_ref_id, received_date FROM (
                           SELECT link_ref_id, doc_type_cd, doc_form_type, link_type_cd,s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                           FROM PAIEB_PRD.document d
                           JOIN PAIEB_PRD.document_set s ON (d.document_set_id = s.document_set_id)
                           JOIN PAIEB_PRD.doc_link dl ON (d.document_id = dl.document_id)
                           JOIN PAIEB_PRD.enum_document_source ds ON (s.doc_source_cd = ds.value)
                           )
                           WHERE doc_type_cd = 'MEDICAL_INFORMATION'
                           AND doc_form_type = 'PC'
                           AND link_type_cd = 'APPLICATION'
                           AND rn = 1) pc_doc ON (pc_doc.link_ref_id = ah.application_id)
             LEFT JOIN (SELECT link_ref_id, received_date
                         FROM (SELECT link_ref_id, doc_type_cd, doc_form_type, link_type_cd, s.received_date,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY s.received_date) rn
                           FROM PAIEB_PRD.document d
                           JOIN PAIEB_PRD.document_set s ON (d.document_set_id = s.document_set_id)
                           JOIN PAIEB_PRD.doc_link dl ON (d.document_id = dl.document_id)
                           JOIN PAIEB_PRD.enum_document_source ds ON (s.doc_source_cd = ds.value)
                           )
                           WHERE doc_type_cd = 'OTHER'
                           AND doc_form_type = 'HCBS_DENIAL_FORM'
                           AND link_type_cd = 'APPLICATION'
                           AND rn = 1) hcbsden_doc ON (hcbsden_doc.link_ref_id = ah.application_id)
           */
           LEFT JOIN
           (  SELECT application_id,
                     MAX (lcd_date)     AS lcd_date,
                     MAX (pc_date)      AS pc_date
                FROM (SELECT mi.application_id,
                             mi.mi_type_cd,
                             CASE
                                 WHEN mi.mi_type_cd = 'lcd'
                                 THEN
                                     mi.satisfied_date
                                 ELSE
                                     NULL
                             END                                          AS lcd_date,
                             CASE
                                 WHEN mi.mi_type_cd = 'pc'
                                 THEN
                                     mi.satisfied_date
                                 ELSE
                                     NULL
                             END                                          AS pc_date,
                             RANK ()
                                 OVER (
                                     PARTITION BY mi.application_id,
                                                  mi.mi_type_cd
                                     ORDER BY mi.missing_info_id DESC)    AS rnk
                        FROM PAIEB_PRD.app_missing_info mi
                       WHERE mi.mi_type_cd IN ('lcd', 'pc'))
               WHERE rnk = 1
            GROUP BY application_id) mi_dates
               ON (ah.application_id = mi_dates.application_id)
     WHERE     ah.application_id >= 343555
           AND ah.create_ts >= ADD_MONTHS(CURRENT_DATE::DATE, -13);
           
  
####################################################
D_PA_CLIENT_DETAIL_SV : 
####################################################
 CREATE OR REPLACE VIEW D_PA_CLIENT_DETAIL_SV AS
 SELECT /*+ parallel(8) */ i.application_id AS app_id
  ,i.client_id
  ,ac.case_id
  ,ac.case_cin
  ,CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN COALESCE(he.close_app_ts,sh_comp.status_dt) ELSE ah.status_date END disposition_dt
  ,CAST(he.app_start_date AS DATE) as app_start_dt
  ,c.clnt_dob
  ,to_char((to_number(to_char(he.app_start_date,'YYYYMMDD')) - to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000) as age
  ,CASE WHEN (to_number(to_char(he.app_start_date,'YYYYMMDD')) - to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000 > 60 THEN 'Over 60'
   ELSE '60 and Under'
   END as over_60
  ,i.app_individual_id
  ,CASE WHEN he.applicant_med_assistance_ind = 1 OR c.clnt_generic_field6_txt IS NOT NULL THEN 1 ELSE 0 END medicaid_enrolled
  ,i.applicant_ind
  ,i.hoh_ind
  ,i.mi_ind
 FROM PAIEB_PRD.app_header ah
 JOIN PAIEB_PRD.app_individual i ON (ah.application_id = i.application_id)
 JOIN PAIEB_PRD.client c ON (i.client_id = c.clnt_client_id)
 JOIN PAIEB_PRD.app_case_link ac ON (ah.application_id = ac.application_id)
 LEFT JOIN PAIEB_PRD.app_header_ext he ON ah.application_id = he.application_id
 --LEFT JOIN harmony_conv.openclose oc ON (oc.openid = ah.application_id)
 LEFT JOIN (SELECT *
            FROM (SELECT sh.application_id,sh.status_dt,sh.status_cd,ROW_NUMBER() OVER (PARTITION BY sh.application_id ORDER BY app_status_history_id DESC) rn
                  FROM PAIEB_PRD.app_status_history sh
                  WHERE sh.status_cd IN('CLOSED', 'COMPLETED' ,'TIMEOUT','DISREGARDED')
                  AND sh.app_status_history_id >= 1530000
                  )
            WHERE rn = 1) sh_comp  ON ah.application_id = sh_comp.application_id
 where ah.application_id >= 343555
and ah.create_ts >= ADD_MONTHS(CURRENT_DATE::DATE,-13) ;

####################################################
F_PA_BY_DATE_SV:
####################################################

CREATE OR REPLACE VIEW F_PA_BY_DATE_SV AS
SELECT /*+ parallel(5) */ ah.application_id app_id
   ,d_date
   ,COALESCE(ah.status_cd,'UD') app_status_code
   ,COALESCE(he.reason_delay_cd,'UD') reason_delay_code
   ,COALESCE(he.enroll_delayed_reason_cd,'UD') enroll_delayed_reason_cd
   ,COALESCE(he.enroll_delayed_ind, 0) nf_flag
   ,CAST(he.app_start_date AS DATE) app_start_dt
   ,sh.end_date complete_dt
   ,ah.create_ts create_dt
   ,NULL as  loca_date_received
   ,NULL as  pc_date_received
   ,(CASE
    WHEN CAST(COALESCE(sh.end_date, bdd.d_date) AS DATE) < bdd.d_date
    THEN CAST(sh.end_date AS DATE)
    ELSE CAST(bdd.d_date as DATE) END) - cast(ah.create_ts as date) age_in_caldays_from_creation
  ,NULL as age_in_caldays_from_open
   ,CASE
      WHEN bdd.d_date >= CAST(ah.create_ts AS DATE) AND
           bdd.d_date <
          CASE WHEN
                CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED')
          THEN CAST(sh.end_date AS DATE) ELSE cast(bdd.d_date as DATE) + 1 END
      THEN 1
      ELSE 0
    END AS inventory_count
   ,CASE
      WHEN bdd.d_date >= CAST(sh.pending_end_dt AS DATE) AND
           bdd.d_date <
          CASE WHEN
                CASE WHEN bdd.d_date < CAST(sh.end_date AS DATE) THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED')
          THEN CAST(sh.end_date AS DATE) ELSE CAST(bdd.d_date as DATE) + 1 END
      THEN 1
      ELSE 0
    END AS inventory_no_pending_count
    ,CASE
      WHEN bdd.d_date = CAST(ah.create_ts AS DATE)
      THEN 1
      ELSE 0
    END creation_count
    ,CASE
      WHEN sh.end_date IS NOT NULL AND bdd.d_date >= CAST(sh.end_date AS DATE)
      THEN 1
      ELSE 0
    END AS completion_count
     ,CASE
      WHEN he.enroll_delayed_ind = 1
      THEN 1
      ELSE 0
    END AS delayed_enroll_count
FROM PAIEB_PRD.app_header ah
JOIN PAIEB_PRD.app_header_ext he ON ah.application_id = he.application_id
--LEFT JOIN harmony_conv.openclose oc ON oc.openid = ah.application_id
--This is getting the first and last app_history_status records for each application and then uses a maxdat_support table to determine if that status is an inventory status.
LEFT JOIN (SELECT COALESCE(a.application_id, b.application_id) as application_id, a.start_date, b.end_date, a.start_cd, b.end_cd, c.pending_start_dt, c.pending_end_dt
            FROM (SELECT l.last, l.app_status_history_id, l.application_id, l.status_dt as start_date, l.status_cd as start_cd
                  FROM (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id) last
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_dt
                    ,aps.inventory_indicator
                    FROM PAIEB_PRD.app_status_history sh
                    JOIN PAIEB_PRD.app_status aps ON (sh.status_cd = aps.app_status_code)
                    WHERE sh.app_status_history_id >= 1530000) l
                  WHERE l.last = l.app_status_history_id
                  AND l.inventory_indicator = 1) a
            --I used first_value but I am ordering desc
            FULL OUTER JOIN (SELECT f.first, f.app_status_history_id, f.application_id, f.status_dt as end_date, f.status_cd as end_cd
                  FROM  (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id DESC) first
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_dt
                    ,aps.inventory_indicator
                    FROM PAIEB_PRD.app_status_history sh
                    JOIN PAIEB_PRD.app_status aps ON (sh.status_cd = aps.app_status_code)
                    WHERE sh.app_status_history_id >= 1530000
                    ) f
                  WHERE f.first = f.app_status_history_id
                  AND f.inventory_indicator = 0) b ON (a.application_id = b.application_id)
            FULL OUTER JOIN (SELECT a.application_id
                              , a.pending_start_dt
                              , a.pending_end_dt
                              FROM (SELECT sh.application_id
                                    , sh.status_cd
                                    , sh.status_dt AS pending_start_dt
                                    , ROW_NUMBER() OVER(PARTITION BY sh.application_id, sh.status_cd ORDER BY sh.app_status_history_id ASC) rn
                                    , LEAD(sh.status_dt, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) pending_end_dt
                                    FROM PAIEB_PRD.app_status_history sh
                                    WHERE sh.app_status_history_id >= 1530000
                                    ) a
                              WHERE a.status_cd = 'PENDING'
                              AND a.rn = 1) c ON (a.application_id = c.application_id) ) sh ON ah.application_id = sh.application_id
  LEFT JOIN (SELECT application_id
              ,MAX(lcd_date) as lcd_date
              ,MAX(pc_date) as pc_date
              FROM
              (SELECT  mi.application_id
              ,mi.mi_type_cd
              ,CASE WHEN mi.mi_type_cd = 'lcd' THEN mi.satisfied_date ELSE NULL END AS lcd_date
              ,CASE WHEN mi.mi_type_cd = 'pc' THEN mi.satisfied_date ELSE NULL END AS pc_date
              ,RANK() OVER(PARTITION BY mi.application_id, mi.mi_type_cd ORDER BY mi.missing_info_id DESC) AS rnk
              FROM PAIEB_PRD.app_missing_info mi
              WHERE mi.mi_type_cd IN ('lcd','pc')
              and mi.application_id >= 343555)
              WHERE rnk = 1
              GROUP BY application_id ) mi_dates ON ah.application_id = mi_dates.application_id
JOIN PAIEB_PRD.d_dates bdd ON bdd.d_date >= cast(ah.create_ts as date) 
and ah.application_id >= 343555 
and bdd.d_date <=  CASE WHEN CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN ('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') THEN CAST(sh.end_date AS DATE) ELSE CAST(CURRENT_DATE AS DATE) END
and ah.create_ts >= ADD_MONTHS(CURRENT_DATE::DATE, -13);

####################################################
D_PA_CASE_ADDRESS_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_CASE_ADDRESS_SV AS
SELECT ac.case_id
 ,ac.application_id as app_id
 ,COALESCE(ad.addr_type_cd, mad.addr_type_cd, fad.addr_type_cd) as addr_type_cd
 ,COALESCE(ad.addr_street_1, mad.addr_street_1, fad.addr_street_1) street
 ,COALESCE(ad.addr_street_2, mad.addr_street_2, fad.addr_street_2) street_2
 ,COALESCE(ad.addr_city, mad.addr_city, fad.addr_city) city
 ,COALESCE(ad.addr_state_cd, mad.addr_state_cd, fad.addr_state_cd) state
 ,COALESCE(ad.addr_zip, mad.addr_zip, fad.addr_zip) zip_code
 ,COALESCE(ad.addr_ctlk_id, mad.addr_ctlk_id, fad.addr_ctlk_id, 'UD') AS county_code
 ,COALESCE(ad.fa_active, mad.fa_active, fad.fa_active) fa_active
FROM  PAIEB_PRD.app_case_link ac
LEFT JOIN (SELECT a.addr_case_id, a.addr_type_cd, a.addr_street_1,a.addr_street_2,a.addr_city,a.addr_state_cd,a.addr_zip,a.addr_ctlk_id, 'N' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd, ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY addr_case_id ORDER BY ad.creation_date DESC,ad.addr_id DESC) rn
           FROM PAIEB_PRD.address ad 
           WHERE ad.addr_type_cd IN('RS','MR')
           AND ad.end_ndt > TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'yyyymmddHH24misssss'))) a
           WHERE rn = 1) ad
 ON (ac.case_id = ad.addr_case_id)
LEFT JOIN (SELECT m.addr_case_id, m.addr_type_cd,m.addr_street_1,m.addr_street_2,m.addr_city,m.addr_state_cd,m.addr_zip,m.addr_ctlk_id, 'N' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd,ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY addr_case_id ORDER BY ad.creation_date DESC,ad.addr_id DESC) rn
           FROM PAIEB_PRD.address ad 
           WHERE ad.addr_type_cd IN('MM','ML')
           AND ad.end_ndt > TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'yyyymmddHH24misssss'))) m
           WHERE rn = 1) mad
 ON (ac.case_id = mad.addr_case_id) 
LEFT JOIN (SELECT f.addr_case_id, f.addr_type_cd,f.addr_street_1,f.addr_street_2,f.addr_city,f.addr_state_cd,f.addr_zip,f.addr_ctlk_id, 'Y' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd,ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY ad.addr_case_id ORDER BY ad.ADDR_END_DATE DESC,ad.addr_id DESC) rn
           FROM PAIEB_PRD.address ad 
           WHERE ad.addr_type_cd IN('RS','MR','MM','ML')
           AND NOT EXISTS (SELECT 1 FROM PAIEB_PRD.address 
                                        WHERE addr_type_cd IN('RS','MR','MM','ML') AND end_ndt > TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'yyyymmddHH24misssss'))
                                        AND addr_case_id = ad.addr_case_id)
           AND EXISTS (SELECT 1 FROM PAIEB_PRD.address 
                                        WHERE addr_type_cd = 'FA' AND end_ndt > TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'yyyymmddHH24misssss'))
                                        AND addr_case_id = ad.addr_case_id)) f
           WHERE rn = 1) fad
 ON (ac.case_id = fad.addr_case_id);

####################################################
D_PA_CLIENT_SV : 
####################################################
CREATE OR REPLACE VIEW D_PA_CLIENT_SV AS
SELECT cl.clnt_client_id client_id
  ,cl.clnt_cin client_cin
  ,cl.clnt_fname first_name
  ,cl.clnt_mi middle_initial
  ,cl.clnt_lname last_name
  ,CASE WHEN LENGTH(TRIM(cl.clnt_lname)) < 1 THEN TRIM(cl.clnt_fname)
        WHEN LENGTH(TRIM(cl.clnt_fname)) < 1 THEN TRIM(cl.clnt_lname)
        ELSE TRIM(cl.clnt_lname) || ', ' || TRIM(cl.clnt_fname)
        END AS full_name
  ,cl.clnt_ssn ssn
  ,cl.clnt_dob dob
  ,cl.clnt_generic_field4_num sec_id
  ,cl.clnt_generic_field6_txt ma_id
  ,cl.clnt_generic_field5_txt harmony_case_id
  ,COALESCE(cl.client_language, 'UD') language_code
  ,cl.clnt_ethnicity AS CLNT_ETHNICITY
  ,cl.clnt_race AS RACE
  ,cl.clnt_gender_cd AS GENDER
FROM PAIEB_PRD.client cl;

####################################################
D_PA_COUNTY_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_COUNTY_SV AS
SELECT ec.value AS county_code
  ,ec.report_label AS county
  ,COALESCE(ec.attrib_district_cd, 'UD') AS region_code
FROM PAIEB_PRD.enum_county ec  
UNION ALL 
SELECT 'UD' AS county_code
  ,'Undefined' AS county
  ,'UD' AS region_code
FROM DUAL;

####################################################
D_PA_ENROLL_DELAYED_REASON_SV: - NOT DONE
####################################################
CREATE OR REPLACE VIEW D_PA_ENROLL_DELAYED_REASON_SV AS
SELECT r.value enroll_delayed_reason_cd
       ,r.report_label enroll_delayed_reason
FROM PAIEB_PRD.ENUM_ENROLL_DELAYED_REASON r
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS enroll_delayed_reason_cd
      , 'Undefined' AS enroll_delayed_reason
FROM DUAL;

####################################################
D_PA_LANGUAGE_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_LANGUAGE_SV AS
SELECT value language_code
      ,report_label language_desc
FROM PAIEB_PRD.enum_language
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS language_code
      ,'Undefined' AS language_desc
FROM DUAL;


####################################################
D_PA_LENGTH_CARE_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_LENGTH_CARE_SV AS
SELECT value length_care_code
       ,report_label length_care
FROM PAIEB_PRD.enum_length_care
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS length_care_code
      , 'Undefined' AS length_care
FROM DUAL;

####################################################
D_PA_LEVEL_CARE_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_LEVEL_CARE_SV AS
SELECT value level_care_code
       ,report_label level_care
FROM PAIEB_PRD.enum_level_care
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS level_care_code
      , 'Undefined' AS level_care
FROM DUAL;

####################################################
D_PA_LEVEL_NEED_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_LEVEL_NEED_SV AS
SELECT value level_of_need_code
       ,report_label level_of_need
FROM PAIEB_PRD.enum_mfp_code
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS level_of_need_code
      , 'Undefined' AS level_of_need
FROM DUAL;

####################################################
D_PA_REASON_DELAY_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_REASON_DELAY_SV AS
SELECT r.value reason_delay_code
       ,r.report_label reason_delay
       ,CASE WHEN r.value IN ('1','2','3','4','5') THEN 'Delayed Enrollment'
          ELSE 'Delay Excuse'
          END AS reason_delay_group
FROM PAIEB_PRD.enum_reason_delay_code r
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' AS reason_delay_code
      , 'Undefined' AS reason_delay
      , 'Undefined' AS reason_delay_group
FROM DUAL;

####################################################
D_PA_SUBPROGRAM_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_SUBPROGRAM_SV AS
SELECT value subprogram_code
      ,report_label subprogram
FROM PAIEB_PRD.enum_subprogram_type
WHERE effective_end_date IS NULL
UNION ALL
SELECT 'UD' subprogram_code
      ,'Undefined' subprogram
FROM dual;

####################################################
D_PA_APP_STATUS_SV:
####################################################
CREATE OR REPLACE VIEW D_PA_APP_STATUS_SV AS
SELECT  app_status_code
       ,app_status
       ,display_order
       ,inventory_indicator
FROM PAIEB_PRD.app_status;




####################################################
D_PI_PLAN_SV:
####################################################

CREATE OR REPLACE VIEW D_PI_PLAN_SV as 
SELECT pl.plan_id source_record_id,
    pl.plan_id_ext,
    pl.created_by record_name,
    pl.plan_id,
    'MEDICAID' managed_care_program,
    '0' csda,
    pl.plan_code,
    pl.plan_name,
    NULL plan_abbreviation,
    NULL plan_effective_date,
    NULL address1,
    NULL address2,
    NULL city,
    NULL state,
    NULL zip,
    'N' active,
    NULL contact_first_name,
    NULL contact_initial,
    NULL contact_last_name,
    NULL contact_full_name,
    NULL contact_phone,
    NULL contact_extension,
    NULL member_contact_phone, --contact info
    'N' enrollok,
    'N' plan_assign,
    pl.create_ts record_date,
    TO_CHAR(pl.create_ts,'HH24MI') record_time,
    NULL plan_type_id,
    NULL plan_type,
    NULL plan_service_type
  FROM ATS.plans pl 
UNION
  SELECT 0 source_record_id,
    '0' AS plan_id_ext,
    NULL record_name,
    0 plan_id,
    'MEDICAID' managed_care_program,
    '0' csda,
    '0' plan_code,
    'Not Defined' plan_name,
    'Not Defined' plan_abbreviation,
    TO_DATE('01/01/1900','MM/DD/YYYY') plan_effective_date,
    NULL address1,
    NULL address2,
    NULL city,
    NULL state,
    NULL zip,
     'N'  active,
    NULL contact_first_name,
    NULL contact_initial,
    NULL contact_last_name,
    NULL contact_full_name,
    NULL contact_phone,
    NULL contact_extension,
    NULL member_contact_phone, --contact info
    'N' enrollok,
    'N' plan_assign,
    NULL record_date,
    NULL record_time,
    NULL plan_type_id,
    NULL plan_type,
    NULL plan_service_type
 FROM DUAL;
 
 
 ####################################################
 D_PA_ASSESSMENT_SV:
####################################################

CREATE OR REPLACE VIEW D_PA_ASSESSMENT_SV as
SELECT ss.assessment_id
       ,ss.client_id
       ,ss.assessment_type_cd
       ,null visit_subtype
       ,ss.status_cd
       ,ss.client_address_id addr_id
       ,ss.create_ts visit_create_date
       ,stf.first_name eb_broker_first_name
       ,stf.last_name eb_broker_last_name
       ,eci.report_label visit_reason
       ,cir.report_label visit_cancel_reason
       ,cst.report_label appt_status
       ,st_sup.first_name eb_broker_supervisor_fname
       ,st_sup.last_name eb_broker_supervisor_lname
       ,ss.status_ts assessment_status_date
       ,ci.start_ts
       ,stf.staff_id
       , ci.created_by
       , ci.updated_by
       , stc.first_name assessment_created_by_fname
       , stc.last_name assessment_created_by_lname
FROM paieb_PRD.assessment ss
 INNER JOIN paieb_PRD.calendar_item ci ON (ss.calendar_item_id = ci.calendar_item_id)
 left join paieb_PRD.staff stc on (stc.staff_id = ci.created_by)
 LEFT JOIN paieb_PRD.staff stf ON (ci.ref_id = stf.staff_id AND ci.ref_type = 'STAFF')
 LEFT JOIN paieb_PRD.groups g ON (g.group_id = stf.default_group_id AND g.type_cd = 'TEAM' AND g.group_name like ('Field EB Unit%'))
 --LEFT JOIN group_staff gf ON (gf.staff_id = stf.staff_id AND gf.group_id in (103100,103083,102955,102954,103055,103056
 --,103057,103058,103059, 103272,103273,103274))
 LEFT JOIN paieb_PRD.staff st_sup ON (g.supervisor_staff_id = st_sup.staff_id)
 LEFT JOIN paieb_PRD.enum_calendar_item_status cst ON (ci.item_status_cd = cst.value)
 LEFT JOIN paieb_PRD.enum_calendar_status_reason cir ON (ci.item_status_reason_cd = cir.value)
 LEFT JOIN paieb_PRD.enum_calendar_item_reason eci ON (ci.ref_id_2 = eci.value AND ci.ref_type_2 = 'REASON')
WHERE ss.assessment_type_cd IN('INTAKE_VISIT','INTAKE_VISIT_NO_MA','REASSESSMENT','APPEAL_HEARING','IVA_PHONE');

#####################################################
D_PA_FIRST_HOME_PHONE_SV:
APP_CASE_LINK is missing
####################################################

CREATE OR REPLACE VIEW D_PA_FIRST_HOME_PHONE_SV as 
SELECT COALESCE(p.phon_id, ac.case_id*-1) as phon_id
        ,ac.case_id
        ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) phone_number
FROM ats.app_case_link ac
LEFT JOIN paieb_PRD.phone_number p ON (ac.case_id = p.phon_case_id)
                          AND phon_type_cd = 'CH'
                          AND phon_case_id IS NOT NULL
                          AND end_ndt >= TO_NUMBER(TO_CHAR(current_date, 'yyyymmddHH24misssss'));
                          

#####################################################
D_PA_ADV_PLANSLCT_SV:
####################################################

CREATE OR REPLACE VIEW D_PA_ADV_PLANSLCT_SV as 
SELECT ASEL.PLAN_ID, ASEL.PLAN_ID_EXT, ASEL.STATUS_CD, ASEL.CREATE_TS, ASEL.SENT_DATE, ASEL.RESPONSE_RECEIVED_DATE
, asel.app_adv_plan_id
, ASEL.APPLICATION_ID app_id
, ASEL.PLACEMENT_COUNTY
, ASEL.RESIDENCE_COUNTY
, ASEL.REASON_CD
, ASEL.CHOICE_HIERARCHY_SELECTION_IND
FROM PAIEB_PRD.APP_ADV_PLAN_SELECTION ASEL
WHERE YEAR(CAST(CREATE_TS as DATE)) >= YEAR(ADD_MONTHS(CURRENT_DATE::DATE,-24) );

