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



