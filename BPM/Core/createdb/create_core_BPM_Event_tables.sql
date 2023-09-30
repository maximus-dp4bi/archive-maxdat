create table BPM_ACTIVITY_ATTRIBUTE 
  (BACA_ID number not null, 
   BEM_ID number not null, 
   BACL_ID number not null, 
   ACTIVITY_FLAG_NAME varchar2(30), 
   VALUE_ON_COMPLETE varchar2(30) not null , 
   FLOW_ORDER number not null)
tablespace MAXDAT_DATA;

alter table BPM_ACTIVITY_ATTRIBUTE add constraint BPM_ACTIVITY_ATTRIBUTE_PK primary key (BACA_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ACTIVITY_ATTRIBUTE add constraint BACA_UNK unique (BEM_ID , BACL_ID) using index tablespace MAXDAT_INDX;
    
grant select on BPM_ACTIVITY_ATTRIBUTE to MAXDAT_READ_ONLY;
    
create table BPM_ACTIVITY_EVENTS 
  (BACE_ID number not null, 
   BI_ID number not null, 
   BETL_ID number not null, 
   BACA_ID number not null, 
   EVENT_DATE date not null, 
   BPMS_PROCESSED varchar2(1))
tablespace MAXDAT_DATA;

alter table BPM_ACTIVITY_EVENTS add constraint BPM_ACTIVITY_EVENTS_PK primary key (BACE_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ACTIVITY_EVENTS add constraint BAE_UNK unique (BI_ID , BETL_ID , BACA_ID) using index tablespace MAXDAT_INDX;
    
grant select on BPM_ACTIVITY_EVENTS to MAXDAT_READ_ONLY;

create table BPM_ACTIVITY_EVENT_TYPE_LKUP 
  (BACETL_ID number not null, 
   EVENT_TYPE_NAME varchar2(20) not null, 
   EVENT_TYPE_ORDER number not null)
tablespace MAXDAT_DATA;

alter table BPM_ACTIVITY_EVENT_TYPE_LKUP add constraint BPM_ACT_EVENT_TYPE_LKUP_PK primary key (BACETL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ACTIVITY_EVENT_TYPE_LKUP add constraint BAETL_UNK unique (EVENT_TYPE_NAME) using index tablespace MAXDAT_INDX ;

grant select on BPM_ACTIVITY_EVENT_TYPE_LKUP to MAXDAT_READ_ONLY;

create table BPM_ACTIVITY_LKUP 
  (BACL_ID number not null, 
   BACTL_ID number not null, 
   ACTIVITY_NAME varchar2(50) not null)
tablespace MAXDAT_DATA;

alter table BPM_ACTIVITY_LKUP add constraint BPM_ACTIVITY_LKUP_PK primary key (BACL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ACTIVITY_LKUP add constraint BACL_UNK unique (BACTL_ID , ACTIVITY_NAME) using index tablespace MAXDAT_INDX;
    
grant select on BPM_ACTIVITY_LKUP to MAXDAT_READ_ONLY;

create table BPM_ACTIVITY_TYPE_LKUP 
  (BACTL_ID number not null, 
   ACTIVITY_TYPE_CD varchar2(1) not null, 
   ACTIVITY_TYPE_DESC varchar2(35) not null)
tablespace MAXDAT_DATA;

alter table BPM_ACTIVITY_TYPE_LKUP add constraint BPM_ACTIVITY_TYPE_LKUP_PK primary key (BACTL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ACTIVITY_TYPE_LKUP add constraint BATL_UNK unique (ACTIVITY_TYPE_CD) using index tablespace MAXDAT_INDX;

grant select on BPM_ACTIVITY_TYPE_LKUP to MAXDAT_READ_ONLY;

create table BPM_ATTRIBUTE 
  (BA_ID number not null, 
   BAL_ID number not null, 
   BEM_ID number not null, 
   WHEN_POPULATED varchar2(30) not null, 
   EFFECTIVE_DATE date not null, 
   END_DATE date not null,
   RETAIN_HISTORY_FLAG varchar2(1 byte))
tablespace MAXDAT_DATA;

alter table BPM_ATTRIBUTE add constraint BPM_ATTRIBUTE_PK primary key (BA_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ATTRIBUTE add constraint BPM_ATTRIBUTE_CK check (WHEN_POPULATED in ('CREATE','UPDATE','BOTH'));
alter table BPM_ATTRIBUTE add constraint BA_RETAIN_HISTORY_FLAG_CK check (RETAIN_HISTORY_FLAG in ('Y', 'N'));
alter table BPM_ATTRIBUTE add constraint BPM_ATTRIBUTE_UNK unique (BAL_ID,BEM_ID,EFFECTIVE_DATE) using index tablespace MAXDAT_INDX;

grant select on BPM_ATTRIBUTE to MAXDAT_READ_ONLY;

create table BPM_ATTRIBUTE_LKUP 
  (BAL_ID number not null, 
   BDL_ID number not null, 
   NAME varchar2(50) not null, 
   PURPOSE varchar2(1000) not null)
tablespace MAXDAT_DATA;

alter table BPM_ATTRIBUTE_LKUP add constraint BPM_ATTRIBUTE_LKUP_PK primary key (BAL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_ATTRIBUTE_LKUP add constraint BPM_ATTRIBUTE_LKUP_UNK unique (name , BDL_ID) using index tablespace MAXDAT_INDX;   
   
grant select on BPM_ATTRIBUTE_LKUP to MAXDAT_READ_ONLY;
    
create table BPM_DATA_MODEL
  (BDM_ID number not null,
   CODE varchar2(12) not null,
   NAME varchar2(12) not null)
tablespace MAXDAT_DATA;

alter table BPM_DATA_MODEL add constraint BPM_DATA_MODEL_PK primary key (BDM_ID) using index tablespace MAXDAT_INDX;

grant select on BPM_DATA_MODEL to MAXDAT_READ_ONLY;

create table BPM_ATTRIBUTE_STAGING_TABLE
  (BAST_ID number not null,
   BA_ID number not null,  
   BSL_ID number not null, 
   STAGING_TABLE_COLUMN varchar2(30) not null)
tablespace MAXDAT_DATA;

alter table BPM_ATTRIBUTE_STAGING_TABLE add constraint BAST_PK primary key (BAST_ID) using index tablespace MAXDAT_INDX;
create index BAST_BA_ID_IX1 on BPM_ATTRIBUTE_STAGING_TABLE (BA_ID) tablespace MAXDAT_INDX compute statistics;  

grant select on BPM_ATTRIBUTE_STAGING_TABLE to MAXDAT_READ_ONLY;

create table BPM_DATATYPE_LKUP 
  (BDL_ID number not null, 
   DATATYPE varchar2(35) not null) 
tablespace MAXDAT_DATA;

alter table BPM_DATATYPE_LKUP add constraint BPM_DATATYPE_LKUP_PK primary key (BDL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_DATATYPE_LKUP add constraint BD_UNK unique (DATATYPE) using index tablespace MAXDAT_INDX;   

grant select on BPM_DATATYPE_LKUP to MAXDAT_READ_ONLY;

-- For MicroStrategy MASH reporting.
create or replace view D_BPM_DATA_MODEL_SV as 
select 
  BDM_ID,
  CODE,
  name
from BPM_DATA_MODEL
with read only;

grant select on D_BPM_DATA_MODEL_SV to MAXDAT_READ_ONLY;

    
create table BPM_D_HOURS (D_HOUR number(2) not null) tablespace MAXDAT_DATA;

alter table BPM_D_HOURS add constraint BPM_D_HOURS_PK primary key (D_HOUR) using index tablespace MAXDAT_INDX;

grant select on BPM_D_HOURS to MAXDAT_READ_ONLY;

create table BPM_D_OPS_GROUP_TASK 
  (OPS_GROUP varchar2(50) not null, 
   TASK_TYPE varchar2(100) not null)
tablespace MAXDAT_DATA;

alter table BPM_D_OPS_GROUP_TASK add constraint BPM_D_OPS_GROUP_TASK_PK primary key (OPS_GROUP,TASK_TYPE);
alter index BPM_D_OPS_GROUP_TASK_PK rebuild tablespace MAXDAT_INDX;

grant select on BPM_D_OPS_GROUP_TASK to MAXDAT_READ_ONLY;

create or replace view D_OPS_GROUP_TASK as
select 
  OPS_GROUP, 
  TASK_TYPE "Task Type"
from BPM_D_OPS_GROUP_TASK
with read only;

grant select on D_OPS_GROUP_TASK to MAXDAT_READ_ONLY;

create table BPM_EVENT_MASTER 
  (BEM_ID number not null, 
   BRL_ID number not null, 
   BPRJ_ID number not null, 
   BPRG_ID number not null, 
   BPROL_ID number not null, 
   NAME varchar2(50) , 
   DESCRIPTION varchar2(1000) not null, 
   EFFECTIVE_DATE date not null, 
   END_DATE date not null)
tablespace MAXDAT_DATA;

comment on column BPM_EVENT_MASTER.BEM_ID is 'Surrogate ID populated by sequence value.';

alter table BPM_EVENT_MASTER add constraint BPM_EVENT_MASTER_PK primary key (BEM_ID) using index tablespace MAXDAT_INDX;
alter table BPM_EVENT_MASTER add constraint BPM_EVENT_MASTER unique (BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID) using index tablespace MAXDAT_INDX;
    
grant select on BPM_EVENT_MASTER to MAXDAT_READ_ONLY;

create table BPM_IDENTIFIER_TYPE_LKUP 
  (BIL_ID number not null, 
   NAME varchar2(35) not null) 
tablespace MAXDAT_DATA;

alter table BPM_IDENTIFIER_TYPE_LKUP add constraint BPM_IDENTIFIER_LKUP_PK primary key (BIL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_IDENTIFIER_TYPE_LKUP add constraint BPM_IDENTIFIER_LKUP_UNK unique (NAME) using index tablespace MAXDAT_INDX;

grant select on BPM_IDENTIFIER_TYPE_LKUP to MAXDAT_READ_ONLY;

create table BPM_LOGGING
  (BL_ID           number not null,
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
(partition PT_BL_LOG_DATE_LT_2012 values less than (TO_DATE('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA;

alter table BPM_LOGGING add constraint BPM_LOGGING_PK primary key (BL_ID) using index tablespace MAXDAT_INDX;

create index BPM_LOGGING_LX1 on BPM_LOGGING (LOG_DATE) local online tablespace MAXDAT_INDX compute statistics;
create index BPM_LOGGING_LX2 on BPM_LOGGING (BSL_ID) local online tablespace MAXDAT_INDX compute statistics;

alter table BPM_LOGGING add constraint BPM_LOGGING_LOG_LEVEL_CK 
check (LOG_LEVEL in ('SEVERE','WARNING','INFO','CONFIG','FINE','FINER','FINEST'));

grant select on BPM_LOGGING to MAXDAT_READ_ONLY;

create table BPM_PROCESS_FLOW 
  (BPF_ID number not null, 
   CURRENT_BACA_ID number not null, 
   COMPLETION_REQUIRED_BACA_ID number not null)
tablespace MAXDAT_DATA;

alter table BPM_PROCESS_FLOW add constraint BPM_PROCESS_FLOW_PK primary key (BPF_ID) using index tablespace MAXDAT_INDX;
alter table BPM_PROCESS_FLOW add constraint BPF_UNK unique (CURRENT_BACA_ID,COMPLETION_REQUIRED_BACA_ID) using index tablespace MAXDAT_INDX;  

grant select on BPM_PROCESS_FLOW to MAXDAT_READ_ONLY;

create table BPM_PROCESS_LKUP 
  (BPROL_ID number not null, 
   NAME varchar2(50) not null, 
   DESCRIPTION varchar2(250))
tablespace MAXDAT_DATA;

alter table BPM_PROCESS_LKUP add constraint BPM_PROCESS_LKUP_PK primary key (BPROL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_PROCESS_LKUP add constraint BPM_PROCESS_LKUP_UNK unique (NAME) using index tablespace MAXDAT_INDX;
    
grant select on BPM_PROCESS_LKUP to MAXDAT_READ_ONLY;

create table BPM_PROGRAM_LKUP 
  (BPRG_ID number not null, 
   NAME varchar2(35) not null) 
tablespace MAXDAT_DATA;

alter table BPM_PROGRAM_LKUP add constraint BPM_PROGRAM_LKUP_PK primary key (BPRG_ID) using index tablespace MAXDAT_INDX;
alter table BPM_PROGRAM_LKUP add constraint BPM_PROGRAM_UNK unique (NAME) using index tablespace MAXDAT_INDX;

grant select on BPM_PROGRAM_LKUP to MAXDAT_READ_ONLY;

create table BPM_PROJECT_LKUP 
  (BPRJ_ID number not null, 
   NAME varchar2(35) not null)
tablespace MAXDAT_DATA;

alter table BPM_PROJECT_LKUP add constraint PK_BPM_PROJECT_LKUP primary key (BPRJ_ID) using index tablespace MAXDAT_INDX;
alter table BPM_PROJECT_LKUP add constraint BPM_PROJECT_UNK unique (NAME) using index tablespace MAXDAT_INDX;

grant select on BPM_PROJECT_LKUP to MAXDAT_READ_ONLY;

create table BPM_REGION_LKUP 
  (BRL_ID number not null, 
   NAME varchar2(35) not null) 
tablespace MAXDAT_DATA;

comment on table BPM_REGION_LKUP is 'List of regions in MAXIMUS Health Services.';

alter table BPM_REGION_LKUP add constraint BPM_REGION_LKUP_PK primary key (BRL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_REGION_LKUP add constraint BPM_REGION_UNK unique (NAME) using index tablespace MAXDAT_INDX;

grant select on BPM_REGION_LKUP to MAXDAT_READ_ONLY;

create table BPM_SOURCE_LKUP 
  (BSL_ID number not null, 
   NAME varchar2(35) not null, 
   BSTL_ID number not null) 
tablespace MAXDAT_DATA;

alter table BPM_SOURCE_LKUP add constraint BPM_SOURCE_LKUP_PK primary key (BSL_ID) using index tablespace MAXDAT_INDX;
alter table BPM_SOURCE_LKUP add constraint BPM_SOURCE_LKUP_UNK unique (NAME) using index tablespace MAXDAT_INDX;  

grant select on BPM_SOURCE_LKUP to MAXDAT_READ_ONLY;

-- For MicroStrategy MASH reporting.
create or replace view D_BPM_SOURCE_LKUP_SV as 
select 
  BSL_ID,
  name,
  BSTL_ID
from BPM_SOURCE_LKUP
with read only;

grant select on D_BPM_SOURCE_LKUP_SV to MAXDAT_READ_ONLY;

create table BPM_SOURCE_TYPE_LKUP 
  (BSTL_ID number not null, 
   NAME varchar2(35) not null) 
tablespace MAXDAT_DATA;
	
alter table BPM_SOURCE_TYPE_LKUP add constraint BPM_SOURCE_TYPE_LKUP_PK primary key (BSTL_ID) using index tablespace MAXDAT_INDX;

grant select on BPM_SOURCE_TYPE_LKUP to MAXDAT_READ_ONLY;

create table BPM_UPDATE_TYPE_LKUP 
  (BUTL_ID number not null, 
   NAME varchar2(35) not null) 
tablespace MAXDAT_DATA;

alter table BPM_UPDATE_TYPE_LKUP add constraint BPM_UPDATE_TYPE_LKUP_PK primary key (BUTL_ID) using index tablespace MAXDAT_INDX;

alter table BPM_UPDATE_TYPE_LKUP add constraint BUTL_UNK unique (NAME) using index tablespace MAXDAT_INDX;

grant select on BPM_UPDATE_TYPE_LKUP to MAXDAT_READ_ONLY;

-- Foreign Keys.
alter table BPM_ACTIVITY_ATTRIBUTE add constraint BAA_BEM_FK foreign key(BEM_ID) references BPM_EVENT_MASTER(BEM_ID);
alter table BPM_ACTIVITY_ATTRIBUTE add constraint BACA_BACL_FK foreign key(BACL_ID) references BPM_ACTIVITY_LKUP(BACL_ID);
alter table BPM_ACTIVITY_EVENTS add constraint BACE_BACA_FK foreign key(BACA_ID) references BPM_ACTIVITY_ATTRIBUTE(BACA_ID);
alter table BPM_ACTIVITY_EVENTS add constraint BACE_BACETL_FK foreign key(BETL_ID) references BPM_ACTIVITY_EVENT_TYPE_LKUP(BACETL_ID);
alter table BPM_ACTIVITY_LKUP add constraint BACL_BACTL_FK foreign key(BACTL_ID) references BPM_ACTIVITY_TYPE_LKUP(BACTL_ID);
alter table BPM_ATTRIBUTE add constraint BA_BAL_FK foreign key (BAL_ID) references BPM_ATTRIBUTE_LKUP (BAL_ID);
alter table BPM_ATTRIBUTE add constraint BA_BEM_FK foreign key (BEM_ID) references BPM_EVENT_MASTER (BEM_ID);
alter table BPM_ATTRIBUTE_LKUP add constraint BAL_BDL_FK foreign key(BDL_ID) references BPM_DATATYPE_LKUP(BDL_ID);
--alter table BPM_ATTRIBUTE_STAGING_TABLE add constraint BAST_BA_FK foreign key(BA_ID) references BPM_ATTRIBUTE(BA_ID);
alter table BPM_ATTRIBUTE_STAGING_TABLE add constraint BAST_BSL_FK foreign key(BSL_ID) references BPM_SOURCE_LKUP(BSL_ID);
alter table BPM_EVENT_MASTER add constraint BEM_BPRG_FK foreign key(BPRG_ID) references BPM_PROGRAM_LKUP(BPRG_ID);
alter table BPM_EVENT_MASTER add constraint BEM_BPRJ_FK foreign key(BPRJ_ID) references BPM_PROJECT_LKUP(BPRJ_ID);
alter table BPM_EVENT_MASTER add constraint BEM_BPROL_FK foreign key(BPROL_ID) references BPM_PROCESS_LKUP(BPROL_ID);
alter table BPM_EVENT_MASTER add constraint BEM_BRL_FK foreign key(BRL_ID) references BPM_REGION_LKUP(BRL_ID);
alter table BPM_PROCESS_FLOW add constraint BPF_CUR_BACA_FK foreign key(CURRENT_BACA_ID) references BPM_ACTIVITY_ATTRIBUTE(BACA_ID);
alter table BPM_PROCESS_FLOW add constraint BPF_COMP_REQ_BACA_FK foreign key(COMPLETION_REQUIRED_BACA_ID) references BPM_ACTIVITY_ATTRIBUTE(BACA_ID);
alter table BPM_SOURCE_LKUP add constraint BSL_BSTL_FK foreign key(BSTL_ID) references BPM_SOURCE_TYPE_LKUP(BSTL_ID);
       