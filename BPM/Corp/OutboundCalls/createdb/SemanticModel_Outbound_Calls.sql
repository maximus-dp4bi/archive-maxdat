create table D_OBC_CURRENT
  (OBC_BI_ID number ,
   OUTBOUND_CALL_IDENTIFIER number not null,
   JOB_ID number not null,
   ROW_ID number not null,
   CASE_CIN varchar2(32 byte) not null,
   CAMPAIGN_ID varchar2(32 byte) not null,
   CAMPAIGN_INDICATOR varchar2(32 byte) not null,
   CREATE_DATE date not null,
   CASE_ID number ,
   CLIENT_ID number ,
   PROGRAM varchar2(32 byte) ,
   SUBPROGRAM varchar2(32 byte) ,
   LANGUAGE varchar2(32 byte) not null,
   ERROR_COUNT number ,
   ERROR_TEXT varchar2(2000 byte) ,
   JOB_PROCESSING_END_TIME date ,
/* 9/30/13 B.Thai exclude due to PHI
   STATE_REPORTED_HOME_PHONE varchar2(32 byte) ,
   CLIENT_REPORTED_HOME_PHONE varchar2(32 byte) ,
   CLIENT_REPORTED_CELL_PHONE varchar2(32 byte) ,
*/
   PHONE_NUMBERS_PROVIDED number not null,
   LETTER_MATERIALS_REQUEST_ID number ,
   NUMBER_OF_ATTEMPTS_REQUIRED number not null,
   NUMBER_OF_ATTEMPTS_MADE number ,
   DIAL_CYCLE_OUTCOME varchar2(32 byte) ,
   TRANSMIT_TO_DIALER_START_DATE date ,
   TRANSMIT_TO_DIALER_END_DATE date ,
   TRANSMIT_TO_DIALER_FLAG varchar2(1 byte) not null,
   PROCESS_OUTCOME_START_DATE date ,
   PROCESS_OUTCOME_END_DATE date ,
   PROCESS_OUTCOME_FLAG varchar2(1 byte) not null,
   COMPLETE_DATE date ,
   CANCEL_DATE date ,
   CANCEL_REASON varchar2(32 byte) ,
   CANCEL_METHOD varchar2(32 byte) ,
   INSTANCE_STATUS varchar2(10 byte) not null,
   AGE_IN_BUSINESS_DAYS number ,
   AGE_IN_CALENDAR_DAYS number ,
   TIMELINESS_STATUS varchar2(32 byte), 
   TIMELINESS_DAYS number ,
   TIMELINESS_DAYS_TYPE varchar2(32 byte) ,
   JEOPARDY_FLAG varchar2(32 byte) ,
   JEOPARDY_DATE date ,
   JEOPARDY_DAYS number, 
   JEOPARDY_DAYS_TYPE varchar2(32 byte), 
   TARGET_DAYS number)
tablespace MAXDAT_DATA parallel;

alter table D_OBC_CURRENT add constraint DOBCCUR_PK primary key (OBC_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DOBCCUR_UIX1 on D_OBC_CURRENT (OUTBOUND_CALL_IDENTIFIER) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_OBC_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_OBC_CURRENT_SV as
select * from D_OBC_CURRENT
with read only;

grant select on D_OBC_CURRENT_SV to MAXDAT_READ_ONLY;


-- Outbound Calls Child table 
create or replace view D_OBC_DETAIL_SV as
select CEPOCD_ID,
CEPOC_ID,
DIALER_ATTEMPT_ID,
CREATE_DT,
CAMPAIGN_INDICATOR,
CASE_CIN,
SUBPROGRAM,
CALL_START_DT,
CALL_END_DT,
CALL_RESULT,
CALL_RESULT_DEF,
ERROR_COUNT,
ERROR_TEXT,
PROCESSED_DT,
PROCESSED_IND,
JOB_ID,
ROW_ID,
UNABLE_TO_CONTACT_IND,
BAD_PHONE_NUMBER_IND,
OUTBOUND_DIAL_RECORD_ID 
from CORP_ETL_PROC_OUTBND_CALL_DTL
with read only;

grant select on D_OBC_DETAIL_SV to MAXDAT_READ_ONLY;


-- F_OBC_BY_DATE     FOBCBD_ID
create sequence SEQ_FOBCBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_OBC_BY_DATE 
  (FOBCBD_ID number not null,
   D_DATE date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   OBC_BI_ID number not null,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_OBC_BY_DATE add constraint FOBCBD_PK primary key (FOBCBD_ID) using index tablespace MAXDAT_INDX;

alter table F_OBC_BY_DATE add constraint FOBCBD_DOBCCUR_FK foreign key (OBC_BI_ID) references D_OBC_CURRENT(OBC_BI_ID);

create unique index FOBCBD_UIX1 on F_OBC_BY_DATE (OBC_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FOBCBD_UIX2 on F_OBC_BY_DATE (OBC_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FOBCBD_IXL1 on F_OBC_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL2 on F_OBC_BY_DATE (OBC_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL3 on F_OBC_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FOBCBD_IXL4 on F_OBC_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_OBC_BY_DATE to MAXDAT_READ_ONLY;


create or replace view F_OBC_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FOBCBD_ID,
  BUCKET_START_DATE D_DATE,
  OBC_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,  
  COMPLETION_COUNT
from F_OBC_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FOBCBD_ID,
  bdd.D_DATE,
  OBC_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,  
  COMPLETION_COUNT
from 
  F_OBC_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FOBCBD_ID,
  bdd.D_DATE,
  OBC_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,  
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_OBC_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FOBCBD_ID,
  bdd.D_DATE,
  OBC_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,  
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_OBC_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_OBC_BY_DATE_SV to MAXDAT_READ_ONLY;




