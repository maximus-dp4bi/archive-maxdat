CREATE OR REPLACE VIEW D_MFB_CURRENT_MFD_DCN_SV AS
select dd."NYHIX_MFD_BI_ID",
b."MFB_BI_ID"
from D_MFB_CURRENT b
join D_NYHIX_MFD_CURRENT dd on (b.batch_id=dd.batch_id)
WITH READ ONLY;

create public synonym D_MFB_CURRENT_MFD_DCN_SV for D_MFB_CURRENT_MFD_DCN_SV;
grant select on D_MFB_CURRENT_MFD_DCN_SV to MAXDAT_READ_ONLY;

create index DNMFDCUR_IX1 on D_NYHIX_MFD_CURRENT (BATCH_ID) online tablespace MAXDAT_INDX parallel compute statistics;
