-- Create Semantic Data Model for NYEC Send Info To Trading Partners process. (NYEC_ETL_SENDINFOTRADPART)

create table D_NYEC_SITP_CURRENT
  (NYEC_SITP_BI_ID                  number,
   "Application ID"                 number,
   "Age in Business Days"           number(18) not null,
   "Age in Calendar Days"           number(18) not null,
   "Call Flag"                      varchar2(1),
   "Call Result"                    varchar2(1),
   "Call Status Date"               date,
   "Cancel Date"                    date,
   "Create New Call Req End Date"   date,
   "Create New Call Req Perf By"    varchar2(100),
   "Create New Call Req Start Date" date,
   "Cr New Letter Req End Date"     date,
   "Cr New Letter Req Perf By"      varchar2(100),
   "Cr New Letter Req Start Date"   date, 
   "District Name"                  varchar2(80),
   "IEDR Error Flag"                varchar2(1),
   "Info Req Cycle End Date"        date,
   "Info Req Cycle Start Date"      date,
   "Info Request Create Date"       date not null,
   "Info Request Cycle Bus Days"    number(10),
   "Info Request Group"             varchar2(20),
   "Info Request ID"                number(18) not null,
   "Info Request Sent Date"         date,
   "Info Request Source"            varchar2(20) not null,
   "Info Request Status"            varchar2(20) not null,  
   "Info Request Type"              varchar2(40) not null,
   "Instance Complete Date"         date,
   "Instance Status"                varchar2(10) not null,   
   "Jeopardy Flag"                  varchar2(1),
   "Letter Image Linked Date"       date,
   "Letter Request Date"            date,
   "Letter Status Date"             date,
   "Mail Letter Req - Perf By"      varchar2(100),
   "Mail Letter Req End Date"       date,
   "Mail Letter Req Start Date"     date,
   "Manual Letter Flag"             varchar2(1),  
   "New Call Request ID"            number(18),
   "New Letter Req ID"              number(18),
   "Perf Outbound Call End Date"    date, 
   "Perf Outbound Call Start Date"  date,
   "Perf Outbound Call Perf By"     varchar2(100),
   "Process Image End Date"         date,
   "Process Image Start Date"       date,
   "Process Image Performed By"     varchar2(100),
   "Receive Info Req End Date"      date,
   "Receive Info Req Start Date"    date,
   "Receive Info Req Performed By"  varchar2(100),
   "Send IEDR Date"                 date,  
   "SLA Days"                       number(10),
   "SLA Days Type"                  varchar2(1),
   "SLA Jeopardy Date"              date,
   "SLA Jeopardy Days"              number(10),
   "SLA Target Days"                number(10),
   "Timeliness Status"              varchar2(20) not null, 
   "Receive Info Request Flag"      varchar2(1),
   "Process Image Flag"             varchar2(1),
   "Perform Outbound Call Flag"     varchar2(1),
   "Create New Call Request Flag"   varchar2(1),
   "Mail Letter Request"            varchar2(1),
   "Create New Letter Request Flag" varchar2(1),    	
   "Request Type Flag"              varchar2(1),
   "Retry Call Flag"                varchar2(1),
   "Letter Mailed Flag"             varchar2(1),
   "Cr Referral Summary End Date"   date,
   "Cr Referral Summary Perf By"    varchar2(100), 
   "Cr Referral Summary Start Date" date) 
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_SITP_CURRENT add constraint DNSITPCUR_PK primary key (NYEC_SITP_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DNSITPCUR_UIX1 on D_NYEC_SITP_CURRENT ("Info Request ID") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_SITP_CURRENT for D_NYEC_SITP_CURRENT;
grant select on D_NYEC_SITP_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SITP_CURRENT_SV as
select * from D_NYEC_SITP_CURRENT
with read only;

create or replace public synonym D_NYEC_SITP_CURRENT_SV for D_NYEC_SITP_CURRENT_SV;
grant select on D_NYEC_SITP_CURRENT_SV to MAXDAT_READ_ONLY;


create sequence SEQ_FNSITPBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_SITP_BY_DATE 
  (FNSITPBD_ID       number not null,
   D_DATE            date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE   date not null,
   NYEC_SITP_BI_ID   number not null,
   CREATION_COUNT    number,
   INVENTORY_COUNT   number,
   COMPLETION_COUNT  number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_NYEC_SITP_BY_DATE add constraint FNSITPBD_PK primary key (FNSITPBD_ID) using index tablespace MAXDAT_INDX;

alter table F_NYEC_SITP_BY_DATE add constraint FNSITPBD_DNSITPCUR_FK foreign key (NYEC_SITP_BI_ID) references D_NYEC_SITP_CURRENT(NYEC_SITP_BI_ID);

create unique index FNSITPBD_UIX1 on F_NYEC_SITP_BY_DATE(FNSITPBD_ID,D_DATE) online tablespace MAXDAT_INDX  parallel compute statistics;
create unique index FNSITPBD_UIX2 on F_NYEC_SITP_BY_DATE(FNSITPBD_ID, BUCKET_START_DATE) online tablespace MAXDAT_INDX  parallel compute statistics;

create index FNSITPBD_IXL1 on F_NYEC_SITP_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSITPBD_IXL2 on F_NYEC_SITP_BY_DATE (NYEC_SR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSITPBD_IXL3 on F_NYEC_SITP_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSITPBD_IXL4 on F_NYEC_SITP_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_NYEC_SITP_BY_DATE for F_NYEC_SITP_BY_DATE;
grant select on F_NYEC_SITP_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_SITP_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNSITPBD_ID,
  BUCKET_START_DATE D_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_NYEC_SITP_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNSITPBD_ID,
  bdd.D_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_NYEC_SITP_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNSITPBD_ID,
  bdd.D_DATE,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNSITPBD_ID,
  bdd.D_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_NYEC_SITP_BY_DATE_SV for F_NYEC_SITP_BY_DATE_SV;
grant select on F_NYEC_SITP_BY_DATE_SV to MAXDAT_READ_ONLY;
