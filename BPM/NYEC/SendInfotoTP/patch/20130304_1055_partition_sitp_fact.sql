-- Parition F_NYEC_SITP_BY_DATE table.

alter table F_NYEC_SITP_BY_DATE drop constraint FNSITPBD_DNSITPCUR_FK;
alter table F_NYEC_SITP_BY_DATE drop primary key;
drop index FNSITPBD_UIX1;
drop index FNSITPBD_UIX2;
drop index FNSITPBD_UIX3;

create table F_NYEC_SITP_BY_DATE_TMP 
  (FNSITPBD_ID       number not null,
   D_DATE            date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE   date not null,
   NYEC_SITP_BI_ID   number not null,
   CREATION_COUNT    number,
   INVENTORY_COUNT   number,
   COMPLETION_COUNT  number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

insert into F_NYEC_SITP_BY_DATE_TMP
select 
   FNSITPBD_ID,
   D_DATE,
   BUCKET_START_DATE, 
   BUCKET_END_DATE,
   NYEC_SITP_BI_ID,
   CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from F_NYEC_SITP_BY_DATE;

commit;

alter table F_NYEC_SITP_BY_DATE rename to F_NYEC_SITP_BY_DATE_BCK;
alter table F_NYEC_SITP_BY_DATE_TMP rename to F_NYEC_SITP_BY_DATE;

alter table F_NYEC_SITP_BY_DATE add constraint FNSITPBD_PK primary key (FNSITPBD_ID);
alter index FNSITPBD_PK rebuild tablespace MAXDAT_INDX parallel;

alter table F_NYEC_SITP_BY_DATE add constraint FNSITPBD_DNSITPCUR_FK foreign key (NYEC_SITP_BI_ID) references D_NYEC_SITP_CURRENT(NYEC_SITP_BI_ID);

create unique index FNSITPBD_UIX1 on F_NYEC_SITP_BY_DATE(FNSITPBD_ID,D_DATE) online tablespace MAXDAT_INDX  parallel compute statistics;
create unique index FNSITPBD_UIX2 on F_NYEC_SITP_BY_DATE(FNSITPBD_ID, BUCKET_START_DATE) online tablespace MAXDAT_INDX  parallel compute statistics;

create index FNSITPBD_IXL1 on F_NYEC_SITP_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSITPBD_IXL2 on F_NYEC_SITP_BY_DATE (NYEC_SITP_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_NYEC_SITP_BY_DATE_SV as
select
  FNSITPBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
  NYEC_SITP_BI_ID,
  case 
    when dense_rank() over (partition by NYEC_SITP_BI_ID order by bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE fnsitpbd
where
  bdd.D_DATE >= fnsitpbd.BUCKET_START_DATE
  and bdd.D_DATE < fnsitpbd.BUCKET_END_DATE
union all
select
  FNSITPBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
  NYEC_SITP_BI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE fnsitpbd
where
  bdd.D_DATE = fnsitpbd.BUCKET_START_DATE
  and bdd.D_DATE = fnsitpbd.BUCKET_END_DATE
with read only;

-- Recompile objects that use table.
alter trigger TRG_AI_NYEC_ETL_SNDIFOTRDPTR_Q compile;
alter trigger TRG_AU_NYEC_ETL_SNDIFOTRDPTR_Q compile;
alter package NYEC_SEND_INFO_TO_TP compile;

-- Rename triggers.
alter trigger TRG_AI_NYEC_ETL_SNDIFOTRDPTR_Q rename to TRG_AI_NYEC_SEND_INFO_TO_TP_Q;
alter trigger TRG_AU_NYEC_ETL_SNDIFOTRDPTR_Q rename to TRG_AU_NYEC_SEND_INFO_TO_TP_Q;

-- Allow NYEC Send Info to TP semantic jobs.
update PROCESS_BPM_QUEUE_JOB_CONFIG 
set ENABLED = 'Y' 
where BSL_ID = 8 
  and BDM_ID = 2;

commit;