SELECT 
created_by
,update_ts date_updated
,updated_by
,prior_selection_start_date
,prior_selection_end_date
,prior_plan_id source_prior_plan_id
,prior_plan_id_ext
,prior_provider_id source_prior_provider_id
,prior_provider_id_ext
,prior_provider_first_name
,prior_provider_middle_name
,prior_provider_last_name
,ref_selection_txn_id
,surplus_info
,create_ts record_date
,TO_CHAR(create_ts, 'hh24mi') record_time
,created_by record_name
,update_ts modified_date
,updated_by modified_name
,TO_CHAR(update_ts, 'hh24mi') modified_time
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
,create_ts date_created
,selection_txn_id selection_transaction_id
,selection_txn_id source_record_id
,selection_txn_group_id
,program_type_cd
,transaction_type_cd
,selection_source_cd
,ref_source_id
,ref_source_type
,ref_ext_txn_id
,plan_type_cd
,plan_id source_plan_id
,plan_id_ext
,contract_id
,network_id
,provider_id source_provider_id
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
,client_id client_number
,NULL current_selection_status_id
,status_date
,client_aid_category_cd
,county
,zipcode zip_code
,client_residence_address_id
,prior_selection_segment_id
,status_cd
,CASE WHEN TRUNC(s.status_date) = TRUNC(s.create_ts)  THEN 0 ELSE
  (TRUNC(s.status_date) - TRUNC(s.create_ts) ) +1 - 
  ((((TRUNC(s.status_date,'D'))-(TRUNC(s.create_ts,'D')))/7)*2) -
  (CASE WHEN TO_CHAR(s.create_ts,'D')='1' THEN 1 ELSE 0 END) -
  (CASE WHEN TO_CHAR(s.status_date,'D')='7' THEN 1 ELSE 0 END) -
  (CASE WHEN TO_CHAR(s.create_ts,'D')='7' AND TO_CHAR(s.status_date,'D')='1' THEN 2 ELSE 0 END)-
  (SELECT count(1) FROM eb.holidays h WHERE h.holiday_date between TRUNC(s.create_ts) and TRUNC(s.status_date)) END age_in_business_days
FROM eb.selection_txn s
where create_ts >= add_months(trunc(sysdate,'mm'),-2)