-- 10/3/13 B.Thai COnsolidate various dimensional attributes not in NYEC.

alter table D_MW_CURRENT add 
( CLIENT_ID number,
   CASE_ID   number,
   "Cancel By" varchar2(50),
   "Cancel Reason" varchar2(256),
   "Cancel Method" varchar2(50),
   TASK_PRIORITY varchar2(50)
);

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
  TASK_PRIORITY
from D_MW_CURRENT
with read only;

