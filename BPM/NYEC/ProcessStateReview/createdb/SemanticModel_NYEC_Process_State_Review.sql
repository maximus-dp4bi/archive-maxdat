-- Create Semantic Data Model for NYEC Process State Review process.

create table D_NYEC_SR_CURRENT
  (NYEC_SR_BI_ID                    number,
   "Application ID"                 number,
   "Instance Complete Date"         date,
   "Instance Status"                varchar2(50),
   "Task Worked By Flag"            varchar2(1),
   "State Result Flag"              varchar2(1),
   "Research Flag"                  varchar2(1),
   "MI Required Flag"               varchar2(1),
   "Receive State Review Flag"      varchar2(1),
   "Process Data Correction Flag"   varchar2(1),
   "Research Resolve Issue Flag"    varchar2(1),
   "Request MI Notification Flag"   varchar2(1),
   "Age in Business Days"           number not null,
   "Age in Calendar Days"           number not null,
   "All MI Satisfied Flag"          varchar2(1) not null,
   "Auto-Close Flag"                varchar2(1) not null,
   "Call Campaign ID"               number,
   "Call Campaign Identified Flag"  varchar2(1) not null,
   "Cancel Date"                    date,
   "Current Task ID"                number,
   "Letter Request ID"              number,
   "Letter Status"                  varchar2(20),
   "New MI Flag"                    varchar2(1),
   "New State Review Task ID"       number,
   "Cur RFE Status Flag"            varchar2(1) not null,
   "Cur State Acceptance Indicator" varchar2(1) not null,
   "State Review Outcome"           varchar2(20),
   "State Review Task ID"           number not null,
   "State Rev Receive End Date"     date,
   "State Rev Receive Performed By" varchar2(100),
   "State Rev Receive Start Date"   date,
   "Proc Data Correct End Date"     date,
   "Proc Data Correct Perf By"      varchar2(100),
   "Proc Data Correct Start Date"   date,
   "Research Resolve End Date"      date,
   "Research Resolve Perf By"       varchar2(100),
   "Research Resolve Start Date"    date,
   "Request MI Notif End Date"      date,
   "Request MI Notif Start Date"    date,
   "Data Correction Task ID"        number,
   "Research Task ID"               number,
   "New MI Satisfied"               varchar2(1),
   "New MI Satisfied Flag"          varchar2(1),
   "Letter Sent Flag"               varchar2(1),
   "Cur HEART App Status"           varchar2(50),
   "Cur App Status Group"           varchar2(30)) 
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_SR_CURRENT add constraint DNSRCUR_PK primary key (NYEC_SR_BI_ID) using index tablespace MAXDAT_INDX;

create index DNSRCUR_IX1 on D_NYEC_SR_CURRENT ("Application ID") online tablespace MAXDAT_INDX parallel compute statistics;
create unique index DNSRCUR_UIX1 on D_NYEC_SR_CURRENT ("State Review Task ID") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_NYEC_SR_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_CURRENT_SV as
select * from D_NYEC_SR_CURRENT
with read only;

grant select on D_NYEC_SR_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_STATE_REV_TASK_SV as
select 
  dnpacur."State Review Task ID",
  dmwcur."Age in Business Days",
  dmwcur."Age in Calendar Days",
  dmwcur."Create Date",
  dmwcur."Complete Date",
  dmwcur."Jeopardy Flag",
  dmwcur."SLA Days",
  dmwcur."SLA Days Type",
  dmwcur."SLA Jeopardy Days",
  dmwcur."SLA Target Days",
  dmwcur."Timeliness Status",
  dmwcur."Cancel Work Date",
  dmwcur."Cancel Work Flag",
  dmwcur."Complete Flag",
  dmwcur."Created By Name",
  dmwcur."Source Reference ID",
  dmwcur."Source Reference Type",
  dmwcur."Status Age in Business Days",
  dmwcur."Status Age in Calendar Days",
  dmwcur."Unit of Work",
  dmwcur."Current Escalated Flag",
  dmwcur."Current Escalated To Name",
  dmwcur."Current Forwarded By Name",
  dmwcur."Current Forwarded Flag",
  dmwcur."Current Group Name",
  dmwcur."Current Group Parent Name",
  dmwcur."Current Group Supervisor Name",
  dmwcur."Current Last Update By Name",
  dmwcur."Current Owner Name",
  dmwcur."Current Task Status",
  dmwcur."Current Task Type",
  dmwcur."Current Team Name",
  dmwcur."Current Team Parent Name",
  dmwcur."Current Team Supervisor Name",
  dmwcur."Current Last Update Date",
  dmwcur."Current Status Date"
from D_NYEC_PA_CURRENT dnpacur
inner join D_MW_CURRENT dmwcur on (dnpacur."State Review Task ID" = dmwcur."Task ID")
with read only;

grant select on D_NYEC_PA_STATE_REV_TASK_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_CURRENT_APP_SV as
select dnsrcur."Application ID",
  dnpacur."Age in Business Days",
  dnpacur."Age in Calendar Days",
  dnpacur."App Age in Calendar Days",
  dnpacur."App Complete Result",
  dnpacur."Application Type",
  dnpacur."Auto Reprocess Flag",
  dnpacur."Cancel App Flag",
  dnpacur."Cancel App Performed By",
  dnpacur."Cancel Date",
  dnpacur."Channel" "Channel Name",
  dnpacur."Close App Flag",
  dnpacur."Close App Performed By",
  dnpacur."Complete App Flag",
  dnpacur."Complete App Performed By",
  dnpacur."Complete Date",
  dnpacur."Create Date",
  dnpacur."Current Task ID",
  dnpacur."Data Entry Task ID",
  dnpacur."Eligibility Action",
  dnpacur."Jeopardy Flag",
  dnpacur."KPR App Cycle Business Days",
  dnpacur."KPR App Cycle Calendar Days",
  dnpacur."KPR App Cycle End Date",
  dnpacur."KPR App Cycle Start Date",
  dnpacur."Last Mail Date",
  dnpacur."MI Received Task Count",
  dnpacur."Missing Information Flag",
  dnpacur."New MI Flag",
  dnpacur."Notify Clnt Pend App Date",
  dnpacur."Notify Clnt Pend App Flag",
  dnpacur."Notify Clnt Pend App Prfrmd By",
  dnpacur."Notify Clnt Pend App Strt Date",
  dnpacur."Outcome Notif Req Gateway Flag",
  dnpacur."Pend Notification Rqrd Flag",
  dnpacur."Perform QC Date",
  dnpacur."Perform QC Performed By",
  dnpacur."Perform QC Flag",
  dnpacur."Perform QC Start Date",
  dnpacur."Perform Research Date",
  dnpacur."Perform Research Performed By",
  dnpacur."Perform Research Flag",
  dnpacur."Perform Research Start Date",
  dnpacur."Process App Info Date",
  dnpacur."Process App Info Flag",
  dnpacur."Process App Info Performed By",
  dnpacur."Process App Info Start Date",
  dnpacur."QC Outcome Flag",
  dnpacur."QC Required Flag",
  dnpacur."QC Task ID",
  dnpacur."Receive and Process MI Flag",
  dnpacur."Receive App Flag",
  dnpacur."Research Flag",
  dnpacur."Research Reason",
  dnpacur."Research Task ID",
  dnpacur."Review Enter Data Date",
  dnpacur."Review Enter Data Performed By",
  dnpacur."Review Enter Data Flag",
  dnpacur."Review Enter Data Start Date",
  dnpacur."SLA Days",
  dnpacur."SLA Days Type",
  dnpacur."SLA Jeopardy Date",
  dnpacur."SLA Jeopardy Days",
  dnpacur."SLA Target Days",
  dnpacur."State Review Task Count",
  dnpacur."State Review Task ID",
  dnpacur."Timeliness Status",
  dnpacur."Wait State Approval Date",
  dnpacur."Wait State Approval Flag",
  dnpacur."Wait State Approval Prfrmd By",
  dnpacur."Wait State Approval Start Date",
  dnpacur."Cur App Status",
  dnpacur."Cur App Status Group",
  dnpacur."Cur County",
  dnpacur."Cur HEART App Status",
  dnpacur."Cur HEART Synch Flag",
  dnpacur."Cur Receipt Date",
  dnpacur."Cur Refer to LDSS Flag",
  dnpacur."Cur CIN",
  dnpacur."CIN Date",
  dnpacur."Provider Name",
  dnpacur."Cur FPBP Sub-type",
  dnpacur."Reverse Clearance Indictr",
  dnpacur."Reverse Clearance Indictr Date",
  dnpacur."Reverse Clearance Outcome",
  dnpacur."Upstate/Downstate Indictr",
  dnpacur."Invoiceable Date",
  dnpacur."Cur HEART Incomplete App Ind",
  dnpacur."Days To Timeout",
  dnpacur."Cur HEART Case Status",
  dnpacur."State Case Identifier",
  dnpacur."Cur Reactivation Indicator",
  dnpacur."Cur Reactivation Date",
  dnpacur."Cur Reactivation Reason",
  dnpacur."Cur Reactivated By",
  dnpacur."Cur Reactivation Number",
  dnpacur."Cur Mode Code",
  dnpacur."Cur Mode Label",
  dnpacur."Cur Outcome Notif Req Flag",
  dnpacur."Outcome Letter ID",
  dnpacur."Outcome Letter Type",
  dnpacur."Cur Outcome Letter Status",
  dnpacur."Outcome Letter Send Date",
  dnpacur."Outcome Letter Create Date",
  dnpacur."Stop Application Reason",
  dnpacur."Cur Workflow Reactivation Ind", 
  dnpacur."Cur QC Indicator"
from D_NYEC_SR_CURRENT dnsrcur
inner join D_NYEC_PA_CURRENT dnpacur on (dnsrcur."Application ID" = dnpacur."Application ID")
with read only;

grant select on D_NYEC_SR_CURRENT_APP_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_STATE_REV_TASK_SV as
select 
  dnsrcur."State Review Task ID",
  dmwcur."Age in Business Days",
  dmwcur."Age in Calendar Days",
  dmwcur."Create Date",
  dmwcur."Complete Date",
  dmwcur."Jeopardy Flag",
  dmwcur."SLA Days",
  dmwcur."SLA Days Type",
  dmwcur."SLA Jeopardy Days",
  dmwcur."SLA Target Days",
  dmwcur."Timeliness Status",
  dmwcur."Cancel Work Date",
  dmwcur."Cancel Work Flag",
  dmwcur."Complete Flag",
  dmwcur."Created By Name",
  dmwcur."Source Reference ID",
  dmwcur."Source Reference Type",
  dmwcur."Status Age in Business Days",
  dmwcur."Status Age in Calendar Days",
  dmwcur."Unit of Work",
  dmwcur."Current Escalated Flag",
  dmwcur."Current Escalated To Name",
  dmwcur."Current Forwarded By Name",
  dmwcur."Current Forwarded Flag",
  dmwcur."Current Group Name",
  dmwcur."Current Group Parent Name",
  dmwcur."Current Group Supervisor Name",
  dmwcur."Current Last Update By Name",
  dmwcur."Current Owner Name",
  dmwcur."Current Task Status",
  dmwcur."Current Task Type",
  dmwcur."Current Team Name",
  dmwcur."Current Team Parent Name",
  dmwcur."Current Team Supervisor Name",
  dmwcur."Current Last Update Date",
  dmwcur."Current Status Date"
from D_NYEC_SR_CURRENT dnsrcur
inner join D_MW_CURRENT dmwcur on (dnsrcur."State Review Task ID" = dmwcur."Task ID")
with read only;

grant select on D_NYEC_SR_STATE_REV_TASK_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_DATA_CORRECT_TASK_SV as
select 
  dnsrcur."Data Correction Task ID",
  dmwcur."Age in Business Days",
  dmwcur."Age in Calendar Days",
  dmwcur."Create Date",
  dmwcur."Complete Date",
  dmwcur."Jeopardy Flag",
  dmwcur."SLA Days",
  dmwcur."SLA Days Type",
  dmwcur."SLA Jeopardy Days",
  dmwcur."SLA Target Days",
  dmwcur."Timeliness Status",
  dmwcur."Cancel Work Date",
  dmwcur."Cancel Work Flag",
  dmwcur."Complete Flag",
  dmwcur."Created By Name",
  dmwcur."Source Reference ID",
  dmwcur."Source Reference Type",
  dmwcur."Status Age in Business Days",
  dmwcur."Status Age in Calendar Days",
  dmwcur."Unit of Work",
  dmwcur."Current Escalated Flag",
  dmwcur."Current Escalated To Name",
  dmwcur."Current Forwarded By Name",
  dmwcur."Current Forwarded Flag",
  dmwcur."Current Group Name",
  dmwcur."Current Group Parent Name",
  dmwcur."Current Group Supervisor Name",
  dmwcur."Current Last Update By Name",
  dmwcur."Current Owner Name",
  dmwcur."Current Task Status",
  dmwcur."Current Task Type",
  dmwcur."Current Team Name",
  dmwcur."Current Team Parent Name",
  dmwcur."Current Team Supervisor Name",
  dmwcur."Current Last Update Date",
  dmwcur."Current Status Date"
from D_NYEC_SR_CURRENT dnsrcur
inner join D_MW_CURRENT dmwcur on (dnsrcur."Data Correction Task ID" = dmwcur."Task ID")
with read only;

grant select on D_NYEC_SR_DATA_CORRECT_TASK_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_RESEARCH_TASK_SV as
select 
  dnsrcur."Research Task ID",
  dmwcur."Age in Business Days",
  dmwcur."Age in Calendar Days",
  dmwcur."Create Date",
  dmwcur."Complete Date",
  dmwcur."Jeopardy Flag",
  dmwcur."SLA Days",
  dmwcur."SLA Days Type",
  dmwcur."SLA Jeopardy Days",
  dmwcur."SLA Target Days",
  dmwcur."Timeliness Status",
  dmwcur."Cancel Work Date",
  dmwcur."Cancel Work Flag",
  dmwcur."Complete Flag",
  dmwcur."Created By Name",
  dmwcur."Source Reference ID",
  dmwcur."Source Reference Type",
  dmwcur."Status Age in Business Days",
  dmwcur."Status Age in Calendar Days",
  dmwcur."Unit of Work",
  dmwcur."Current Escalated Flag",
  dmwcur."Current Escalated To Name",
  dmwcur."Current Forwarded By Name",
  dmwcur."Current Forwarded Flag",
  dmwcur."Current Group Name",
  dmwcur."Current Group Parent Name",
  dmwcur."Current Group Supervisor Name",
  dmwcur."Current Last Update By Name",
  dmwcur."Current Owner Name",
  dmwcur."Current Task Status",
  dmwcur."Current Task Type",
  dmwcur."Current Team Name",
  dmwcur."Current Team Parent Name",
  dmwcur."Current Team Supervisor Name",
  dmwcur."Current Last Update Date",
  dmwcur."Current Status Date"
from D_NYEC_SR_CURRENT dnsrcur
inner join D_MW_CURRENT dmwcur on (dnsrcur."Research Task ID" = dmwcur."Task ID")
with read only;

grant select on D_NYEC_SR_RESEARCH_TASK_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_CURRENT_TASK_SV as
select 
  dnsrcur."Current Task ID",
  dmwcur."Age in Business Days",
  dmwcur."Age in Calendar Days",
  dmwcur."Create Date",
  dmwcur."Complete Date",
  dmwcur."Jeopardy Flag",
  dmwcur."SLA Days",
  dmwcur."SLA Days Type",
  dmwcur."SLA Jeopardy Days",
  dmwcur."SLA Target Days",
  dmwcur."Timeliness Status",
  dmwcur."Cancel Work Date",
  dmwcur."Cancel Work Flag",
  dmwcur."Complete Flag",
  dmwcur."Created By Name",
  dmwcur."Source Reference ID",
  dmwcur."Source Reference Type",
  dmwcur."Status Age in Business Days",
  dmwcur."Status Age in Calendar Days",
  dmwcur."Unit of Work",
  dmwcur."Current Escalated Flag",
  dmwcur."Current Escalated To Name",
  dmwcur."Current Forwarded By Name",
  dmwcur."Current Forwarded Flag",
  dmwcur."Current Group Name",
  dmwcur."Current Group Parent Name",
  dmwcur."Current Group Supervisor Name",
  dmwcur."Current Last Update By Name",
  dmwcur."Current Owner Name",
  dmwcur."Current Task Status",
  dmwcur."Current Task Type",
  dmwcur."Current Team Name",
  dmwcur."Current Team Parent Name",
  dmwcur."Current Team Supervisor Name",
  dmwcur."Current Last Update Date",
  dmwcur."Current Status Date"
from D_NYEC_SR_CURRENT dnsrcur
inner join D_MW_CURRENT dmwcur on (dnsrcur."Current Task ID" = dmwcur."Task ID")
with read only;

grant select on D_NYEC_SR_CURRENT_TASK_SV to MAXDAT_READ_ONLY;


--RFE Status Flag DNSRRSF_ID
create sequence SEQ_DNSRRSF_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_SR_RFE_STATUS_FLAG
  (DNSRRSF_ID        number, 
   "RFE Status Flag" varchar2(1))
tablespace MAXDAT_DATA;

alter table D_NYEC_SR_RFE_STATUS_FLAG add constraint DNSRRSF_PK primary key (DNSRRSF_ID) using index tablespace MAXDAT_INDX;

grant select on D_NYEC_SR_RFE_STATUS_FLAG to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_RFE_STATUS_FLAG_SV as
select * from D_NYEC_SR_RFE_STATUS_FLAG
with read only;

grant select on D_NYEC_SR_RFE_STATUS_FLAG_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_SR_RFE_STATUS_FLAG (DNSRRSF_ID,"RFE Status Flag") values (SEQ_DNSRRSF_ID.nextval,null);
insert into D_NYEC_SR_RFE_STATUS_FLAG (DNSRRSF_ID,"RFE Status Flag") values (SEQ_DNSRRSF_ID.nextval,'N');
insert into D_NYEC_SR_RFE_STATUS_FLAG (DNSRRSF_ID,"RFE Status Flag") values (SEQ_DNSRRSF_ID.nextval,'Y');
commit;


--State Acceptance Indicator DNSRSAI_ID
create sequence SEQ_DNSRSAI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_SR_STATE_ACCEPT_IND
  (DNSRSAI_ID                   number, 
   "State Acceptance Indicator" varchar2(1) not null)
tablespace MAXDAT_DATA;

alter table D_NYEC_SR_STATE_ACCEPT_IND add constraint DNSRSAI_PK primary key (DNSRSAI_ID) using index tablespace MAXDAT_INDX;

grant select on D_NYEC_SR_STATE_ACCEPT_IND to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_STATE_ACCEPT_IND_SV as
select * from D_NYEC_SR_STATE_ACCEPT_IND
with read only;

grant select on D_NYEC_SR_STATE_ACCEPT_IND_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_SR_STATE_ACCEPT_IND (DNSRSAI_ID,"State Acceptance Indicator") values (SEQ_DNSRSAI_ID.nextval,'N');
insert into D_NYEC_SR_STATE_ACCEPT_IND (DNSRSAI_ID,"State Acceptance Indicator") values (SEQ_DNSRSAI_ID.nextval,'Y');
commit;


--HEART App Status DNSRHAS_ID
create sequence SEQ_DNSRHAS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_SR_HEART_APP_STATUS
  (DNSRHAS_ID         number, 
   "HEART App Status" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_SR_HEART_APP_STATUS add constraint DNSRHAS_PK primary key (DNSRHAS_ID) using index tablespace MAXDAT_INDX;

create unique index DNSRHAS_UIX1 on D_NYEC_SR_HEART_APP_STATUS ("HEART App Status") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_NYEC_SR_HEART_APP_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_HEART_APP_STATUS_SV as
select * from D_NYEC_SR_HEART_APP_STATUS
with read only;

grant select on D_NYEC_SR_HEART_APP_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_SR_HEART_APP_STATUS (DNSRHAS_ID,"HEART App Status") values (SEQ_DNSRHAS_ID.nextval,null);
commit;


--App Status Group DNSRASG_ID
create sequence SEQ_DNSRASG_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_SR_APP_STATUS_GROUP
  (DNSRASG_ID         number, 
   "App Status Group" varchar2(30))
tablespace MAXDAT_DATA;

alter table D_NYEC_SR_APP_STATUS_GROUP add constraint DNSRASG_PK primary key (DNSRASG_ID) using index tablespace MAXDAT_INDX;

create unique index DNSRASG_UIX1 on D_NYEC_SR_APP_STATUS_GROUP ("App Status Group") online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_NYEC_SR_APP_STATUS_GROUP to MAXDAT_READ_ONLY;

create or replace view D_NYEC_SR_APP_STATUS_GROUP_SV as
select * from D_NYEC_SR_APP_STATUS_GROUP
with read only;

grant select on D_NYEC_SR_APP_STATUS_GROUP_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_SR_APP_STATUS_GROUP (DNSRASG_ID,"App Status Group") values (SEQ_DNSRASG_ID.nextval,null);
commit;


create sequence SEQ_FNSRBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_SR_BY_DATE 
  (FNSRBD_ID         number not null,
   D_DATE            date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE   date not null,
   NYEC_SR_BI_ID     number not null,
   DNSRRSF_ID        number not null,
   DNSRSAI_ID        number not null,
   DNSRHAS_ID        number not null,
   DNSRASG_ID        number not null,
   CREATION_COUNT    number,
   INVENTORY_COUNT   number,
   COMPLETION_COUNT  number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;


alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_PK primary key (FNSRBD_ID) using index tablespace MAXDAT_INDX;

alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_DNSRRSF_FK foreign key (DNSRRSF_ID) references D_NYEC_SR_RFE_STATUS_FLAG(DNSRRSF_ID);
alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_DNSRSAI_FK foreign key (DNSRSAI_ID) references D_NYEC_SR_STATE_ACCEPT_IND(DNSRSAI_ID);
alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_DNSRHAS_FK foreign key (DNSRHAS_ID) references D_NYEC_SR_HEART_APP_STATUS(DNSRHAS_ID);
alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_DNSRASG_FK foreign key (DNSRASG_ID) references D_NYEC_SR_APP_STATUS_GROUP(DNSRASG_ID);
alter table F_NYEC_SR_BY_DATE add constraint FNSRBD_DNSRCUR_FK foreign key (NYEC_SR_BI_ID) references D_NYEC_SR_CURRENT(NYEC_SR_BI_ID);

create unique index FNSRBD_UIX1 on F_NYEC_SR_BY_DATE(FNSRBD_ID,D_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create unique index FNSRBD_UIX2 on F_NYEC_SR_BY_DATE(FNSRBD_ID,BUCKET_START_DATE) tablespace MAXDAT_INDX parallel compute statistics;

create index FNSRBD_IXL1 on F_NYEC_SR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL2 on F_NYEC_SR_BY_DATE (NYEC_SR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL3 on F_NYEC_SR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNSRBD_IXL4 on F_NYEC_SR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_NYEC_SR_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_SR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNSRBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_NYEC_SR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNSRBD_ID,
  bdd.D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_NYEC_SR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNSRBD_ID,
  bdd.D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SR_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNSRBD_ID,
  bdd.D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_NYEC_SR_BY_DATE_SV to MAXDAT_READ_ONLY;
