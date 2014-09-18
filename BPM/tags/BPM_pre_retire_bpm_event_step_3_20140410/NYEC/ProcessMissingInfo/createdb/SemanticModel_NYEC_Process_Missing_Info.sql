-- Create Semantic Data Model for NYEC Process Missing Info process.

create table D_NYEC_PMI_CURRENT
  (NYEC_PMI_BI_ID                  number not null,
   "Age in Business Days"          number not null,
   "Age in Calendar Days"          number,
   "Cur Application ID"            number not null,
   "Cancel Date"                   date,
   "Complete MI Task End Date"     date,
   "Complete MI Task Performed By" varchar2(100),
   "Complete MI Task Start Date"   date,
   "Crt St Accept Task End Date"   date,
   "Crt St Accept Task Perf By"    varchar2(100),
   "Crt St Accept Task Start Date" date,
   "Current Task ID"               number,
   "Determine MI Outcm End Date"   date,
   "Determine MI Outcm Perf By"    varchar2(100),
   "Determine MI Outcm Start Date" date,
   "Cur Inbound MI Type"           varchar2(50),
   "Instance Complete Date"        date,
   "Instance Status"               varchar2(50),
   "Jeopardy Flag"                 varchar2(1),
   "MI Receipt Date"               date,
   "MI Channel"                    varchar2(20),
   "MI Task Type"                  varchar2(50) not null,
   "MI Task ID"                    number not null,
   "MI Task Create Date"           date,
   "MI Task Complete Date"         date,
   "MI Cycle Business Days"        number,
   "MI Cycle End Date"             date,
   "MI Cycle Start Date"           date,
   "MI Call Campaign"              varchar2(50),
   "MI Letter Request ID"          number,
   "Cur MI Letter Status"          varchar2(50),
   "Manual Letter ID"              number,
   "Manual Letter Sent Date"       date,
   "Cur Pending MI Type"           varchar2(100),
   "Perform QC End Date"           date,
   "Perform QC Performed By"       varchar2(100),
   "Perform QC Start Date"         date,
   "Perform Research End Date"     date,
   "Perform Research Performed By" varchar2(100),
   "Perform Research Start Date"   date,
   "Cur QC Task ID"                number,
   "Receive MI End Date"           date,
   "Receive MI Performed By"       varchar2(100),
   "Receive MI Start Date"         date,
   "Request MI End Date"           date,
   "Request MI Performed By"       varchar2(100),
   "Request MI Start Date"         date,
   "Cur Research Reason"           varchar2(50),
   "Cur Research Task ID"          number,
   "SLA Days"                      number,
   "SLA Days Type"                 varchar2(20),
   "SLA Jeopardy Date"             date,
   "SLA Jeopardy Days"             number,
   "SLA Target Days"               number,
   "Cur State Review Task ID"      number,
   "Timeliness Status"             varchar2(20),
   "Channel Flag"                  varchar2(1),
   "QC Required - Phone Flag"      varchar2(1),
   "Update State System Flag"      varchar2(1),
   "Manual Letter Flag"            varchar2(1),
   "Send Research Flag"            varchar2(1),
   "QC Required Flag"              varchar2(1),
   "QC Outcome Flag"               varchar2(1),
   "MI Outcome Flag"               varchar2(1),
   "Receive MI Flag"               varchar2(1),
   "Create State Accept Flag"      varchar2(1),
   "Determine MI Outcome Flag"     varchar2(1),
   "Complete MI Task Flag"         varchar2(1),
   "Perform QC on MI Flag"         varchar2(1),
   "Perform Research Flag"         varchar2(1),
   "Send MI Letter Flag"           varchar2(1),
   -- "RSRCH_TASK_CLAIMED_DATE"       date,
   -- "RSRCH_TASK_CLAIMED_BY"         varchar2(100),
   -- "RSRCH_TASK_COMPLETED_DATE"     date,
   -- "RSRCH_TASK_COMPLETED_BY"       varchar2(100),    
   -- "QC_TASK_CLAIMED_DATE"          date,
   -- "QC_TASK_CLAIMED_BY"            varchar2(100),
   -- "QC_TASK_COMPLETED_DATE"        date,
   -- "QC_TASK_COMPLETED_BY"          varchar2(100),     
   -- "MI_LETTER_REQUESTED_ON"        date,
   -- "MI_TASK_COMPLETED_BY"          varchar2(100),    
   -- "MI_TASK_CREATED_BY"            varchar2(100),
   -- "MI_TASK_CLAIMED_DATE"          date,
   -- "MI_TASK_CLAIMED_BY"            varchar2(100),    
   -- "MI_DOC_LINKED_DATE"            date,
   -- "MI_DOC_LINKED_BY"              varchar2(100),    
   -- "MI_DOC_ECN"                    varchar2(32),    
   -- "STRW_TASK_CLAIMED_DATE"        date,
   -- "STRW_TASK_CLAIMED_BY"          varchar2(100),
   -- "STRW_TASK_COMPLETED_DATE"      date,
   -- "STRW_TASK_COMPLETED_BY"        varchar2(100),
   "All MI Satisfied"              varchar2(1),
   "New MI Creation Date"          date,
   "New MI Satisfied Date"         date,
   "MI Letter Sent On"             date
  ) 
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PMI_CURRENT add constraint DNPMIC_PK primary key (NYEC_PMI_BI_ID) using index tablespace MAXDAT_INDX;

create index DNPMICUR_UIX1 on D_NYEC_PMI_CURRENT ("Cur Application ID") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PMI_CURRENT for D_NYEC_PMI_CURRENT;
grant select on D_NYEC_PMI_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_CURRENT_SV as
select * from D_NYEC_PMI_CURRENT 
with read only;

create or replace public synonym D_NYEC_PMI_CURRENT_SV for D_NYEC_PMI_CURRENT_SV;
grant select on D_NYEC_PMI_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_CURRENT_APP_SV as
select 
  dnpmicur."Cur Application ID",
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
  dnpacur."State Case Identifier", --
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
from D_NYEC_PMI_CURRENT dnpmicur
inner join D_NYEC_PA_CURRENT dnpacur on (dnpmicur."Cur Application ID" = dnpacur."Application ID")
with read only;

create or replace public synonym D_NYEC_PMI_CURRENT_TASK for D_NYEC_PMI_CURRENT_TASK;
grant select on D_NYEC_PMI_CURRENT_TASK to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_CURRENT_TASK_SV as
select
  dnpmicur."Current Task ID",
  dnpmicur."MI Task ID",
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
from D_NYEC_PMI_CURRENT dnpmicur
inner join D_MW_CURRENT dmwcur on (dnpmicur."MI Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_CURRENT_TASK_SV for D_NYEC_PMI_CURRENT_TASK_SV;
grant select on D_NYEC_PMI_CURRENT_TASK_SV to MAXDAT_READ_ONLY;

--D_NYEC_PMI_STATE_RVW_TASK_SV
create or replace view D_NYEC_PMI_STATE_RVW_TASK_SV as
select   
  dnpmicur."Cur State Review Task ID",
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
  from D_NYEC_PMI_CURRENT dnpmicur
  inner join D_MW_CURRENT_SV dmwcur on (dnpmicur."Cur State Review Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_STATE_RVW_TASK_SV for D_NYEC_PMI_STATE_RVW_TASK_SV;
grant select on D_NYEC_PMI_STATE_RVW_TASK_SV to MAXDAT_READ_ONLY;

--D_NYEC_PMI_RESEARCH_TASK_SV
create or replace view D_NYEC_PMI_RESEARCH_TASK_SV as
select   
  dnpmicur."Cur Research Task ID",
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
  from D_NYEC_PMI_CURRENT dnpmicur
  inner join D_MW_CURRENT_SV dmwcur on (dnpmicur."Cur Research Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_RESEARCH_TASK_SV for D_NYEC_PMI_RESEARCH_TASK_SV;
grant select on D_NYEC_PMI_RESEARCH_TASK_SV to MAXDAT_READ_ONLY;

--D_NYEC_PMI_QC_TASK_SV
create or replace view D_NYEC_PMI_QC_TASK_SV as
select   dnpmicur."Cur QC Task ID",
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
  from D_NYEC_PMI_CURRENT dnpmicur
  inner join D_MW_CURRENT_SV dmwcur on (dnpmicur."Cur QC Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_QC_TASK_SV for D_NYEC_PMI_QC_TASK_SV;
grant select on D_NYEC_PMI_QC_TASK_SV to MAXDAT_READ_ONLY;

--D_NYEC_PMI_MI_TASK_SV
create or replace view D_NYEC_PMI_MI_TASK_SV as
select   
  dnpmicur."MI Task ID",
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
  from D_NYEC_PMI_CURRENT dnpmicur
  inner join D_MW_CURRENT_SV dmwcur on (dnpmicur."MI Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_MI_TASK_SV for D_NYEC_PMI_MI_TASK_SV;
grant select on D_NYEC_PMI_MI_TASK_SV to MAXDAT_READ_ONLY;

--D_NYEC_PMI_CURRENT_TASK_SV
create or replace view D_NYEC_PMI_CURRENT_TASK_SV as
select   
  dnpmicur."Current Task ID",
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
  from D_NYEC_PMI_CURRENT dnpmicur
  inner join D_MW_CURRENT_SV dmwcur on (dnpmicur."Current Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PMI_CURRENT_TASK_SV for D_NYEC_PMI_CURRENT_TASK_SV;
grant select on D_NYEC_PMI_CURRENT_TASK_SV to MAXDAT_READ_ONLY;


----- D_NYEC_PMI_APP_ID    DNPMIAI_ID  
create sequence SEQ_DNPMIAI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_APP_ID
  (DNPMIAI_ID       number not null, 
   "Application ID" number not null) 
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_APP_ID add constraint DNPMIAI_PK primary key (DNPMIAI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIAI_UIX1 on D_NYEC_PMI_APP_ID ("Application ID") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_APP_ID for D_NYEC_PMI_APP_ID;
grant select on D_NYEC_PMI_APP_ID to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_APP_ID_SV as
select * from D_NYEC_PMI_APP_ID
with read only;

create or replace public synonym D_NYEC_PMI_APP_ID_SV for D_NYEC_PMI_APP_ID_SV;
grant select on D_NYEC_PMI_APP_ID_SV to MAXDAT_READ_ONLY;


----- D_NYEC_PMI_LETTER_STATUS     DNPMILS_ID
create sequence SEQ_DNPMILS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_LETTER_STATUS
  (DNPMILS_ID         number not null, 
   "MI Letter Status" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_LETTER_STATUS add constraint DNPMILS_PK primary key (DNPMILS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMILS_UIX1 on D_NYEC_PMI_LETTER_STATUS ("MI Letter Status") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_LETTER_STATUS for D_NYEC_PMI_LETTER_STATUS;
grant select on D_NYEC_PMI_LETTER_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_LETTER_STATUS_SV as
select * from D_NYEC_PMI_LETTER_STATUS
with read only;

create or replace public synonym D_NYEC_PMI_LETTER_STATUS_SV for D_NYEC_PMI_LETTER_STATUS_SV;
grant select on D_NYEC_PMI_LETTER_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_LETTER_STATUS (DNPMILS_ID,"MI Letter Status") values (SEQ_DNPMILS_ID.nextval,null);
commit;


----- D_NYEC_PMI_INBOUND_MI_TYPE     DNPMIIMIT_ID
create sequence SEQ_DNPMIIMIT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_INBOUND_MI_TYPE
  (DNPMIIMIT_ID      number not null, 
   "Inbound MI Type" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_INBOUND_MI_TYPE add constraint DNPMIIMIT_PK primary key (DNPMIIMIT_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIIMIT_UIX1 on D_NYEC_PMI_INBOUND_MI_TYPE ("Inbound MI Type") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PMI_INBOUND_MI_TYPE for D_NYEC_PMI_INBOUND_MI_TYPE;
grant select on D_NYEC_PMI_INBOUND_MI_TYPE to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_INBOUND_MI_TYPE_SV as
select * from D_NYEC_PMI_INBOUND_MI_TYPE
with read only;

create or replace public synonym D_NYEC_PMI_INBOUND_MI_TYPE_SV for D_NYEC_PMI_INBOUND_MI_TYPE_SV;
grant select on D_NYEC_PMI_INBOUND_MI_TYPE_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_INBOUND_MI_TYPE (DNPMIIMIT_ID,"Inbound MI Type") values (SEQ_DNPMIIMIT_ID.nextval,null);
commit;


----- D_NYEC_PMI_PENDING_MI_TYPE   SEQ_DNPMIPMIT_ID
create sequence SEQ_DNPMIPMIT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_PENDING_MI_TYPE
  (DNPMIPMIT_ID      number not null, 
   "Pending MI Type" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_PENDING_MI_TYPE add constraint DNPMIPMIT_PK primary key (DNPMIPMIT_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIPMIT_UIX1 on D_NYEC_PMI_PENDING_MI_TYPE ("Pending MI Type") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_PENDING_MI_TYPE for D_NYEC_PMI_PENDING_MI_TYPE;
grant select on D_NYEC_PMI_PENDING_MI_TYPE to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_PENDING_MI_TYPE_SV as
select * from D_NYEC_PMI_PENDING_MI_TYPE
with read only;

create or replace public synonym D_NYEC_PMI_PENDING_MI_TYPE_SV for D_NYEC_PMI_PENDING_MI_TYPE_SV;
grant select on D_NYEC_PMI_PENDING_MI_TYPE_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_PENDING_MI_TYPE (DNPMIPMIT_ID,"Pending MI Type") values (SEQ_DNPMIPMIT_ID.nextval,null);
commit;


----- D_NYEC_PMI_QC_TASK_ID   DNPMIQTI_ID
create sequence SEQ_DNPMIQTI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_QC_TASK_ID
  (DNPMIQTI_ID  number not null, 
   "QC Task ID" number)
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_QC_TASK_ID add constraint DNPMIQTI_PK primary key (DNPMIQTI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIQTI_UIX1 on D_NYEC_PMI_QC_TASK_ID ("QC Task ID") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_QC_TASK_ID for D_NYEC_PMI_QC_TASK_ID;
grant select on D_NYEC_PMI_QC_TASK_ID to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_QC_TASK_ID_SV as
select * from D_NYEC_PMI_QC_TASK_ID
with read only;

create or replace public synonym D_NYEC_PMI_QC_TASK_ID_SV for D_NYEC_PMI_QC_TASK_ID_SV;
grant select on D_NYEC_PMI_QC_TASK_ID_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_QC_TASK_ID (DNPMIQTI_ID,"QC Task ID") values (SEQ_DNPMIQTI_ID.nextval,null);
commit;


----- D_NYEC_PMI_RESEARCH_REASON    DNPMIRR_ID
create sequence SEQ_DNPMIRR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_RESEARCH_REASON
  (DNPMIRR_ID        number not null, 
   "Research Reason" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_RESEARCH_REASON add constraint DNPMIRR_PK primary key (DNPMIRR_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIRR_UIX1 on D_NYEC_PMI_RESEARCH_REASON ("Research Reason") tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_RESEARCH_REASON for D_NYEC_PMI_RESEARCH_REASON;
grant select on D_NYEC_PMI_RESEARCH_REASON to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_RESEARCH_REASON_SV as
select * from D_NYEC_PMI_RESEARCH_REASON
with read only;

create or replace public synonym D_NYEC_PMI_RESEARCH_REASON_SV for D_NYEC_PMI_RESEARCH_REASON_SV;
grant select on D_NYEC_PMI_RESEARCH_REASON_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_RESEARCH_REASON (DNPMIRR_ID,"Research Reason") values (SEQ_DNPMIRR_ID.nextval,null);
commit;


----- D_NYEC_PMI_RESEARCH_TASK_ID   DNPMIRTI_ID 
create sequence SEQ_DNPMIRTI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_RESEARCH_TASK_ID
  (DNPMIRTI_ID        number not null, 
   "Research Task ID" number)
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_RESEARCH_TASK_ID add constraint DNPMIRTI_PK primary key (DNPMIRTI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMIRTI_UIX1 on D_NYEC_PMI_RESEARCH_TASK_ID ("Research Task ID") tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_RESEARCH_TASK_ID for D_NYEC_PMI_RESEARCH_TASK_ID;
grant select on D_NYEC_PMI_RESEARCH_TASK_ID to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_RESEARCH_TASK_ID_SV as
select * from D_NYEC_PMI_RESEARCH_TASK_ID
with read only;

create or replace public synonym D_NYEC_PMI_RESEARCH_TASK_ID_SV for D_NYEC_PMI_RESEARCH_TASK_ID_SV;
grant select on D_NYEC_PMI_RESEARCH_TASK_ID_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_RESEARCH_TASK_ID (DNPMIRTI_ID,"Research Task ID") values (SEQ_DNPMIRTI_ID.nextval,null);
commit;


----- D_NYEC_PMI_ST_REV_TASK_ID       DNPMISRTI_ID
create sequence SEQ_DNPMISRTI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PMI_ST_REV_TASK_ID
  (DNPMISRTI_ID number not null, 
   "State Review Task ID" number) 
tablespace MAXDAT_DATA;

alter table D_NYEC_PMI_ST_REV_TASK_ID add constraint DNPMISRTI_PK primary key (DNPMISRTI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPMISRTI_UIX1 on D_NYEC_PMI_ST_REV_TASK_ID ("State Review Task ID") tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PMI_ST_REV_TASK_ID for D_NYEC_PMI_ST_REV_TASK_ID;
grant select on D_NYEC_PMI_ST_REV_TASK_ID to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PMI_ST_REV_TASK_ID_SV as
select * from D_NYEC_PMI_ST_REV_TASK_ID
with read only;

create or replace public synonym D_NYEC_PMI_ST_REV_TASK_ID_SV for D_NYEC_PMI_ST_REV_TASK_ID_SV;
grant select on D_NYEC_PMI_ST_REV_TASK_ID_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PMI_ST_REV_TASK_ID (DNPMISRTI_ID,"State Review Task ID") values (SEQ_DNPMISRTI_ID.nextval,null);
commit;


---
create sequence SEQ_FNPMIBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_PMI_BY_DATE
  (FNPMIBD_ID number not null, 
   D_DATE date not null, 
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   NYEC_PMI_BI_ID number not null, 
   DNPMIAI_ID number not null, 
   DNPMILS_ID number not null, 
   DNPMIIMIT_ID number not null, 
   DNPMIPMIT_ID number not null, 
   DNPMIQTI_ID number not null, 
   DNPMIRR_ID number not null,      
   DNPMIRTI_ID number not null, 
   DNPMISRTI_ID number not null,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_PK primary key (FMPMIBD_ID) using index tablespace MAXDAT_INDX;

alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMILS_FK foreign key (DNPMILS_ID) references D_NYEC_PMI_LETTER_STATUS(DNPMILS_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIIMIT_FK foreign key (DNPMIIMIT_ID) references D_NYEC_PMI_INBOUND_MI_TYPE(DNPMIIMIT_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIPMIT_FK foreign key (DNPMIPMIT_ID) references D_NYEC_PMI_PENDING_MI_TYPE(DNPMIPMIT_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIQTI_FK foreign key (DNPMIQTI_ID) references D_NYEC_PMI_QC_TASK_ID(DNPMIQTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIRR_FK foreign key (DNPMIRR_ID) references D_NYEC_PMI_RESEARCH_REASON(DNPMIRR_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIRTI_FK foreign key (DNPMIRTI_ID) references D_NYEC_PMI_RESEARCH_TASK_ID(DNPMIRTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMISRTI_FK foreign key (DNPMISRTI_ID) references D_NYEC_PMI_ST_REV_TASK_ID(DNPMISRTI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMIAI_FK foreign key (DNPMIAI_ID) references D_NYEC_PMI_APP_ID(DNPMIAI_ID);
alter table F_NYEC_PMI_BY_DATE add constraint FNPMIBD_DNPMICUR_FK foreign key (NYEC_PMI_BI_ID) references D_NYEC_PMI_CURRENT(NYEC_PMI_BI_ID);

create unique index FNPMIBD_UIX1 on F_NYEC_PMI_BY_DATE (FNPMIBD_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FNPMIBD_UIX2 on F_NYEC_PMI_BY_DATE (FNPMIBD_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FNPMIBD_IXL1 on F_NYEC_PMI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL2 on F_NYEC_PMI_BY_DATE (NYEC_PMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL3 on F_NYEC_PMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPMIBD_IXL4 on F_NYEC_PMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_NYEC_PMI_BY_DATE for F_NYEC_PMI_BY_DATE;
grant select on F_NYEC_PMI_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_PMI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNPMIBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_NYEC_PMI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_NYEC_PMI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_NYEC_PMI_BY_DATE_SV for F_NYEC_PMI_BY_DATE_SV;
grant select on F_NYEC_PMI_BY_DATE_SV to MAXDAT_READ_ONLY;
