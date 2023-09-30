alter table NYHX_ETL_IDR_INCIDENTS      add current_step varchar2(256);
alter table NYHX_ETL_IDR_INCIDENTS_OLTP add current_step varchar2(256);
alter table NYHX_ETL_IDR_INCIDENTS_wip  add current_step varchar2(256);
alter table d_idr_current               add current_step varchar2(256);

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

create or replace public synonym D_IDR_CURRENT_SV for D_IDR_CURRENT_SV;
