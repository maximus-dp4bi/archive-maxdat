create or replace view MAXEB_DP4BI_PAIEB_PRD.MAXDAT_SUPPORT.D_PA_CURRENT_SV(
  APP_ID,
  APP_TYPE_CODE,
  DOC_SOURCE_CODE,
  APP_CREATE_DT,
  APP_RECEIPT_DT,
  APP_STATUS_CODE,
  APP_STATUS_DT,
  APP_STATUS_AGE_BD,
  APP_STATUS_AGE_CD,
  ELIG_OUTCOME_CD,
  ELIG_OUTCOME_REASON_CD,
  ELIG_OUTCOME_CREATE_TS,
  ELIG_OUTCOME_CREATED_BY,
  ELIG_OUTCOME_UPDATE_TS,
  ELIG_OUTCOME_UPDATED_BY,
  SUBPROGRAM_CODE,
  HARMONY_FLAG,
  VISIT_ATTENDED_DATE,
  VISIT_SCHEDULED_DT,
  APP_START_DT,
  PA600_RECEIVED_DATE,
  LOCA_DATE_SENT,
  LOCA_DATE_RECEIVED,
  LOCA_LEVEL_CARE_CODE,
  LOCA_LENGTH_CARE_CODE,
  PC_SENT_DATE,
  PC_LEVEL_CARE_CODE,
  PC_LENGTH_CARE_CODE,
  PC_DATE_RECEIVED,
  OPEN_TO_VISIT,
  OPEN_TO_STATUS,
  OPEN_TO_PCSENT,
  OPEN_TO_PCREC,
  OPEN_TO_LOCASENT,
  OPEN_TO_LOCAREC,
  OPEN_TO_PA600REC,
  LEVEL_OF_NEED_CODE,
  TRANSITION_DATE,
  APP_DISPATCHED_CAO,
  P1768_SENT_DT,
  DISPOSITION_STATUS_CODE,
  REASON_DELAY_CODE,
  ENROLL_DELAYED_REASON_CD,
  DELAY_EXCUSE,
  SC_ENTITY_DT,
  COMPLETE_DT,
  CLOSE_REASON_CODE,
  ELIG_APP_STATUS_CODE,
  APP_AGE_BD,
  APP_AGE_CD,
  NF_FLAG,
  MFP_FLAG,
  ANTICIPATED_DETERMINATION,
  ELI_SLA_DAYS,
  ELI_SLA_DAYS_TYPE,
  ELI_SLA_JEOPARDY_DAYS,
  ELI_SLA_TARGET_DAYS,
  ELI_SLA_JEOPARDY_DT,
  APP_SLA_DAYS,
  APP_SLA_DAYS_TYPE,
  APP_CYCLE_BUS_DAYS,
  APP_CYCLE_CAL_DAYS,
  APP_SLA_JEOPARDY_DAYS,
  APP_SLA_TARGET_DAYS,
  APP_SLA_JEOPARDY_DT,
  APP_JEOPARDY_FLAG,
  APP_TIMELINESS_STATUS,
  TRANS_SLA_DAYS,
  TRANS_SLA_DAYS_TYPE,
  TRANS_SLA_JEOPARDY_DAYS,
  TRANS_SLA_TARGET_DAYS,
  TRANS_SLA_JEOPARDY_DT,
  TRANS_JEOPARDY_FLAG,
  PENDING_MI_TYPE,
  MI_LETTER_ID,
  OPEN_ID,
  COMPASS_APPLICATION_ID,
  APP_CREATED_BY,
  OPTIONS,
  MI_IND,
  FIRST_MI_ADDED_DATE,
  OVERALL_MI_IND,
  ACTUAL_DISCHARGE_DATE,
  APPLICANT_MED_ASSISTANCE_IND,
  APPLICANT_RECEIVE_WAIVER_IND,
  OTH_WAIVER_CD,
  CMI_SC_AGENCY_1,
  CMI_SC_AGENCY_2,
  CMI_SC_AGENCY_3,
  CMI_NH_TRAN_COORDINATOR_1,
  CMI_NH_TRAN_COORDINATOR_2,
  CMI_NH_TRAN_COORDINATOR_3,
  PHY_SIGN_DATE,
  PHY_CERT_STATUS,
  LCD_SUPERVISOR_SIGN_DATE,
  LCD_STATUS,
  PA600_LETTER_DATE,
  OPEN_TO_PA600_SENT,
  FINAL_PACKET_LETTER_ID,
  MD_REVIEW_IND,
  CHC_ZONE_IND,
  DISPOSITION_DT,
  APP_REVIEW_START_DT,
  APP_REVIEW_END_DT,
  APPROVED_DT,
  XAPPROVED_DT,
  ASSESS_IN_PROC_START_DT,
  ASSESS_IN_PROC_END_DT,
  FIN_APPR_START_DT,
  FIN_APPR_END_DT,
  FIN_APPR_MISMATCH_START_DT,
  FIN_APPR_MISMATCH_END_DT,
  MA162_REC_DT,
  FIN_DENIAL_END_DT,
  MMS_DT,
  XMMS_DT,
  OLTL_READY_DT,
  OLTL_READY_END_DT,
  PC_LCD_PENDING_DT,
  XPC_LCD_PENDING_DT,
  APP_INITIAL_CONTACT,
  READY_ASSESS_END_DT,
  READY_TRANS_START_DT,
  READY_TRANS_END_DT,
  VISIT_FIRST_CONTACT,
  SCHEDULED_END_DT,
  PENDING_STATUS_DT,
  PENDING_END_DT,
  ELIGIBILITY_DET_DT,
  ENROLLED_DT,
  EB_IVA_START_DT,
  FIN_APPR_CYCLE_START_DT,
  DATA_ENTRY_CYCLE_START_DT,
  OPEN_TO_ENROLLED,
  PC_LCD_TO_PC_RCVD,
  PC_LCD_TO_LOCA_RCVD,
  DAYS_IN_LCD,
  DAYS_IN_MMS,
  DAYS_IN_APPRV,
  ENROLLMENT_STATUS_AGE_BD,
  ENROLLMENT_STATUS_AGE_CD,
  ELI_APP_CYCLE_BUS_DAYS,
  ELI_APP_CYCLE_CAL_DAYS,
  ELI_SLA_JEOPARDY_FLAG,
  ELI_TIMELINESS_STATUS,
  TRANS_APP_CYCLE_BUS_DAYS,
  TRANS_APP_CYCLE_CAL_DAYS,
  TRANS_TIMELINESS_STATUS,
  DETERMINATION_NOTICE_DT,
  PC_LCD_CYCLE_AGE_CD,
  APP_REVIEW_CYCLE_AGE_CD,
  EB_IVA_CYCLE_AGE_CD,
  MMS_CYCLE_AGE_CD,
  FIN_APPR_CYCLE_AGE_CD,
  DATA_ENTRY_CYCLE_AGE_CD,
  FINAL_MAIL_CYCLE_AGE_CD,
  PENDING_NEXT_STATUS,
  FIRST_CONTACT_DATE,
  LAST_IVA_CONTACT_DATE,
  PERMISSION_TO_SHARE_IND,
  HOW_HEARD_OTHER,
  DUAL_HOUSEHOLD_FLAG,
  REASON_DELAYED_SCHEDULE,
  MD_DETERMINATION
) as
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
           app_doc.pa600_received_date as pa600_received_date,
           lcd_ltr.sent_date as loca_date_sent,
           mi_dates.lcd_date as loca_date_received,
           COALESCE (he.lcd_level_care, 'UD')
               loca_level_care_code,
           COALESCE (he.lcd_len_care, 'UD')
               loca_length_care_code,
           pc_ltr.sent_date as pc_sent_date,
           
           COALESCE (he.phy_level_care, 'UD')
               pc_level_care_code,
           COALESCE (he.phy_len_care, 'UD')
               pc_length_care_code,
           mi_dates.pc_date as pc_date_received,
             
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
                     cast(COALESCE (ash.fin_appr_status_dt,
                               ash.fin_denial_status_dt) as date)
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
               sh.status_date status_dt,
               ROW_NUMBER () OVER (PARTITION BY sh.application_id, sh.status_cd ORDER BY app_status_history_id DESC) AS rn,
               LEAD (sh.app_status_history_id, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) AS next_ash_id,
               LEAD (sh.status_date , 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) AS end_dt,
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
                           sh.status_date status_dt,
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


