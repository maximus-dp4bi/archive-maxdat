-- Create Semantic Data Model for Manage Job process.

create table D_MJ_CURRENT
  (MJ_BI_ID number,
   JOB_ID number,
   CREATE_DATE date,
   CREATED_BY varchar2(80),
   JOB_NAME varchar2(500),
   JOB_DETAIL varchar2(500),
   JOB_GROUP varchar2(80),
   JOB_TYPE varchar2(32),
   JOB_START_DATE date,
   JOB_END_DATE date,
   JOB_STATUS varchar2(100),
   FILE_NAME varchar2(50),
   RECEIPT_DATE date,
   TRANSMIT_DATE  date,
   FILE_TYPE varchar2(50),
   FILE_SOURCE varchar2(50),
   FILE_DESTINATION varchar2(50),
   HEALTH_PLAN_NAME varchar2(50),
   RESPONSE_FILE_REQUIRED varchar2(50),
   RECORD_COUNT number,
   RECORD_ERROR_COUNT number,
   RESPONSE_FILE_NAME varchar2(50),
   LAST_UPDATE_BY_NAME varchar2(50), --HISTORY
   LAST_UPDATE_BY_DATE date, --HISTORY
   IDENTIFY_JOB_START_DATE date,
   IDENTIFY_JOB_END_DATE date,
   PROCESS_JOB_START_DATE date,
   PROCESS_JOB_END_DATE date,
   CREATE_REPONSE_FILE_START_DATE date,
   CREATE_RESPONSE_FILE_END_DATE date,
   CREATE_OUTBOUND_START_DATE date,
   CREATE_OUTBOUND_END_DATE date,
   IDENTIFY_JOB_TYPE_FLAG varchar2(1),
   PROCESS_JOB_FLAG varchar2(1),
   RESPONSE_FILE_FLAG varchar2(1),
   OUTBOUND_FILE_FLAG varchar2(1),
   PROCESSED_OK_FLAG varchar2(1),
   JOB_TYPE_FLAG varchar2(1),
   RESPONSE_FILE_GTW_FLAG varchar2(1),
   COMPLETE_DATE date,
   INSTANCE_STATUS varchar2(10),
   CANCEL_DATE date,
   CANCEL_BY varchar2(80),
	 CANCEL_REASON varchar2(100), --CALCULATED
   CANCEL_METHOD varchar2(40),
	 FILE_RECEIVED_TIMELY varchar2(32), --CALCULATED
	 RECORD_COUNT_THRESHOLD_MET varchar2(32), --CALCULATED
	 RECORD_ERROR_PERCENTAGE number, --CALCULATED
	 RECORD_ERROR_THRESHOLD varchar2(32), --CALCULATED
	 FILE_PROCESSED_TIMELY varchar2(32), --CALCULATED
	 FILE_PROCESS_TIME 	varchar2(20)) --CALCULATED
tablespace MAXDAT_DATA parallel;

alter table D_MJ_CURRENT_PK add constraint DMJCUR_PK primary key (MJ_BI_ID) using index tablespace MAXDAT_INDX;

create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;


----- D_MJ_LAST_UPDATE_BY   DIMJLUB_ID 
-- SEQ_DIMJLUB_ID is named non-standard.  Has reference to ILEB.  Should be SEQ_DMJLUB_ID.
create sequence SEQ_DIMJLUB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

-- DIMJLUB_ID is named non-standard.  Has reference to ILEB.  Should be DMJLUB_ID.
create table D_MJ_LAST_UPDATE_BY
  (DIMJLUB_ID number not null, 
   LAST_UPDATE_BY_NAME varchar2(50))
tablespace MAXDAT_DATA parallel;

alter table D_MJ_LAST_UPDATE_BY add constraint DMJLUB_PK primary key (DMJLUB_ID) using index tablespace MAXDAT_INDX;

create unique index DMJLUB_UIX1 on D_MJ_LAST_UPDATE_BY (LAST_UPDATE_BY_NAME) tablespace MAXDAT_INDX;   

create or replace view D_MJ_LAST_UPDATE_BY_SV as
select * from D_MJ_LAST_UPDATE_BY
with read only;

insert into D_MJ_LAST_UPDATE_BY (DIMJLUB_ID,LAST_UPDATE_BY_NAME) values (SEQ_DIMJLUB_ID.nextval,null);
commit;


-- SEQ_FIMJBD_ID is named non-standard.  Has reference to ILEB.  Should be SEQ_FMJBD_ID.
create sequence SEQ_FIMJBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

-- FIMJBD_ID is named non-standard.  Has reference to ILEB.  Should be FMJBD_ID.
create table F_MJ_BY_DATE
  (FIMJBD_ID number not null, 
   D_DATE date not null, 
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   MJ_BI_ID number not null, 
	 DIMJLUB_ID number not null, 
	 LAST_UPDATE_BY_DATE date,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number)
tablespace MAXDAT_DATA parallel;

alter table F_MJ_BY_DATE add constraint FMJBD_PK primary key (FIMJBD_ID) using index tablespace MAXDAT_INDX;

alter table F_MJ_BY_DATE add constraint FMJBD_DMJLUB_FK foreign key (DIMJLUB_ID) references D_MJ_LAST_UPDATE_BY(DIMJLUB_ID);
alter table F_MJ_BY_DATE add constraint FMJBD_DMJCUR_FK foreign key (MJ_BI_ID) references D_MJ_CURRENT(MJ_BI_ID);

create unique index FMRBD_UIX1 on F_MJ_BY_DATE(FIMJBD_ID,D_DATE) tablespace MAXDAT_INDX;
create unique index FMRBD_UIX2 on F_MJ_BY_DATE(FIMJBD_ID,BUCKET_START_DATE) tablespace MAXDAT_INDX;
create unique index FMRBD_UIX3 on F_MJ_BY_DATE(FIMJBD_ID,BUCKET_END_DATE) tablespace MAXDAT_INDX;

create or replace view F_MJ_BY_DATE_SV as
select
  FIMJBD_ID, 
  BDD.D_DATE, 
  MJ_BI_ID, 
  DIMJLUB_ID,
  case 
   when dense_rank() over (partition by MJ_BI_ID order by MJ_BI_ID asc, BDD.D_DATE asc) = 1 then 1
   else 0
   end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES BDD,
  F_MJ_BY_DATE FIMJRBD
where
  BDD.D_DATE >= FIMJRBD.BUCKET_START_DATE 
  and BDD.D_DATE < FIMJRBD.BUCKET_END_DATE
union all
select
  FIMJBD_ID, 
  BDD.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES BDD,
  F_MJ_BY_DATE FIMJRBD
where
  BDD.D_DATE = FIMJRBD.BUCKET_START_DATE 
  and BDD.D_DATE = FIMJRBD.BUCKET_END_DATE
with read only;
   
commit;  





