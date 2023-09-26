create table D_SCI_CURRENT
  (SCI_BI_ID number,
   CONTACT_RECORD_ID number not null,
   CONTACT_TYPE	varchar2(64), 
   PARENT_RECORD_ID number,
   TRACKING_NUMBER varchar2(32),
   CREATED_BY_NAME varchar2(32), 
   CREATED_BY_UNIT varchar2(256),
   CREATED_BY_ROLE varchar2(50),
   CREATE_DATE date, 
   COMPLETE_DATE date, 
   CONTACT_START_TIME date, 
   CONTACT_END_TIME date, 
   HANDLE_TIME number, 
   CONTACT_GROUP varchar2(256), 
   LANGUAGE varchar2(256), 
   TRANSLATION_REQUIRED varchar2(1), 
   EXT_TELEPHONY_REF varchar2(32),
   PARTICIPANT_STATUS	varchar2(15), 
   NOTE_CATEGORY varchar2(32), 
   NOTE_TYPE varchar2(32), 
   NOTE_SOURCE varchar2(80), 
   NOTE_PRESENT varchar2(1),
   CONTACT_RECORD_FIELD_1	varchar2(80), 
   CONTACT_RECORD_FIELD_2	varchar2(80), 
   CONTACT_RECORD_FIELD_3	varchar2(80), 
   CONTACT_RECORD_FIELD_4 varchar2(80), 
   CONTACT_RECORD_FIELD_5 varchar2(80),
   HANDLE_CALL_WEBCHAT_START_DATE date, 
   HANDLE_CALL_WEBCHAT_END_DATE date, 
   HANDLE_CALL_WEBCHAT_PERF_BY varchar2(100), 
   CREATE_ROUTE_WORK_START_DATE date, 
   CREATE_ROUTE_WORK_END_DATE date, 
   INSTANCE_STATUS varchar2(10), 
   CANCEL_DATE date, 
   LAST_UPDATE_BY_NAME varchar2(100), 
   LAST_UPDATE_DATE date,
   HANDLE_CONTACT_FLAG varchar2(1),
   CREATE_ROUTE_WORK_FLAG varchar2(100),
   CANCEL_CONTACT_FLAG varchar2(100),
   WORK_IDENTIFIED_FLAG varchar2(1),
   CANCEL_METHOD varchar2(50), 
   CANCEL_REASON varchar2(256),
   CANCEL_BY varchar2(50))
tablespace MAXDAT_DATA parallel;

alter table D_SCI_CURRENT add constraint DSCICUR_PK primary key (SCI_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DSCICUR_UIX1 on D_SCI_CURRENT (CONTACT_RECORD_ID) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_SCI_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_SCI_CURRENT_SV as
select * from D_SCI_CURRENT
with read only;


create sequence SEQ_FSCIBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_SCI_BY_DATE 
  (FSCIBD_ID number not null,
   D_DATE date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   SCI_BI_ID number not null,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_SCI_BY_DATE add constraint FSCIBD_PK primary key (FSCID_ID) using index tablespace MAXDAT_INDX;

alter table F_SCI_BY_DATE add constraint FSCIBD_DSCICUR_FK foreign key (SCI_BI_ID) references D_SCI_CURRENT(SCI_BI_ID);

create unique index FSCIBD_UIX1 on F_SCI_BY_DATE (SCI_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FSCIBD_UIX2 on F_SCI_BY_DATE (SCI_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FSCIBD_IXL1 on F_SCI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL2 on F_SCI_BY_DATE (SCI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL3 on F_SCI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FSCIBD_IXL4 on F_SCI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_SCI_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_SCI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FSCIBD_ID,
  BUCKET_START_DATE D_DATE,
  SCI_BI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_SCI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FSCIBD_ID,
  bdd.D_DATE,
  SCI_BI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_SCI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FSCIBD_ID,
  bdd.D_DATE,
  SCI_BI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_SCI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FSCIBD_ID,
  bdd.D_DATE,
  SCI_BI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_SCI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_SCI_BY_DATE_SV to MAXDAT_READ_ONLY;


create or replace view D_SCID_CURRENT_SV as
select 
  CONTACT_RECORD_ID,
  CONTACT_RECORD_LINK_ID,
  CLIENT_ID,
  CASE_ID,
  PROGRAM_TYPE program,
  PROGRAM_SUBTYPE subprogram,
  CLIENT_UNDER_TWENTYONE,
  RESIDENCE_COUNTY,
  SERVICE_AREA,
  REGION
from CORP_ETL_CLIENT_INQUIRY_DTL
with read only;

grant select on D_SCID_CURRENT_SV to MAXDAT_READ_ONLY;

/*create or replace view D_SCIE_CURRENT_SV as
select
  CONTACT_RECORD_ID,
  EVENT_ID,
  EVENT_CREATED_BY event_created_by_name,
  EVENT_CREATE_DT event_create_date,
  SUPP_EVENT_CONTEXT,
  EVENT_ACTION,
  MANUAL_ACTION_CATEGORY,
  EVENT_REF_ID event_reference_id,
  EVENT_REF_TYPE event_reference_type
from CORP_ETL_CLIENT_INQUIRY_EVENT
with read only;*/ -- This view has been replaced with the below as the ETL was not populating Manual Action events in EVENT_ACTION column

create or replace view D_SCIE_CURRENT_SV as
select
  CONTACT_RECORD_ID,
  EVENT_ID,
  EVENT_CREATED_BY event_created_by_name,
  EVENT_CREATE_DT event_create_date,
  SUPP_EVENT_CONTEXT,
  (CASE WHEN a.EVENT_ACTION = 'Manual Action' THEN (SELECT out_var 
  FROM corp_etl_list_lkup lkup
  WHERE lkup.name       = 'CLIENT_INQUIRY_MANUAL_ACTION' 
  and a.supp_event_context=lkup.value) 
  ELSE (a.EVENT_ACTION) END)EVENT_ACTION,
  MANUAL_ACTION_CATEGORY,
  EVENT_REF_ID event_reference_id,
  EVENT_REF_TYPE event_reference_type
from CORP_ETL_CLIENT_INQUIRY_EVENT a
with read only;

grant select on D_SCIE_CURRENT_SV to MAXDAT_READ_ONLY;

