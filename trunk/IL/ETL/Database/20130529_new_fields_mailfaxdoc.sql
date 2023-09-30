
alter table corp_etl_mailfaxdoc add cancel_method varchar2(50);
alter table corp_etl_mailfaxdoc_oltp add cancel_method varchar2(50);
alter table corp_etl_mailfaxdoc_wip_bpm add cancel_method varchar2(50);

alter table corp_etl_mailfaxdoc add cancel_reason varchar2(256);
alter table corp_etl_mailfaxdoc_oltp add cancel_reason varchar2(256);
alter table corp_etl_mailfaxdoc_wip_bpm add cancel_reason varchar2(256);

alter table corp_etl_mailfaxdoc add cancel_by varchar2(50);
alter table corp_etl_mailfaxdoc_oltp add cancel_by varchar2(50);
alter table corp_etl_mailfaxdoc_wip_bpm add cancel_by varchar2(50);

alter table corp_etl_mailfaxdoc_oltp add trashed_doc_ind varchar2(1);
alter table corp_etl_mailfaxdoc_oltp add trashed_date date;
/