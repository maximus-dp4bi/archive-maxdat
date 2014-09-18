create or replace view F_MJ_BY_DATE_SV as
select
  FIMJBD_ID, 
  bdd.D_DATE, 
  MJ_BI_ID, 
  DIMJLUB_ID,
  case 
    when dense_rank() over (partition by MJ_BI_ID order by MJ_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_MJ_BY_DATE fimjrbd
where
  bdd.D_DATE >= fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE < fimjrbd.BUCKET_END_DATE
union all
select
  FIMJBD_ID, 
  bdd.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_MJ_BY_DATE fimjrbd
where
  bdd.D_DATE = fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE = fimjrbd.BUCKET_END_DATE
with read only;
   
create or replace view F_MFDOC_BY_DATE_SV as
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  case 
    when dense_rank() over (partition by MFDOC_BI_ID order by MFDOC_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from 
  BPM_D_DATES bdd,
  F_MFDOC_BY_DATE fmfdocbd
where
  bdd.D_DATE >= fmfdocbd.BUCKET_START_DATE 
  and bdd.D_DATE < fmfdocbd.BUCKET_END_DATE
union all
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  MFDOC_BI_ID,
  DMFDOCDT_ID, 
  DMFDOCB_ID, 
  DMFDOCTS_ID, 
  DMFDOCDS_ID, 
  DMFDOCIS_ID, 
  DMFDOCDCNJS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Document Status Date", 
  "DCN Jeopardy Status Date"
from 
  BPM_D_DATES bdd,
  F_MFDOC_BY_DATE fmfdocbd
where
  bdd.D_DATE = fmfdocbd.BUCKET_START_DATE 
  and bdd.D_DATE = fmfdocbd.BUCKET_END_DATE
with read only;

create or replace view F_PI_BY_DATE_SV as
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  case 
    when dense_rank() over (partition by PI_BI_ID order by PI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  BPM_D_DATES bdd,
  F_PI_BY_DATE fpibd
where
  bdd.D_DATE >= fpibd.BUCKET_START_DATE 
  and bdd.D_DATE < fpibd.BUCKET_END_DATE
union all
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  BPM_D_DATES bdd,
  F_PI_BY_DATE fpibd
where
  bdd.D_DATE = fpibd.BUCKET_START_DATE 
  and bdd.D_DATE = fpibd.BUCKET_END_DATE
with read only; 

create or replace view F_PL_BY_DATE_SV as
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  case 
    when dense_rank() over (partition by PL_BI_ID order by PL_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  BPM_D_DATES bdd,
  F_PL_BY_DATE fplbd
where
  bdd.D_DATE >= fplbd.BUCKET_START_DATE 
  and bdd.D_DATE < fplbd.BUCKET_END_DATE
union all
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  BPM_D_DATES bdd,
  F_PL_BY_DATE fplbd
where
  bdd.D_DATE = fplbd.BUCKET_START_DATE 
  and bdd.D_DATE = fplbd.BUCKET_END_DATE
with read only;

create or replace view F_SCI_BY_DATE_SV as
select
  FSCIBD_ID,
  bdd.D_date,
  SCI_BI_ID, 
  case 
    when dense_rank() over (partition by SCI_BI_ID order by SCI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_SCI_BY_DATE fscibd
where
  bdd.D_DATE >= fscibd.BUCKET_START_DATE 
  and bdd.D_DATE < fscibd.BUCKET_END_DATE
union all
select
  FSCIBD_ID,
  bdd.D_date,
  SCI_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_SCI_BY_DATE fscibd
where
  bdd.D_DATE = fscibd.BUCKET_START_DATE 
  and bdd.D_DATE = fscibd.BUCKET_END_DATE
with read only;