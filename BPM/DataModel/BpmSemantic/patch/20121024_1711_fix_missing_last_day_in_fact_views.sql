create or replace view F_MW_BY_DATE_SV as
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID, 
  DMWTT_ID, 
  DMWE_ID, 
  DMWF_ID, 
  DMWO_ID, 
  DMWTS_ID, 
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  case 
    when dense_rank() over (partition by MW_BI_ID order by MW_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_MW_BY_DATE fmwbd
where
  bdd.D_DATE >= fmwbd.BUCKET_START_DATE 
  and bdd.D_DATE < fmwbd.BUCKET_END_DATE
union all
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID, 
  DMWTT_ID, 
  DMWE_ID, 
  DMWF_ID, 
  DMWO_ID, 
  DMWTS_ID, 
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_MW_BY_DATE fmwbd
where
  bdd.D_DATE = fmwbd.BUCKET_START_DATE
  and bdd.D_DATE = fmwbd.BUCKET_END_DATE
with read only;

alter table F_NYEC_PA_BY_DATE rename column CREATIONS_COUNT to CREATION_COUNT;

create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  case 
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE >= fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpabd.BUCKET_END_DATE
union all
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;