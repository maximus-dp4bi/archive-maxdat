CREATE OR REPLACE VIEW EMRS_D_AA_TRANS_SV
AS
select a.*
, (Select max(create_ts)
  from selection_txn_status_history sh1 
  where sh1.selection_txn_id = curr_selection_txn_id 
  and sh1.create_ts >= job_end_ts 
  and sh1.status_cd = 'acceptedByIFC'
  )  acceptedbyifc_date 
, (Select max(create_ts)
  from selection_txn_status_history sh1 
  where sh1.selection_txn_id = curr_selection_txn_id 
  and sh1.create_ts >= job_end_ts 
  and sh1.status_cd = 'readyToUpload2'
  )  readytoupload2_date 
, (Select max(create_ts)
  from selection_txn_status_history sh1 
  where sh1.selection_txn_id = curr_selection_txn_id 
  and sh1.create_ts >= job_end_ts 
  and sh1.status_cd = 'readyToUpload'
  )  readyToUpload_date 
from 
(
select aj.job_id, aj.aa_job_id, j.job_name, j.start_ts job_start_ts, j.end_ts job_end_ts, trunc(j.end_ts) job_date, j.status_cd job_status_cd, aa.client_id, aa.plan_id, aa.aa_action_cd, 
st.selection_txn_id curr_selection_txn_id, st.transaction_type_cd curr_transaction_type_cd, st.selection_source_cd curr_selection_source_cd
, st.plan_id curr_plan_id
, st.contract_id curr_contract_id
, st.start_date curr_start_date
, st.choice_reason_cd curr_choice_reason_cd
, st.status_cd curr_Status_cd
, st.status_date curr_Status_date
, st.client_aid_category_cd curr_client_aid_Category_cd
, st.county curr_county
, st.zipcode curr_zipcode
, st.client_residence_address_id curr_address_id
, st.selection_generic_field7_txt curr_selection_generic_field7_txt
, st.selection_generic_field8_txt curr_selection_generic_field8_txt
, st.selection_generic_field9_txt curr_selection_generic_field9_txt
, csi.case_id
, csi.case_cin
, csi.last_name
, csi.first_name
, csi.client_cin
, csi.clnt_generic_field5_txt hicn
, eac.subprogram_codes subprogram_code
, st.plan_type_cd
from aa_client aa 
join aa_job aj on aj.aa_job_id = aa.aa_job_id
join job_run_data j on (j.job_run_data_id = aj.job_id and j.status_cd = 'COMPLETED' and j.create_ts >= add_months(trunc(sysdate-2),-2))
left join selection_txn st on (st.client_id = aa.client_id and st.status_date >= j.end_ts and st.transaction_type_cd = 'DefaultEnroll' and st.selection_source_cd = 'A' and st.plan_id = aa.plan_id)
join client_supplementary_info csi on csi.client_id = aa.client_id
JOIN case_client cc ON cc.cscl_id = csi.case_client_id 
JOIN enum_aid_category eac ON eac.value = cc.cscl_adlk_id
) a
;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_TRANS_SV TO MAXDAT_REPORTS;
