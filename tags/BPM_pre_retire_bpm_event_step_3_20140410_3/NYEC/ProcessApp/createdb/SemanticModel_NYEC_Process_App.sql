-- Create Semantic Data Model for NYEC Process App process.

create table D_NYEC_PA_CURRENT
  (NYEC_PA_BI_ID number not null, 
   "Application ID" number not null, 
   "Age in Business Days" number not null, 
   "Age in Calendar Days" number not null, 
   "App Age in Calendar Days" number null,
   "App Complete Result" varchar2(50), 
   "Application Type" varchar2(30), 
   "Auto Reprocess Flag" varchar2(1), 
   "Cancel App Flag" varchar2(1) not null, 
   "Cancel App Performed By" varchar2(100), 
   "Cancel Date" date, 
   "Channel" varchar2(20), 
   "Close App Flag" varchar2(1) not null, 
   "Close App Performed By" varchar2(100), 
   "Complete App Flag" varchar2(1) not null, 
   "Complete App Performed By" varchar2(100), 
   "Complete Date" date, 
   "Create Date" date not null, 
   "Current Task ID" number, 
   "Data Entry Task ID" number, 
   "Eligibility Action" varchar2(20), 
   "Jeopardy Flag" varchar2(1) not null, 
   "KPR App Cycle Business Days" number, 
   "KPR App Cycle Calendar Days" number, 
   "KPR App Cycle End Date" date, 
   "KPR App Cycle Start Date" date, 
   "Last Mail Date" date, 
   "MI Received Task Count" number not null, 
   "Missing Information Flag" varchar2(1), 
   "New MI Flag" varchar2(1), 
   "Notify Clnt Pend App Date" date, 
   "Notify Clnt Pend App Flag" varchar2(1) not null, 
   "Notify Clnt Pend App Prfrmd By" varchar2(100), 
   "Notify Clnt Pend App Strt Date" date, 
   "Outcome Notif Req Gateway Flag" varchar2(1) not null, 
   "Pend Notification Rqrd Flag" varchar2(1), 
   "Perform QC Date" date, 
   "Perform QC Performed By" varchar2(100), 
   "Perform QC Flag" varchar2(1) not null, 
   "Perform QC Start Date" date, 
   "Perform Research Date" date, 
   "Perform Research Performed By" varchar2(100), 
   "Perform Research Flag" varchar2(1) not null, 
   "Perform Research Start Date" date, 
   "Process App Info Date" date, 
   "Process App Info Flag" varchar2(1) not null, 
   "Process App Info Performed By" varchar2(100), 
   "Process App Info Start Date" date, 
   "QC Outcome Flag" varchar2(1), 
   "QC Required Flag" varchar2(1), 
   "QC Task ID" number, 
   "Receive and Process MI Flag" varchar2(1) not null, 
   "Receive App Flag" varchar2(1) not null, 
   "Research Flag" varchar2(1), 
   "Research Reason" varchar2(50), 
   "Research Task ID" number, 
   "Review Enter Data Date" date, 
   "Review Enter Data Performed By" varchar2(100), 
   "Review Enter Data Flag" varchar2(1) not null, 
   "Review Enter Data Start Date" date, 
   "SLA Days" number, 
   "SLA Days Type" varchar2(1), 
   "SLA Jeopardy Date" date, 
   "SLA Jeopardy Days" number, 
   "SLA Target Days" number, 
   "State Review Task Count" number not null, 
   "State Review Task ID" number, 
   "Timeliness Status" varchar2(20) not null, 
   "Wait State Approval Date" date, 
   "Wait State Approval Flag" varchar2(1) not null, 
   "Wait State Approval Prfrmd By" varchar2(100), 
   "Wait State Approval Start Date" date, 
   "Cur App Status" varchar2(50) not null, 
   "Cur App Status Group" varchar2(30) not null, 
   "Cur County" varchar2(60), 
   "Cur HEART App Status" varchar2(50), 
   "Cur HEART Synch Flag" varchar2(1) not null, 
   "Cur Receipt Date" date, 
   "Cur Refer to LDSS Flag" varchar2(1) not null,
   "Cur CIN" varchar2(30),
   "CIN Date" date,
   "Provider Name" varchar2(80),
   "Cur FPBP Sub-type" varchar2(30),
   "Reverse Clearance Indictr" varchar2(22),
   "Reverse Clearance Indictr Date" date,
   "Reverse Clearance Outcome" varchar2(22),
   "Upstate/Downstate Indictr" varchar2(20),
   "Invoiceable Date" date,
   "Cur HEART Incomplete App Ind" varchar2(1),
   "Days To Timeout" number,
   "Cur HEART Case Status" varchar2(50),
   "State Case Identifier" varchar2(30),
   "Cur Reactivation Indicator" number,
   "Cur Reactivation Date" date,
   "Cur Reactivation Reason" varchar2(32),
   "Cur Reactivated By" varchar2(100),
   "Cur Reactivation Number" number not null,
   "Cur Mode Code" varchar2(2),
   "Cur Mode Label" varchar2(50),
   "Cur Outcome Notif Req Flag" varchar2(1),
   "Outcome Letter ID" number,
   "Outcome Letter Type" varchar2(100),
   "Cur Outcome Letter Status" varchar2(32),
   "Outcome Letter Send Date" date,
   "Outcome Letter Create Date" date,
   "Stop Application Reason" varchar2(100),
   "Cur Workflow Reactivation Ind" varchar2(1), 
   "Cur QC Indicator" varchar2(1),
   CUR_MA_REASON VARCHAR2 (50),
   PROVIDER_ID NUMBER,
   APPLICANT_ID NUMBER,
   REGISTRATION_TASK_ID NUMBER,
   QC_REGISTRATION_TASK_ID NUMBER,
   PERFORM_QC_REG_START_DATE DATE,
   PERFORM_QC_REG_PERFORMED_BY VARCHAR2 (100 BYTE),
   REG_AND_ENTER_DATA_PERFORM_BY VARCHAR2 (100 BYTE),
   REG_AND_ENTER_DATA_START_DATE DATE,
   PERFORM_QC_REG_DATE DATE,
   CUR_REVERSE_CLEARANCE_REASON VARCHAR2(50),
   NUMBER_OF_APPLICANTS NUMBER null,
   PERFORM_REG_ENTER_DATA_DATE DATE)
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_CURRENT add constraint DNPACUR_PK primary key (NYEC_PA_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPACUR_UIX1 on D_NYEC_PA_CURRENT ("Application ID","Cur Reactivation Number") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_CURRENT for D_NYEC_PA_CURRENT;
grant select on D_NYEC_PA_CURRENT to MAXDAT_READ_ONLY;

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
  "Stop Application Reason",
  "Cur Workflow Reactivation Ind", 
  "Cur QC Indicator",
  CUR_MA_REASON,
  PROVIDER_ID,
  APPLICANT_ID,
  REGISTRATION_TASK_ID,
  QC_REGISTRATION_TASK_ID,
  PERFORM_QC_REG_START_DATE,
  PERFORM_QC_REG_PERFORMED_BY,
  REG_AND_ENTER_DATA_PERFORM_BY,
  REG_AND_ENTER_DATA_START_DATE,
  PERFORM_QC_REG_DATE,
  CUR_REVERSE_CLEARANCE_REASON,
  NUMBER_OF_APPLICANTS,
  PERFORM_REG_ENTER_DATA_DATE,
  cast (((sysdate - "KPR App Cycle End Date") - 30) as numeric) as "Days Left to Reactivate"
from D_NYEC_PA_CURRENT dnpacur
with read only;

create or replace public synonym D_NYEC_PA_CURRENT_SV for D_NYEC_PA_CURRENT_SV;
grant select on D_NYEC_PA_CURRENT_SV to MAXDAT_READ_ONLY;


create or replace view D_NYEC_PA_CURRENT_TASK_SV as
select
  dnpacur."Current Task ID", 
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
inner join D_MW_CURRENT dmwcur on (dnpacur."Current Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PA_CURRENT_TASK_SV for D_NYEC_PA_CURRENT_TASK_SV;
grant select on D_NYEC_PA_CURRENT_TASK_SV to MAXDAT_READ_ONLY;


create or replace view D_NYEC_PA_DATA_ENTRY_TASK_SV as
select
  dnpacur."Data Entry Task ID", 
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
inner join D_MW_CURRENT dmwcur on (dnpacur."Data Entry Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PA_DATA_ENTRY_TASK_SV for D_NYEC_PA_DATA_ENTRY_TASK_SV;
grant select on D_NYEC_PA_DATA_ENTRY_TASK_SV to MAXDAT_READ_ONLY;


create or replace view D_NYEC_PA_QC_TASK_SV as
select
  dnpacur."QC Task ID", 
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
inner join D_MW_CURRENT dmwcur on (dnpacur."QC Task ID" = dmwcur."Task ID")
with read only;

create or replace public synonym D_NYEC_PA_QC_TASK_SV for D_NYEC_PA_QC_TASK_SV;
grant select on D_NYEC_PA_QC_TASK_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DNPAAS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_APP_STATUS
  (DNPAAS_ID number not null, 
   "App Status" varchar2(50) not null, 
   "App Status Group" varchar2(30) not null, 
   "Heart App Status" varchar2(50), 
   "Refer to LDSS Flag" varchar2(1) not null) 
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_APP_STATUS add constraint DNPAAS_PK primary key (DNPAAS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAAS_UIX1 on D_NYEC_PA_APP_STATUS ("App Status","App Status Group","Heart App Status","Refer to LDSS Flag") online tablespace MAXDAT_INDX parallel compute statistics;  

create or replace public synonym D_NYEC_PA_APP_STATUS for D_NYEC_PA_APP_STATUS;
grant select on D_NYEC_PA_APP_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_APP_STATUS_SV as
select * from D_NYEC_PA_APP_STATUS 
with read only;

create or replace public synonym D_NYEC_PA_APP_STATUS_SV for D_NYEC_PA_APP_STATUS_SV;
grant select on D_NYEC_PA_APP_STATUS_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DNPACIN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_CIN
  (DNPACIN_ID number not null,
   "CIN" varchar2(30))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_CIN add constraint DNPACIN_PK primary key (DNPACIN_ID) using index tablespace MAXDAT_INDX;

create unique index DNPACIN_UIX1 on D_NYEC_PA_CIN ("CIN") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_NYEC_PA_CIN for D_NYEC_PA_CIN;
grant select on D_NYEC_PA_CIN to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_CIN_SV as
select * from D_NYEC_PA_CIN
with read only;

create or replace public synonym D_NYEC_PA_CIN_SV for D_NYEC_PA_CIN_SV;
grant select on D_NYEC_PA_CIN_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_CIN (DNPACIN_ID,"CIN") values (SEQ_DNPACIN_ID.nextval,null);
commit;


create sequence SEQ_DNPACOU_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_COUNTY
  (DNPACOU_ID number not null,
   "County" varchar2(60))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_COUNTY add constraint DNPACOU_PK primary key (DNPACOU_ID) using index tablespace MAXDAT_INDX;

create unique index DNPACOU_UIX1 on D_NYEC_PA_COUNTY ("County") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PA_COUNTY for D_NYEC_PA_COUNTY;
grant select on D_NYEC_PA_COUNTY to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_COUNTY_SV as
select 
  DNPACOU_ID,
  "County" "County Name"
from D_NYEC_PA_COUNTY 
with read only;

create or replace public synonym D_NYEC_PA_COUNTY_SV for D_NYEC_PA_COUNTY_SV;
grant select on D_NYEC_PA_COUNTY_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_COUNTY (DNPACOU_ID,"County") values (SEQ_DNPACOU_ID.nextval,null);
commit;


create sequence SEQ_DNPAFPBPST_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_FPBP_SUBTYPE
  (DNPAFPBPST_ID number not null,
   "FPBP Sub-type" varchar2(30))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_FPBP_SUBTYPE add constraint DNPAFPBPST_PK primary key (DNPAFPBPST_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAFPBPST_UIX1 on D_NYEC_PA_FPBP_SUBTYPE ("FPBP Sub-type") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PA_FPBP_SUBTYPE for D_NYEC_PA_FPBP_SUBTYPE;
grant select on D_NYEC_PA_FPBP_SUBTYPE to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_FPBP_SUBTYPE_SV as
select * from D_NYEC_PA_FPBP_SUBTYPE
with read only;

create or replace public synonym D_NYEC_PA_FPBP_SUBTYPE_SV for D_NYEC_PA_FPBP_SUBTYPE_SV;
grant select on D_NYEC_PA_FPBP_SUBTYPE_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_FPBP_SUBTYPE (DNPAFPBPST_ID,"FPBP Sub-type") values (SEQ_DNPAFPBPST_ID.nextval,null);
commit;


create sequence SEQ_DNPAHCS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_HEART_CASE_STATUS
  (DNPAHCS_ID number not null,
   "HEART Case Status" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_HEART_CASE_STATUS add constraint DNPAHCS_PK primary key (DNPAHCS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAHCS_UIX1 on D_NYEC_PA_HEART_CASE_STATUS ("HEART Case Status") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PA_HEART_CASE_STATUS for D_NYEC_PA_HEART_CASE_STATUS;
grant select on D_NYEC_PA_HEART_CASE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_HEART_CASE_STATUS_SV as
select * from D_NYEC_PA_HEART_CASE_STATUS
with read only;

create or replace public synonym D_NYEC_PA_HEART_CASE_STATUS_SV for D_NYEC_PA_HEART_CASE_STATUS_SV;
grant select on D_NYEC_PA_HEART_CASE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_HEART_CASE_STATUS (DNPAHCS_ID,"HEART Case Status") values (SEQ_DNPAHCS_ID.nextval,null);
commit;


create sequence SEQ_DNPAHIAI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_HEART_INC_APP_IND
  (DNPAHIAI_ID number not null, 
   "HEART Incomplete App Ind" varchar2(1)) 
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_HEART_INC_APP_IND add constraint DNPAHIAI_PK primary key (DNPAHIAI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAHIAI_UIX1 on D_NYEC_PA_HEART_INC_APP_IND ("HEART Incomplete App Ind") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PA_HEART_INC_APP_IND for D_NYEC_PA_HEART_INC_APP_IND;
grant select on D_NYEC_PA_HEART_INC_APP_IND to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_HEART_INC_APP_IND_SV as
select * from D_NYEC_PA_HEART_INC_APP_IND
with read only;

create or replace public synonym D_NYEC_PA_HEART_INC_APP_IND_SV for D_NYEC_PA_HEART_INC_APP_IND_SV;
grant select on D_NYEC_PA_HEART_INC_APP_IND_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_HEART_INC_APP_IND (DNPAHIAI_ID,"HEART Incomplete App Ind") values (SEQ_DNPAHIAI_ID.nextval,null);
commit;


create sequence SEQ_DNPAHS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_HEART_SYNCH
  (DNPAHS_ID number not null, 
   "HEART Synch Flag" varchar2(1) not null)
tablespace MAXDAT_DATA ;

alter table D_NYEC_PA_HEART_SYNCH add constraint DNPAHS_PK primary key (DNPAHS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAHS_UIX1 on D_NYEC_PA_HEART_SYNCH ("HEART Synch Flag") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace public synonym D_NYEC_PA_HEART_SYNCH for D_NYEC_PA_HEART_SYNCH;
grant select on D_NYEC_PA_HEART_SYNCH to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_HEART_SYNCH_SV as
select * from D_NYEC_PA_HEART_SYNCH   
with read only;

create or replace public synonym D_NYEC_PA_HEART_SYNCH_SV for D_NYEC_PA_HEART_SYNCH_SV;
grant select on D_NYEC_PA_HEART_SYNCH_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DNPAMC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MODE_CODE 
  (DNPAMC_ID number, 
	 "Mode Code" varchar2(2))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_MODE_CODE add constraint DNPAMC_PK primary key (DNPAMC_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAMC_UIX1 on D_NYEC_PA_MODE_CODE ("Mode Code") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_MODE_CODE for D_NYEC_PA_MODE_CODE;
grant select on D_NYEC_PA_MODE_CODE to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_MODE_CODE_SV as
select * from D_NYEC_PA_MODE_CODE
with read only;

create or replace public synonym D_NYEC_PA_MODE_CODE_SV for D_NYEC_PA_MODE_CODE_SV;
grant select on D_NYEC_PA_MODE_CODE_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_MODE_CODE (DNPAMC_ID,"Mode Code") values (SEQ_DNPAMC_ID.nextval,null);
commit;


create sequence SEQ_DNPAML_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MODE_LABEL 
  (DNPAML_ID number, 
	 "Mode Label" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_MODE_LABEL add constraint DNPAML_PK primary key (DNPAML_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAML_UIX1 on D_NYEC_PA_MODE_LABEL ("Mode Label") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_MODE_LABEL for D_NYEC_PA_MODE_LABEL;
grant select on D_NYEC_PA_MODE_LABEL to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_MODE_LABEL_SV as
select * from D_NYEC_PA_MODE_LABEL
with read only;

create or replace public synonym D_NYEC_PA_MODE_LABEL_SV for D_NYEC_PA_MODE_LABEL_SV;
grant select on D_NYEC_PA_MODE_LABEL_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_MODE_LABEL (DNPAML_ID,"Mode Label") values (SEQ_DNPAML_ID.nextval,null);
commit;


create sequence SEQ_DNPAOLS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_OUTCOM_LTR_STATUS 
  (DNPAOLS_ID number, 
   "Outcome Letter Status" varchar2(32))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_OUTCOM_LTR_STATUS add constraint DNPAOLS_PK primary key (DNPAOLS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAOLS_UIX1 on D_NYEC_PA_OUTCOM_LTR_STATUS ("Outcome Letter Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_OUTCOM_LTR_STATUS for D_NYEC_PA_OUTCOM_LTR_STATUS;
grant select on D_NYEC_PA_OUTCOM_LTR_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_OUTCOM_LTR_STATUS_SV as
select * from D_NYEC_PA_OUTCOM_LTR_STATUS
with read only;

create or replace public synonym D_NYEC_PA_OUTCOM_LTR_STATUS_SV for D_NYEC_PA_OUTCOM_LTR_STATUS_SV;
grant select on D_NYEC_PA_OUTCOM_LTR_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_OUTCOM_LTR_STATUS (DNPAOLS_ID,"Outcome Letter Status") values (SEQ_DNPAOLS_ID.nextval,null);
commit;


create sequence SEQ_DNPAONF_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_OUTCOME_NOTF_FLAG
  (DNPAONF_ID number, 
   "Outcome Notif Req Flag" varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_OUTCOME_NOTF_FLAG add constraint DNPAONF_PK primary key (DNPAONF_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAONF_UIX1 on D_NYEC_PA_OUTCOME_NOTF_FLAG ("Outcome Notif Req Flag") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_OUTCOME_NOTF_FLAG for D_NYEC_PA_OUTCOME_NOTF_FLAG;
grant select on D_NYEC_PA_OUTCOME_NOTF_FLAG to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_OUTCOME_NOTF_FLAG_SV as
select * from D_NYEC_PA_OUTCOME_NOTF_FLAG
with read only;

create or replace public synonym D_NYEC_PA_OUTCOME_NOTF_FLAG_SV for D_NYEC_PA_OUTCOME_NOTF_FLAG_SV;
grant select on D_NYEC_PA_OUTCOME_NOTF_FLAG_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_OUTCOME_NOTF_FLAG (DNPAONF_ID,"Outcome Notif Req Flag") values (SEQ_DNPAONF_ID.nextval,null);
commit;


create sequence SEQ_DNPARI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATION_IND 
  (DNPARI_ID number, 
   "Reactivation Indicator" number)
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_REACTIVATION_IND add constraint DNPARI_PK primary key (DNPARI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPARI_UIX1 on D_NYEC_PA_REACTIVATION_IND ("Reactivation Indicator") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_REACTIVATION_IND for D_NYEC_PA_REACTIVATION_IND;
grant select on D_NYEC_PA_REACTIVATION_IND to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_REACTIVATION_IND_SV as
select * from D_NYEC_PA_REACTIVATION_IND
with read only;

create or replace public synonym D_NYEC_PA_REACTIVATION_IND_SV for D_NYEC_PA_REACTIVATION_IND_SV;
grant select on D_NYEC_PA_REACTIVATION_IND_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_REACTIVATION_IND (DNPARI_ID,"Reactivation Indicator") values (SEQ_DNPARI_ID.nextval,null);
commit;  


create sequence SEQ_DNPARR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATE_REASON 
  (DNPARR_ID number, 
   "Reactivation Reason" varchar2(32))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_REACTIVATE_REASON add constraint DNPARR_PK primary key (DNPARR_ID) using index tablespace MAXDAT_INDX;

create unique index DNPARR_UIX1 on D_NYEC_PA_REACTIVATE_REASON ("Reactivation Reason") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_REACTIVATE_REASON for D_NYEC_PA_REACTIVATE_REASON;
grant select on D_NYEC_PA_REACTIVATE_REASON to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_REACTIVATE_REASON_SV as
select * from D_NYEC_PA_REACTIVATE_REASON
with read only;

create or replace public synonym D_NYEC_PA_REACTIVATE_REASON_SV for D_NYEC_PA_REACTIVATE_REASON_SV;
grant select on D_NYEC_PA_REACTIVATE_REASON_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_REACTIVATE_REASON (DNPARR_ID,"Reactivation Reason") values (SEQ_DNPARR_ID.nextval,null);
commit;


create sequence SEQ_DNPARB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATED_BY 
  (DNPARB_ID number, 
	 "Reactivated By" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_REACTIVATED_BY add constraint DNPARB_PK primary key (DNPARB_ID) using index tablespace MAXDAT_INDX;

create unique index DNPARB_UIX1 on D_NYEC_PA_REACTIVATED_BY ("Reactivated By") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_REACTIVATED_BY for D_NYEC_PA_REACTIVATED_BY;
grant select on D_NYEC_PA_REACTIVATED_BY to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_REACTIVATED_BY_SV as
select * from D_NYEC_PA_REACTIVATED_BY
with read only;

create or replace public synonym D_NYEC_PA_REACTIVATED_BY_SV for D_NYEC_PA_REACTIVATED_BY_SV;
grant select on D_NYEC_PA_REACTIVATED_BY_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_REACTIVATED_BY (DNPARB_ID,"Reactivated By") values (SEQ_DNPARB_ID.nextval,null);
commit;


create sequence SEQ_DNPARN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 267
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATION_NUM 
  (DNPARN_ID number, 
	 "Reactivation Number" number not null)
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_REACTIVATION_NUM add constraint DNPARN_PK primary key (DNPARN_ID) using index tablespace MAXDAT_INDX;

create unique index DNPARN_UIX1 on D_NYEC_PA_REACTIVATION_NUM ("Reactivation Number") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_REACTIVATION_NUM for D_NYEC_PA_REACTIVATION_NUM;
grant select on D_NYEC_PA_REACTIVATION_NUM to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_REACTIVATION_NUM_SV as
select * from D_NYEC_PA_REACTIVATION_NUM
with read only;

create or replace public synonym D_NYEC_PA_REACTIVATION_NUM_SV for D_NYEC_PA_REACTIVATION_NUM_SV;
grant select on D_NYEC_PA_REACTIVATION_NUM_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_REACTIVATION_NUM (DNPARN_ID,"Reactivation Number") values (SEQ_DNPARN_ID.nextval,0);
commit;


create sequence SEQ_DNPAWRI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_WORKFLOW_REAC_IND 
  (DNPAWRI_ID number, 
   "Workflow Reactivation Ind" varchar2(1))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_WORKFLOW_REAC_IND add constraint DNPAWRI_PK primary key (DNPAWRI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAWRI_UIX1 on D_NYEC_PA_WORKFLOW_REAC_IND ("Workflow Reactivation Ind") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_WORKFLOW_REAC_IND for D_NYEC_PA_WORKFLOW_REAC_IND;
grant select on D_NYEC_PA_WORKFLOW_REAC_IND to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_WORKFLOW_REAC_IND_SV as
select * from D_NYEC_PA_WORKFLOW_REAC_IND
with read only;

create or replace public synonym D_NYEC_PA_WORKFLOW_REAC_IND_SV for D_NYEC_PA_WORKFLOW_REAC_IND_SV;
grant select on D_NYEC_PA_WORKFLOW_REAC_IND_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_WORKFLOW_REAC_IND (DNPAWRI_ID,"Workflow Reactivation Ind") values (SEQ_DNPAWRI_ID.nextval,null);
commit;


create sequence SEQ_DNPAQI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_QC_INDICATOR 
  (DNPAQI_ID number, 
   "QC Indicator" varchar2(1))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_QC_INDICATOR add constraint DNPAQI_PK primary key (DNPAQI_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAQI_UIX1 on D_NYEC_PA_QC_INDICATOR ("QC Indicator") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_QC_INDICATOR for D_NYEC_PA_QC_INDICATOR;
grant select on D_NYEC_PA_QC_INDICATOR to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_QC_INDICATOR_SV as
select * from D_NYEC_PA_QC_INDICATOR
with read only;

create or replace public synonym D_NYEC_PA_QC_INDICATOR_SV for D_NYEC_PA_QC_INDICATOR_SV;
grant select on D_NYEC_PA_QC_INDICATOR_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_QC_INDICATOR (DNPAQI_ID,"QC Indicator") values (SEQ_DNPAQI_ID.nextval,null);
commit;


--v4
create sequence SEQ_DNPAMAR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MA_REASON 
  (DNPAMAR_ID number, 
   MA_REASON varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_MA_REASON add constraint DNPAMAR_PK primary key (DNPAMAR_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAMAR_UIX1 on D_NYEC_PA_MA_REASON (MA_REASON) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_MA_REASON for D_NYEC_PA_MA_REASON;
grant select on D_NYEC_PA_MA_REASON to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_MA_REASON_SV as
select * from D_NYEC_PA_MA_REASON
with read only;

create or replace public synonym D_NYEC_PA_MA_REASON_SV for D_NYEC_PA_MA_REASON_SV;
grant select on D_NYEC_PA_MA_REASON_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_MA_REASON (DNPAMAR_ID,MA_REASON) values (SEQ_DNPAMAR_ID.nextval,null);
commit;


create sequence SEQ_DNPARCR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REV_CLEAR_REASON 
  (DNPARCR_ID number, 
   REVERSE_CLEARANCE_REASON varchar2(50))
tablespace MAXDAT_DATA;

alter table D_NYEC_PA_REV_CLEAR_REASON add constraint DNPARCR_PK primary key (DNPARCR_ID) using index tablespace MAXDAT_INDX;

create unique index DNPARCR_UIX1 on D_NYEC_PA_REV_CLEAR_REASON (REVERSE_CLEARANCE_REASON) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYEC_PA_REV_CLEAR_REASON for D_NYEC_PA_REV_CLEAR_REASON;
grant select on D_NYEC_PA_REV_CLEAR_REASON to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PA_REV_CLEAR_REASON_SV as
select * from D_NYEC_PA_REV_CLEAR_REASON
with read only;

create or replace public synonym D_NYEC_PA_REV_CLEAR_REASON_SV for D_NYEC_PA_REV_CLEAR_REASON_SV;
grant select on D_NYEC_PA_REV_CLEAR_REASON_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PA_REV_CLEAR_REASON (DNPARCR_ID,REVERSE_CLEARANCE_REASON) values (SEQ_DNPARCR_ID.nextval,null);
commit;


create sequence SEQ_FNPABD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_PA_BY_DATE
  (FNPABD_ID number not null, 
   D_DATE date not null, 
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   NYEC_PA_BI_ID number not null, 
   DNPAAS_ID number not null, 
   DNPACOU_ID number not null, 
   DNPAHS_ID number not null, 
   "Receipt Date" date,
   CREATION_COUNT number, 
   INVENTORY_COUNT number, 
   COMPLETION_COUNT number,
   DNPACIN_ID number not null,
   DNPAFPBPST_ID number not null,
   DNPAHIAI_ID number,
   "Invoiceable Date" date,
   DNPAHCS_ID number not null,
   DNPARI_ID number not null, 
   DNPARR_ID number not null,
   DNPARB_ID number not null,
   DNPARN_ID number not null,
   DNPAMC_ID number not null,
   DNPAML_ID number not null,
   DNPAONF_ID number not null,
   DNPAOLS_ID number not null,
   DNPAWRI_ID number not null,
   DNPAQI_ID number not null,
   DNPAMAR_ID number not null,
   DNPARCR_ID number not null,
   "Reactivation Date" date)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table F_NYEC_PA_BY_DATE add constraint FNPABD_PK primary key (FNPABD_ID) using index tablespace MAXDAT_INDX;

create unique index FNPABD_UIX1 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FNPABD_UIX2 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FNPABD_IX1 on F_NYEC_PA_BY_DATE ("Receipt Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IX2 on F_NYEC_PA_BY_DATE ("Invoiceable Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IX3 on F_NYEC_PA_BY_DATE ("Reactivation Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FNPABD_IXL1 on F_NYEC_PA_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL2 on F_NYEC_PA_BY_DATE (NYEC_PA_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL3 on F_NYEC_PA_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPABD_IXL4 on F_NYEC_PA_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAAS_FK foreign key (DNPAAS_ID) references D_NYEC_PA_APP_STATUS (DNPAAS_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPACUR_FK foreign key (NYEC_PA_BI_ID) references D_NYEC_PA_CURRENT (NYEC_PA_BI_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPACOU_FK foreign key (DNPACOU_ID) references D_NYEC_PA_COUNTY (DNPACOU_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHS_FK foreign key (DNPAHS_ID) references D_NYEC_PA_HEART_SYNCH (DNPAHS_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPACIN_FK foreign key (DNPACIN_ID) references D_NYEC_PA_CIN(DNPACIN_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAFPBPST_FK foreign key (DNPAFPBPST_ID) references D_NYEC_PA_FPBP_SUBTYPE(DNPAFPBPST_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHIAI_FK foreign key (DNPAHIAI_ID) references D_NYEC_PA_HEART_INC_APP_IND(DNPAHIAI_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHCS_FK foreign key (DNPAHCS_ID) references D_NYEC_PA_HEART_CASE_STATUS(DNPAHCS_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARI_FK foreign key (DNPARI_ID) references D_NYEC_PA_HEART_CASE_STATUS(DNPAHCS_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHCS_FK foreign key (DNPAHCS_ID) references D_NYEC_PA_HEART_CASE_STATUS(DNPAHCS_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARR_FK foreign key (DNPARR_ID) references D_NYEC_PA_REACTIVATE_REASON(DNPARR_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARB_FK foreign key (DNPARB_ID) references D_NYEC_PA_REACTIVATED_BY(DNPARB_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARN_FK foreign key (DNPARN_ID) references D_NYEC_PA_REACTIVATION_NUM(DNPARN_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAMC_FK foreign key (DNPAMC_ID) references D_NYEC_PA_MODE_CODE(DNPAMC_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAML_FK foreign key (DNPAML_ID) references D_NYEC_PA_MODE_LABEL(DNPAML_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAONF_FK foreign key (DNPAONF_ID) references D_NYEC_PA_OUTCOME_NOTF_FLAG(DNPAONF_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAOLS_FK foreign key (DNPAOLS_ID) references D_NYEC_PA_OUTCOM_LTR_STATUS(DNPAOLS_ID);   
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAWRI_FK foreign key (DNPAWRI_ID) references D_NYEC_PA_WORKFLOW_REAC_IND(DNPAWRI_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAQI_FK foreign key (DNPAQI_ID) references D_NYEC_PA_QC_INDICATOR(DNPAQI_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAMAR_FK foreign key (DNPAMAR_ID) references D_NYEC_PA_MA_REASON(DNPAMAR_ID);
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARCR_FK foreign key (DNPARCR_ID) references D_NYEC_PA_REV_CLEAR_REASON(DNPARCR_ID);

create or replace public synonym F_NYEC_PA_BY_DATE for F_NYEC_PA_BY_DATE;
grant select on F_NYEC_PA_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_PA_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNPABD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from F_NYEC_PA_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNPABD_ID,
  bdd.D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from 
  F_NYEC_PA_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNPABD_ID,
  bdd.D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID,
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNPABD_ID,
  bdd.D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_NYEC_PA_BY_DATE_SV for F_NYEC_PA_BY_DATE_SV;
grant select on F_NYEC_PA_BY_DATE_SV to MAXDAT_READ_ONLY;


create or replace View REL_TASK_APP_SV as
select
  dmwcur.MW_BI_ID as mw_bi_id,
  dnpacur.NYEC_PA_BI_ID as nyec_pa_bi_id
from
  D_MW_CURRENT dmwcur, 
  D_NYEC_PA_CURRENT dnpacur
where
  dmwcur."Source Reference ID" = dnpacur."Application ID"
  and dmwcur."Source Reference Type" = 'Application ID' 
with read only;

create or replace public synonym REL_TASK_APP_SV for REL_TASK_APP_SV;
grant select on REL_TASK_APP_SV to MAXDAT_READ_ONLY;

