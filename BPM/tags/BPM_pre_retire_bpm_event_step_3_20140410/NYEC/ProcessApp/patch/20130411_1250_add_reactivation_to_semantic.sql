--PROCESS APPS REACTIVATIONS

alter table D_NYEC_PA_CURRENT rename column "Outcome Notification Rqrd Flag" to "Outcome Notif Req Gateway Flag"; 

ALTER TABLE d_nyec_pa_current
  ADD ( "Cur Reactivation Indicator"                      NUMBER, --****X
        "Cur Reactivation Date"                           DATE, --**** in F
        "Cur Reactivation Reason"                         VARCHAR2(32), --****X
        "Cur Reactivated By"                              VARCHAR2(100), --****X
        "Cur Reactivation Number"                         NUMBER, --****X
        "Cur Mode Code"                                   VARCHAR2(2), --****X
        "Cur Mode Label"                                  VARCHAR2(50), --****X
        "Cur Outcome Notif Req Flag"                      VARCHAR2(1), --****X
        "Outcome Letter ID"                               NUMBER,
        "Outcome Letter Type"                             VARCHAR2(100),
        "Cur Outcome Letter Status"                       VARCHAR2(32), --****X
        "Outcome Letter Send Date"                        DATE,
        "Outcome Letter Create Date"                      DATE,
        "Cur Stop Application Reason"                     VARCHAR2(100), --****X
        "Cur Workflow Reactivation Ind"                   VARCHAR2(1), --****X
        "Cur QC Indicator"                                VARCHAR2(1)
        );
        
update D_NYEC_PA_CURRENT
set "Cur Reactivation Number" = 0;

commit;
        
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


--D_NYEC_PA_REACTIVATION_IND  DNPARI_ID
create sequence SEQ_DNPARI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATION_IND 
  (DNPARI_ID number, 
	 "Reactivation Indicator" NUMBER)
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_REACTIVATION_IND add constraint DNPARI_PK primary key (DNPARI_ID);
alter index DNPARI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPARI_UIX1 on D_NYEC_PA_REACTIVATION_IND ("Reactivation Indicator") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REACTIVATION_IND_SV as
select * from D_NYEC_PA_REACTIVATION_IND
with read only;

insert into D_NYEC_PA_REACTIVATION_IND (DNPARI_ID ,"Reactivation Indicator") values (SEQ_DNPARI_ID.nextval,null);
commit;  



--D_NYEC_PA_REACTIVATION_REASON  DNPARR_ID Reactivation Reason
create sequence SEQ_DNPARR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATE_REASON 
  (DNPARR_ID number, 
	 "Reactivation Reason" VARCHAR2(32))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_REACTIVATE_REASON add constraint DNPARR_PK primary key (DNPARR_ID);
alter index DNPARR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPARR_UIX1 on D_NYEC_PA_REACTIVATE_REASON ("Reactivation Reason") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REACTIVATE_REASON_SV as
select * from D_NYEC_PA_REACTIVATE_REASON
with read only;

insert into D_NYEC_PA_REACTIVATE_REASON (DNPARR_ID ,"Reactivation Reason") values (SEQ_DNPARR_ID.nextval,null);
commit;  

--D_NYEC_PA_REACTIVATED_BY  DNPARB_ID "Reactivated By"
create sequence SEQ_DNPARB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATED_BY 
  (DNPARB_ID number, 
	 "Reactivated By" VARCHAR2(100))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_REACTIVATED_BY add constraint DNPARB_PK primary key (DNPARB_ID);
alter index DNPARB_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPARB_UIX1 on D_NYEC_PA_REACTIVATED_BY ("Reactivated By") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REACTIVATED_BY_SV as
select * from D_NYEC_PA_REACTIVATED_BY
with read only;

insert into D_NYEC_PA_REACTIVATED_BY (DNPARB_ID ,"Reactivated By") values (SEQ_DNPARB_ID.nextval,null);
commit;  

--D_NYEC_PA_REACTIVATION_NUM  DNPARN_ID "Reactivation Number"
create sequence SEQ_DNPARN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 267
increment by 1
cache 20;

create table D_NYEC_PA_REACTIVATION_NUM 
  (DNPARN_ID number, 
	 "Reactivation Number" NUMBER not null)
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_REACTIVATION_NUM add constraint DNPARN_PK primary key (DNPARN_ID);
alter index DNPARN_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPARN_UIX1 on D_NYEC_PA_REACTIVATION_NUM ("Reactivation Number") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REACTIVATION_NUM_SV as
select * from D_NYEC_PA_REACTIVATION_NUM
with read only;

insert into D_NYEC_PA_REACTIVATION_NUMBER (DNPARN_ID,"Reactivation Number") values (SEQ_DNPARN_ID.nextval,0);
commit;


--D_NYEC_PA_MODE_CODE  DNPAMC_ID "Mode Code"
create sequence SEQ_DNPAMC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MODE_CODE 
  (DNPAMC_ID number, 
	 "Mode Code" VARCHAR2(2))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_MODE_CODE add constraint DNPAMC_PK primary key (DNPAMC_ID);
alter index DNPAMC_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAMC_UIX1 on D_NYEC_PA_MODE_CODE ("Mode Code") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_MODE_CODE_SV as
select * from D_NYEC_PA_MODE_CODE
with read only;

insert into D_NYEC_PA_MODE_CODE (DNPAMC_ID ,"Mode Code") values (SEQ_DNPAMC_ID.nextval,null);
commit;

--D_NYEC_PA_MODE_LABEL  DNPAML_ID "Mode Label"
create sequence SEQ_DNPAML_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MODE_LABEL 
  (DNPAML_ID number, 
	 "Mode Label" VARCHAR2(50))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_MODE_LABEL add constraint DNPAML_PK primary key (DNPAML_ID);
alter index DNPAML_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAML_UIX1 on D_NYEC_PA_MODE_LABEL ("Mode Label") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_MODE_LABEL_SV as
select * from D_NYEC_PA_MODE_LABEL
with read only;

insert into D_NYEC_PA_MODE_LABEL (DNPAML_ID ,"Mode Label") values (SEQ_DNPAML_ID.nextval,null);
commit;


--D_NYEC_PA_OUTCOME_NOTF_FLG  DNPAONF_ID "Outcome Notif Req Flag"
create sequence SEQ_DNPAONF_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_OUTCOME_NOTF_FLAG
  (DNPAONF_ID number, 
   "Outcome Notif Req Flag" VARCHAR2(50))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_OUTCOME_NOTF_FLAG add constraint DNPAONF_PK primary key (DNPAONF_ID);
alter index DNPAONF_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAONF_UIX1 on D_NYEC_PA_OUTCOME_NOTF_FLAG ("Outcome Notif Req Flag") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_OUTCOME_NOTF_FLG_SV as
select * from D_NYEC_PA_OUTCOME_NOTF_FLAG
with read only;

insert into D_NYEC_PA_OUTCOME_NOTF_FLAG (DNPAONF_ID ,"Outcome Notif Req Flag") values (SEQ_DNPAONF_ID.nextval,null);
commit;


--D_NYEC_PA_OUTCOM_LTR_STATUS DNPAOLS_ID "Outcome Letter Status"
create sequence SEQ_DNPAOLS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_OUTCOM_LTR_STATUS 
  (DNPAOLS_ID number, 
   "Outcome Letter Status" VARCHAR2(32))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_OUTCOM_LTR_STATUS add constraint DNPAOLS_PK primary key (DNPAOLS_ID);
alter index DNPAOLS_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAOLS_UIX1 on D_NYEC_PA_OUTCOM_LTR_STATUS ("Outcome Letter Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_OUTCOM_LTR_STATUS_SV as
select * from D_NYEC_PA_OUTCOM_LTR_STATUS
with read only;

insert into D_NYEC_PA_OUTCOM_LTR_STATUS (DNPAOLS_ID ,"Outcome Letter Status") values (SEQ_DNPAOLS_ID.nextval,null);
commit;


--
--D_NYEC_PA_STOP_APP_REASON DNPASAR_ID "Stop Application Reason"
create sequence SEQ_DNPASAR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_STOP_APP_REASON 
  (DNPASAR_ID number, 
   "Stop Application Reason" VARCHAR2(100))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_STOP_APP_REASON add constraint DNPASAR_PK primary key (DNPASAR_ID);
alter index DNPASAR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPASAR_UIX1 on D_NYEC_PA_STOP_APP_REASON ("Stop Application Reason") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_STOP_APP_REASON_SV as
select * from D_NYEC_PA_STOP_APP_REASON
with read only;

insert into D_NYEC_PA_STOP_APP_REASON (DNPASAR_ID ,"Stop Application Reason") values (SEQ_DNPASAR_ID.nextval,null);
commit;

--"Workflow Reactivation Ind"              VARCHAR2(1), --****
--D_NYEC_PA_WORKFLOW_REAC_IND DNPAWRI_ID "Workflow Reactivation Ind" 
create sequence SEQ_DNPAWRI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_WORKFLOW_REAC_IND 
  (DNPAWRI_ID number, 
   "Workflow Reactivation Ind" VARCHAR2(1))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_WORKFLOW_REAC_IND add constraint DNPAWRI_PK primary key (DNPAWRI_ID);
alter index DNPAWRI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAWRI_UIX1 on D_NYEC_PA_WORKFLOW_REAC_IND ("Workflow Reactivation Ind") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_WORKFLOW_REAC_IND_SV as
select * from D_NYEC_PA_WORKFLOW_REAC_IND
with read only;

insert into D_NYEC_PA_WORKFLOW_REAC_IND (DNPAWRI_ID ,"Workflow Reactivation Ind") values (SEQ_DNPAWRI_ID.nextval,null);
commit;


--D_NYEC_PA_QC_INDICATOR DNPAQI_ID "QC Indicator" 
create sequence SEQ_DNPAQI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_QC_INDICATOR 
  (DNPAQI_ID number, 
   "QC Indicator" VARCHAR2(1))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_QC_INDICATOR add constraint DNPAQI_PK primary key (DNPAQI_ID);
alter index DNPAQI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAQI_UIX1 on D_NYEC_PA_QC_INDICATOR ("QC Indicator") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_QC_INDICATOR_SV as
select * from D_NYEC_PA_QC_INDICATOR
with read only;

insert into D_NYEC_PA_QC_INDICATOR (DNPAQI_ID ,"QC Indicator") values (SEQ_DNPAQI_ID.nextval,null);
commit;


ALTER TABLE F_NYEC_PA_BY_DATE
ADD (DNPARI_ID NUMBER,
     DNPARR_ID    NUMBER,
     DNPARB_ID    NUMBER,
     DNPARN_ID    NUMBER,
     DNPAMC_ID    NUMBER,
     DNPAML_ID    NUMBER,
     DNPAONF_ID    NUMBER,
     DNPAOLS_ID    NUMBER,
     DNPASAR_ID    NUMBER,
     DNPAWRI_ID    NUMBER,
     DNPAQI_ID    NUMBER,
    "Reactivation Date"  DATE);
   
update F_NYEC_PA_BY_DATE 
set DNPARN_ID = 267;

commit;

alter table F_NYEC_PA_BY_DATE modify (DNPARN_ID number not null);

--D_NYEC_PA_REACTIVATION_IND  DNPARI_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARI_FK
foreign key (DNPARI_ID) references D_NYEC_PA_REACTIVATION_IND (DNPARI_ID);

--D_NYEC_PA_REACTIVATE_REASON  DNPARR_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARR_FK
foreign key (DNPARR_ID) references D_NYEC_PA_REACTIVATE_REASON (DNPARR_ID);

--D_NYEC_PA_REACTIVATED_BY  DNPARB_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARB_FK
foreign key (DNPARB_ID) references D_NYEC_PA_REACTIVATED_BY (DNPARB_ID);

--D_NYEC_PA_REACTIVATION_NUM  DNPARN_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARN_FK
foreign key (DNPARN_ID) references D_NYEC_PA_REACTIVATION_NUM (DNPARN_ID);

--D_NYEC_PA_MODE_CODE  DNPAMC_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAMC_FK
foreign key (DNPAMC_ID) references D_NYEC_PA_MODE_CODE (DNPAMC_ID);

--D_NYEC_PA_MODE_LABEL  DNPAML_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAML_FK
foreign key (DNPAML_ID) references D_NYEC_PA_MODE_LABEL (DNPAML_ID);

--D_NYEC_PA_OUTCOME_NOTF_FLAG  DNPAONF_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAONF_FK
foreign key (DNPAONF_ID) references D_NYEC_PA_OUTCOME_NOTF_FLAG (DNPAONF_ID);

--D_NYEC_PA_OUTCOM_LTR_STATUS DNPAOLS_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAOLS_FK
foreign key (DNPAOLS_ID) references D_NYEC_PA_OUTCOM_LTR_STATUS (DNPAOLS_ID);

--D_NYEC_PA_STOP_APP_REASON DNPASAR_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPASAR_FK
foreign key (DNPASAR_ID) references D_NYEC_PA_STOP_APP_REASON (DNPASAR_ID);

--D_NYEC_PA_WORKFLOW_REAC_IND DNPAWRI_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAWRI_FK
foreign key (DNPAWRI_ID) references D_NYEC_PA_WORKFLOW_REAC_IND (DNPAWRI_ID);

--D_NYEC_PA_QC_INDICATOR DNPAQI_ID
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAQI_FK
foreign key (DNPAQI_ID) references D_NYEC_PA_QC_INDICATOR (DNPAQI_ID);

create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  case 
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
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
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE >= fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpabd.BUCKET_END_DATE
union all
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
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
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;

