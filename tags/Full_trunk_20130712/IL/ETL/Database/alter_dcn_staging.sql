Delete from corp_etl_mailfaxdoc;

Delete from corp_etl_mailfaxdoc_oltp;

Delete from corp_etl_mailfaxdoc_wip_bpm;

commit;


alter table corp_etl_mailfaxdoc modify dcn varchar2(256);

alter table corp_etl_mailfaxdoc_oltp modify dcn varchar2(256);

alter table corp_etl_mailfaxdoc_wip_bpm modify dcn varchar2(256);

update corp_etl_control set value = '0' where name = 'PM_LAST_DCN';

commit;
/