create table D_CMOR_CURRENT
  (CMOR_BI_ID                     number,
   OUTREACH_SESSION_ID            number,
   REQUEST_DATE                   date,
   REQUESTED_BY                   varchar2(60),
   REQUEST_METHOD                 varchar2(256),
   SESSION_CREATED_BY             varchar2(80),
   SESSION_CREATE_DATE            date,
   EVENT_TYPE                     varchar2(256),
   CUR_SESSION_STATUS             varchar2(256),
   SESSION_STATUS_DATE            date,
   PUBLIC_ALLOWED_INDICATOR       varchar2(10),
   MULTILINGUAL_INDICATOR         varchar2(10),
   GROUP_INDIVIDUAL_INDICATOR     varchar2(10),
   ESTIMATED_ATTENDEES            varchar2(10),
   EVENT_DATE                     date,
   ALTERNATIVE_DATE_1             date,
   ALTERNATIVE_DATE_2             date,
   ALTERNATIVE_DATE_3             date,
   DURATION 			                varchar2(256),
   PREPARATION_TIME               varchar2(20),
   TRAVEL_TIME                    varchar2(20),
   PRESENTER_NAME                 varchar2(256),
   SITE_ID                        number(18,0),
   SITE_TYPE                      varchar2(256),
   SITE_LANGUAGE                  varchar2(512),
   SITE_CITY                      varchar2(40),
   SITE_ZIP_CODE                  varchar2(32),
   SITE_COUNTY                    varchar2(40),
   SITE_STATE                     varchar2(2),
   SITE_NAME                      varchar2(120),
   SITE_CAPACITY                  number(4,0) ,
   SITE_SERVICE_AREA              varchar2(256),
   SITE_STATUS                    varchar2(10),
   CONTACT_NAME                   varchar2(60),
   SESSION_UPDATED_BY             varchar2(80),
   SESSION_UPDATED_DT             date,
   NOTE_REF_ID                    number(18,0),
   RESCHEDULE_INDICATOR           varchar2(10),
   RECURRING_GROUP_ID             number(18,0),
   RECURRING_FREQUENCY            varchar2(256),
   NUMBER_OF_OCCURENCES           number(5,0) ,
   CLIENT_REG_REQ_INDICATOR       varchar2(10),
   SESSION_START_TIME             varchar2(256),
   SESSION_END_TIME               varchar2(256),
   DETAILS_SURVEY_ID              number(18,0),
   SURVEY_NAME                    varchar2(256),
   EVENT_TITLE                    varchar2(4000),
   LANGUAGES_SUPPORTED            varchar2(4000),
   EVENT_RECEIVED_FROM            varchar2(4000),
   EVENT_RECEIVED_VIA             varchar2(4000),
   GENERAL_PUBLIC_INDICATOR       varchar2(4000),
   SENIORS_INDICATOR              varchar2(4000),
   RESTRICTED_TO_AGENCY_INDICATOR varchar2(4000),
   SCHOOL_AGED_FAMILIES_INDICATOR varchar2(4000),
   MIGRANTS_INDICATOR             varchar2(4000),
   PREGNANT_WOMEN_TEENS_INDICATOR varchar2(4000),
   OTHER_GROUPS_INDICATOR         varchar2(4000),
   PLANS_TO_ATTEND                varchar2(4000),
   ALL_PLANS_INVITED_INDICATOR    varchar2(4000),
   STAR_INVITED_INDICATOR         varchar2(4000),
   STARPLUS_INVITED_INDICATOR     varchar2(4000),
   DENTAL_INVITED_INDICATOR       varchar2(4000),
   NORTHSTAR_INVITED_INDICATOR    varchar2(4000),
   PLAN_SPONSORED_INDICATOR       varchar2(4000),
   PLAN_EXCLUSIVE_INDICATOR       varchar2(4000),
   PLAN_RSVP_INDICATOR            varchar2(4000),
   RSVP_DEADLINE                  varchar2(4000),
   STAR_EVENT_INDICATOR           varchar2(4000),
   STAR_PLUS_EVENT_INDICATOR      varchar2(4000),
   NORTHSTAR_EVENT_INDICATOR      varchar2(4000),
   DENTAL_EVENT_INDICATOR         varchar2(4000),
   SURVEY_COMMENTS                varchar2(4000),
   COMPLETE_DATE                  date,
   CANCEL_DATE                    date,
   CANCEL_BY                      varchar2(80),
   CANCEL_REASON                  varchar2(40),
   CANCEL_METHOD                  varchar2(40),
   INSTANCE_STATUS                varchar2(10),
   REVIEW_EVENT_START_DATE        date,
   REVIEW_EVENT_END_DATE          date,
   REVIEW_EVENT_PERFORMED_BY      varchar2(256),
   WAIT_FOR_EVENT_START_DATE      date,
   WAIT_FOR_EVENT_END_DATE        date,
   RECORD_OUTCOME_START_DATE      date,
   RECORD_OUTCOME_END_DATE        date,
   RECORD_OUTCOME_PERFORMED_BY    varchar2(256),
   AGE_IN_BUSINESS_DAYS           number,
   AGE_IN_CALENDAR_DAYS           number,
   OUTREACH_CYCLE_TIME            number,
   JEOPARDY_FLAG                  varchar2(10),
   REVIEW_TIMELINESS_STATUS       varchar2(40),
   PUBLISH_TO_CAL_TIMELY_STATUS   varchar2(40),
   RCRD_OUTCOME_TIMELY_STATUS     varchar2(40),
INSTANCE_START_DATE DATE,
INSTANCE_END_DATE DATE)
tablespace MAXDAT_DATA parallel;

alter table D_CMOR_CURRENT add constraint DCMORCUR_PK primary key (CMOR_BI_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym D_CMOR_CURRENT for D_CMOR_CURRENT;
grant select on D_CMOR_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_CMOR_CURRENT_SV as
select * from D_CMOR_CURRENT 
with read only;

create or replace public synonym D_CMOR_CURRENT_SV for D_CMOR_CURRENT_SV;
grant select on D_CMOR_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_CMOR_CLIENT_SV  as
select 
  OUTREACH_CLIENT_ID,
  CLIENT_ID,
  CASE_ID,
  CLIENT_GENDER as OUTREACH_CLIENT_GENDER,
  CLIENT_RACE as OUTREACH_CLIENT_RACE,
  CLIENT_ETHNICITY as OUTREACH_CLIENT_ETHNICITY,
  CLIENT_ATTENDED_IND as CLIENT_ATTENDED_INDICATOR,
  CLIENT_SURVEY_COLLECTED_IND as CLIENT_SURVEY_COLLECTED_IND,
  CLIENT_CREATE_DT as CLIENT_CREATE_DATE,
  CLIENT_CREATED_BY as CLIENT_CREATED_BY,
  CLIENT_LAST_UPDATE_DT as CLIENT_UPDATE_DATE,
  CLIENT_LAST_UPDATED_BY as CLIENT_UPDATED_BY,
  OUTREACH_SESSION_ID
from CORP_ETL_COMM_OUTREACH_CLI_CHD  
with read only;


-------Outreach Activity View
create or replace view D_CMOR_ACTIVITIES_SV as
select * from CORP_ETL_COMMUNITY_ACTIVITIES
with read only;

create or replace public synonym D_CMOR_ACTIVITIES_SV for D_CMOR_ACTIVITIES_SV;
grant select on D_CMOR_ACTIVITIES_SV to MAXDAT_READ_ONLY;


-------Outreach Activity Details View
create or replace view D_CMOR_ACTIVITIES_DETAILS_SV as
select * from CORP_ETL_COMM_ACTY_DETAIL_CHLD
with read only;

create or replace public synonym D_CMOR_ACTIVITIES_DETAILS_SV for D_CMOR_ACTIVITIES_DETAILS_SV;
grant select on D_CMOR_ACTIVITIES_DETAILS_SV to MAXDAT_READ_ONLY;


----- D_CMOR_SESSION_STATUS   DCMORSS_ID  
create sequence SEQ_DCMORSS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_CMOR_SESSION_STATUS
  (DCMORSS_ID number not null, 
   SESSION_STATUS varchar2(50))  
tablespace MAXDAT_DATA;

alter table D_CMOR_SESSION_STATUS add constraint DCMORSS_PK primary key (DCMORSS_ID) using index tablespace MAXDAT_INDX;

create unique index DCMORSS_UIX1 on D_CMOR_SESSION_STATUS (SESSION_STATUS) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_CMOR_SESSION_STATUS for D_CMOR_SESSION_STATUS;
grant select on D_CMOR_SESSION_STATUS to MAXDAT_READ_ONLY;

create or replace view D_CMOR_SESSION_STATUS_SV as
select * from D_CMOR_SESSION_STATUS
with read only;

create or replace public synonym D_CMOR_SESSION_STATUS_SV for D_CMOR_SESSION_STATUS_SV;
grant select on D_CMOR_SESSION_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_CMOR_SESSION_STATUS (DCMORSS_ID,SESSION_STATUS) values (SEQ_DCMORSS_ID.NEXTVAL,null);
commit;


create sequence SEQ_FCMORBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_CMOR_BY_DATE
  (FCMORBD_ID number not null, 
   D_DATE date not null,
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   CMOR_BI_ID number not null,
   DCMORSS_ID number not null,
   LAST_UPDATE_BY_DATE 		date,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number )
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_CMOR_BY_DATE add constraint FCMORBD_PK primary key (FCMORBD_ID) using index tablespace MAXDAT_INDX;
alter table F_CMOR_BY_DATE add constraint FCMORBD_DCMORSS_FK foreign key (DCMORSS_ID) references D_CMOR_SESSION_STATUS (DCMORSS_ID);
alter table F_CMOR_BY_DATE add constraint FCMORBD_DCMORCUR_FK foreign key (CMOR_BI_ID) references D_CMOR_CURRENT (CMOR_BI_ID);

create unique index FCMORBD_UIX1 on F_CMOR_BY_DATE (FCMORBD_ID,D_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
create unique index FCMORBD_UIX2 on F_CMOR_BY_DATE (CMOR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCMORBD_IX1 on F_CMOR_BY_DATE (LAST_UPDATE_BY_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCMORBD_IXL1 on F_CMOR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMORBD_IXL2 on F_CMOR_BY_DATE (CMOR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMORBD_IXL3 on F_CMOR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCMORBD_IXL4 on F_CMOR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_CMOR_BY_DATE for F_CMOR_BY_DATE;
grant select on F_CMOR_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_CMOR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCMORBD_ID, 
  BUCKET_START_DATE D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from F_CMOR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select  
  FCMORBD_ID, 
  bdd.D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from 
  F_CMOR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCMORBD_ID, 
  bdd.D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from
  BPM_D_DATES bdd,
  F_CMOR_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCMORBD_ID, 
  bdd.D_DATE,
  CMOR_BI_ID,
  DCMORSS_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LAST_UPDATE_BY_DATE
from
  BPM_D_DATES bdd,
  F_CMOR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_CMOR_BY_DATE_SV for F_CMOR_BY_DATE_SV;
grant select on F_CMOR_BY_DATE_SV to MAXDAT_READ_ONLY;

