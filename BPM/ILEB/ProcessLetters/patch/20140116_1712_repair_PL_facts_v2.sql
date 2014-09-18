/* 

-- Find invalid Process Letters fact rows.

select * from F_PL_BY_DATE
where 
  D_DATE < BUCKET_START_DATE
  or to_date(to_char(D_DATE,'YYYY-MM-DD'),'YYYY-MM-DD') > BUCKET_END_DATE
  or BUCKET_START_DATE > BUCKET_END_DATE
  or BUCKET_END_DATE < BUCKET_START_DATE;

select f.* 
from F_PL_BY_DATE f
where f.PL_BI_ID in 
(18442651,
18458637)
order by 
  f.PL_BI_ID asc,
  D_DATE asc;
  
*/

--- Fix invalid Process Letters fact rows.

alter table F_PL_BY_DATE enable row movement;

update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2013-12-19','YYYY-MM-DD')
where 
  PL_BI_ID = 18442651
  and FPLBD_ID = 2550028;

-- Temp setting.
update F_PL_BY_DATE
set
  D_DATE = to_date('2013-12-31 09:02:24','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2013-12-31','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2013-12-20','YYYY-MM-DD')
where 
  PL_BI_ID = 18442651
  and FPLBD_ID = 2859172;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2013-12-20 19:48:56','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2013-12-20','YYYY-MM-DD')
where 
  PL_BI_ID = 18442651
  and FPLBD_ID = 3001569;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2013-12-19 09:02:24','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2013-12-19','YYYY-MM-DD')
where 
  PL_BI_ID = 18442651
  and FPLBD_ID = 2859172;
  
commit;

alter table F_PL_BY_DATE disable row movement;
