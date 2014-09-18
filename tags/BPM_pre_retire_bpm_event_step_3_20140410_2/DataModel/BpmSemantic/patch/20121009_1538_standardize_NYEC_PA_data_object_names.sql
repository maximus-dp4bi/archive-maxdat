rename SEQ_DPAAS_ID to SEQ_DNPAAS_ID;
alter table D_NYEC_PA_APP_STATUS rename column DPAAS_ID to DNPAAS_ID;
alter table D_NYEC_PA_APP_STATUS rename constraint DPAAS_PK to DNPAAS_PK;
alter index DPAAS_PK rename to DNPAAS_PK;
alter index DPAAS_UIX1 rename to DNPAAS_UIX1;

create or replace view D_NYEC_PA_APP_STATUS_SV as
select * from D_NYEC_PA_APP_STATUS 
with read only;


rename SEQ_DPAC_ID to SEQ_DNPACOU_ID;
alter table D_NYEC_PA_COUNTY rename column DPAC_ID to DNPACOU_ID;
alter table D_NYEC_PA_COUNTY rename constraint DPACOU_PK to DNPACOU_PK;
alter index DPACOU_PK rename to DNPACOU_PK;
alter index DPAC_UIX1 rename to DNPACOU_UIX1;

create or replace view D_NYEC_PA_COUNTY_SV as
select * from D_NYEC_PA_COUNTY 
with read only;


alter table D_NYEC_PA_CURRENT rename constraint DPACUR_PK to DNPACUR_PK;
alter index DPACUR_PK rename to DNPACUR_PK;
alter index DPACUR_UIX1 rename to DNPACUR_UIX1;


alter table D_NYEC_PA_CURRENT_TASK rename constraint DPACT_PK to DNPACT_PK;
alter index DPACT_PK rename to DNPACT_PK;


drop view D_PA_DATA_ENTRY_TASK_SV;
alter table D_PA_DATA_ENTRY_TASK rename to D_NYEC_PA_DATA_ENTRY_TASK;
alter table D_NYEC_PA_DATA_ENTRY_TASK rename constraint DPADET_PK to DNPADET_PK;
alter index DPADET_PK rename to DNPADET_PK;

create or replace view D_NYEC_PA_DATA_ENTRY_TASK_SV as
select * from D_NYEC_PA_DATA_ENTRY_TASK  
with read only;


rename SEQ_DPAHS_ID to SEQ_DNPAHS_ID;
alter table D_NYEC_PA_HEART_SYNCH rename column DPAHS_ID to DNPAHS_ID;
alter table D_NYEC_PA_HEART_SYNCH rename constraint DPAHS_PK to DNPAHS_PK;
alter index DPAHS_PK rename to DNPAHS_PK;
alter index DPAHS_UIX1 rename to DNPAHS_UIX1;

create or replace view D_NYEC_PA_HEART_SYNCH_SV as
select * from D_NYEC_PA_HEART_SYNCH   
with read only;


alter table D_NYEC_PA_QC_TASK rename constraint DPAQT_PK to DNPAQT_PK;
alter index DPAQT_PK rename to DNPAQT_PK;


rename SEQ_DPARD_ID to SEQ_DNPARD_ID;
alter table D_NYEC_PA_RECEIPT_DATE rename column DPARD_ID to DNPARD_ID;
alter table D_NYEC_PA_RECEIPT_DATE rename constraint DPARD_PK to DNPARD_PK;
alter index DPARD_PK rename to DNPARD_PK;

create or replace view D_NYEC_PA_RECEIPT_DATE_SV as
select * from D_NYEC_PA_RECEIPT_DATE   
with read only;


alter table F_NYEC_PA_BY_DATE rename column DPAAS_ID to DNPAAS_ID;
alter table F_NYEC_PA_BY_DATE rename column DPAC_ID to DNPACOU_ID;
alter table F_NYEC_PA_BY_DATE rename column DPAHS_ID to DNPAHS_ID;
alter table F_NYEC_PA_BY_DATE rename column DPARD_ID to DNPARD_ID;
alter table F_NYEC_PA_BY_DATE rename column COMPLETIONS_COUNT to COMPLETION_COUNT;

create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID, 
  DNPAAS_ID, 
  DNPACOU_ID, 
  DNPAHS_ID, 
  DNPARD_ID,
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


alter table D_NYEC_PA_CURRENT rename constraint DPACUR_DPACT_FK to DNPACUR_DNPACT_FK;
alter table D_NYEC_PA_CURRENT drop constraint DPACUR_DPADET_FK;
alter table D_NYEC_PA_CURRENT add constraint DNPACUR_DNPADET_FK foreign key 
  ("Data Entry Task ID") references D_NYEC_PA_DATA_ENTRY_TASK ("Data Entry Task ID");
alter table D_NYEC_PA_CURRENT rename constraint DPACUR_DPAQT_FK to DNPACUR_DNPAQT_FK;

alter table F_NYEC_PA_BY_DATE rename constraint FNPABD_DPAAS_FK to FNPABD_DNPAAS_FK;
alter table F_NYEC_PA_BY_DATE rename constraint FNPABD_DPACUR_FK to FNPABD_DNPACUR_FK;
alter table F_NYEC_PA_BY_DATE rename constraint FNPABD_DPAC_FK to FNPABD_DNPACOU_FK;
alter table F_NYEC_PA_BY_DATE rename constraint FNPABD_DPAHS_FK to FNPABD_DNPAHS_FK;
alter table F_NYEC_PA_BY_DATE rename constraint FNPABD_DPARD_FK to FNPABD_DNPARD_FK;
alter table REL_TASK_APP rename constraint RTA_DPACUR_FK to RTA_DNPACUR_FK;


