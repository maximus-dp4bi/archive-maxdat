--- Patch for BPM_ATTRIBUTE_LKUP
update BPM_ATTRIBUTE_LKUP 
set 
  NAME = 'CIN Date',
  PURPOSE = 'The CIN Date is the date that the CIN is created or updated, and then saved in MAXe.'
where 
  BAL_ID = 332 
  and NAME = 'CIN  Date';

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (351,2,'HEART Case Status','The HEART Case Status is the status of the HEART case associated with the renewal application and does not apply to FPBP.');

-- Patch for BPM_ATTRIBUTE
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (425,351,2,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (426,260,2,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'),'N');

-- Patch for BPM_ATTRIBUTE_STAGING_TABLE
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,425,2,'HEART_CASE_STATUS');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,426,2,'STATE_CASE_IDEN');

commit;


-- D_NYEC_PA_HEART_CASE_STATUS semantic model
create sequence SEQ_DNPAHCS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_HEART_CASE_STATUS
  (DNPAHCS_ID number not null,
   "HEART Case Status" varchar2(50))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_HEART_CASE_STATUS add constraint DNPAHCS_PK primary key (DNPAHCS_ID);
alter index DNPAHCS_PK rebuild  online tablespace MAXDAT_INDX parallel;

create unique index DNPAHCS_UIX1 on D_NYEC_PA_HEART_CASE_STATUS ("HEART Case Status") online tablespace MAXDAT_INDX parallel compute statistics;    

create or replace view D_NYEC_PA_HEART_CASE_STATUS_SV as
select * from D_NYEC_PA_HEART_CASE_STATUS
with read only;

insert into D_NYEC_PA_HEART_CASE_STATUS (DNPAHCS_ID,"HEART Case Status") values (SEQ_DNPAHCS_ID.nextval,null);
commit;


alter table D_NYEC_PA_CURRENT add
  ("Cur HEART Case Status" varchar2(50),
   "State Case Identifier" varchar2(15));

alter table F_NYEC_PA_BY_DATE add (DNPAHCS_ID number);
   
update F_NYEC_PA_BY_DATE
set DNPAHCS_ID = 265;
commit;

create or replace view D_NYEC_PA_CURRENT_SV as
select
  NYEC_PA_BI_ID, 
  "Application ID", 
  "Age in Business Days", 
  "Age in Calendar Days", 
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
  "Outcome Notification Rqrd Flag", 
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
  "State Case Identifier"
from D_NYEC_PA_CURRENT dnpacur
with read only;


alter table F_NYEC_PA_BY_DATE modify (DNPAHCS_ID number not null);

alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHCS_FK 
foreign key (DNPAHCS_ID) references D_NYEC_PA_HEART_CASE_STATUS(DNPAHCS_ID);

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
  DNPAHCS_ID
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
  DNPAHCS_ID
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;
