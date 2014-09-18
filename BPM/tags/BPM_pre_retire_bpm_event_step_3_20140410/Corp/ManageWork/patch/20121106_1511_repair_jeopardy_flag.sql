update
(select MW_BI_ID,"Jeopardy Flag"
 from D_MW_CURRENT
 where
   "Jeopardy Flag" != 'Y'
   and
     (   ("SLA Days Type" = 'B' and "Age in Business Days" is not null and "SLA Jeopardy Days" is not null and "Age in Business Days" >= "SLA Jeopardy Days")
      or ("SLA Days Type" = 'C' and "Age in Calendar Days" is not null and "SLA Jeopardy Days" is not null and "Age in Calendar Days" >= "SLA Jeopardy Days")))
set "Jeopardy Flag" = 'Y';

commit;

update
(select MW_BI_ID,"Jeopardy Flag"
 from D_MW_CURRENT
 where
   "Jeopardy Flag" != 'N'
   and
     (   ("SLA Days Type" = 'B' and ("Age in Business Days" is null or "SLA Jeopardy Days" is null or "Age in Business Days" < "SLA Jeopardy Days"))
      or ("SLA Days Type" = 'C' and ("Age in Calendar Days" is null or "SLA Jeopardy Days" is null or "Age in Calendar Days" < "SLA Jeopardy Days"))))
set "Jeopardy Flag" = 'N';

commit;

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
  "Current Last Update Date", 
  "Current Status Date"
from D_MW_CURRENT
with read only;
