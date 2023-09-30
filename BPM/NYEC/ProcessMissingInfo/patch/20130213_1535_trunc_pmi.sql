alter session set ddl_lock_timeout = 1200;

-- Unrelated, but drop obsolete BPM_ERRORS table.
drop table BPM_ERRORS;

-- Remove from queue.
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 5;

commit;


-- Remove from queue archive.  Also remove any event, for all processes, over 7 days old.

create table BUEQ_ARCHIVE_TEMP
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER number not null,
   EVENT_DATE date not null,
   QUEUE_DATE date not null,
   PROCESS_BUEQ_ID number,
   BUE_ID number,
   WROTE_BPM_EVENT_DATE date,
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
parallel;

insert into BUEQ_ARCHIVE_TEMP
select * from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where BSL_ID != 5 and EVENT_DATE >= trunc(sysdate - 7);

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE; 

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID);
alter index BUEQA_PK rebuild tablespace MAXDAT_INDX parallel;

--alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);
--alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);
--alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);


-- Remove from BPM Semantic.
truncate table F_NYEC_PMI_BY_DATE;

alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMILS_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIIMIT_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIPMIT_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIQTI_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIRR_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIRTI_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMISRTI_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMIAI_FK;
alter table F_NYEC_PMI_BY_DATE drop constraint FNPMIBD_DNPMICUR_FK;

truncate table D_NYEC_PMI_CURRENT;
truncate table D_NYEC_PMI_APP_ID;
truncate table D_NYEC_PMI_LETTER_STATUS;
truncate table D_NYEC_PMI_INBOUND_MI_TYPE;
truncate table D_NYEC_PMI_PENDING_MI_TYPE;
truncate table D_NYEC_PMI_QC_TASK_ID;
truncate table D_NYEC_PMI_RESEARCH_REASON;
truncate table D_NYEC_PMI_RESEARCH_TASK_ID;
truncate table D_NYEC_PMI_ST_REV_TASK_ID;

alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMILS_FK foreign key (DNPMILS_ID) references D_NYEC_PMI_LETTER_STATUS(DNPMILS_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIIMIT_FK foreign key (DNPMIIMIT_ID) references D_NYEC_PMI_INBOUND_MI_TYPE(DNPMIIMIT_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIPMIT_FK foreign key (DNPMIPMIT_ID) references D_NYEC_PMI_PENDING_MI_TYPE(DNPMIPMIT_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIQTI_FK foreign key (DNPMIQTI_ID) references D_NYEC_PMI_QC_TASK_ID(DNPMIQTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIRR_FK foreign key (DNPMIRR_ID) references D_NYEC_PMI_RESEARCH_REASON(DNPMIRR_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIRTI_FK foreign key (DNPMIRTI_ID) references D_NYEC_PMI_RESEARCH_TASK_ID(DNPMIRTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMISRTI_FK foreign key (DNPMISRTI_ID) references D_NYEC_PMI_ST_REV_TASK_ID(DNPMISRTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIAI_FK foreign key (DNPMIAI_ID) references D_NYEC_PMI_APP_ID(DNPMIAI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMICUR_FK foreign key (NYEC_PMI_BI_ID) references D_NYEC_PMI_CURRENT(NYEC_PMI_BI_ID);

insert into D_NYEC_PMI_LETTER_STATUS (DNPMILS_ID,"MI Letter Status") values (SEQ_DNPMILS_ID.nextval,null);
insert into D_NYEC_PMI_INBOUND_MI_TYPE (DNPMIIMIT_ID,"Inbound MI Type") values (SEQ_DNPMIIMIT_ID.nextval,null);
insert into D_NYEC_PMI_PENDING_MI_TYPE (DNPMIPMIT_ID,"Pending MI Type") values (SEQ_DNPMIPMIT_ID.nextval,null);
insert into D_NYEC_PMI_QC_TASK_ID (DNPMIQTI_ID,"QC Task ID") values (SEQ_DNPMIQTI_ID.nextval,null);
insert into D_NYEC_PMI_RESEARCH_REASON (DNPMIRR_ID,"Research Reason") values (SEQ_DNPMIRR_ID.nextval,null);
insert into D_NYEC_PMI_RESEARCH_TASK_ID (DNPMIRTI_ID,"Research Task ID") values (SEQ_DNPMIRTI_ID.nextval,null);
insert into D_NYEC_PMI_ST_REV_TASK_ID (DNPMISRTI_ID,"State Review Task ID") values (SEQ_DNPMISRTI_ID.nextval,null);
commit;

-- Remove from BPM Event.
create table BPM_INSTANCE_ATTRIBUTE_TEMP
  (BIA_ID       number not null,
   BI_ID        number not null,
   BA_ID        number not null,
   VALUE_NUMBER number,
   VALUE_DATE   date,
   VALUE_CHAR   varchar2(4000),
   START_DATE   date not null,
   END_DATE     date,
   BUE_ID       number not null)
partition by range (BA_ID)
interval(1)
  (partition PT_BIA_BA_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;

insert into BPM_INSTANCE_ATTRIBUTE_TEMP
select * 
from BPM_INSTANCE_ATTRIBUTE 
where BA_ID in
  (select BA_ID
   from BPM_ATTRIBUTE 
   where BEM_ID != 5);
   
commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;

--drop index BPM_INSTANCE_ATTRIBUTE_PK;
drop index BPM_INSTANCE_ATTRIBUTE_UNK1;
drop index BPM_INSTANCE_ATTRIBUTE_IX1;
drop index BPM_INSTANCE_ATTRIBUTE_IX2;
--drop index BPM_INSTANCE_ATTRIBUTE_IXL1;

alter table BPM_INSTANCE_ATTRIBUTE rename to BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE_TEMP rename to BPM_INSTANCE_ATTRIBUTE;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BPM_INSTANCE_ATTRIBUTE_PK primary key (BIA_ID);
alter index BPM_INSTANCE_ATTRIBUTE_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index BPM_INSTANCE_ATTRIBUTE_UNK1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,START_DATE,END_DATE,BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,END_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_LX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create table BPM_UPDATE_EVENT_TEMP as
select * 
from BPM_UPDATE_EVENT 
where BI_ID in 
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID != 5);

commit;

alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_UPDATE_EVENT_BACKUP drop constraint BPM_UPDATE_EVENT_PK;
drop index BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT drop constraint BEM_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BUTL_BUE_FK;
drop index BUE_IX1;

alter table BPM_UPDATE_EVENT rename to BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT_TEMP rename to BPM_UPDATE_EVENT;

alter table BPM_UPDATE_EVENT add constraint BPM_UPDATE_EVENT_PK2 primary key (BUE_ID);
alter index BPM_UPDATE_EVENT_PK2 rebuild tablespace MAXDAT_INDX parallel;

create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) tablespace MAXDAT_INDX parallel compute statistics;
alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT add constraint BEM_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);
alter table BPM_UPDATE_EVENT add constraint BUTL_BUE_FK foreign key (BUTL_ID) references BPM_UPDATE_TYPE_LKUP (BUTL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

delete from BPM_INSTANCE where BEM_ID = 5;
commit;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

commit;
