alter table F_NYEC_PA_BY_DATE enable row movement;

update F_NYEC_PA_BY_DATE
set
  D_DATE = to_date('2012-02-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2012-02-13','YYYY-MM-DD'),
  DNPAHS_ID = 265,
  INVENTORY_COUNT = 1,
  COMPLETION_COUNT = 1
where 
  FNPABD_ID = 642557
  and NYEC_PA_BI_ID = 899894;

insert into F_NYEC_PA_BY_DATE (FNPABD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,NYEC_PA_BI_ID,DNPAAS_ID,DNPACOU_ID,DNPAHS_ID,"Receipt Date",INVENTORY_COUNT,CREATION_COUNT,COMPLETION_COUNT,DNPACIN_ID,DNPAFPBPST_ID,DNPAHIAI_ID,"Invoiceable Date",DNPAHCS_ID,DNPARI_ID,DNPARR_ID,DNPARB_ID,DNPARN_ID,DNPAMC_ID,DNPAML_ID,DNPAONF_ID,DNPAOLS_ID,DNPASAR_ID,DNPAWRI_ID,DNPAQI_ID,"Reactivation Date",DNPAMAR_ID,DNPARCR_ID) 
values (SEQ_FNPABD_ID.nextval,to_date('2012-12-07 09:49:40','YYYY-MM-DD HH24:MI:SS'),to_date('2012-12-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2012-12-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),899894,265,265,266,null,0,0,1,265,265,265,null,265,286,265,265,267,265,265,265,265,265,265,265,null,265,265);

commit;

alter table F_NYEC_PA_BY_DATE disable row movement;