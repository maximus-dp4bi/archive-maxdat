-- Retire BPM Event

-- Step 2-A
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BI_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BUE_FK;
alter table BPM_INSTANCE_ATTRIBUTE drop primary key drop index;
drop index BPM_INSTANCE_ATTRIBUTE_UNK1; 
drop index BPM_INSTANCE_ATTRIBUTE_IX1; 
drop index BPM_INSTANCE_ATTRIBUTE_IX2; 
drop index BPM_INSTANCE_ATTRIBUTE_LX1;

alter table BPM_UPDATE_EVENT drop constraint BUE_BI_FK;
alter table BPM_UPDATE_EVENT drop constraint BUE_BUTL_FK;
drop index BUE_IX1;

alter table BPM_INSTANCE drop constraint BI_BEM_FK;
alter table BPM_INSTANCE drop constraint BI_BIL_FK;
alter table BPM_INSTANCE drop constraint BI_BSL_FK;
alter table BPM_ACTIVITY_EVENTS drop constraint BACE_BI_FK;
alter table BPM_INSTANCE drop primary key drop index;
drop index BPM_INSTANCE_UNK1;


-- Step 2-D
-- OK if this drop table fails because table does not exist.
drop table BPM_LOGGING_TEMP;

create table BPM_LOGGING_TEMP
  (BL_ID           number,
   LOG_DATE        date not null,
   LOG_LEVEL       varchar2(7) not null,
   PBQJ_ID         number,
   RUN_DATA_OBJECT varchar2(61),
   BSL_ID          number,
   BIL_ID          number,
   IDENTIFIER      varchar2(100), 
   BI_ID           number,
   MESSAGE	       clob,
   ERROR_NUMBER    number,
   BACKTRACE       clob)
storage (initial 64K)
partition by range (LOG_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BL_LOG_DATE_LT_2014 values less than (TO_DATE('20140101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

insert into BPM_LOGGING_TEMP
select 
  BL_ID,
  LOG_DATE,
  LOG_LEVEL,
  PBQJ_ID,
  RUN_DATA_OBJECT,
  BSL_ID,
  BIL_ID,
  IDENTIFIER, 
  BI_ID,
  MESSAGE,
  ERROR_NUMBER,
  BACKTRACE
from BPM_LOGGING
where LOG_DATE >= trunc(sysdate - 7);

commit;

drop table BPM_LOGGING;

alter table BPM_LOGGING_TEMP rename to BPM_LOGGING; 

alter table BPM_LOGGING add constraint BPM_LOGGING_PK primary key (BL_ID) using index tablespace MAXDAT_INDX;

create index BPM_LOGGING_LX1 on BPM_LOGGING (LOG_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BPM_LOGGING_LX2 on BPM_LOGGING (BSL_ID,LOG_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_LOGGING add constraint BPM_LOGGING_LOG_LEVEL_CK 
check (LOG_LEVEL in ('SEVERE','WARNING','INFO','CONFIG','FINE','FINER','FINEST'));

grant select on BPM_LOGGING to MAXDAT_READ_ONLY;

drop index BUEQ_LX6;
alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE drop column BUE_ID;
drop trigger TRG_BI_BPM_UPDATE_EVENT_QUEUE;

create or replace view D_BPM_UPDATE_EVENT_QUEUE_SV as 
select *
from BPM_UPDATE_EVENT_QUEUE
with read only;

alter table BPM_UPDATE_EVENT drop primary key drop index;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop column BUE_ID;


-- Step 2-I
delete from PROCESS_BPM_QUEUE_JOB_CONFIG where BDM_ID = 1;

commit;