/*
Created on 25-Apr-2013 by Mayuresh.
Description:
This script is created to clean the BPM events and Semantic layer for a fresh reload of the Manage Jobs (corp_etl_manage_jobs) Stage table.

steps:
1. Deleting BPM Event Queue.
2. Deleting Semantic layer.
3. Deleting BPM Events.
BEM_id need to hard coded for the process at 3 places and bsl_id at 2 places
*/

-- Remove from queue.
DELETE FROM BPM_UPDATE_EVENT_QUEUE WHERE bsl_id=11;
COMMIT;


-- Remove from queue archive.  Also remove any event, for all processes, over 7 days old.

-- OK if this drop table fails because table does not exist.
drop table BUEQ_ARCHIVE_TEMP;

create table BUEQ_ARCHIVE_TEMP
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER varchar2(35) not null,
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
select 
  BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  PROCESS_BUEQ_ID,
  BUE_ID,
  WROTE_BPM_EVENT_DATE,
  WROTE_BPM_SEMANTIC_DATE, 
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where BSL_ID != 111;

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE; 

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID);
alter index BUEQA_PK rebuild tablespace MAXDAT_INDX parallel;


--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table f_mj_by_date;
alter table F_MJ_BY_DATE drop constraint FIMJBD_DIMJCUR_FK;

truncate table d_mj_current;
alter table F_MJ_BY_DATE add constraint FIMJBD_DIMJCUR_FK foreign key (MJ_BI_ID) references D_MJ_CURRENT (MJ_BI_ID);
--------------------------------------------------------------------------------------


-- Remove from BPM Event.

-- OK if this drop table fails because table does not exist.
drop table BPM_INSTANCE_ATTRIBUTE_TEMP;

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
   where BEM_ID != 11);
   
commit;

alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BPM_INSTANCE_ATTRIBUTE_PK;

drop index BPM_INSTANCE_ATTRIBUTE_UNK1;
drop index BPM_INSTANCE_ATTRIBUTE_IX1;
drop index BPM_INSTANCE_ATTRIBUTE_IX2;
drop index BPM_INSTANCE_ATTRIBUTE_LX1;

drop table BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE rename to BIA_BACKUP;
alter table BPM_INSTANCE_ATTRIBUTE_TEMP rename to BPM_INSTANCE_ATTRIBUTE;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BPM_INSTANCE_ATTRIBUTE_PK primary key (BIA_ID);
alter index BPM_INSTANCE_ATTRIBUTE_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index BPM_INSTANCE_ATTRIBUTE_UNK1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,START_DATE,END_DATE,BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID,BA_ID,END_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_IX2 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics; 
create index BPM_INSTANCE_ATTRIBUTE_LX1 on BPM_INSTANCE_ATTRIBUTE (BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);

-- OK if this drop table fails because table does not exist.
drop table BPM_UPDATE_EVENT_TEMP;

create table BPM_UPDATE_EVENT_TEMP as
select * 
from BPM_UPDATE_EVENT 
where BI_ID in 
  (select BI_ID
   from BPM_INSTANCE
   where BEM_ID != 11);

commit;

alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;

alter table BPM_UPDATE_EVENT drop constraint BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT drop constraint BUE_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BUE_BUTL_FK;

drop index BUE_IX1;

drop table BPM_UPDATE_EVENT_BACKUP;

alter table BPM_UPDATE_EVENT rename to BPM_UPDATE_EVENT_BACKUP;
alter table BPM_UPDATE_EVENT_TEMP rename to BPM_UPDATE_EVENT;

--Creating PK and index on BPM_UPDATE_EVENT_BACKUP.BUE_ID
alter table BPM_UPDATE_EVENT add constraint BPM_UPDATE_EVENT_PK primary key (BUE_ID);
alter index BPM_UPDATE_EVENT_PK rebuild tablespace MAXDAT_INDX parallel;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_UPDATE_EVENT add constraint BUE_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);
alter table BPM_UPDATE_EVENT add constraint BUE_BUTL_FK foreign key (BUTL_ID) references BPM_UPDATE_TYPE_LKUP (BUTL_ID);
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

delete from BPM_INSTANCE where BEM_ID = 11;
commit;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BI_FK foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

------------------------------------
--removing attriubte 1693,1694
------------------------------------
 delete from BPM_ATTRIBUTE
 where ba_id in (1693,1694);
 commit;


truncate table corp_etl_manage_jobs;

update corp_etl_control set value = '0' 
where name = 'LAST_JOB_ID';

delete from bpm_logging where bsl_id = 11;

commit;


----------------------------------
--inserting new attribute 2179, 2180
----------------------------------

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2179,576,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2180,722,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');



--insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1523,11,'CANCEL_REASON'); 
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,2179,11,'CANCEL_BY'); 
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,2180,11,'CANCEL_METHOD'); 
commit;
 

