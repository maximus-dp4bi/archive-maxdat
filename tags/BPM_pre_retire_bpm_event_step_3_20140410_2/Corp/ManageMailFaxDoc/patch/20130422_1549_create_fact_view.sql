create or replace view F_MFDOC_BY_DATE_SV as
select
  FMFDOCBD_ID,
  bdd.D_DATE,
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
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
  BUCKET_START_DATE, 
  BUCKET_END_DATE,
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
  bdd.D_DATE = fmfdocbd.BUCKET_START_DATE 
  and bdd.D_DATE = fmfdocbd.BUCKET_END_DATE
with read only;




