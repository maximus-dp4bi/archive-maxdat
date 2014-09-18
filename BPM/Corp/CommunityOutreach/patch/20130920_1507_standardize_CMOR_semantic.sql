alter table D_CMOR_SESSION_STATUS noparallel;

drop index FCMORBD_UIX1;

create unique index FCMORBD_UIX1 on F_CMOR_BY_DATE (FCMORBD_ID,D_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
create unique index FCMORBD_UIX2 on F_CMOR_BY_DATE (CMOR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCMORBD_IX1 on F_CMOR_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCMORBD_IXL1 on F_CMOR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMORBD_IXL2 on F_CMOR_BY_DATE (CMOR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMORBD_IXL3 on F_CMOR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_CMOR_BY_DATE_SV as
select
  FCMORBD_ID, 
  bdd.D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  case 
    when dense_rank() over (partition by CMOR_BI_ID order by CMOR_BI_ID asc, BDD.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_CMOR_BY_DATE fcmorbd
where
  bdd.D_DATE >= fcmorbd.BUCKET_START_DATE 
  and bdd.D_DATE < fcmorbd.BUCKET_END_DATE
union all
select
  FCMORBD_ID, 
  bdd.D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_CMOR_BY_DATE fcmorbd
where
  bdd.D_DATE = fcmorbd.BUCKET_START_DATE 
  and bdd.D_DATE = fcmorbd.BUCKET_END_DATE
with read only; 
