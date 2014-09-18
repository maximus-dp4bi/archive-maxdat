Alter table cadir_maxdat_stg add (MW_Processed Varchar2(1) default 'Y' not null);

Alter table cadir_maxdat_stg modify MW_Processed default 'N';

Alter table corp_etl_manage_work_tmp drop column updated;

Alter table CORP_ETL_MANAGE_WORK add ( 
ROLE_NAME VARCHAR2(100),
CLAIM_DATE DATE,
LAST_TASK VARCHAR2(1) default 'N' not null);

Alter table CORP_ETL_MANAGE_WORK_TMP add ( 
ROLE_NAME VARCHAR2(100),
CLAIM_DATE DATE,
LAST_TASK VARCHAR2(1) default 'N' not null,
UPDATED VARCHAR2(1) );

ALTER TABLE d_mw_current add ( ROLE_NAME VARCHAR2(100), CLAIM_DATE DATE, LAST_TASK VARCHAR2(1),   Handle_Time NUMBER );

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
  --CASE_ID,    -- 8/28/13 Renamed from "Case_ID"
  "Current Last Update Date",
  "Current Status Date",
  "Cancel By",
  "Cancel Reason",
  "Cancel Method",
  TASK_PRIORITY,
  SOURCE_COMPLETE_DATE,
  Received_Date,
  Assigned_Date,
  Case_Number,
  Original_Create_Date,
  Parent_Task_ID,
  Age_From_Assigned_Date,
  Role_Name,
  Claim_Date,
  Last_Task,
  Handle_Time
from D_MW_CURRENT
with read only;

grant select on D_MW_CURRENT_SV to MAXDAT_READ_ONLY;

