/*
Created on 15-Aug-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
*/

create index IDX_ceme_inst_stat        on corp_etl_manage_enroll_oltp (instance_status);
create index IDX_ceme_cancel_dt        on corp_etl_manage_enroll_oltp (cancel_dt);
create index IDX_ceme_client_id        on corp_etl_manage_enroll_oltp (client_id);
create index IDX_ceme_create_dt        on corp_etl_manage_enroll_oltp (create_dt);
create index IDX_ceme_case_id          on corp_etl_manage_enroll_oltp (case_id);
create index IDX_ceme_enrl_stat_cd     on corp_etl_manage_enroll_oltp (enrollment_status_code);
create index IDX_ceme_enrl_stat_dt     on corp_etl_manage_enroll_oltp (enrollment_status_dt);
create index IDX_ceme_enrl_pack_id     on corp_etl_manage_enroll_oltp (enrl_pack_id);
create index IDX_enrl_pack_request_dt  on corp_etl_manage_enroll_oltp (enrl_pack_request_dt);
create index IDX_ceme_1st_fu_id        on corp_etl_manage_enroll_oltp (first_followup_id);
create index IDX_ased_first_followup   on corp_etl_manage_enroll_oltp (ased_first_followup);
create index IDX_ceme_2nd_fu_id        on corp_etl_manage_enroll_oltp (second_followup_id);
create index IDX_ceme_3rd_fu_id        on corp_etl_manage_enroll_oltp (third_followup_id );
create index IDX_ceme_4th_fu_id        on corp_etl_manage_enroll_oltp (fourth_followup_id);
create index IDX_ceme_slct_method      on corp_etl_manage_enroll_oltp (slct_method);
CREATE INDEX IDX_PLAN_TYPE         ON CORP_ETL_MANAGE_ENROLL_OLTP(PLAN_TYPE);
CREATE INDEX IDX_SEL_auto_proc     ON corp_etl_manage_enroll_oltp(slct_auto_proc);
CREATE INDEX IDX_CEME_AGE_BUS_DAYS ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_BUSINESS_DAYS);
CREATE INDEX IDX_CEME_AGE_CAL_DAYS ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_CALENDAR_DAYS);
create index maxdat.IDX_CEME_ceme_id on maxdat.CORP_ETL_MANAGE_ENROLL_OLTP (ceme_id );

create index IDX_WIP_Upd_flg          on corp_etl_manage_enroll_wip (UPDATE_FLG);
create index maxdat.IDX_WIP_ceme_id on maxdat.CORP_ETL_MANAGE_ENROLL_WIP (ceme_id );

create index IDX_clnt_enrl_stat_id on CLIENT_ENROLL_STATUS_stg(CLIENT_ENROLL_STATUS_ID);
create index IDX_CLIENT_ID         on CLIENT_ENROLL_STATUS_stg(CLIENT_ID);
create index IDX_ENROLL_STATUS_CD  on CLIENT_ENROLL_STATUS_stg(ENROLL_STATUS_CD);
create index IDX_CREATE_TS         on CLIENT_ENROLL_STATUS_stg(CREATE_TS);
create index IDX_UPDATE_TS         on CLIENT_ENROLL_STATUS_stg(UPDATE_TS);

alter table CLIENT_ENROLL_STATUS_stg
 add constraint PK_clnt_enrl_stat_id primary key (CLIENT_ENROLL_STATUS_ID) ;

create index IDX_CL_ENRL_plan_type_cd on client_enroll_status_stg(plan_type_cd);
-----------------------------------------------------------------------------------------
alter table SELECTION_TXN_stg
 add constraint PK_SELECTION_TXN_ID primary key (SELECTION_TXN_ID) ;

create index IDX_sel_client_id on SELECTION_TXN_stg(CLIENT_ID);
CREATE INDEX IDX_SEL_STATUS_CD ON SELECTION_TXN_STG(STATUS_CD);
CREATE INDEX IDX_SEL_source_cd ON SELECTION_TXN_STG(SELECTION_SOURCE_CD);
CREATE INDEX IDX_SEL_create_dt ON SELECTION_TXN_STG(CREATE_TS);
CREATE INDEX IDX_SEL_UPDATE_TS ON SELECTION_TXN_STG(UPDATE_TS);
-----------------------------------------------------------------------------------------
ALTER TABLE CLIENT_ELIG_STATUS_STG
 add constraint PK_clnt_elig_stat_id primary key (CLIENT_ELIG_STATUS_ID) ;

CREATE INDEX IDX_CL_ELIG_STAT_CLIENT_ID         ON CLIENT_ELIG_STATUS_STG(CLIENT_ID);
CREATE INDEX IDX_CL_ELIG_STAT_CREATE_TS         ON CLIENT_ELIG_STATUS_STG(CREATE_TS);
CREATE INDEX IDX_CL_ELIG_STAT_UPDATE_TS         ON CLIENT_ELIG_STATUS_STG(UPDATE_TS);
-----------------------------------------------------------------------------------------
ALTER TABLE COST_SHARE_DETAILS_STG
 add constraint PK_CS_DETAILS_ID primary key (CS_DETAILS_ID) ;

CREATE INDEX IDX_COSTSHARE_CASE_ID         ON COST_SHARE_DETAILS_STG(CASE_ID);
CREATE INDEX IDX_COSTSHARE_CREATE_TS         ON COST_SHARE_DETAILS_STG(CREATE_TS);
CREATE INDEX IDX_COSTSHARE_UPDATE_TS         ON COST_SHARE_DETAILS_STG(UPDATE_TS);