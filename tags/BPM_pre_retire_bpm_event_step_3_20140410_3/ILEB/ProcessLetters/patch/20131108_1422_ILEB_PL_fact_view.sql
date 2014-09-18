create index FPLBD_IX1 on F_PL_BY_DATE (LETTER_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL4 on F_PL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_PL_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FPLBD_ID,
  BUCKET_START_DATE D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from F_PL_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  F_PL_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_PL_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_PL_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;