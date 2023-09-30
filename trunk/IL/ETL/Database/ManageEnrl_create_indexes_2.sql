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

create index IDX_enrl_pack_request_dt  on corp_etl_manage_enroll_oltp (enrl_pack_request_dt);
create index IDX_ased_first_followup  on corp_etl_manage_enroll_oltp (ased_first_followup);