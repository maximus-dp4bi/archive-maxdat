--attribute lookup
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (593,1,'Client_ID','Unique identifier associated to the client level task in MAXe');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (479,1,'Case_ID','Unique identifier associated to the case level task in MAXe');
commit;

--attribute
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1686,593,1,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1687,479,1,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
commit;

--attribute staging
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1686,1,'CLIENT_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1687,1,'CASE_ID');
commit;


alter table D_MW_CURRENT add "Client_ID" NUMBER null;
alter table D_MW_CURRENT add "Case_ID" NUMBER null;

CREATE OR REPLACE FORCE VIEW "MAXDAT"."D_MW_CURRENT_SV" ("MW_BI_ID", "Task ID", "Age in Business Days", "Age in Calendar Days", "Create Date", "Complete Date", "Jeopardy Flag", "SLA Days", "SLA Days Type", "SLA Jeopardy Days", "SLA Target Days", "Timeliness Status", "Cancel Work Date", "Cancel Work Flag", "Complete Flag", "Created By Name", "Source Reference ID", "Source Reference Type", "Status Age in Business Days", "Status Age in Calendar Days", "Unit of Work", "Current Escalated Flag", "Current Escalated To Name", "Current Forwarded By Name", "Current Forwarded Flag", "Current Group Name", "Current Group Parent Name", "Current Group Supervisor Name", "Current Last Update By Name", "Current Owner Name", "Current Task Status", "Current Task Type", "Current Team Name", "Current Team Parent Name", "Current Team Supervisor Name", "Current Last Update Date", "Current Status Date","Client_ID","Case_ID") AS 
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
  "Current Status Date",
  "Client_ID",
  "Case_ID"
from D_MW_CURRENT
with read only;


