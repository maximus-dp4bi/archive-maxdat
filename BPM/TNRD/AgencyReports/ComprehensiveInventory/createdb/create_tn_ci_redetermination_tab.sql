alter session set current_schema = "MAXDAT";

CREATE TABLE TN_CI_REDETERMINATION
(APPLICATION_ID	NUMBER
,	CLIENT_ID	NUMBER
,	CASE_ID	NUMBER
,	APP_INDIVIDUAL_ID	NUMBER
,	MEDICAID_RFI_SELECTION_DATE	VARCHAR2(20)
,	RID	VARCHAR2(30)
, SUPPLEMENTAL_NBR VARCHAR2(32)
,	CASE_CIN	VARCHAR2(30)
,	FIRST_NAME	VARCHAR2(50)
,	MIDDLE_NAME	VARCHAR2(50)
,	LAST_NAME	VARCHAR2(50)
,	GENDER	VARCHAR2(32)
,	DATE_OF_BIRTH	DATE
,	SSN	VARCHAR2(30)
,	AUTHORIZED_REPRESENTATIVE	VARCHAR2(200)
,	PREGNANCY_INDICATOR	VARCHAR2(10)
,	US_CITIZEN_INDICATOR	VARCHAR2(10)
,	ELIGIBLE_IMMIGRANT_ALLEGED	VARCHAR2(10)
,	PREVIOUS_AID_CATEGORY	VARCHAR2(32)
,	NEW_AID_CATEGORY	VARCHAR2(32)
,	HOUSEHOLD_SIZE	NUMBER
,	HOUSEHOLD_INCOME	NUMBER
,	OTHER_COVERAGE	VARCHAR2(10)
,	PHONE	VARCHAR2(30)
,	RENEWAL_PACKET_ID	NUMBER
,	RENEWAL_PACKET_TYPE	VARCHAR2(64)
,	METHOD_OF_RECEIPT	VARCHAR2(64)
,	HOME_ADDRESS1	VARCHAR2(55)
,	HOME_ADDRESS2	VARCHAR2(55)
,	HOME_ADDRESS_CITY	VARCHAR2(30)
,	HOME_ADDRESS_STATE	VARCHAR2(30)
,	HOME_ADDRESS_ZIP	VARCHAR2(32)
,	HOME_ADDRESS_COUNTY	VARCHAR2(64)
,	MAIL_ADDRESS1	VARCHAR2(55)
,	MAIL_ADDRESS2	VARCHAR2(55)
,	MAIL_ADDRESS_CITY	VARCHAR2(30)
,	MAIL_ADDRESS_STATE	VARCHAR2(30)
,	MAIL_ADDRESS_ZIP	VARCHAR2(32)
,	MAIL_ADDRESS_COUNTY	VARCHAR2(64)
,	ELIGIBILITY_END_DATE	DATE
,	TN412_MAIL_DATE	DATE
,	TN401_MAIL_DATE	DATE
,	TN401A_MAIL_DATE	DATE
,	TN402_MAIL_DATE	DATE
,	TN403_MAIL_DATE	DATE
,	TN403QMB_MAIL_DATE	DATE
,	TN404_MAIL_DATE	DATE
,	TN405_MAIL_DATE	DATE
,	TN405A_MAIL_DATE	DATE
,	TN406A_MAIL_DATE	DATE
,	TN406B_MAIL_DATE	DATE
,	TN406C_MAIL_DATE	DATE
,	TN406D_MAIL_DATE	DATE
,	TN406E_MAIL_DATE	DATE
,	TN406F_MAIL_DATE	DATE
,	TN406G_MAIL_DATE	DATE
,	TN406H_MAIL_DATE	DATE
,	TN406I_MAIL_DATE	DATE
,	TN406J_MAIL_DATE	DATE
,	TN406L_MAIL_DATE	DATE
,	TN406M_MAIL_DATE	DATE
,	TN406N_MAIL_DATE	DATE
,	TN406O_MAIL_DATE	DATE
,	TN406P_MAIL_DATE	DATE
,	TN407_MAIL_DATE	DATE
,	TN408_MAIL_DATE	DATE
,	TN409_MAIL_DATE	DATE
,	TN401R_INITIAL_MAIL_DATE	DATE
,	TN401AR_INITIAL_MAIL_DATE	DATE
,	TN401R_LAST_MAIL_DATE	DATE
,	TN401AR_LAST_MAIL_DATE	DATE
,	TN411_MAIL_DATE	DATE
,	TN408FTP_MAIL_DATE	DATE
,	TN409FTP_MAIL_DATE	DATE
,	TN410MSP_MAIL_DATE	DATE
,	TN413_MAIL_DATE	DATE
,	TN413A_MAIL_DATE	DATE
,	PARENT_CARETAKER_INDICATOR	VARCHAR2(10)
,	POOL_FILE_SELECT_DATE	DATE
,	RENEWAL_RECEIPT_DATE	DATE
,	STUDENT_INDICATOR	VARCHAR2(10)
,	MITC_RESULT_REDETERMINATION	VARCHAR2(32)
,	WORK_NUMBER_VERIFIED	VARCHAR2(10)
,	RESIDENCY_VERIFIED	VARCHAR2(10)
,	LAST_STATUS_SENT_TO_MMIS	DATE
,	STATUS_CODE_SENT_TO_MMIS	VARCHAR2(32)
,	VERIFICATION_RETURN_DATE	DATE
,	RELATIONSHIP_PERSON1	VARCHAR2(32)
,	MAXE_ATS_APPLICATION_STATUS	VARCHAR2(32)
,	IN_RFI_YN	VARCHAR2(10)
,	DATE_HCFA_REFERRAL	DATE
,	REFERRAL_TASK_TYPE	VARCHAR2(100)
,	SCAN_DATE	DATE
,	COB_INDICATOR	VARCHAR2(10)
,	CK_POOL_FILE_SELECTION_DATE	DATE
, INCLUDE_IN_CIR VARCHAR2(10)
, CREATE_DATE DATE
, UPDATE_DATE DATE
, ELIG_OUTCOME_CD VARCHAR2(32)
, ELIG_OUTCOME_REASON_CD VARCHAR2(32)
, PROGRAM_CD VARCHAR2(32)
, RES_ADDR_ID NUMBER
, MAIL_ADDR_ID NUMBER
, ACCENT_PROCESSED_DATE DATE
, LATEST_APP_RECEIPT_DATE DATE
, LATEST_DOC_RECEIPT_DATE DATE
, STATUS_DATE DATE
, APPROVAL_LTR_MAILED VARCHAR2(2)
, DENIAL_LTR_MAILED VARCHAR2(2)
, APP_FORM_CD VARCHAR2(32)
, RCVD_DURING_RECONSIDER_PRD VARCHAR2(1)
, OUTSTANDING_MI_COUNT NUMBER
, UC_TASK_TYPE VARCHAR2(100)
, UC_TASK_BU_NAME VARCHAR2(100)
, UC_TASK_STATUS VARCHAR2(64)
, UC_TASK_OWNER_NAME VARCHAR2(100)
, UC_TASK_OWNER_TYPE VARCHAR2(32)
, UC_TASK_ID NUMBER
, UC_TASK_CREATE_DATE DATE
, L_401_401a_DATE NUMBER
, RFE_STATUS_CD VARCHAR2(32)
) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX IDX1_TNCIR_APP ON TN_CI_REDETERMINATION(APPLICATION_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX2_TNCIR_INCLUDEFLAG ON TN_CI_REDETERMINATION(INCLUDE_IN_CIR) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX3_TNCIR_INCLUDEFLAG ON TN_CI_REDETERMINATION(CASE_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX4_TNCIR_INCLUDEFLAG ON TN_CI_REDETERMINATION(CLIENT_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX5_TNCIR_INCLUDEFLAG ON TN_CI_REDETERMINATION(MAXE_ATS_APPLICATION_STATUS) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX6_TNCIR_INCLUDEFLAG ON TN_CI_REDETERMINATION(APP_FORM_CD) TABLESPACE MAXDAT_INDX;



GRANT SELECT ON TN_CI_REDETERMINATION TO MAXDAT_READ_ONLY;

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
,tn406p_mail_date
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
,ci.LATEST_DOC_RECEIPT_DATE verification_received_date --BW added column for TNERPS_4382
,verification_return_date verification_satisfy_date
,relationship_person1
,maxe_ats_application_status
,in_rfi_yn
,CASE WHEN denial_ltr_mailed = 'Y' AND elig_outcome_cd IN('REJECTED','STATE REJECTED') THEN r.report_label ELSE null END denial_reason 
,date_hcfa_referral
--,CASE WHEN TRUNC(renewal_receipt_date) > eligibility_end_date AND TRUNC(renewal_receipt_date) <= eligibility_end_date + 90 THEN 'Y' ELSE 'N' END rcvd_during_reconsider_prd
,rcvd_during_reconsider_prd
,referral_task_type
,scan_date
--,CASE WHEN latest_doc_receipt_date IS NOT NULL AND maxe_ats_application_status = 'INPROCESS' THEN 'Y' ELSE 'N' END pending_status 
,CASE WHEN uc_task_id IS NOT NULL THEN 'Y' ELSE 'N' END pending_status
,DECODE(cob_indicator,'Y','Yes','N','No','No') cob_indicator
,ck_pool_file_selection_date
,outstanding_mi_count outstanding_verifications_count
,uc_task_type task_type
,uc_task_create_date task_create_date
,CASE WHEN uc_task_type IN('Voluntary Terminations','LTSS+','Other Non-MAGI+','MSP Only','Medically Eligible Review','DOD') 
         OR uc_task_bu_name IN('State Eligibility','HCFA Verifications')
         OR uc_task_owner_type = 'STATE' THEN 'HCFA_TASK'
       WHEN uc_task_id IS NOT NULL THEN 'MAXIMUS_TASK'
       WHEN COALESCE(outstanding_mi_count,0) != 0 AND uc_task_id IS NULL AND maxe_ats_application_status = 'INPROCESS' THEN 'PENDING_MI'
       WHEN (status_code_sent_to_mmis = 'RFI' AND  maxe_ats_application_status = 'INPROCESS' AND (latest_app_receipt_date IS NULL OR latest_app_receipt_date < l_401_401a_date) )
          OR (TRUNC(SYSDATE)  BETWEEN tn411_mail_date AND tn411_mail_date+ 20 )  THEN 'PENDING_APP'       
    ELSE NULL END redet_status
FROM tn_ci_redetermination ci
 LEFT JOIN subprogram_type_lkup ac ON ci.previous_aid_category = ac.value
 LEFT JOIN subprogram_type_lkup nac ON ci.new_aid_category = nac.value
 LEFT JOIN elig_outcome_reason_lkup r ON ci.elig_outcome_reason_cd = r.value
WHERE 1 = 1
AND ci.application_id >= 320 -- filter out test data
AND ci.case_cin IS NOT NULL
  /* ((ci.app_form_cd IN('RENEWAL','LTSS') AND ci.maxe_ats_application_status NOT IN('TIMEOUT','DISREGARDED'))  OR (ci.app_form_cd IS NULL AND ci.maxe_ats_application_status = 'DISREGARDED') 
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
)*/
  
;

GRANT SELECT ON TN_CI_REDETERMINATION_SV TO MAXDAT_READ_ONLY;