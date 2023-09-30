alter table F_NYEC_PA_BY_DATE_BCK rename to F_NYEC_PA_BY_DATE_BCK2;

delete from F_NYEC_PA_BY_DATE 
where 
  NYEC_PA_BI_ID = 897526
  and FNPABD_ID > 2154396;
  
delete from F_NYEC_PA_BY_DATE 
where 
  NYEC_PA_BI_ID = 1126014
  and FNPABD_ID in (3804537,4097931);

alter table F_NYEC_PA_BY_DATE enable row movement;
  
update F_NYEC_PA_BY_DATE
set 
  D_DATE = to_date('2012-11-05 06:06:57','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2012-11-05','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2012-11-05','YYYY-MM-DD')
where
  NYEC_PA_BI_ID = 897526
  and FNPABD_ID = 2154396;

commit;

alter table F_NYEC_PA_BY_DATE disable row movement;