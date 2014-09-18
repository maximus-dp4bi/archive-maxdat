create index FNPMIBD_IXL4 on F_NYEC_PMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_NYEC_PMI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNPMIBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_NYEC_PMI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_NYEC_PMI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;