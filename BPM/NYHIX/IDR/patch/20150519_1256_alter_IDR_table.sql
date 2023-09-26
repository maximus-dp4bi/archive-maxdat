alter table NYHX_ETL_IDR_INCIDENTS 
add (CHANNEL VARCHAR2(80));
alter table NYHX_ETL_IDR_INCIDENTS_OLTP 
add (CHANNEL VARCHAR2(80));
alter table NYHX_ETL_IDR_INCIDENTS_wip 
add (CHANNEL VARCHAR2(80));
alter table d_idr_current 
add (CHANNEL VARCHAR2(80));

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;



