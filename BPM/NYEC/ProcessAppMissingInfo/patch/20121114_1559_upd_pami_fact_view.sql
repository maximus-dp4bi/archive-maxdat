create or replace view F_NYEC_PAMI_BY_DATE_SV as
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE,
  BUCKET_END_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  case 
    when dense_rank() over (partition by NYEC_PAMI_BI_ID order by NYEC_PAMI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE fnpamibd
where
  bdd.D_DATE >= fnpamibd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpamibd.BUCKET_END_DATE
union all
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE,
  BUCKET_END_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  INVENTORY_COUNT,
  CREATION_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE fnpamibd
where
  bdd.D_DATE = fnpamibd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpamibd.BUCKET_END_DATE
with read only;