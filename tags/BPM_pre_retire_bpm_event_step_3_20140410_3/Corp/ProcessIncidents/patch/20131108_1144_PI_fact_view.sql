create index FPIBD_IXL4 on F_PI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_PI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FPIBD_ID,
  BUCKET_START_DATE D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from F_PI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  F_PI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from
  BPM_D_DATES bdd,
  F_PI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from
  BPM_D_DATES bdd,
  F_PI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;