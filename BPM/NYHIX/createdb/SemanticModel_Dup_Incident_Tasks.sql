-- NYHIX-2739 Manage Work Duplicate Incident Tasks

create or replace view D_MW_INCIDENT_CURRENT_SV as
select MW."Source Reference ID" as "Incident ID"
     , IDR.TRACKING_NUMBER as "Incident Tracking Number"
     , MW."MW_BI_ID"
     , MW."Task ID"
     , MW."Age in Business Days"
     , MW."Age in Calendar Days"
     , MW."Create Date"
     , MW."Complete Date"
     , MW."Jeopardy Flag"
     , MW."SLA Days"
     , MW."SLA Days Type"
     , MW."SLA Jeopardy Days"
     , MW."SLA Target Days"
     , MW."Timeliness Status"
     , MW."Cancel Work Date"
     , MW."Cancel Work Flag"
     , MW."Complete Flag"
     , MW."Created By Name"
     , MW."Status Age in Business Days"
     , MW."Status Age in Calendar Days"
     , MW."Unit of Work"
     , MW."Current Escalated Flag"
     , MW."Current Escalated To Name"
     , MW."Current Forwarded By Name"
     , MW."Current Forwarded Flag"
     , MW."Current Group Name"
     , MW."Current Group Parent Name"
     , MW."Current Group Supervisor Name"
     , MW."Current Last Update By Name"
     , MW."Current Owner Name"
     , MW."Current Task Status"
     , MW."Current Task Type"
     , MW."Current Team Name"
     , MW."Current Team Parent Name"
     , MW."Current Team Supervisor Name"
     , MW."CLIENT_ID",MW."CASE_ID"
     , MW."Current Last Update Date"
     , MW."Current Status Date"
     , MW."Cancel By"
     , MW."Cancel Reason"
     , MW."Cancel Method"
     , MW."TASK_PRIORITY"
  from D_MW_CURRENT MW, D_IDR_CURRENT IDR
 where "Source Reference Type" = 'Incident ID' 
   and "Source Reference ID" = IDR.INCIDENT_ID
union all
select MW."Source Reference ID" as "Incident ID"
     , APP.INCIDENT_TRACKING_NUMBER as "Incident Tracking Number"
     , MW."MW_BI_ID"
     , MW."Task ID"
     , MW."Age in Business Days"
     , MW."Age in Calendar Days"
     , MW."Create Date"
     , MW."Complete Date"
     , MW."Jeopardy Flag"
     , MW."SLA Days"
     , MW."SLA Days Type"
     , MW."SLA Jeopardy Days"
     , MW."SLA Target Days"
     , MW."Timeliness Status"
     , MW."Cancel Work Date"
     , MW."Cancel Work Flag"
     , MW."Complete Flag"
     , MW."Created By Name"
     , MW."Status Age in Business Days"
     , MW."Status Age in Calendar Days"
     , MW."Unit of Work"
     , MW."Current Escalated Flag"
     , MW."Current Escalated To Name"
     , MW."Current Forwarded By Name"
     , MW."Current Forwarded Flag"
     , MW."Current Group Name"
     , MW."Current Group Parent Name"
     , MW."Current Group Supervisor Name"
     , MW."Current Last Update By Name"
     , MW."Current Owner Name"
     , MW."Current Task Status"
     , MW."Current Task Type"
     , MW."Current Team Name"
     , MW."Current Team Parent Name"
     , MW."Current Team Supervisor Name"
     , MW."CLIENT_ID",MW."CASE_ID"
     , MW."Current Last Update Date"
     , MW."Current Status Date"
     , MW."Cancel By"
     , MW."Cancel Reason"
     , MW."Cancel Method"
     , MW."TASK_PRIORITY"
  from D_MW_CURRENT MW, D_APPEALS_CURRENT APP
 where "Source Reference Type" = 'Incident ID' 
   and "Source Reference ID" = APP.INCIDENT_ID
union all
select MW."Source Reference ID" as "Incident ID"
     , CMP.INCIDENT_TRACKING_NUMBER as "Incident Tracking Number"
     , MW."MW_BI_ID"
     , MW."Task ID"
     , MW."Age in Business Days"
     , MW."Age in Calendar Days"
     , MW."Create Date"
     , MW."Complete Date"
     , MW."Jeopardy Flag"
     , MW."SLA Days"
     , MW."SLA Days Type"
     , MW."SLA Jeopardy Days"
     , MW."SLA Target Days"
     , MW."Timeliness Status"
     , MW."Cancel Work Date"
     , MW."Cancel Work Flag"
     , MW."Complete Flag"
     , MW."Created By Name"
     , MW."Status Age in Business Days"
     , MW."Status Age in Calendar Days"
     , MW."Unit of Work"
     , MW."Current Escalated Flag"
     , MW."Current Escalated To Name"
     , MW."Current Forwarded By Name"
     , MW."Current Forwarded Flag"
     , MW."Current Group Name"
     , MW."Current Group Parent Name"
     , MW."Current Group Supervisor Name"
     , MW."Current Last Update By Name"
     , MW."Current Owner Name"
     , MW."Current Task Status"
     , MW."Current Task Type"
     , MW."Current Team Name"
     , MW."Current Team Parent Name"
     , MW."Current Team Supervisor Name"
     , MW."CLIENT_ID",MW."CASE_ID"
     , MW."Current Last Update Date"
     , MW."Current Status Date"
     , MW."Cancel By"
     , MW."Cancel Reason"
     , MW."Cancel Method"
     , MW."TASK_PRIORITY"
  from D_MW_CURRENT MW, D_COMPLAINT_CURRENT CMP
 where "Source Reference Type" = 'Incident ID' 
   and "Source Reference ID" = CMP.INCIDENT_ID;

grant select on D_MW_INCIDENT_CURRENT_SV to MAXDAT_READ_ONLY;

  CREATE TABLE "MAXDAT"."INCIDENT_HEADER_STAT_HIST_STG" 
   (	"INCIDENT_HEADER_STAT_HIST_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"INCIDENT_HEADER_ID" NUMBER(18,0), 
	"STATUS_CD" VARCHAR2(30 BYTE), 
  "INCIDENT_STATUS" VARCHAR2(80),
	"CREATED_BY" VARCHAR2(80 BYTE), 
	"CREATE_TS" DATE, 
	"CREATED_BY_STAFF_ID" NUMBER(18,0),
  primary key (INCIDENT_HEADER_STAT_HIST_ID) using index tablespace MAXDAT_INDX
   ) 
  TABLESPACE "MAXDAT_DATA" ;

create index INC_HEAD_STAT_HIST_STG_IX1 on INCIDENT_HEADER_STAT_HIST_STG (INCIDENT_HEADER_ID) tablespace MAXDAT_INDX;

grant select on INCIDENT_HEADER_STAT_HIST_STG to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW MAXDAT.D_INCIDENT_STATUS_HISTORY_SV
AS select 
INCIDENT_HEADER_ID AS INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
CREATE_TS INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID
from 
INCIDENT_HEADER_STAT_HIST_STG with read only;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('MAX_UPDATE_TS_INCIDENT_STTAUS_HIST','D','2010/04/20 00:00:00','Max Update Date for INCIDENT_HEADER_STAT_HIST_STG Stage table',SYSDATE,SYSDATE);

commit;
