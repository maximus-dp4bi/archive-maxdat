create index FMFBBH_IXL4 on F_MFB_BY_HOUR (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_MFB_BY_HOUR_SV as
-- First hour plus interpolate hours until before the next hour with an update.
select
  FMFBBH_ID,
  BUCKET_START_DATE d_date_hour,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_MFB_BY_HOUR
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First hour (again) and all hours with interpolated hours in-between, except completion hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion hour when not completed on the first hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;
