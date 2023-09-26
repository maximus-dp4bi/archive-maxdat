CREATE OR REPLACE VIEW tn_ci_redetermination_sv
AS
SELECT 
 application_id
 ,medicaid_rfi_selection_date
 ,rid
 ,CASE WHEN supplemental_nbr IS NOT NULL THEN
    CASE WHEN (approval_ltr_mailed = 'Y' AND elig_outcome_cd IN('APPROVED','STATE APPROVED') AND program_cd != 'CHIP')
     OR (accent_processed_date IS NOT NULL AND  program_cd != 'CHIP') THEN case_cin ELSE supplemental_nbr END
   ELSE case_cin END case_id
,first_name
,middle_name
,last_name
,gender
,date_of_birth
,ssn
,authorized_representative
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN pregnancy_indicator ELSE NULL END pregnancy_indicator
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN us_citizen_indicator ELSE NULL END us_citizen_indicator
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN eligible_immigrant_alleged ELSE NULL END eligible_immigrant_alleged
,previous_aid_category
,ac.report_label previous_aid_category_desc
,CASE WHEN (approval_ltr_mailed = 'Y' AND elig_outcome_cd IN('APPROVED','STATE APPROVED') AND program_cd != 'CHIP')
     OR (accent_processed_date IS NOT NULL AND  program_cd != 'CHIP') THEN new_aid_category ELSE NULL END new_aid_category
,CASE WHEN (approval_ltr_mailed = 'Y' AND elig_outcome_cd IN('APPROVED','STATE APPROVED') AND program_cd != 'CHIP')
     OR (accent_processed_date IS NOT NULL AND  program_cd != 'CHIP') THEN nac.report_label ELSE NULL END new_aid_category_desc
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN household_size ELSE NULL END  household_size
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN household_income ELSE NULL END household_income
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN other_coverage ELSE NULL END other_coverage
,phone
,renewal_packet_id
,renewal_packet_type
,method_of_receipt
,home_address1
,home_address2
,home_address_city
,home_address_state
,home_address_zip
,home_address_county
,mail_address1
,mail_address2
,mail_address_city
,mail_address_state
,mail_address_zip
,mail_address_county
,CASE WHEN tn405_mail_date IS NOT NULL THEN
           CASE WHEN TO_CHAR(tn405_mail_date + 20,'D') IN ('1','7') OR EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = TRUNC(tn405_mail_date)+20) THEN
                   get_business_date(TRUNC(tn405_mail_date+20),1) ELSE TRUNC(tn405_mail_date)+20  END +1         
      WHEN tn405a_mail_date IS NOT NULL AND COALESCE(tn408ftp_mail_date,tn409ftp_mail_date,tn411_mail_date) IS NOT NULL THEN eligibility_end_date +1   
      WHEN tn403_mail_date IS NOT NULL THEN latest_doc_receipt_date   
      WHEN tn402_mail_date IS NOT NULL OR tn404_mail_date IS NOT NULL  THEN latest_app_receipt_date      
      WHEN tn403qmb_mail_date IS NOT NULL AND maxe_ats_application_status = 'COMPLETED' THEN ADD_MONTHS(TRUNC(status_date,'mm'),1)      
      WHEN tn413_mail_date IS NOT NULL THEN latest_app_receipt_date
	    WHEN tn413a_mail_date IS NOT NULL AND COALESCE(tn408ftp_mail_date,tn411_mail_date) IS NOT NULL THEN eligibility_end_date +1   
 ELSE null END approval_notice_effective_date 
,CASE WHEN approval_ltr_mailed = 'Y' THEN NULL ELSE eligibility_end_date END eligibility_end_date
,tn412_mail_date
,tn401_mail_date
,tn401a_mail_date
,tn402_mail_date
,tn403_mail_date
,tn403qmb_mail_date
,tn404_mail_date
,tn405_mail_date
,tn405a_mail_date
,tn406a_mail_date
,tn406b_mail_date
,tn406c_mail_date
,tn406d_mail_date
,tn406e_mail_date
,tn406f_mail_date
,tn406g_mail_date
,tn406h_mail_date
,tn406i_mail_date
,tn406j_mail_date
,tn406l_mail_date
,tn406m_mail_date
,tn406n_mail_date
,tn406o_mail_date
,tn406p_mail_date --Bonnie added jira 4784
,tn407_mail_date
,tn408_mail_date
,tn409_mail_date
,tn401r_initial_mail_date
,tn401ar_initial_mail_date
,tn401r_last_mail_date
,tn401ar_last_mail_date
,tn411_mail_date
,tn408ftp_mail_date
,tn409ftp_mail_date
,tn410msp_mail_date
,tn413_mail_date
,tn413a_mail_date
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN parent_caretaker_indicator ELSE NULL END parent_caretaker_indicator
,pool_file_select_date
,renewal_receipt_date
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN student_indicator ELSE NULL END student_indicator
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN mitc_result_redetermination ELSE NULL END mitc_result_redetermination
,COALESCE(work_number_verified,'N') work_number_verified
,CASE WHEN maxe_ats_application_status = 'COMPLETED' THEN residency_verified ELSE NULL END residency_verified
,last_status_sent_to_mmis
,status_code_sent_to_mmis
,ci.LATEST_DOC_RECEIPT_DATE Verification_Received_Date --BW added column for TNERPS_4382
,verification_return_date verification_satisfied_date
,relationship_person1
,maxe_ats_application_status
,in_rfi_yn
,CASE WHEN denial_ltr_mailed = 'Y' AND elig_outcome_cd IN('REJECTED','STATE REJECTED') THEN r.report_label ELSE null END denial_reason 
,date_hcfa_referral
,CASE WHEN TRUNC(renewal_receipt_date) > eligibility_end_date AND TRUNC(renewal_receipt_date) <= eligibility_end_date + 90 THEN 'Y' ELSE 'N' END rcvd_during_reconsider_prd
,referral_task_type
,scan_date
,CASE WHEN latest_doc_receipt_date IS NOT NULL AND maxe_ats_application_status = 'INPROCESS' THEN 'Y' ELSE 'N' END pending_status 
,DECODE(cob_indicator,'Y','Yes','N','No','No') cob_indicator
,ck_pool_file_selection_date
FROM tn_ci_redetermination ci
 LEFT JOIN subprogram_type_lkup ac ON ci.previous_aid_category = ac.value
 LEFT JOIN subprogram_type_lkup nac ON ci.new_aid_category = nac.value
 LEFT JOIN elig_outcome_reason_lkup r ON ci.elig_outcome_reason_cd = r.value
WHERE ((ci.app_form_cd IN('RENEWAL','LTSS') AND ci.maxe_ats_application_status NOT IN('TIMEOUT','DISREGARDED'))  OR (ci.app_form_cd IS NULL AND ci.maxe_ats_application_status = 'DISREGARDED') 
    OR (ci.app_form_cd IS NULL AND renewal_packet_id IS NOT NULL)
    OR (ci.app_form_cd = 'APPLICATION_PACKET' AND ci.maxe_ats_application_status NOT IN('TIMEOUT','DISREGARDED') 
         AND NOT EXISTS(SELECT 1 FROM tn_ci_redetermination cir 
                        WHERE ci.client_id = cir.client_id
                        AND cir.app_form_cd IN('RENEWAL')
                        AND cir.maxe_ats_application_status NOT IN('DISREGARDED','TIMEOUT')))
     OR (ci.app_form_cd IN('RENEWAL','LTSS','APPLICATION_PACKET') AND ci.maxe_ats_application_status IN('DISREGARDED','TIMEOUT') 
                                             AND NOT EXISTS(SELECT 1 FROM tn_ci_redetermination air 
                                                             WHERE air.client_id = ci.client_id 
                                                             AND air.application_id > ci.application_id
                                                             )
                                                             AND NOT EXISTS(SELECT 1 FROM tn_ci_redetermination air
                                                             WHERE  air.client_id = ci.client_id
                                                             AND air.application_id != ci.application_id
                                                             AND air.maxe_ats_application_status NOT IN('DISREGARDED','TIMEOUT')                               
                                                             ))  
)
  AND ci.application_id >= 320 -- filter out test data
  AND ci.case_cin IS NOT NULL
;

GRANT SELECT ON TN_CI_REDETERMINATION_SV TO MAXDAT_READ_ONLY;

