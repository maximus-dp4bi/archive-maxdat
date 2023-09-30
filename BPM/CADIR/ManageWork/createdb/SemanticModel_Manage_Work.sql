-- Create Semantic Data Model for Manage Work process.

create table D_MW_CURRENT
  ( MW_BI_ID                       number not null,
   "Task ID"                       number,
   "Age in Business Days"          number not null,
   "Age in Calendar Days"          number not null,
   "Create Date"                   date not null,
   "Complete Date"                 date,
   "Jeopardy Flag"                 varchar2(1) not null,
   "SLA Days"                      number,
   "SLA Days Type"                 varchar2(1),
   "SLA Jeopardy Days"             number,
   "SLA Target Days"               number,
   "Timeliness Status"             varchar2(20) not null,
   "Cancel Work Date"              date,
   "Cancel Work Flag"              varchar2(1) not null,
   "Complete Flag"                 varchar2(1) not null,
   "Created By Name"               varchar2(100),
   "Source Reference ID"           number,
   "Source Reference Type"         varchar2(30),
   "Status Age in Business Days"   number not null,
   "Status Age in Calendar Days"   number not null,
   "Unit of Work"                  varchar2(30),
   "Current Escalated Flag"        varchar2(1) not null,
   "Current Escalated To Name"     varchar2(100),
   "Current Forwarded By Name"     varchar2(100),
   "Current Forwarded Flag"        varchar2(1) not null,
   "Current Group Name"            varchar2(100),
   "Current Group Parent Name"     varchar2(100),
   "Current Group Supervisor Name" varchar2(100),
   "Current Last Update By Name"   varchar2(100),
   "Current Owner Name"            varchar2(100),
   "Current Task Status"           varchar2(50) not null,
   "Current Task Type"             varchar2(100) not null,
   "Current Team Name"             varchar2(100),
   "Current Team Parent Name"      varchar2(100),
   "Current Team Supervisor Name"  varchar2(100), 
    CLIENT_ID                      number,
    CASE_ID                        number,
   "Current Last Update Date"      date not null,
   "Current Status Date"           date not null,
   "Cancel By"                     varchar2(50),
   "Cancel Reason"                 varchar2(256),
   "Cancel Method"                 varchar2(50),
    TASK_PRIORITY                  varchar2(50),
    SOURCE_COMPLETE_DATE           date,
    received_date                  date,
    assigned_date                  date,
    case_number                    varchar2(100)
) 
tablespace MAXDAT_DATA parallel;

alter table D_MW_CURRENT add constraint DMWCUR_PK primary key (MW_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DMWCUR_UIX1 on D_MW_CURRENT ("Task ID") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_MW_CURRENT_SV as
select
  MW_BI_ID,
  "Task ID",
  "Age in Business Days",
  "Age in Calendar Days",
  "Create Date",
  "Complete Date",
  case
    when ("SLA Days Type" = 'B' and "Age in Business Days" is not null and "SLA Jeopardy Days" is not null and "Age in Business Days" >= "SLA Jeopardy Days")
      or ("SLA Days Type" = 'C' and "Age in Calendar Days" is not null and "SLA Jeopardy Days" is not null and "Age in Calendar Days" >= "SLA Jeopardy Days") then
      'Y'
    else
      'N'
    end "Jeopardy Flag",
  "SLA Days",
  "SLA Days Type",
  "SLA Jeopardy Days",
  "SLA Target Days",
  "Timeliness Status",
  "Cancel Work Date",
  "Cancel Work Flag",
  "Complete Flag",
  "Created By Name",
  "Source Reference ID",
  "Source Reference Type",
  "Status Age in Business Days", 
  "Status Age in Calendar Days",
  "Unit of Work",
  "Current Escalated Flag",
  "Current Escalated To Name",
  "Current Forwarded By Name",
  "Current Forwarded Flag",
  "Current Group Name",
  "Current Group Parent Name",
  "Current Group Supervisor Name",
  "Current Last Update By Name",
  "Current Owner Name",
  "Current Task Status",
  "Current Task Type",
  "Current Team Name",
  "Current Team Parent Name",
  "Current Team Supervisor Name",
  CLIENT_ID,  -- 8/28/13 Renamed from "Client_ID"
  CASE_ID,    -- 8/28/13 Renamed from "Case_ID"
  "Current Last Update Date",
  "Current Status Date",
  "Cancel By",
  "Cancel Reason",
  "Cancel Method",
  TASK_PRIORITY,
  SOURCE_COMPLETE_DATE,
  received_date,
  assigned_date,
  case_number
from D_MW_CURRENT
with read only;

grant select on D_MW_CURRENT_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DMWE_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_ESCALATED
  (DMWE_ID number not null,
   "Escalated Flag" varchar2(1) not null,
   "Escalated To Name" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_MW_ESCALATED add constraint DMWE_PK primary key (DMWE_ID) using index tablespace MAXDAT_INDX;

create unique index DMWE_UIX1 on D_MW_ESCALATED ("Escalated Flag","Escalated To Name") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_ESCALATED to MAXDAT_READ_ONLY;

create or replace view D_MW_ESCALATED_SV as
select * from D_MW_ESCALATED
with read only;

grant select on D_MW_ESCALATED_SV to MAXDAT_READ_ONLY;

insert into D_MW_ESCALATED (DMWE_ID,"Escalated Flag","Escalated To Name") values (SEQ_DMWE_ID.nextval,'N',null);
insert into D_MW_ESCALATED (DMWE_ID,"Escalated Flag","Escalated To Name") values (SEQ_DMWE_ID.nextval,'Y',null);
commit;


create sequence SEQ_DMWF_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_FORWARDED
  (DMWF_ID number not null,
   "Forwarded By Name" varchar2(100),
   "Forwarded Flag" varchar2(1) not null)
tablespace MAXDAT_DATA;

alter table D_MW_FORWARDED add constraint DMWF_PK primary key (DMWF_ID) using index tablespace MAXDAT_INDX;

create unique index DMWF_UIX1 on D_MW_FORWARDED ("Forwarded By Name","Forwarded Flag") tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_FORWARDED to MAXDAT_READ_ONLY;

create or replace view D_MW_FORWARDED_SV as
select * from D_MW_FORWARDED
with read only;

grant select on D_MW_FORWARDED_SV to MAXDAT_READ_ONLY;

insert into D_MW_FORWARDED (DMWF_ID,"Forwarded By Name","Forwarded Flag") values (SEQ_DMWF_ID.nextval,null,'N');
insert into D_MW_FORWARDED (DMWF_ID,"Forwarded By Name","Forwarded Flag") values (SEQ_DMWF_ID.nextval,null,'Y');
commit;


create sequence SEQ_DMWLUBN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_LAST_UPDATE_BY_NAME
  (DMWLUBN_ID number not null,
   "Last Update By Name" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_MW_LAST_UPDATE_BY_NAME add constraint DMWLUBN_PK primary key (DMWLUBN_ID) using index tablespace MAXDAT_INDX;

create unique index DMWLUBN_UIX1 on D_MW_LAST_UPDATE_BY_NAME ("Last Update By Name") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_LAST_UPDATE_BY_NAME to MAXDAT_READ_ONLY;

create or replace view D_MW_LAST_UPDATE_BY_NAME_SV as
select * from D_MW_LAST_UPDATE_BY_NAME
with read only;

grant select on D_MW_LAST_UPDATE_BY_NAME_SV to MAXDAT_READ_ONLY;

insert into D_MW_LAST_UPDATE_BY_NAME (DMWLUBN_ID,"Last Update By Name") values (SEQ_DMWLUBN_ID.nextval,null);
commit;


create sequence SEQ_DMWO_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_OWNER
  (DMWO_ID number not null,
   "Owner Name" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_MW_OWNER add constraint DMWO_PK primary key (DMWO_ID) using index tablespace MAXDAT_INDX;

create unique index DMWO_UIX1 on D_MW_OWNER ("Owner Name") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_OWNER to MAXDAT_READ_ONLY;

create or replace view D_MW_OWNER_SV as
select * from D_MW_OWNER
with read only;

grant select on D_MW_OWNER_SV to MAXDAT_READ_ONLY;

insert into D_MW_OWNER (DMWO_ID,"Owner Name") values (SEQ_DMWO_ID.nextval,null);
commit;


create sequence SEQ_DMWTS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_TASK_STATUS
  (DMWTS_ID number not null,
   "Task Status" varchar2(50) not null)
tablespace MAXDAT_DATA;

alter table D_MW_TASK_STATUS add constraint DMWTS_PK primary key (DMWTS_ID) using index tablespace MAXDAT_INDX;

create unique index DMWTS_UIX1 on D_MW_TASK_STATUS ("Task Status") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_TASK_STATUS to MAXDAT_READ_ONLY;

create or replace view D_MW_TASK_STATUS_SV as
select * from D_MW_TASK_STATUS
with read only;

grant select on D_MW_TASK_STATUS_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DMWTT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_TASK_TYPE
  (DMWTT_ID number not null,
   "Group Name" varchar2(100),
   "Group Parent Name" varchar2(100),
   "Group Supervisor Name" varchar2(100),
   "Task Type" varchar2(100) not null,
   "Team Name" varchar2(100),
   "Team Parent Name" varchar2(100),
   "Team Supervisor Name" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_MW_TASK_TYPE add constraint DMWTT_PK primary key (DMWTT_ID) using index tablespace MAXDAT_INDX;

create unique index DMWTT_UIX1 on D_MW_TASK_TYPE ("Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_MW_TASK_TYPE to MAXDAT_READ_ONLY;

create or replace view D_MW_TASK_TYPE_SV as
select * from D_MW_TASK_TYPE
with read only;

grant select on D_MW_TASK_TYPE_SV to MAXDAT_READ_ONLY;


create sequence SEQ_FMWBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_MW_BY_DATE
  (FMWBD_ID           number not null,
   D_DATE             date not null,
   BUCKET_START_DATE  date not null,
   BUCKET_END_DATE    date not null,
   MW_BI_ID           number not null,
   DMWTT_ID           number not null,
   DMWE_ID            number not null,
   DMWF_ID            number not null,
   DMWO_ID            number not null,
   DMWTS_ID           number not null, 
   DMWLUBN_ID         number not null,
   "Last Update Date" date not null,
   "Status Date"      date not null,
   CREATION_COUNT     number,
   INVENTORY_COUNT    number,
   COMPLETION_COUNT   number,
   received_date      date,
   assigned_date      date
)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_MW_BY_DATE add constraint FMWBD_PK primary key (FMWBD_ID) using index tablespace MAXDAT_INDX;

alter table F_MW_BY_DATE add constraint FMWBD_DMWCUR_FK foreign key (MW_BI_ID) references D_MW_CURRENT (MW_BI_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWE_FK foreign key (DMWE_ID) references D_MW_ESCALATED (DMWE_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWF_FK foreign key (DMWF_ID) references D_MW_FORWARDED (DMWF_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWLUBN_FK foreign key (DMWLUBN_ID) references D_MW_LAST_UPDATE_BY_NAME (DMWLUBN_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWO_FK foreign key (DMWO_ID) references D_MW_OWNER (DMWO_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWTS_FK foreign key (DMWTS_ID) references D_MW_TASK_STATUS (DMWTS_ID);
alter table F_MW_BY_DATE add constraint FMWBD_DMWTT_FK foreign key (DMWTT_ID) references D_MW_TASK_TYPE (DMWTT_ID);

create unique index FMWBD_UIX1 on F_MW_BY_DATE (MW_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMWBD_UIX2 on F_MW_BY_DATE (MW_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FMWBD_IX1 on F_MW_BY_DATE ("Last Update Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IX2 on F_MW_BY_DATE ("Status Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FMWBD_IXL1 on F_MW_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL2 on F_MW_BY_DATE (MW_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL3 on F_MW_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL4 on F_MW_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

--added 20140306 by JJH for Micostrategy report performance
create index FMWBD_IXL5 on F_MW_BY_DATE (DMWTT_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMWBD_IXL6 on F_MW_BY_DATE (DMWTS_ID) local online tablespace MAXDAT_INDX parallel compute statistics;


grant select on F_MW_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_MW_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FMWBD_ID,
  BUCKET_START_DATE D_DATE,
  MW_BI_ID,
  DMWTT_ID,
  DMWE_ID,
  DMWF_ID,
  DMWO_ID,
  DMWTS_ID,
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  received_date,
  assigned_date
from F_MW_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID,
  DMWTT_ID,
  DMWE_ID,
  DMWF_ID,
  DMWO_ID,
  DMWTS_ID,
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  received_date,
  assigned_date
from 
  F_MW_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID,
  DMWTT_ID,
  DMWE_ID,
  DMWF_ID,
  DMWO_ID,
  DMWTS_ID,
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  received_date,
  assigned_date
from 
  F_MW_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day..
select
  FMWBD_ID,
  bdd.D_DATE D_DATE,
  MW_BI_ID,
  DMWTT_ID,
  DMWE_ID,
  DMWF_ID,
  DMWO_ID,
  DMWTS_ID,
  DMWLUBN_ID,
  "Last Update Date",
  "Status Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  received_date,
  assigned_date
from
  BPM_D_DATES bdd,
  F_MW_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_MW_BY_DATE_SV to MAXDAT_READ_ONLY;
