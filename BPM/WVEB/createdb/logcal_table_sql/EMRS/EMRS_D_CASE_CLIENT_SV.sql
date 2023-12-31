SELECT
cscl_id source_record_id,
cscl_status_begin_date,
cscl_close_reason,
cscl_relationship_cd,
cscl_elig_determination_date,
cscl_medical_ind,
cscl_case_id case_number,
cscl_clnt_client_id client_number,
cscl_status_end_date,
cscl_byb_temp_id,
cscl_appl_client_id,
cscl_actual_term_date,
cscl_pacmis_status_cd,
cscl_legacy,
rhsp,
rhga,
cscl_status_cd,
cscl_adlk_id,
cscl_res_addr_id,
cscl_elig_begin_dt,
cscl_elig_end_dt,
anniversary_dt,
program_cd managed_care_program,
program_status_cd,
elig_begin_nd,
elig_end_nd
episode_id,
cscl_generic_field1_date,
cscl_generic_field2_date,
cscl_generic_field3_num,
cscl_generic_field4_num,
cscl_generic_field5_txt,
cscl_generic_field6_txt,
cscl_generic_field7_txt,
cscl_generic_field8_txt,
cscl_generic_field9_txt,
cscl_generic_field10_txt,
cscl_generic_ref11_id,
cscl_generic_ref12_id,
status_begin_ndt,
status_end_ndt,
change_notes,
cscl_id case_client_id,
created_by,
creation_date date_created,
last_updated_by updated_by,
last_update_date date_updated,
TRUNC(last_update_date) modified_date,
last_updated_by modified_name,
TO_CHAR(last_update_date,'HH24MI') modified_time,
TRUNC(creation_date) record_date,
created_by record_name,
TO_CHAR(creation_date,'HH24MI') record_time 
FROM case_client