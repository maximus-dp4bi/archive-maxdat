CREATE OR REPLACE VIEW D_MFB_CURRENT_MFD_DCN_SV AS
select dd."NYHIX_MFD_BI_ID",
b."MFB_BI_ID"
from D_MFB_CURRENT b
join D_NYHIX_MFD_CURRENT_V2 dd on (b.batch_name=dd.batch_name)
WITH READ ONLY;

grant select on D_MFB_CURRENT_MFD_DCN_SV to MAXDAT_READ_ONLY;

create index DMFDCU_IX4 on D_NYHIX_MFD_CURRENT_V2 (BATCH_ID) online tablespace MAXDAT_INDX parallel 4 compute statistics;