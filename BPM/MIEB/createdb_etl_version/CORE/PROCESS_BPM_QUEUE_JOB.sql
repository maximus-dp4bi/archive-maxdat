create table PBQJ_ADJUST_REASON_LKUP
  (PBQJ_ADJUST_REASON_ID number,
   ADJUST_TYPE varchar2(5) not null,
   REASON_NAME varchar2(30) not null,
   DESCRIPTION varchar2(100) not null)
tablespace &tablespace_name;

alter table PBQJ_ADJUST_REASON_LKUP add constraint PBQJ_ADJUST_REASON_LKUP_PK primary key (PBQJ_ADJUST_REASON_ID);
alter index PBQJ_ADJUST_REASON_LKUP_PK rebuild tablespace &tablespace_name parallel;

create unique index PBQJ_ADJUST_REASON_LKUP_UX1 on PBQJ_ADJUST_REASON_LKUP (REASON_NAME) tablespace &tablespace_name parallel;

insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (101,'START','ALL_PROC_ENABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = Y setting.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (102,'START','BSL_BDM_PROC_ENABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = Y setting.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (103,'START','MANUAL_START','Manual creation of job via procedure execute.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (111,'START','TOO_FEW_JOBS','Number of running jobs less than PROCESS_BPM_QUEUE_JOB_CONFIG.MIN_NUM_JOBS.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (130,'START','WORK_BACKLOG','Number of queue rows left to process is enough to need more jobs.');

insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (201,'STOP','ALL_PROC_DISABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = N setting.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (202,'STOP','BSL_BDM_PROC_DISABLED','PROCESS_BPM_QUEUE_JOB_CTRL_CFG.PROCESSING_ENABLED = N setting.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (203,'STOP','MANUAL_STOP','Manual stop of specific jobs via procedure execute.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (210,'STOP','TOO_MANY_TOTAL_JOBS','Number of running jobs exceeds PROCESS_BPM_QUEUE_JOB_CTRL_CFG.MAX_TOTAL_NUM_JOBS.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (211,'STOP','TOO_MANY_JOBS','Number of running jobs exceeds PROCESS_BPM_QUEUE_JOB_CONFIG.MAX_NUM_JOBS.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (220,'STOP','SLEEPING','Job was sleeping.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (240,'STOP','BAD_METADATA','Job had bad metadata.');
insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (241,'STOP','STARTED','Job was started but not running.');

commit;


create sequence SEQ_PBQJ_ID 
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 265
  increment by 1
  cache 20;

create table PROCESS_BPM_QUEUE_JOB
  (PBQJ_ID number not null,
   JOB_NAME varchar2(30) not null,
   BSL_ID number,
   BDM_ID number,
   BATCH_SIZE number,
   START_DATE date not null,
   END_DATE date,
   STATUS varchar2(10) not null,
   STATUS_DATE date not null,
   JOB_ADJUST_REASON_ID number,
   ENABLED varchar2(1) not null,
   START_REASON_ID number,
   STOP_REASON_ID number)
tablespace &tablespace_name parallel;

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_PK primary key (PBQJ_ID);
alter index PBQJ_PK rebuild tablespace &tablespace_name parallel;

create index PBQJ_IX1 on PROCESS_BPM_QUEUE_JOB (BSL_ID) tablespace &tablespace_name parallel;
create index PBQJ_IX2 on PROCESS_BPM_QUEUE_JOB (STATUS) tablespace &tablespace_name parallel;
create index PBQJ_UX1 on PROCESS_BPM_QUEUE_JOB (JOB_NAME) tablespace &tablespace_name parallel;

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_BSL_ID_FK
foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_BDM_ID_CK 
foreign key (BDM_ID) references BPM_DATA_MODEL (BDM_ID);

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_STATUS_CK 
check (STATUS in ('FAILED','LOCKING','PROCESSING','RESERVING','SLEEPING','STARTED','STOPPED'));

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_ENABLED_CK 
check (ENABLED in ('N','Y'));

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_START_REASON_ID_FK
foreign key (START_REASON_ID) references PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID);

alter table PROCESS_BPM_QUEUE_JOB add constraint PBQJ_STOP_REASON_ID_FK
foreign key (STOP_REASON_ID) references PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID);

-- For MicroStrategy MASH reporting.
create or replace view D_PROCESS_BPM_QUEUE_JOB_SV 
  (PBQJ_ID,
   JOB_NAME,
   BSL_ID,
   BDM_ID,
   BATCH_SIZE,
   START_DATE,
   END_DATE,
   STATUS,
   STATUS_DATE,
   ENABLED,
   START_REASON_ID,
   STOP_REASON_ID) as 
select
  PBQJ_ID,
  JOB_NAME,
  BSL_ID,
  BDM_ID,
  BATCH_SIZE,
  START_DATE,
  END_DATE,
  STATUS,
  STATUS_DATE,
  ENABLED,
  START_REASON_ID,
  STOP_REASON_ID
from PROCESS_BPM_QUEUE_JOB
with read only;


create sequence SEQ_PBQJB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table PROCESS_BPM_QUEUE_JOB_BATCH
  (PBQJB_ID number not null,
   PBQJ_ID  number not null,
   BATCH_ID number,
   PROCESS_BUEQ_ID number,
   BATCH_START_DATE date not null,
   BATCH_END_DATE date,
   LOCKING_START_DATE date,
   LOCKING_END_DATE date,
   RESERVE_START_DATE date,
   RESERVE_END_DATE date,
   PROC_XML_START_DATE date,
   PROC_XML_END_DATE date,
   NUM_SLEEP_SECONDS number default(0) not null,
   NUM_QUEUE_ROWS_IN_BATCH number default(0) not null,
   NUM_BPM_EVENT_INSERT number default(0) not null,
   NUM_BPM_EVENT_UPDATE number default(0) not null,
   NUM_BPM_SEMANTIC_INSERT number default(0) not null,
   NUM_BPM_SEMANTIC_UPDATE number default(0) not null,
   STATUS_DATE date not null)
storage (initial 64K)
partition by range (BATCH_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BE_ERROR_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))
tablespace &tablespace_name parallel;

alter table PROCESS_BPM_QUEUE_JOB_BATCH add constraint PBQJB_PK primary key (PBQJB_ID);
alter index PBQJB_PK  rebuild tablespace &tablespace_name parallel;

create index PBQJB_LX1 on PROCESS_BPM_QUEUE_JOB_BATCH (PBQJ_ID) local online tablespace &tablespace_name parallel compute statistics;
create index PBQJB_LX2 on PROCESS_BPM_QUEUE_JOB_BATCH (BATCH_START_DATE) local online tablespace &tablespace_name parallel compute statistics;

alter table PROCESS_BPM_QUEUE_JOB_BATCH add constraint PBQJB_PBQJ_ID_FK 
foreign key (PBQJ_ID) references PROCESS_BPM_QUEUE_JOB(PBQJ_ID);


-- For MicroStrategy MASH reporting.
create or replace view D_PROCESS_BPM_QUEUE_JOB_BAT_SV as 
select
  PBQJB_ID,
  PBQJ_ID,
  BATCH_ID,
  PROCESS_BUEQ_ID,
  BATCH_START_DATE,
  BATCH_END_DATE,
  LOCKING_START_DATE,
  LOCKING_END_DATE,
  RESERVE_START_DATE,
  RESERVE_END_DATE,
  PROC_XML_START_DATE,
  PROC_XML_END_DATE,
  NUM_SLEEP_SECONDS,
  NUM_QUEUE_ROWS_IN_BATCH,
  NUM_BPM_EVENT_INSERT,
  NUM_BPM_EVENT_UPDATE,
  NUM_BPM_SEMANTIC_INSERT,
  NUM_BPM_SEMANTIC_UPDATE,
  STATUS_DATE
from PROCESS_BPM_QUEUE_JOB_BATCH
with read only;


create table PROCESS_BPM_QUEUE_JOB_CTRL_CFG
  (MAX_TOTAL_NUM_JOBS number(4) not null,
   NUM_JOBS_TO_DEL_DURING_ADJUST number(3) not null,
   NUM_JOBS_TO_ADD_DURING_ADJUST number(3) not null,
   NUM_GROUP_CYCLES_BEFORE_ADD number(3) not null,
   CONTROL_JOB_SLEEP_SECONDS number(5) not null,
   LOCK_TIMEOUT_SECONDS number(5) not null,
   PROCESS_SLEEP_SECONDS number(5) not null,
   PROCESS_BATCH_SECONDS number(5) not null,
   START_DELAY_SECONDS number(5) not null,
   STOP_DELAY_SECONDS number(5) not null,
   PROCESSING_ENABLED varchar2(1) not null)
tablespace &tablespace_name;

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_TOTAL_MAX_NUM_JOBS_CK 
check (MAX_TOTAL_NUM_JOBS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_NUM_JOBS_TO_DEL_ADJ_CK
check (NUM_JOBS_TO_DEL_DURING_ADJUST >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_NUM_JOBS_TO_ADD_ADJ_CK
check (NUM_JOBS_TO_ADD_DURING_ADJUST >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_NUM_GC_BEFORE_ADD_CK
check (NUM_GROUP_CYCLES_BEFORE_ADD >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_LOCK_TIMEOUT_SECONDS_CK 
check (LOCK_TIMEOUT_SECONDS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_PROC_SLEEP_SECONDS_CK 
check (PROCESS_SLEEP_SECONDS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_PROC_BATCH_SECONDS_CK 
check (PROCESS_BATCH_SECONDS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_START_DELAY_SECONDS_CK 
check (START_DELAY_SECONDS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CTRL_CFG add constraint PBQJCC_STOP_DELAY_SECONDS_CK 
check (STOP_DELAY_SECONDS >= 0);

insert into PROCESS_BPM_QUEUE_JOB_CTRL_CFG 
  (MAX_TOTAL_NUM_JOBS,NUM_JOBS_TO_DEL_DURING_ADJUST,NUM_JOBS_TO_ADD_DURING_ADJUST,
   NUM_GROUP_CYCLES_BEFORE_ADD,CONTROL_JOB_SLEEP_SECONDS,LOCK_TIMEOUT_SECONDS,PROCESS_SLEEP_SECONDS,
   PROCESS_BATCH_SECONDS,START_DELAY_SECONDS,STOP_DELAY_SECONDS,PROCESSING_ENABLED) 
values (64,1,4,2,30,300,120,10,10,5,'Y');

commit;


create sequence SEQ_PBQJC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1;

create table PROCESS_BPM_QUEUE_JOB_CONFIG
  (PBQJC_ID number not null,
   BSL_ID number not null,
   BDM_ID number not null,
   MIN_NUM_JOBS number(3),
   INIT_NUM_JOBS number(3),
   MAX_NUM_JOBS number(3),
   BATCH_SIZE number(5),
   ENABLED varchar2(1) not null)
tablespace &tablespace_name;

alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_PK primary key (PBQJC_ID);
alter index PBQJC_PK rebuild tablespace &tablespace_name parallel;

alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_MIN_NUM_JOBS_CK 
check (MIN_NUM_JOBS is null or MIN_NUM_JOBS >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_INT_NUM_JOBS_CK 
check (INIT_NUM_JOBS is null or (INIT_NUM_JOBS >= 0 and (MIN_NUM_JOBS is null or INIT_NUM_JOBS >= MIN_NUM_JOBS)));

alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_MAX_NUM_JOBS_CK 
check (MAX_NUM_JOBS is null or (MAX_NUM_JOBS >= 0 
  and (MIN_NUM_JOBS is null or MAX_NUM_JOBS >= MIN_NUM_JOBS)
  and (INIT_NUM_JOBS is null or MAX_NUM_JOBS >= INIT_NUM_JOBS)));
  
alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_BATCH_SIZE_CK 
check (BATCH_SIZE is null or BATCH_SIZE >= 0);

alter table PROCESS_BPM_QUEUE_JOB_CONFIG add constraint PBQJC_ENABLED_CK 
check (ENABLED in ('N','Y'));

create unique index PBQJC_UX1 on PROCESS_BPM_QUEUE_JOB_CONFIG (BSL_ID,BDM_ID) tablespace &tablespace_name parallel;

insert into PROCESS_BPM_QUEUE_JOB_CONFIG 
  (PBQJC_ID,BSL_ID,BDM_ID,MIN_NUM_JOBS,INIT_NUM_JOBS,MAX_NUM_JOBS,BATCH_SIZE,ENABLED)
values (SEQ_PBQJC_ID.nextval,0,0,1,2,24,100,'Y');

commit;


create sequence SEQ_PBCJC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1;

create table PROCESS_BPM_CALC_JOB_CONFIG
  (PBCJC_ID number not null,
   PACKAGE_NAME varchar2(30) not null,
   PROCEDURE_NAME varchar2(30) not null,
   PROCESS_ENABLED varchar2(1) not null)
tablespace &tablespace_name;

alter table PROCESS_BPM_CALC_JOB_CONFIG add constraint PBCJC_PK primary key (PBCJC_ID);
alter index PBCJC_PK rebuild tablespace &tablespace_name parallel;

create unique index PBCJC_UX1 on PROCESS_BPM_CALC_JOB_CONFIG (PACKAGE_NAME,PROCEDURE_NAME) tablespace &tablespace_name parallel;