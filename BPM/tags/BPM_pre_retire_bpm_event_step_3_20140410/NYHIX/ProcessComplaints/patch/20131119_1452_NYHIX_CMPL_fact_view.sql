alter table D_COMPLAINT_ACTION_COMMENTS noparallel;
alter table D_COMPLAINT_INCIDENT_ABOUT noparallel;
alter table D_COMPLAINT_INCIDENT_DESC noparallel;
alter table D_COMPLAINT_INCIDENT_REASON noparallel;
alter table D_COMPLAINT_INCIDENT_STATUS noparallel;
alter table D_COMPLAINT_INSTANCE_STATUS noparallel;
alter table D_COMPLAINT_RESOLUTION_DESC noparallel;

create index FCMPLBD_IX1 on F_COMPLAINT_BY_DATE (INCIDENT_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IX2 on F_COMPLAINT_BY_DATE (LAST_UPDATE_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IX3 on F_COMPLAINT_BY_DATE (COMPLETE_DT) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCMPLBD_IXL2 on F_COMPLAINT_BY_DATE (CMPL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IXL3 on F_COMPLAINT_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMPLBD_IXL4 on F_COMPLAINT_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_COMPLAINT_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCMPLBD_ID,
  BUCKET_START_DATE D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT
from F_COMPLAINT_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT
from 
  F_COMPLAINT_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT
from
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  COMPLETE_DT
from
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;
