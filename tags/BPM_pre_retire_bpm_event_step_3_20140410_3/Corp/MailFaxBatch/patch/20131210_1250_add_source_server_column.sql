truncate table corp_etl_mfb_batch_oltp;
truncate table corp_etl_mfb_batch_events_oltp;
truncate table corp_etl_mfb_form_oltp;

alter table corp_etl_mfb_batch_oltp add source_server varchar2(255) not null;
alter table corp_etl_mfb_batch_stg add source_server varchar2(255) not null;

alter table corp_etl_mfb_batch_events_oltp add source_server varchar2(255) not null;
alter table corp_etl_mfb_batch_events_stg add source_server varchar2(255) not null;

alter table corp_etl_mfb_form_oltp add source_server varchar2(255) not null;
alter table corp_etl_mfb_form_stg add source_server varchar2(255) not null;