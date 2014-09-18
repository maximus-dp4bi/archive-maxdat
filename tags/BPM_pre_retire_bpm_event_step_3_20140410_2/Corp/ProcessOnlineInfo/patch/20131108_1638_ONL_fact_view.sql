alter table D_ONL_INSTANCE_STATUS noparallel;

create index FONLBD_IXL3 on F_ONL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL4 on F_ONL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_ONL_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FONLBD_ID, 
  BUCKET_START_DATE D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_ONL_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_ONL_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_ONL_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_ONL_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;