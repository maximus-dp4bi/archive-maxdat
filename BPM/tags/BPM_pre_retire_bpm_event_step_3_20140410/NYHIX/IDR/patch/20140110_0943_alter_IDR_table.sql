alter table NYHX_ETL_IDR_INCIDENTS 
add (APPELLANT_TYPE VARCHAR2(32),     
      APPELLANT_TYPE_DESC VARCHAR2(64));
alter table NYHX_ETL_IDR_INCIDENTS_OLTP 
add (APPELLANT_TYPE VARCHAR2(32),     
    APPELLANT_TYPE_DESC VARCHAR2(64));
alter table NYHX_ETL_IDR_INCIDENTS_wip 
add (APPELLANT_TYPE VARCHAR2(32),     
     APPELLANT_TYPE_DESC VARCHAR2(64));
alter table d_idr_current 
add (APPELLANT_TYPE VARCHAR2(32),     
     APPELLANT_TYPE_DESCRIPTION VARCHAR2(64));

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

create or replace public synonym D_IDR_CURRENT_SV for D_IDR_CURRENT_SV;

