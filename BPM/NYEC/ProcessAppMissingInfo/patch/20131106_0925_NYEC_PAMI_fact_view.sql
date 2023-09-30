create index FNPAMIBD_IXL4 on F_NYEC_PAMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_NYEC_PAMI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNPAMIBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from F_NYEC_PAMI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  F_NYEC_PAMI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;