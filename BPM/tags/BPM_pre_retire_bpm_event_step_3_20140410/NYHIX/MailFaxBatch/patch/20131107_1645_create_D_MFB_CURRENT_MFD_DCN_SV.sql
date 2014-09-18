CREATE OR REPLACE VIEW D_MFB_CURRENT_MFD_DCN_SV AS
select dd."NYHIX_MFD_BI_ID",
b."MFB_BI_ID",
b."BATCH_NAME"
from D_MFB_CURRENT b
join D_NYHIX_MFD_CURRENT dd on (b.batch_name=dd.batch_name)
WITH READ ONLY;

create or replace public synonym D_MFB_CURRENT_MFD_DCN_SV for D_MFB_CURRENT_MFD_DCN_SV;
grant select on D_MFB_CURRENT_MFD_DCN_SV to MAXDAT_READ_ONLY;

drop index DNMFDCUR_IX1;

create index DNMFDCUR_IX1 on D_NYHIX_MFD_CURRENT (BATCH_NAME) online tablespace MAXDAT_INDX parallel compute statistics;
