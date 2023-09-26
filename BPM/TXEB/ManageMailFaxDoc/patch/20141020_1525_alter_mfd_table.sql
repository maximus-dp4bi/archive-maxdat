ALTER TABLE corp_etl_mailfaxdoc
ADD GWF_CHANNEL_ONLINE VARCHAR2(1);

ALTER TABLE corp_etl_mailfaxdoc_oltp
ADD GWF_CHANNEL_ONLINE VARCHAR2(1);

ALTER TABLE corp_etl_mailfaxdoc_wip_bpm
ADD GWF_CHANNEL_ONLINE VARCHAR2(1);

ALTER TABLE d_mfdoc_current
ADD  "Channel Online Flag" VARCHAR2(1);

create or replace view D_MFDOC_CURRENT_SV as
select * from D_MFDOC_CURRENT
with read only;