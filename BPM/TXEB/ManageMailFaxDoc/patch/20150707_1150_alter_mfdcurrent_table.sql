alter table D_MFDOC_CURRENT
add ("Document ID" number);

create index docid_dmfdoc_curr on D_MFDOC_CURRENT ("Document ID") tablespace MAXDAT_INDX;

create or replace view D_MFDOC_CURRENT_SV as
select * from D_MFDOC_CURRENT
with read only;

create or replace public synonym D_MFDOC_CURRENT_SV for D_MFDOC_CURRENT_SV;
grant select on D_MFDOC_CURRENT_SV to MAXDAT_READ_ONLY;
