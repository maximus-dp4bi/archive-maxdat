create index LETTER_req_on_IDX on LETTERS_STG (LETTER_REQUESTED_ON);
create index LETTER_CASE_ID_IDX on LETTERS_STG (LETTER_CASE_ID);

create index IDX_ceme_inst_stat    on corp_etl_manage_enroll_oltp (instance_status);
create index IDX_ceme_cancel_dt    on corp_etl_manage_enroll_oltp (cancel_dt);
create index IDX_ceme_client_id    on corp_etl_manage_enroll_oltp (client_id);
create index IDX_ceme_create_dt    on corp_etl_manage_enroll_oltp (create_dt);
create index IDX_ceme_case_id      on corp_etl_manage_enroll_oltp (case_id);
create index IDX_ceme_enrl_stat_cd on corp_etl_manage_enroll_oltp (enrollment_status_code);
create index IDX_ceme_enrl_stat_dt  on corp_etl_manage_enroll_oltp (enrollment_status_dt);
create index IDX_ceme_enrl_pack_id on corp_etl_manage_enroll_oltp (enrl_pack_id);
--create index IDX_enrl_pack_request_dt  on corp_etl_manage_enroll_oltp (enrl_pack_request_dt);
create index IDX_ceme_1st_fu_id on corp_etl_manage_enroll_oltp (first_followup_id);
--create index IDX_ased_first_followup  on corp_etl_manage_enroll_oltp (ased_first_followup);
create index IDX_ceme_2nd_fu_id on corp_etl_manage_enroll_oltp ( second_followup_id);
create index IDX_ceme_3rd_fu_id on corp_etl_manage_enroll_oltp (third_followup_id );
create index IDX_ceme_4th_fu_id on corp_etl_manage_enroll_oltp (fourth_followup_id);
create index IDX_ceme_slct_method on corp_etl_manage_enroll_oltp (slct_method);