create table F_NYEC_PA_BY_DATE_BCK
as
select * from F_NYEC_PA_BY_DATE;

commit;

delete from F_NYEC_PA_BY_DATE 
where 
  NYEC_PA_BI_ID = 983976
  and FNPABD_ID = 5511536;
  
update F_NYEC_PA_BY_DATE
set 
  D_DATE = to_date('2013-01-07 14:36:51','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_END_DATE = to_date('2013-01-07','YYYY-MM-DD')
where 
  NYEC_PA_BI_ID = 983976
  and FNPABD_ID = 3158612;
  
alter table F_NYEC_PA_BY_DATE enable row movement;

delete from F_NYEC_PA_BY_DATE
where   
  NYEC_PA_BI_ID = 899894
  and FNPABD_ID > 642557;

update F_NYEC_PA_BY_DATE
set
  D_DATE = to_date('2012-02-07 09:49:40','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2012-12-07','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2012-12-07','YYYY-MM-DD'),
  INVENTORY_COUNT = 0,
  COMPLETION_COUNT = 1
where
  NYEC_PA_BI_ID = 899894
  and FNPABD_ID = 642557;
  
commit;
  
delete from F_NYEC_PA_BY_DATE
where   
  NYEC_PA_BI_ID = 1045957
  and FNPABD_ID > 3571313;
  
update F_NYEC_PA_BY_DATE
set
  D_DATE = to_date('2013-01-10 12:51:31','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2013-01-10','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2013-01-10','YYYY-MM-DD'),
  INVENTORY_COUNT = 0,
  COMPLETION_COUNT = 1
where
  NYEC_PA_BI_ID = 1045957
  and FNPABD_ID = 3571313;
  
commit;
  
update F_NYEC_PA_BY_DATE
set BUCKET_END_DATE = BUCKET_START_DATE
where
  NYEC_PA_BI_ID = 983976
  and FNPABD_ID = 3158612;

commit;

alter table F_NYEC_PA_BY_DATE disable row movement;