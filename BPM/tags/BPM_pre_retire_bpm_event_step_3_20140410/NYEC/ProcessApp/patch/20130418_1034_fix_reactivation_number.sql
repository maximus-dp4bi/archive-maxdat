update D_NYEC_PA_CURRENT 
set "Cur Reactivation Number" = 0
where "Cur Reactivation Number" is null;

commit;

alter table D_NYEC_PA_CURRENT modify ("Cur Reactivation Number" number not null);


drop index DNPACUR_UIX1;
create unique index DNPACUR_UIX1 on D_NYEC_PA_CURRENT ("Application ID","Cur Reactivation Number") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view D_NYEC_PA_CURRENT_SV as
select
  NYEC_PA_BI_ID, 
  "Application ID", 
  "Age in Business Days", 
  "Age in Calendar Days", 
  "App Age in Calendar Days",
  "App Complete Result", 
  "Application Type", 
  "Auto Reprocess Flag", 
  "Cancel App Flag", 
  "Cancel App Performed By", 
  "Cancel Date", 
  "Channel" "Channel Name", 
  "Close App Flag", 
  "Close App Performed By", 
  "Complete App Flag", 
  "Complete App Performed By", 
  "Complete Date", 
  "Create Date", 
  "Current Task ID", 
  "Data Entry Task ID", 
  "Eligibility Action", 
  "Jeopardy Flag", 
  "KPR App Cycle Business Days", 
  "KPR App Cycle Calendar Days", 
  "KPR App Cycle End Date", 
  "KPR App Cycle Start Date", 
  "Last Mail Date", 
  "MI Received Task Count", 
  "Missing Information Flag", 
  "New MI Flag", 
  "Notify Clnt Pend App Date", 
  "Notify Clnt Pend App Flag", 
  "Notify Clnt Pend App Prfrmd By", 
  "Notify Clnt Pend App Strt Date", 
  "Outcome Notif Req Gateway Flag", 
  "Pend Notification Rqrd Flag", 
  "Perform QC Date", 
  "Perform QC Performed By", 
  "Perform QC Flag", 
  "Perform QC Start Date", 
  "Perform Research Date", 
  "Perform Research Performed By", 
  "Perform Research Flag", 
  "Perform Research Start Date", 
  "Process App Info Date", 
  "Process App Info Flag", 
  "Process App Info Performed By", 
  "Process App Info Start Date", 
  "QC Outcome Flag", 
  "QC Required Flag", 
  "QC Task ID", 
  "Receive and Process MI Flag", 
  "Receive App Flag", 
  "Research Flag", 
  "Research Reason", 
  "Research Task ID", 
  "Review Enter Data Date", 
  "Review Enter Data Performed By", 
  "Review Enter Data Flag", 
  "Review Enter Data Start Date", 
  "SLA Days", 
  "SLA Days Type", 
  "SLA Jeopardy Date", 
  "SLA Jeopardy Days", 
  "SLA Target Days", 
  "State Review Task Count", 
  "State Review Task ID", 
  "Timeliness Status", 
  "Wait State Approval Date", 
  "Wait State Approval Flag", 
  "Wait State Approval Prfrmd By", 
  "Wait State Approval Start Date", 
  "Cur App Status", 
  "Cur App Status Group", 
  "Cur County", 
  "Cur HEART App Status", 
  "Cur HEART Synch Flag", 
  "Cur Receipt Date", 
  "Cur Refer to LDSS Flag",
  "Cur CIN",
  "CIN Date",
  "Provider Name",
  "Cur FPBP Sub-type",
  "Reverse Clearance Indictr",
  "Reverse Clearance Indictr Date",
  "Reverse Clearance Outcome",
  "Upstate/Downstate Indictr",
  "Invoiceable Date",
  "Cur HEART Incomplete App Ind",
  "Days To Timeout",
  "Cur HEART Case Status",
  "State Case Identifier",
  "Cur Reactivation Indicator",
  "Cur Reactivation Date",
  "Cur Reactivation Reason",
  "Cur Reactivated By",
  "Cur Reactivation Number",
  "Cur Mode Code",
  "Cur Mode Label",
  "Cur Outcome Notif Req Flag",
  "Outcome Letter ID",
  "Outcome Letter Type",
  "Cur Outcome Letter Status",
  "Outcome Letter Send Date",
  "Outcome Letter Create Date",
  "Cur Stop Application Reason",
  "Cur Workflow Reactivation Ind", 
  "Cur QC Indicator"
from D_NYEC_PA_CURRENT dnpacur
with read only;


update F_NYEC_PA_BY_DATE
set DNPARN_ID = 267
where DNPARN_ID = 265 or DNPARN_ID is null;

commit;


delete from D_NYEC_PA_REACTIVATION_NUM where "Reactivation Number" is null;

commit;

alter table D_NYEC_PA_REACTIVATION_NUM modify ("Reactivation Number" NUMBER not null);

drop index DNPARN_UIX1;
create unique index DNPARN_UIX1 on D_NYEC_PA_REACTIVATION_NUM ("Reactivation Number") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REACTIVATION_NUM_SV as
select * from D_NYEC_PA_REACTIVATION_NUM
with read only;


update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;