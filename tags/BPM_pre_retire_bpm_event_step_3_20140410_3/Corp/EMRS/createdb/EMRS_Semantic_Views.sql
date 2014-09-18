CREATE OR REPLACE VIEW EMRS_D_PROGRAM_SV
AS
SELECT program_id
      ,program_code
      ,program_name
      ,start_date
      ,end_date
      ,program_category
      ,managed_care_program
      ,active_inactive
      ,source_record_id
FROM emrs_d_program;

CREATE OR REPLACE VIEW EMRS_D_AID_CATEGORY_SV
AS
SELECT ACTIVE_INACTIVE
       ,END_DATE
       ,MANAGED_CARE_PROGRAM 
       ,AID_CATEGORY_NAME 
       ,AID_CATEGORY_CODE 
       ,AID_CATEGORY_ID 
       ,START_DATE 
       ,SOURCE_RECORD_ID 
FROM emrs_d_aid_category;

CREATE OR REPLACE VIEW EMRS_D_CARE_SERV_DELIV_AREA_SV
AS
SELECT csda_id
       ,managed_care_program
       ,csda_code
       ,csda_name
       ,region_number_category
       ,status
       ,implementation_date
       ,record_date
       ,record_time
       ,record_name
       ,modified_date
       ,modified_name
       ,starplus
       ,source_record_id
FROM emrs_d_care_serv_deliv_area;

CREATE OR REPLACE VIEW EMRS_D_CASE_SV
AS
SELECT case_id
       ,managed_care_program
       ,case_number
       ,csda_code
       ,first_name
       ,middle_initial
       ,last_name
       ,full_name
       ,phone
       ,mailing_address1
       ,mailing_address2
       ,mailing_city
       ,mailing_state
       ,mailing_zip
       ,case_search_element
       ,guardian_full_name
       ,record_date
       ,record_time
       ,record_name
       ,modified_date
       ,modified_time
       ,modified_name
       ,version
       ,date_of_validity_start
       ,date_of_validity_end
       ,created_by
       ,date_created
       ,updated_by
       ,date_updated
       ,source_record_id
       ,current_case_id
       ,current_flag
       ,case_cin 
       ,family_number 
       ,case_status_date 
       ,case_educated_ind 
       ,case_educated_date 
       ,case_need_translator_ind 
       ,case_phone_reminder_use
       ,case_educated_by 
       ,case_staff_id
       ,case_language_cd 
       ,case_how_educated_cd
       ,case_status 
       ,case_head_ssn 
       ,case_team 
       ,case_load 
       ,clnt_client_id 
       ,fmnb_id
       ,load_type 
       ,case_spoken_language_cd 
       ,note_ref_id 
       ,anniversary_dt 
       ,state_staff_id_ext 
       ,case_generic_field1_date
       ,case_generic_field2_date
       ,case_generic_field3_num 
       ,case_generic_field4_num 
       ,case_generic_field5_txt 
       ,case_generic_field6_txt 
       ,case_generic_field7_txt 
       ,case_generic_field8_txt 
       ,case_generic_field9_txt 
       ,case_generic_field10_txt
       ,case_generic_ref11_id
       ,case_generic_ref12_id
       ,last_state_update_ts
       ,last_state_updated_by
FROM emrs_d_case
WHERE current_flag = 'Y';

CREATE OR REPLACE VIEW EMRS_D_CHANGE_REASON_SV
AS
SELECT change_reason_id
       ,managed_care_program
       ,change_reason_code_plan
       ,change_reason_code
       ,change_reason
       ,source_record_id
FROM emrs_d_change_reason;

CREATE OR REPLACE VIEW EMRS_D_CITIZENSHIP_STATUS_SV
AS
SELECT managed_care_program
       ,citizenship_description
       ,citizenship_code
       ,citizenship_id
       ,source_record_id
FROM emrs_d_citizenship_status;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_SV
AS
SELECT client_id
       ,client_number
       ,managed_care_program
       ,full_name
       ,first_name
       ,middle_initial
       ,last_name
       ,coverage_type
       ,enrollment_status
       ,transaction_hold
       ,managed_care_candidate
       ,base_plan
       ,race
       ,sex
       ,date_of_birth
       ,phone
       ,social_security_number
       ,add1
       ,add2
       ,city
       ,st
       ,zip
       ,county
       ,ssn_railroad_claim_number
       ,record_date
       ,record_time
       ,record_name
       ,modified_date
       ,modified_time
       ,modified_name
       ,version
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_created
       ,created_by
       ,updated_by
       ,date_updated
       ,pregnant_member
       ,newborn
       ,adult_or_child
       ,third_party_resources_avail
       ,migrant_worker_flag
       ,managed_via_gen_rev_flag
       ,managed_via_state_fund_flag
       ,receiving_tanf_flag
       ,receiving_ssi_flag
       ,client_reported_shcn
       ,plan_reported_shcn
       ,date_of_death
       ,date_of_death_source
       ,source_record_id
       ,current_flag
       ,current_client_id
       ,clnt_clnt_client_id 
       ,clnt_ethnicity 
       ,clnt_tpl_present 
       ,clnt_national_id 
       ,clnt_from_pacmis 
       ,clnt_share_premium 
       ,clnt_not_born 
       ,clnt_hipaa_privacy_ind
       ,clnt_finet_vendor_nbr
       ,clnt_enroll_status 
       ,clnt_enroll_status_date
       ,sched_auto_assign_date 
       ,clnt_cin
       ,clnt_comment 
       ,clnt_pseudo_id 
       ,ssnvl_id 
       ,note_ref_id 
       ,clnt_marital_cd
       ,clnt_status_cd 
       ,clnt_expected_dob 
       ,clnt_preg_term_date 
       ,clnt_preg_term_reas_cd 
       ,client_type_cd 
       ,supplemental_nbr
       ,state_language 
       ,do_not_call_ind 
       ,written_language 
       ,suffix 
       ,salutation_cd 
       ,domestic_violence_ind
       ,english_fluency_cd  
       ,english_literacy_cd  
       ,tribe_cd  
       ,clnt_generic_field1_date
       ,clnt_generic_field2_date
       ,clnt_generic_field3_num
       ,clnt_generic_field4_num
       ,clnt_generic_field5_txt
       ,clnt_generic_field6_txt
       ,clnt_generic_field7_txt
       ,clnt_generic_field8_txt
       ,clnt_generic_field9_txt
       ,clnt_generic_field10_txt 
       ,clnt_generic_ref11_id 
       ,clnt_generic_ref12_id 
       ,do_not_text_ind 
       ,do_not_email_ind 
       ,last_state_update_ts 
       ,last_state_updated_by 
       ,comparable_key      
       ,EXTRACT(YEAR FROM(SYSDATE - date_of_birth) YEAR TO MONTH) age
FROM emrs_d_client
WHERE current_flag = 'Y';

CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
SELECT client_plan_eligibility_id
       ,client_number
       ,plan_type_id
       ,sub_program_id
       ,eligibility_status_code
       ,current_eligibility_status_cd
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,version
       ,source_record_id
FROM emrs_d_client_plan_eligibility
WHERE current_flag = 'Y';

CREATE OR REPLACE VIEW EMRS_D_COUNTY_SV
AS
SELECT county_id
       ,state
       ,county_code
       ,county_fips_code
       ,county_name
       ,modified_date
       ,modified_time
       ,modified_name
       ,vol
       ,status
       ,csdaid
       ,star
       ,starplus
       ,public_health_code
       ,sh_region
       ,plan_service_type
       ,source_record_id
FROM emrs_d_county;

CREATE OR REPLACE VIEW EMRS_D_COVERAGE_CATEGORY_SV
AS
SELECT coverage_category_id
       ,managed_care_program
       ,coverage_category_type
       ,coverage_category_code
       ,coverage_category
       ,source_record_id
FROM emrs_d_coverage_category;

CREATE OR REPLACE VIEW EMRS_D_DATE_PERIOD_SV
AS
SELECT date_period_id
       ,date_full
       ,date_standard_1
       ,date_standard_2
       ,date_standard_3
       ,date_standard_4
       ,day_of_week
       ,month_name
       ,season
       ,quarter
       ,last_day_in_month_ind
       ,last_day_in_week_ind
       ,holiday_ind
       ,weekday_ind
       ,major_event
       ,week_ending_date
       ,day_number_in_month
       ,day_number_in_week
       ,day_number_in_year
       ,fiscal_half_year
       ,fiscal_month_num_in_year
       ,fiscal_quarter
       ,fiscal_week
       ,fiscal_year
       ,fiscal_year_day_number
       ,fiscal_year_month
       ,fiscal_year_quarter
       ,month_number_in_year
       ,week_number_in_year
       ,year_yyyy
       ,year_half
       ,year_month
       ,year_quarter
       ,version
       ,date_of_validity_start
       ,date_of_validity_end
       ,created_by
       ,date_created
       ,updated_by
       ,date_updated
FROM emrs_d_date_period;

CREATE OR REPLACE VIEW EMRS_D_ENROLL_ACTION_STATUS_SV
AS
SELECT enrollment_action_status_id
       ,managed_care_program
       ,enrollment_action_status_code
       ,enrollment_action_status_code_
       ,source_record_id
FROM emrs_d_enrollment_action_statu;

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_NOTIF_SV
AS
SELECT enrollment_group_id
       ,notification_id
FROM emrs_d_enrollment_notification;

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_REJECTION_SV
AS
SELECT enrollment_id
       ,rejection_error_reason_id
FROM emrs_d_enrollment_rejection;

CREATE OR REPLACE VIEW EMRS_D_FEDERAL_POVERTY_LVL_SV
AS
SELECT fpl_id
       ,fpl_year
       ,fpl_locale
       ,fpl_number_in_family
       ,fpl_max_dollars
       ,fpl_description
       ,source_record_id
FROM emrs_d_federal_poverty_level;

CREATE OR REPLACE VIEW EMRS_D_LANGUAGE_SV
AS
SELECT language_code_id
       ,managed_care_program
       ,language_code
       ,language
       ,business_start_date
       ,business_end_date
       ,source_record_id
FROM emrs_d_language;

CREATE OR REPLACE VIEW EMRS_D_NOTIFICATION_SV
AS
SELECT notification_id
       ,send_date
       ,maintenance_type_cd
       ,maintenance_reason
       ,created_by
       ,date_created
       ,source_record_id
FROM emrs_d_notification;

CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
SELECT plan_id
       ,managed_care_program
       ,csda
       ,plan_code
       ,plan_name
       ,plan_abbreviation
       ,plan_effective_date
       ,address1
       ,address2
       ,city
       ,state
       ,zip
       ,active
       ,contact_first_name
       ,contact_initial
       ,contact_last_name
       ,contact_full_name
       ,contact_phone
       ,contact_extension
       ,member_contact_phone
       ,enrollok
       ,plan_assign
       ,record_date
       ,record_time
       ,record_name
       ,source_record_id
       ,plan_type_id
       ,plan_service_type
FROM emrs_d_plan;

CREATE OR REPLACE VIEW EMRS_D_PLAN_TYPE_SV
AS
SELECT plan_type_id
       ,plan_type
       ,managed_care_program
       ,source_record_id
FROM emrs_d_plan_type;

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SV
AS
SELECT provider_id
       ,provider_code
       ,managed_care_program
       ,plan_id
       ,provider_title
       ,provider_first_name
       ,provider_last_name
       ,attention_line
       ,address_1
       ,address_2
       ,address_3
       ,city
       ,state
       ,zip
       ,phone
       ,county_id
       ,provider_license_number
       ,provider_license_number_old
       ,provider_license_national_id
       ,provider_license_category
       ,npi_benefit_code
       ,npi_primary_taxonomy_code
       ,race_id
       ,provider_type       
       ,provider_specialty
       ,provider_tax_id
       ,provider_sex_restrictions
       ,csda_id
       ,age_high
       ,age_low
       ,language_served_1
       ,language_served_2
       ,language_served_3
       ,total_clients_allowed
       ,source_record_date
       ,source_record_time
       ,source_record_name
       ,date_of_validity_start
       ,date_of_validity_end
       ,created_by
       ,date_created
       ,updated_by
       ,date_updated
       ,ofc_hr_open_from
       ,ofc_hr_close_at
       ,ofc_hr_days_of_week
       ,current_flag
       ,current_provider_id
       ,source_record_id
       ,provider_number       
       ,version
FROM emrs_d_provider
WHERE current_flag = 'Y';

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPEC_CD_SV
AS
SELECT provider_specialty_code_id
      ,provider_specialty_code
      ,provider_specialty
      ,valid_pcp
      ,invalid_pcp
      ,special_needs
      ,managed_care_program
      ,source_record_id
FROM emrs_d_provider_specialty_code;

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_TYPE_SV
AS
SELECT provider_type_id
      ,managed_care_program
      ,provider_name
      ,provider_code
      ,valid
      ,invalid
      ,source_record_id
FROM emrs_d_provider_type;

CREATE OR REPLACE VIEW EMRS_D_RACE_SV
AS
SELECT race_id
       ,race_code
       ,race_description
       ,managed_care_program
       ,source_record_id
FROM emrs_d_race;

CREATE OR REPLACE VIEW EMRS_D_REJECTION_ERROR_RSN_SV
AS
SELECT rejection_error_reason_id
       ,managed_care_program
       ,rejection_category
       ,related_files
       ,rejection_code
       ,rejection_error_reason
       ,rejection_error_description
       ,source_record_id
FROM emrs_d_rejection_error_reason;

CREATE OR REPLACE VIEW EMRS_D_RISK_GROUP_SV
AS
SELECT risk_group_id
       ,managed_care_program
       ,risk_group
       ,risk_group_code
       ,source_record_id
FROM emrs_d_risk_group;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_REASON_SV
AS
SELECT managed_care_program
       ,selection_reason_code
       ,selection_reason_id
       ,source_record_id
       ,selection_reason
FROM emrs_d_selection_reason;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_SOURCE_SV
AS
SELECT managed_care_program
       ,selection_source_code
       ,selection_source_id
       ,source_record_id
       ,selection_source
       ,is_choice_ind
FROM emrs_d_selection_source;

CREATE OR REPLACE VIEW EMRS_D_STATUS_IN_GROUP_SV
AS
SELECT status_in_group_id
       ,managed_care_program
       ,status_in_group_category
       ,status_in_group_code
       ,status_in_group
       ,source_record_id
FROM emrs_d_status_in_group;

CREATE OR REPLACE VIEW EMRS_D_SUB_PROGRAM_SV
AS
SELECT sub_program_id
      ,sub_program_name
      ,sub_program_code
      ,parent_program_id
      ,parent_program_name
      ,start_date
      ,end_date
      ,source_record_id
      ,managed_care_program
      ,plan_service_type
FROM emrs_d_sub_program
WHERE end_date IS NULL;

CREATE OR REPLACE VIEW EMRS_D_TERMINATION_REASON_SV
AS
SELECT term_reason_code_id
       ,managed_care_program
       ,plan_name
       ,reason_code
       ,reason
       ,source_record_id
FROM emrs_d_termination_reason;


CREATE OR REPLACE VIEW EMRS_D_TIME_PERIOD_SV
AS
SELECT time_period_id
       ,hour_minute
       ,hour_minute_military
       ,morning_noon_night
       ,open_lunch_close
       ,hour
       ,minute
       ,second
       ,military_hour
       ,military_second
       ,version
       ,date_of_validity_start
       ,date_of_validity_end
       ,created_by
       ,date_created
       ,updated_by
       ,date_updated
FROM emrs_d_time_period;

CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
AS
SELECT enrollment_id       
       ,change_reason_id       
       ,communication_type_id
       ,county_id
       ,coverage_category_id
       ,csda_id
       ,date_period_id
       ,enrollment_action_status_id
       ,fpl_id
       ,language_code_id
       ,plan_id
       ,program_id       
       ,provider_type_id
       ,race_id
       ,rejection_error_reason_id
       ,risk_group_id
       ,stat_in_grp_id
       ,sub_program_id
       ,term_reason_code_id
       ,time_period_id
       ,certification_date
       ,csda_change_date
       ,enrollment_status_change_date
       ,jyear_of_last_enrollment_form
       ,managed_care_end_date
       ,managed_care_start_date
       ,medicaid_buy_in_fee
       ,medicaid_buy_in_fee_date
       ,medicaid_recertification_date
       ,number_count
       ,date_created
       ,created_by
       ,updated_by
       ,date_updated
       ,met_cost_share_cap_date
       ,cost_share_start_date
       ,cost_share_end_date
       ,enrollment_fee_frequency
       ,chip_annual_enroll_date
       ,selection_source_id
       ,selection_reason_id
       ,aid_category_id
       ,citizenship_id
       ,enrollment_group_id
       ,source_record_id
       ,people_in_family
       ,enrollment_fee_assessed
       ,enrollment_fee_assessed_date
       ,enrollment_fee_paid
       ,enrollment_fee_paid_date
       ,co_pay_amount
       ,source_table_name
       ,eligibility_receipt_date
       ,case_number
       ,client_number
       ,provider_number
       ,plan_type_id
       ,fpl_percentage
FROM emrs_f_enrollment;

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPECIALTY_SV
AS
SELECT provider_number
       ,provider_specialty_code_id
       ,created_by
       ,date_created
FROM emrs_d_provider_specialty;

CREATE OR REPLACE VIEW EMRS_D_CASE_REF_SV
AS
SELECT case_number
FROM emrs_d_case_ref;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_REF_SV
AS
SELECT client_number
FROM emrs_d_client_ref;

CREATE OR REPLACE VIEW EMRS_D_PROVIDER_REF_SV
AS
SELECT provider_number
FROM emrs_d_provider_ref;

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_STATUS_SV
AS
SELECT enrollment_status_id
,enrollment_status_code
,enrollment_status_desc
,is_aa_pce_ind
,is_mandatory_unassign_ind
,managed_care_program 
,source_record_id 
FROM emrs_d_enrollment_status;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_STATUS_SV
AS
SELECT selection_status_id
,selection_status_code
,selection_status_description
,overwrite_ind 
,overwrite_to_value 
,valid_selection_ind 
,allow_new_selection_ind
,managed_care_program 
,source_record_id
FROM emrs_d_selection_status;

CREATE OR REPLACE VIEW EMRS_D_ZIPCODE_SV
AS
SELECT zipcode_id
,zip_code 
,zip_city 
,zip_county 
,zip_state 
,covers_multiple_county 
,source_record_id
FROM emrs_d_zipcode;

CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
SELECT enrollment_error_code_id 
,enrollment_error_code 
,enrollment_error_description 
,warning_ind 
,denial_reason_ind 
,needs_image_ind 
,manual_edit_ind 
,do_not_persist_ind 
,recycle_ind 
,denied_letter_ind 
,on_denial_create_task_ind 
,correct_for_plan_svc_types 
,managed_care_program 
,source_record_id 
FROM emrs_d_enrollment_error_code;

CREATE OR REPLACE VIEW EMRS_D_CLIENT_ENRL_STATUS_SV
AS
SELECT client_enroll_status_id 
,client_number 
,plan_type_id 
,enrollment_status_id 
,current_enrollment_status_id 
,created_by 
,date_created 
,date_of_validity_start 
,date_of_validity_end 
,date_updated
,updated_by 
,current_flag 
,version 
,source_record_id
FROM emrs_d_client_plan_enrl_status
WHERE current_flag = 'Y';

CREATE OR REPLACE VIEW EMRS_D_ADDRESS_SV
AS
SELECT address_id 
,source_record_id 
,addr_street_1 
,addr_street_2 
,addr_city 
,addr_state_cd 
,addr_zip 
,addr_zip_four 
,addr_type_cd
,addr_type 
,addr_country 
,client_number 
,addr_attn 
,addr_house_code 
,addr_bar_code 
,addr_origin_cd 
,addr_staff_id 
,addr_ctlk_id 
,addr_dolk_id 
,addr_prov_id
,addr_payc_id
,addr_verified
,addr_verified_date
,advy_id
,addr_bad_date
,addr_bad_date_satisfied
,case_number 
,start_ndt 
,end_ndt 
,comparable_key
,record_date 
,record_time 
,record_name
,modified_date 
,modified_name
,modified_time 
,source_addr_begin_date
,source_addr_end_date
,date_created 
,created_by
FROM emrs_d_address;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_SV
AS
SELECT selection_transaction_id
,source_record_id 
,selection_txn_group_id 
,program_type_cd	
,transaction_type_cd 
,selection_source_cd 
,ref_source_id 
,ref_source_type	
,ref_ext_txn_id 
,plan_type_cd 
,source_plan_id
,plan_id_ext 
,contract_id 
,network_id 
,source_provider_id 
,provider_id_ext	
,provider_first_name 
,provider_middle_name 
,provider_last_name 
,start_date 
,end_date 
,choice_reason_cd
,disenroll_reason_cd_1
,disenroll_reason_cd_2
,override_reason_cd 
,followup_reason_cd
,followup_call_date 
,followup_form_rcv_date
,followup_by 
,missing_info_id
,missing_signature_ind 
,outreach_session_id
,benefits_package_cd 
,selection_segment_id 
,client_number 
,current_selection_status_id
,status_date 
,client_aid_category_cd
,county	
,zip_code
,client_residence_address_id 
,prior_selection_segment_id 
,prior_selection_start_date 
,prior_selection_end_date 
,source_prior_plan_id 
,prior_plan_id_ext 
,source_prior_provider_id 
,prior_provider_id_ext 
,prior_provider_first_name 
,prior_provider_middle_name 
,prior_provider_last_name 
,ref_selection_txn_id 
,surplus_info 
,record_date
,record_time
,record_name 
,modified_date
,modified_name
,modified_time 
,prior_contract_id 
,prior_network_id 
,start_nd 
,end_nd 
,prior_choice_reason_cd 
,prior_disenroll_reason_cd_1
,prior_disenroll_reason_cd_2
,prior_client_aid_category_cd
,prior_county_cd 
,prior_zipcode 
,original_start_date
,original_end_date 
,selection_generic_field1_date
,selection_generic_field2_date
,selection_generic_field3_num 
,selection_generic_field4_num 
,selection_generic_field5_txt 
,selection_generic_field6_txt 
,selection_generic_field7_txt 
,selection_generic_field8_txt 
,selection_generic_field9_txt 
,selection_generic_field10_txt
,date_created
,created_by
,date_updated 
,updated_by
FROM emrs_d_selection_transaction;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_MI_SV
AS
SELECT selection_missing_info_id
,source_record_id 
,selection_transaction_id 
,missing_info_type_cd 
,missing_info_type 
,enrollment_error_code_id 
,send_in_letter_ind 
,rejection_error_reason_id 
,supplemental_info 
,record_date 	
,record_time 
,record_name
,created_by 
,date_created
FROM emrs_d_selection_missing_info;

CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_HIST_SV
AS
SELECT selection_trans_history_id
 ,source_record_id
 ,selection_transaction_id 
 ,selection_status_id 
 ,record_date 
 ,record_time
 ,record_name
 ,created_by
 ,date_created
FROM emrs_d_selection_trans_history;

CREATE OR REPLACE VIEW EMRS_D_PLAN_PERCENTAGE_SV
AS
SELECT plan_percentage_id 
,source_record_id
,year_month 
,plan_type_id
,managed_care_program 
,service_area 
,source_plan_id 
,percentage 
,record_date
,record_time 
,record_name 
,modified_date
,modified_time
,modified_name
,date_created
,created_by
,date_updated
,updated_by 
FROM emrs_d_plan_percentage;

CREATE OR REPLACE VIEW EMRS_D_AA_CONTRACT_SV
AS
SELECT aa_contract_id
,source_record_id 
,aa_job_id 
,aa_plan_id
,valid_ind 
,contract_name
,current_enrollment 
,managed_care_program 
,source_plan_id 
,status_cd 
,plan_service_type_cd 
,all_counties 
,case_assignment_only 
,client_count 
,sanctioned_ind 
,phsp_plan_ind
,qm_plan_ind
,total_assigned_clients 
,total_autoenrolled_clients
,exclusion_reason 
,record_date 
,record_time 
,record_name 
,modified_date 
,modified_time 
,modified_name 
,date_created
,created_by
,date_updated
,updated_by 
FROM emrs_d_aa_contract;

CREATE OR REPLACE VIEW EMRS_D_AA_COUNTYCONTRACT_SV
AS
SELECT aa_countycontract_id
,source_record_id
,aa_job_id 
,aa_contract_id 
,contract_amendment_id 
,assigned_num 
,target_num 
,case_add_num 
,prior_plan_num 
,random_num 
,order_by_default 
,mother_child_add 
,pcp_add  
,claim_add
,record_date
,record_time
,record_name 
,modified_date
,modified_time
,modified_name
,date_created
,created_by
,date_updated
,updated_by 
FROM emrs_d_aa_countycontract;

CREATE OR REPLACE VIEW EMRS_D_CASE_FPIL_SV 
AS
SELECT *
FROM(
SELECT  r.case_number       
       ,(SELECT case_cin FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') case_cin
       ,(SELECT managed_care_program FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') managed_care_program
       ,(SELECT MIN(managed_via_gen_rev_flag) FROM emrs_d_client dc,emrs_f_enrollment f WHERE dc.client_number = f.client_number AND current_flag = 'Y' AND f.case_number = r.case_number) managed_via_gen_rev_flag
       ,(SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f           
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'MEDICAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
            OR eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate) )
           ) eligibility_hp_plan_id       
       ,(SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'DENTAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
            OR eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate) )
           ) eligibility_dental_plan_id              
        ,(SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'MEDICAL'
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate))))  current_hp_plan_id
        ,(SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'DENTAL'          
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate)))) current_dental_plan_id             
        , cs.fpil 
        ,(SELECT MAX(cs1.fpil)
          FROM cost_share_details_stg cs1
          WHERE cs1.case_id = cs.case_id
          AND cs_period_start_date = (SELECT MAX(cs_period_start_date)
                                      FROM cost_share_details_stg cs2
                                      WHERE cs1.case_id = cs2.case_id
                                      AND cs1.enrollment_end_date = cs2.enrollment_end_date)
          --cs1.enrollment_end_date = cs.enrollment_end_date
          ) current_fpil
        ,cs.enrollment_start_date
        ,cs.enrollment_end_date
        ,cs.cs_period_start_date
        ,cs.cs_period_end_date
        ,cs.enrollment_end_date + 1 chip_annual_enroll_date
        ,cs.enrollment_fee
        ,cs.date_fee_paid
        ,cs.fee_paid_flag
FROM emrs_d_case_ref r
INNER JOIN cost_share_details_stg cs
ON r.case_number = cs.case_id)
WHERE managed_care_program = 'CHIP';

CREATE OR REPLACE VIEW EMRS_D_AA_CLIENT_SV 
AS
SELECT aa_client_id
 ,source_record_id
 ,aa_job_id
 ,client_number
 ,cin
 ,source_plan_id
 ,aa_action_cd
 ,program_type
 ,subprogram_type
 ,source_provider_id
 ,record_date
 ,record_time
 ,record_name
 ,order_by_default
 ,modified_date
 ,modified_time
 ,modified_name
FROM emrs_d_aa_client; 

CREATE OR REPLACE VIEW EMRS_D_ALERT_SV 
AS
SELECT alert_id
 ,source_record_id
 ,case_number
 ,client_number
 ,message
 ,source_alert_start_date
 ,source_alert_end_date
 ,void_ind
 ,system_alert_ind
 ,ref_type
 ,ref_id
 ,lock_id
 ,record_count
 ,alert_handler
 ,record_date
 ,record_time
 ,record_name 
 ,modified_date
 ,modified_time
 ,modified_name
 ,date_updated
 ,date_created
 ,created_by
 ,updated_by
FROM emrs_d_alert; 

CREATE OR REPLACE VIEW EMRS_D_CASE_CLIENT_SV
AS
SELECT
CASE_CLIENT_ID,
SOURCE_RECORD_ID,
CSCL_STATUS_BEGIN_DATE,
CSCL_CLOSE_REASON,
CSCL_RELATIONSHIP_CD,
CSCL_ELIG_DETERMINATION_DATE,
CSCL_MEDICAL_IND,
CASE_NUMBER,
CLIENT_NUMBER,
CSCL_STATUS_END_DATE,
CSCL_BYB_TEMP_ID,
CSCL_APPL_CLIENT_ID,
CSCL_ACTUAL_TERM_DATE,
CSCL_PACMIS_STATUS_CD,
CSCL_LEGACY,
RHSP,
RHGA,
CSCL_STATUS_CD,
CSCL_ADLK_ID,
CSCL_RES_ADDR_ID,
CSCL_ELIG_BEGIN_DT,
CSCL_ELIG_END_DT,
ANNIVERSARY_DT,
MANAGED_CARE_PROGRAM,
PROGRAM_STATUS_CD,
ELIG_BEGIN_ND,
ELIG_END_ND
EPISODE_ID,
CSCL_GENERIC_FIELD1_DATE,
CSCL_GENERIC_FIELD2_DATE,
CSCL_GENERIC_FIELD3_NUM,
CSCL_GENERIC_FIELD4_NUM,
CSCL_GENERIC_FIELD5_TXT,
CSCL_GENERIC_FIELD6_TXT,
CSCL_GENERIC_FIELD7_TXT,
CSCL_GENERIC_FIELD8_TXT,
CSCL_GENERIC_FIELD9_TXT,
CSCL_GENERIC_FIELD10_TXT,
CSCL_GENERIC_REF11_ID,
CSCL_GENERIC_REF12_ID,
STATUS_BEGIN_NDT,
STATUS_END_NDT,
CHANGE_NOTES,
RECORD_DATE, 
RECORD_TIME, 
RECORD_NAME, 
MODIFIED_DATE, 
MODIFIED_TIME, 
MODIFIED_NAME,
DATE_CREATED, 
CREATED_BY, 
UPDATED_BY, 
DATE_UPDATED
FROM EMRS_D_CASE_CLIENT;