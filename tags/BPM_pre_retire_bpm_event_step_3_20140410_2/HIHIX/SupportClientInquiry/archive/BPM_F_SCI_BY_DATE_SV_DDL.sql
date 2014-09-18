create or replace view F_SCI_BY_DATE_SV as
select
  FSCIBD_ID,
  bdd.D_date,
  BUCKET_START_date, 
  BUCKET_END_date,
  SCI_BI_ID, 
  INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by SCI_BI_ID order by SCI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
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
  BUCKET_START_date, 
  BUCKET_END_date,
  SCI_BI_ID, 
  INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by SCI_BI_ID order by SCI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_SCI_BY_DATE fscibd
where
  bdd.D_DATE = fscibd.BUCKET_START_DATE 
  and bdd.D_DATE = fscibd.BUCKET_END_DATE
with read only;

