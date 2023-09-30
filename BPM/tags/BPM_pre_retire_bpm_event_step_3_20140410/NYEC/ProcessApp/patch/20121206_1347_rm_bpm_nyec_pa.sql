alter session set ddl_lock_timeout = 1200;

-- Remove all Process App instance data from BPM Event and BPM Semantic data models.

----------------------------------------
-- Delete all queue rows for Process App

truncate table BPM_UPDATE_EVENT_QUEUE_CONV;

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID=2;
commit;

create table BUEQ_ARCHIVE_BACKUP as (select * from BPM_UPDATE_EVENT_QUEUE_ARCHIVE where BSL_ID != 2);
commit;
truncate table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;



-------------------------------------------------------
-- Remove from Semantic Data Model for NYEC Process App

alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpaas_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpacin_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpacou_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpacur_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpafpbpst_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpahcs_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpahiai_fk;
alter table F_NYEC_PA_BY_DATE disable constraint fnpabd_dnpahs_fk;

truncate table F_NYEC_PA_BY_DATE;

truncate table D_NYEC_PA_APP_STATUS;

truncate table D_NYEC_PA_CIN;
insert into D_NYEC_PA_CIN (DNPACIN_ID,"CIN") values (SEQ_DNPACIN_ID.nextval,null);
commit;

truncate table D_NYEC_PA_COUNTY;
insert into D_NYEC_PA_COUNTY (DNPACOU_ID,"County") values (SEQ_DNPACOU_ID.nextval,null);
commit;

truncate table D_NYEC_PA_FPBP_SUBTYPE;

truncate table D_NYEC_PA_HEART_INC_APP_IND;
insert into D_NYEC_PA_HEART_INC_APP_IND (DNPAHIAI_ID,"HEART Incomplete App Ind") values (SEQ_DNPAHIAI_ID.nextval,null);
commit;

truncate table D_NYEC_PA_HEART_SYNCH;

truncate table D_NYEC_PA_HEART_CASE_STATUS;
insert into D_NYEC_PA_HEART_CASE_STATUS (DNPAHCS_ID,"HEART Case Status") values (SEQ_DNPAHCS_ID.nextval,null);
commit;

truncate table D_NYEC_PA_CURRENT;

alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpaas_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpacin_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpacou_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpacur_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpafpbpst_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpahcs_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpahiai_fk;
alter table F_NYEC_PA_BY_DATE enable constraint fnpabd_dnpahs_fk;

commit;



------------------------
-- Remove from BPM Event

create table BPM_INSTANCE_ATTRIBUTE_TEMP as
(select * from BPM_INSTANCE_ATTRIBUTE where BA_ID in
   (select BA_ID
    from BPM_ATTRIBUTE 
    where BEM_ID != 2)
);
commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;
drop index BPM_INSTANCE_ATTRIBUTE_PK;
drop index bpm_instance_attribute_ix1;
drop index bpm_instance_attribute_ix2;
drop index bpm_instance_attribute_unk1;
drop table BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE rename to BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE_TEMP rename to BPM_INSTANCE_ATTRIBUTE;
alter table BPM_INSTANCE_ATTRIBUTE ADD CONSTRAINT BPM_INSTANCE_ATTRIBUTE_PK PRIMARY KEY (BIA_ID);
alter table BPM_INSTANCE_ATTRIBUTE ADD CONSTRAINT BIA_BI_FK FOREIGN KEY (BI_ID) REFERENCES MAXDAT.BPM_INSTANCE (BI_ID);
alter table BPM_INSTANCE_ATTRIBUTE ADD CONSTRAINT BIA_BUE_FK FOREIGN KEY (BUE_ID) REFERENCES MAXDAT.BPM_UPDATE_EVENT (BUE_ID);
CREATE INDEX BPM_INSTANCE_ATTRIBUTE_IX1 ON BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, END_DATE) TABLESPACE MAXDAT_INDX  parallel compute statistics;
CREATE INDEX BPM_INSTANCE_ATTRIBUTE_IX2 ON BPM_INSTANCE_ATTRIBUTE (BUE_ID) TABLESPACE MAXDAT_INDX  parallel compute statistics;
CREATE UNIQUE INDEX BPM_INSTANCE_ATTRIBUTE_UNK1	ON BPM_INSTANCE_ATTRIBUTE (BI_ID, BA_ID, START_DATE, END_DATE, BUE_ID) TABLESPACE MAXDAT_INDX  parallel compute statistics;

create table BPM_UPDATE_EVENT_TEMP as
(select * from BPM_UPDATE_EVENT WHERE BI_ID IN 
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID != 2)
);
commit;

alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_CONV drop constraint BUEQC_BUE_ID_FK;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_UPDATE_EVENT drop constraint BPM_UPDATE_EVENT_PK;
drop index BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT drop constraint BEM_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BUTL_BUE_FK;
drop index BUE_IX1;

drop table BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT rename to BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT_TEMP rename to BPM_UPDATE_EVENT;

alter table BPM_UPDATE_EVENT add constraint BPM_UPDATE_EVENT_PK primary key (BUE_ID);
alter index BPM_UPDATE_EVENT_PK rebuild tablespace MAXDAT_INDX parallel;

create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

alter table BPM_UPDATE_EVENT add constraint BEM_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

alter table BPM_UPDATE_EVENT add constraint BUTL_BUE_FK foreign key (BUTL_ID) references BPM_UPDATE_TYPE_LKUP (BUTL_ID);

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_CONV add constraint BUEQC_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

delete from BPM_INSTANCE where BEM_ID = 2;
commit;
