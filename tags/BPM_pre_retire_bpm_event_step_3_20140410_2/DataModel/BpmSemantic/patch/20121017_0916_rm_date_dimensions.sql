alter table F_MW_BY_DATE rename column LAST_UPDATE_DATE to "Last Update Date";
create index FMWBD_IX1 on F_MW_BY_DATE ("Last Update Date") tablespace MAXDAT_INDX parallel compute statistics;

alter table F_MW_BY_DATE add ("STATUS_DATE_TMP" date);
update 
  (select
     fmwbd.MW_BI_ID,
     dmwsd."Status Date",
     fmwbd.STATUS_DATE_TMP
   from F_MW_BY_DATE fmwbd
   inner join D_MW_STATUS_DATE dmwsd on (fmwbd.DMWSD_ID = dmwsd.DMWSD_ID))
set STATUS_DATE_TMP = "Status Date";
commit;

alter table F_MW_BY_DATE drop constraint FMWBD_DMWSD_FK;
alter table F_MW_BY_DATE modify (DMWSD_ID null);
update F_MW_BY_DATE set DMWSD_ID = null;
commit;
alter table F_MW_BY_DATE rename column DMWSD_ID to "Status Date";
alter table F_MW_BY_DATE modify ("Status Date" date);
update F_MW_BY_DATE set "Status Date" = STATUS_DATE_TMP;
commit;
alter table F_MW_BY_DATE modify ("Status Date" date not null);
alter table F_MW_BY_DATE drop (STATUS_DATE_TMP);
create index FMWBD_IX2 on F_MW_BY_DATE ("Status Date") tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_MW_BY_DATE_SV as
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID, 
  DMWTT_ID, 
  DMWE_ID, 
  DMWF_ID, 
  DMWO_ID, 
  DMWTS_ID, 
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  case 
    when dense_rank() over (partition by MW_BI_ID order by MW_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_MW_BY_DATE fmwbd
where
  bdd.D_DATE >= fmwbd.BUCKET_START_DATE 
  and bdd.D_DATE < fmwbd.BUCKET_END_DATE
with read only;

drop view D_MW_STATUS_DATE_SV;
drop table D_MW_STATUS_DATE;
drop sequence SEQ_DMWSD_ID;


alter table F_NYEC_PA_BY_DATE drop constraint FNPABD_DNPARD_FK; 
alter table F_NYEC_PA_BY_DATE rename column DNPARD_ID to "Receipt Date";
alter table F_NYEC_PA_BY_DATE modify ("Receipt Date" date);
create index FNPABD_IX1 on F_NYEC_PA_BY_DATE ("Receipt Date") tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  case 
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE >= fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpabd.BUCKET_END_DATE
with read only;