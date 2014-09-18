create index FCORBD_IXL4 on F_COR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_COR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCORBD_ID,
  BUCKET_START_DATE D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from F_COR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from 
  F_COR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_COR_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_COR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;