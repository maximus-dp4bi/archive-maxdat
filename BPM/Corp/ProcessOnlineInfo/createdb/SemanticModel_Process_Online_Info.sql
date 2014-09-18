--D_ONL_CURRENT dimension table
create table D_ONL_CURRENT
  (ONL_BI_ID                    number,
   TRANSACTION_ID               number,
   TRANSACTION_TYPE             varchar2(50),
   CREATE_DATE                  date,
   CREATE_BY_NAME               varchar2(80),
   CASE_ID                      number,
   CLIENT_ID                    number,
   WORK_REQUIRED_FLAG           varchar2(1),
   CUR_INSTANCE_STATUS          varchar2(10),
   SOURCE_RECORD_TYPE           varchar2(50),
   SOURCE_RECORD_ID             number,
   LAST_UPDATE_DATE             date,
   LAST_UPDATED_BY_NAME         varchar2(80),
   LANGUAGE                     varchar2(2),
   PROCESS_NEW_INFO_START_DATE  date,
   PROCESS_NEW_INFO_END_DATE    date,
   PROCESS_NEW_INFO_FLAG        varchar2(1),
   CREATE_ROUTE_WORK_START_DATE date,
   CREATE_ROUTE_WORK_END_DATE   date,
   CREATE_ROUTE_WORK_FLAG       varchar2(1),
	  WORK_IDENTIFIED_FLAG        varchar2(1),
   CANCEL_REASON                varchar2(50),
   CANCEL_METHOD                varchar2(32),
   CANCEL_BY                    varchar2(80),
   CANCEL_DATE                  date,
   COMPLETE_DATE                date,
   AGE_IN_BUSINESS_DAYS         number,
   AGE_IN_CALENDAR_DAYS         number,
   TIMELINESS_STATUS            varchar2(20),
   JEOPARDY_STATUS              varchar2(1),
   SLA_DAYS                     number,
   SLA_DAYS_TYPE                varchar2(1),
   SLA_TARGET_DAYS              number,
   JEOPARDY_DAYS                number,
   JEOPARDY_DAYS_TYPE           varchar2(1),
   JEOPARDY_TARGET_DAYS         number,
   JEOPARDY_DATE                date)
tablespace MAXDAT_DATA parallel;

alter table D_ONL_CURRENT add constraint DONLCUR_PK primary key (ONL_BI_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym D_ONL_CURRENT for D_ONL_CURRENT;
grant select on D_ONL_CURRENT to MAXDAT_READ_ONLY;
  
create or replace view D_ONL_CURRENT_SV as
select * from D_ONL_CURRENT 
with read only;  

create or replace public synonym D_ONL_CURRENT_SV for D_ONL_CURRENT_SV;
grant select on D_ONL_CURRENT_SV to MAXDAT_READ_ONLY;


--D_ONL_INSTANCE_STATUS dimension table 
create sequence SEQ_DONLIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_ONL_INSTANCE_STATUS
  (DONLIS_ID number not null, 
  INSTANCE_STATUS varchar2(50))  
tablespace MAXDAT_DATA parallel;

alter table D_ONL_INSTANCE_STATUS add constraint DONLIS_PK primary key (DONLIS_ID)using index tablespace MAXDAT_INDX;

create unique index DONLIS_PK_UIX1 on D_ONL_INSTANCE_STATUS(INSTANCE_STATUS) tablespace MAXDAT_INDX parallel compute statistics;   

create or replace public synonym D_ONL_INSTANCE_STATUS for D_ONL_INSTANCE_STATUS;
grant select on D_ONL_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_ONL_INSTANCE_STATUS_SV as
select * from D_ONL_INSTANCE_STATUS
with read only;

create or replace public synonym D_ONL_INSTANCE_STATUS_SV for D_ONL_INSTANCE_STATUS_SV;
grant select on D_ONL_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_ONL_INSTANCE_STATUS (DONLIS_ID,INSTANCE_STATUS) values (SEQ_DONLIS_ID.NEXTVAL,null);
commit;


--F_ONL_BY_DATE fact table 
create sequence SEQ_FONLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_ONL_BY_DATE
  (FONLBD_ID number not null, 
   D_DATE date not null,
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   ONL_BI_ID number not null,
   DONLIS_ID number not null,
   LAST_UPDATE_BY_DATE date,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_ONL_BY_DATE add constraint FONLBD_PK primary key (FONLBD_ID)using index tablespace MAXDAT_INDX;

alter table F_ONL_BY_DATE add constraint FONLBD_DONLCUR_FK foreign key (ONL_BI_ID) references D_ONL_CURRENT (ONL_BI_ID);
alter table F_ONL_BY_DATE add constraint FONLBD_DONLIS_FK foreign key (DONLIS_ID) references D_ONL_INSTANCE_STATUS (DONLIS_ID);

create unique index FONLBD_UIX1 on F_ONL_BY_DATE (ONL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FONLBD_UIX2 on F_ONL_BY_DATE (ONL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FONLBD_IX1 on F_ONL_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FONLBD_IXL1 on F_ONL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL2 on F_ONL_BY_DATE (ONL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL3 on F_ONL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL4 on F_ONL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_ONL_BY_DATE for F_ONL_BY_DATE;
grant select on F_ONL_BY_DATE to MAXDAT_READ_ONLY;


create or replace view F_ONL_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FONLBD_ID, 
  BUCKET_START_DATE D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_ONL_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_ONL_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_ONL_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FONLBD_ID, 
  bdd.D_DATE,
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_ONL_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_ONL_BY_DATE_SV for F_ONL_BY_DATE_SV;
grant select on F_ONL_BY_DATE_SV to MAXDAT_READ_ONLY;
