update BPM_UPDATE_EVENT_QUEUE 
set 
  BUE_ID = null,
  PROCESS_BUEQ_ID = null,
  WROTE_BPM_EVENT_DATE = null,
  WROTE_BPM_SEMANTIC_DATE = null
where BSL_ID = 9;

commit;

truncate table F_MFDOC_BY_DATE;
alter table F_MFDOC_BY_DATE drop constraint FMFDOCBD_DMFDOCCUR_FK;
truncate table D_MFDOC_CURRENT;
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCCUR_FK foreign key (MFDOC_BI_ID) references D_MFDOC_CURRENT (MFDOC_BI_ID);

delete from BPM_INSTANCE_ATTRIBUTE
where BA_ID in
  (select BA_ID
   from BPM_ATTRIBUTE 
   where BEM_ID = 9);
   
commit;

delete from BPM_UPDATE_EVENT
where BI_ID in
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID = 9);
   
commit;

delete from BPM_INSTANCE where BEM_ID = 9;

commit;

update PROCESS_BPM_QUEUE_JOB_CONFIG 
set ENABLED = 'Y'
where BSL_ID = 9;

commit;
