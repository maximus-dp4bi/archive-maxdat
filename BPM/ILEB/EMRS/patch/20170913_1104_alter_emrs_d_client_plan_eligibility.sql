ALTER TABLE EMRS_S_CLIENT_ELIGIBILITY_STG
ADD (DEBUG VARCHAR2(2000));

ALTER TABLE EMRS_D_CLIENT_PLAN_ELIGIBILITY
ADD (DEBUG VARCHAR2(2000));

CREATE INDEX IDX5_CLIENTELIG ON EMRS_D_CLIENT_PLAN_ELIGIBILITY(DEBUG) TABLESPACE MAXDAT_INDX;

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
       ,debug
FROM emrs_d_client_plan_eligibility
WHERE current_flag = 'Y';

ALTER TABLE EMRS_D_SELECTION_TRANSACTION
ADD (SUBPROGRAM VARCHAR2(2000));

CREATE INDEX IDX7_SELECTIONTRANS ON EMRS_D_SELECTION_TRANSACTION(SUBPROGRAM) TABLESPACE MAXDAT_INDX;

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
,subprogram
FROM emrs_d_selection_transaction;