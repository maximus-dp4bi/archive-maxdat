alter session set ddl_lock_timeout = 1200;

-- Remove all data from BPM Event for processes other than Manage Work

------------------------
-- Remove from BPM Event

create table BPM_INSTANCE_ATTRIBUTE_TEMP as
(select * from BPM_INSTANCE_ATTRIBUTE where BI_ID in
   (select BI_ID
    from BPM_INSTANCE
    where BEM_ID = 1)
);
commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;
drop index bpm_instance_attribute_ix1;
drop index bpm_instance_attribute_ix2;
drop index bpm_instance_attribute_unk1;
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
   where BEM_ID = 1)
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

delete from BPM_INSTANCE where BEM_ID != 1;
commit;
