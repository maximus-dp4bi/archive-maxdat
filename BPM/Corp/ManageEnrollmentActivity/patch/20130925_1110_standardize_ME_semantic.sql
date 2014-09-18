alter table D_ME_CURRENT parallel;
alter table D_ME_ENRL_STATUS_CODE noparallel;

create index FMEBD_IXL2 on F_ME_BY_DATE (ME_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL3 on F_ME_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_ME_BY_DATE_SV as
select
  FMEBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
  ME_BI_ID, 
  DMESC_ID, 
  case 
    when dense_rank() over (partition by ME_BI_ID order by ME_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from 
  BPM_D_DATES bdd,
  F_ME_BY_DATE fmebd
where
  bdd.D_DATE >= fmebd.BUCKET_START_DATE 
  and bdd.D_DATE < fmebd.BUCKET_END_DATE
union all
select
  FMEBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
  ME_BI_ID, 
  DMESC_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from 
  BPM_D_DATES bdd,
  F_ME_BY_DATE fmebd
where
  bdd.D_DATE = fmebd.BUCKET_START_DATE 
  and bdd.D_DATE = fmebd.BUCKET_END_DATE
with read only;