truncate table BPM_UPDATE_EVENT_QUEUE;
truncate table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

truncate table BPM_LOGGING;

truncate table F_MFDOC_BY_DATE;
alter table F_MFDOC_BY_DATE drop constraint FMFDOCBD_DMFDOCCUR_FK;
truncate table D_MFDOC_CURRENT;
alter table F_MFDOC_BY_DATE add constraint FMFDOCBD_DMFDOCCUR_FK foreign key (MFDOC_BI_ID) references D_MFDOC_CURRENT (MFDOC_BI_ID);

-- Non-standard constraint name.
truncate table F_MJ_BY_DATE;
alter table F_MJ_BY_DATE drop constraint FIMJBD_DIMJCUR_FK;
truncate table D_MJ_CURRENT;
alter table F_MJ_BY_DATE add constraint FIMJBD_DIMJCUR_FK foreign key (MJ_BI_ID) references D_MJ_CURRENT (MJ_BI_ID);

truncate table F_MW_BY_DATE;
alter table F_MW_BY_DATE drop constraint FMWBD_DMWCUR_FK;
truncate table D_MW_CURRENT;
alter table F_MW_BY_DATE add constraint FMWBD_DMWCUR_FK foreign key (MW_BI_ID) references D_MW_CURRENT (MW_BI_ID);

truncate table F_PI_BY_DATE;
alter table F_PI_BY_DATE drop constraint FPIBD_DPICUR_FK;
truncate table D_PI_CURRENT;
alter table F_PI_BY_DATE add constraint FPIBD_DPICUR_FK foreign key (PI_BI_ID) references D_PI_CURRENT (PI_BI_ID);

truncate table F_PL_BY_DATE;
alter table F_PL_BY_DATE drop constraint FPLBD_DPLCUR_FK;
truncate table D_PL_CURRENT;
alter table F_PL_BY_DATE add constraint FPLBD_DPLCUR_FK foreign key (PL_BI_ID) references D_PL_CURRENT (PL_BI_ID);

truncate table F_SCI_BY_DATE;
alter table F_SCI_BY_DATE drop constraint FSCIBD_DSCICUR_FK;
truncate table D_SCI_CURRENT;
alter table F_SCI_BY_DATE add constraint FSCIBD_DSCICUR_FK foreign key (SCI_BI_ID) references D_SCI_CURRENT (SCI_BI_ID);

truncate table BPM_INSTANCE_ATTRIBUTE;

delete from BPM_UPDATE_EVENT;
commit;

delete from BPM_INSTANCE;
commit;