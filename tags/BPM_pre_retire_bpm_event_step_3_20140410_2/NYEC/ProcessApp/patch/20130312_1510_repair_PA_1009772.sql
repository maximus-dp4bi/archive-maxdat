delete from F_NYEC_PA_BY_DATE 
where 
  NYEC_PA_BI_ID = 1009772
  and FNPABD_ID in (3265654,3396086);
  
update F_NYEC_PA_BY_DATE
set 
  D_DATE = to_date('2013-01-07 17:38:44','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_END_DATE = to_date('2013-01-07','YYYY-MM-DD'),
  INVENTORY_COUNT = 0,
  COMPLETION_COUNT = 1
where
  NYEC_PA_BI_ID = 1009772
  and FNPABD_ID = 3165050;

commit;