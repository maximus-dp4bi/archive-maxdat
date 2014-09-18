/*
Description:
These indexes were originally in the SVN folder, trunk\IL\ETL\Database; in files ManageEnrl_create_indexes.sql and ManageEnrl_create_indexes_2.sql
I combined these two files and added this file.

v1 Raj A. 04/02/2014 Creation. Combined the above two files into a single index file. These are the indexes in ILEBMXDP as of 02-Apr-2014. IL is a corp process.
                     TXEB has project based scripts.
*/
create index LETTER_req_on_IDX on LETTERS_STG (LETTER_REQUESTED_ON);
create index LETTER_CASE_ID_IDX on LETTERS_STG (LETTER_CASE_ID);

create index IDX_ceme_inst_stat       on corp_etl_manage_enroll_oltp (instance_status);
create index IDX_ceme_cancel_dt       on corp_etl_manage_enroll_oltp (cancel_dt);
create index IDX_ceme_client_id       on corp_etl_manage_enroll_oltp (client_id);
create index IDX_ceme_create_dt       on corp_etl_manage_enroll_oltp (create_dt);
create index IDX_ceme_case_id         on corp_etl_manage_enroll_oltp (case_id);
create index IDX_ceme_enrl_stat_cd    on corp_etl_manage_enroll_oltp (enrollment_status_code);
create index IDX_ceme_enrl_stat_dt    on corp_etl_manage_enroll_oltp (enrollment_status_dt);
create index IDX_ceme_enrl_pack_id    on corp_etl_manage_enroll_oltp (enrl_pack_id);
create index IDX_ceme_1st_fu_id       on corp_etl_manage_enroll_oltp (first_followup_id);
create index IDX_ceme_2nd_fu_id       on corp_etl_manage_enroll_oltp ( second_followup_id);
create index IDX_ceme_3rd_fu_id       on corp_etl_manage_enroll_oltp (third_followup_id );
create index IDX_ceme_4th_fu_id       on corp_etl_manage_enroll_oltp (fourth_followup_id);
create index IDX_ceme_slct_method     on corp_etl_manage_enroll_oltp (slct_method);
create index IDX_enrl_pack_request_dt on corp_etl_manage_enroll_oltp (enrl_pack_request_dt);
create index IDX_ased_first_followup  on corp_etl_manage_enroll_oltp (ased_first_followup);
CREATE INDEX IDX_PLAN_TYPE            ON CORP_ETL_MANAGE_ENROLL_OLTP(PLAN_TYPE);
CREATE INDEX IDX_SEL_auto_proc        ON corp_etl_manage_enroll_oltp(slct_auto_proc);
CREATE INDEX IDX_CEME_AGE_BUS_DAYS    ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_BUSINESS_DAYS);
CREATE INDEX IDX_CEME_AGE_CAL_DAYS    ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_CALENDAR_DAYS);
create index IDX_CEME_ceme_id         on CORP_ETL_MANAGE_ENROLL_OLTP (ceme_id);
---------------------------------------------------------------------------------------
create index IDX_WIP_Upd_flg on CORP_ETL_MANAGE_ENROLL_WIP (UPDATE_FLG);
create index IDX_WIP_ceme_id on CORP_ETL_MANAGE_ENROLL_WIP (ceme_id);

----------------------------------------------------------------------------------------
create index IDX_clnt_enrl_stat_id on CLIENT_ENROLL_STATUS_stg(CLIENT_ENROLL_STATUS_ID);
create index IDX_CLIENT_ID on CLIENT_ENROLL_STATUS_stg(CLIENT_ID);
create index IDX_ENROLL_STATUS_CD on CLIENT_ENROLL_STATUS_stg(ENROLL_STATUS_CD);
create index IDX_CREATE_TS on CLIENT_ENROLL_STATUS_stg(CREATE_TS);
create index IDX_UPDATE_TS on CLIENT_ENROLL_STATUS_stg(UPDATE_TS);

alter table CLIENT_ENROLL_STATUS_stg
 add constraint PK_clnt_enrl_stat_id primary key (CLIENT_ENROLL_STATUS_ID) ;

-----------------------------------------------------------------------------------------
alter table SELECTION_TXN_stg
 add constraint PK_SELECTION_TXN_ID primary key (SELECTION_TXN_ID) ;

create index IDX_sel_client_id on SELECTION_TXN_stg(CLIENT_ID);
-----------------------------------------------------------------------------------------

