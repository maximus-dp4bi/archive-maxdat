-- Consolidate F_MW_BY_DATE rows by bucket date.  Keeps the latest row by bucket date for a MW_BI_ID.
-- Fixes result of bug in MANAGE_WORK_pkg.sql.

delete 
from F_MW_BY_DATE
where FMWBD_ID in 
  (select F_MW_BY_DATE.FMWBD_ID
   from
     (select 
        max(FMWBD_ID) max_fmwbd_id,
        MW_BI_ID,
        BUCKET_START_DATE
      from F_MW_BY_DATE
      group by 
        MW_BI_ID,
        BUCKET_START_DATE
      having count(*) > 1) keep_rows,
     F_MW_BY_DATE
   where
     F_MW_BY_DATE.MW_BI_ID = keep_rows.MW_BI_ID
     and F_MW_BY_DATE.BUCKET_START_DATE = keep_rows.BUCKET_START_DATE
     and F_MW_BY_DATE.FMWBD_ID != keep_rows.max_fmwbd_id);
     
commit;