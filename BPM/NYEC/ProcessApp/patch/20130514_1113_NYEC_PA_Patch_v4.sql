--attribute lookup
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (616,2,'Reverse Clearance Reason','The reverse clearance reason is the reason clearance is being performed on the application (Dropdown to include: SSN, Date of Birth, Name(full legal), and Residence Address )');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (617,2,'MA Reason','The MA Reason provides the application result detail for FPBP Downstate applications. The detail includes the acceptance reason or the denial reason.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (480,1,'Provider ID','The unique ID per provider site');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (619,1,'Applicant ID','The Maxe Identifier for the applicant on the FPBP application');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (620,1,'Registration Task ID','Task ID identifying the Application Registration task created for the application. Will only be created on FPBP and PE types');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (621,1,'QC Registration Task ID','Task ID identifying the QC application registration task created for the FPBP application. This is the initial QC task created after the application registration task is completed and only on FPBP type = PE');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (622,3,'Perform QC Reg Date','Date the QC application registration task was completed');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (623,3,'Reg and Enter Data Start Date','Date work started for the Review and Enter Data App activity step.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (624,3,'Perform QC Reg Start Date','Date work started for the Perform QC activity step. This is the earliest of the first date the QC task was claimed or the QC task completion date');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (625,2,'Reg and Enter Data Performed By','Name of the staff member that completed the "Review and Enter Data" activity step. This is the person that completed the data entry task.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (626,2,'Perform QC Reg Performed By','Name of the staff member that completed the "Perform QC" activity step. This is the name of the staff member that completed the QC Task as captured in the "QC Task ID" attribute.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (627,1,'Number of Applicants','The number of applying clients associated to the application.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (721,3,'Perform Reg Enter Data Dt','Date the application registration task was completed.');

commit;

--attribute
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1592,616,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1593,617,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1594,480,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1595,619,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1596,620,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1597,621,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1598,622,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1599,623,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1600,624,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1601,625,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1602,626,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1603,627,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1604,721,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
commit;

--attribute staging
--v4
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1592,2,'REV_CLEAR_REASON');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1593,2,'MA_REASON');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1594,2,'OFFICE_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1595,2,'APPLICANT_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1596,2,'REG_TASK_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1597,2,'QC_REG_TASK_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1598,2,'PERFORM_QC_REG_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1599,2,'ASSD_REG_ENTER_DATA');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1600,2,'ASSD_PERFORM_QC_REG');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1601,2,'ASPB_REG_ENTER_DATA');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1602,2,'ASPB_PERFORM_QC_REG');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1603,2,'NUMBER_OF_APPLICANTS');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1604,2,'REG_ENTER_DATA_DT');
commit;

--semantic model
create sequence SEQ_DNPAMAR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_MA_REASON 
  (DNPAMAR_ID number, 
   MA_REASON VARCHAR2(50))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_MA_REASON add constraint DNPAMAR_PK primary key (DNPAMAR_ID);
alter index DNPAMAR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAMAR_UIX1 on D_NYEC_PA_MA_REASON (MA_REASON) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_MA_REASON_SV as
select * from D_NYEC_PA_MA_REASON
with read only;

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
   REVERSE_CLEARANCE_REASON VARCHAR2(50))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_REV_CLEAR_REASON add constraint DNPARCR_PK primary key (DNPARCR_ID);
alter index DNPARCR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPARCR_UIX1 on D_NYEC_PA_REV_CLEAR_REASON (REVERSE_CLEARANCE_REASON) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_NYEC_PA_REV_CLEAR_REASON_SV as
select * from D_NYEC_PA_REV_CLEAR_REASON
with read only;

insert into D_NYEC_PA_REV_CLEAR_REASON (DNPARCR_ID,REVERSE_CLEARANCE_REASON) values (SEQ_DNPARCR_ID.nextval,null);

commit;

alter table D_NYEC_PA_CURRENT add CUR_MA_REASON VARCHAR2 (50) null;
alter table D_NYEC_PA_CURRENT add PROVIDER_ID NUMBER null;
alter table D_NYEC_PA_CURRENT add APPLICANT_ID NUMBER null;
alter table D_NYEC_PA_CURRENT add REGISTRATION_TASK_ID NUMBER null;
alter table D_NYEC_PA_CURRENT add QC_REGISTRATION_TASK_ID NUMBER null;
alter table D_NYEC_PA_CURRENT add PERFORM_QC_REG_START_DATE DATE null;
alter table D_NYEC_PA_CURRENT add PERFORM_QC_REG_PERFORMED_BY VARCHAR2 (100) null;
alter table D_NYEC_PA_CURRENT add REG_AND_ENTER_DATA_PERFORM_BY VARCHAR2 (100) null;
alter table D_NYEC_PA_CURRENT add REG_AND_ENTER_DATA_START_DATE DATE null;
alter table D_NYEC_PA_CURRENT add PERFORM_QC_REG_DATE DATE null;
alter table D_NYEC_PA_CURRENT add CUR_REVERSE_CLEARANCE_REASON VARCHAR2 (50) null;
alter table D_NYEC_PA_CURRENT add NUMBER_OF_APPLICANTS NUMBER null;
alter table D_NYEC_PA_CURRENT add PERFORM_REG_ENTER_DATA_DATE DATE null;

alter table D_NYEC_PA_CURRENT add PROVIDER_ID NUMBER null;
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
  PERFORM_REG_ENTER_DATA_DATE,
  cast (((sysdate - "KPR App Cycle End Date") - 30) as numeric) as "Days Left to Reactivate"
from D_NYEC_PA_CURRENT dnpacur
with read only;


alter table F_NYEC_PA_BY_DATE add DNPAMAR_ID number null;
alter table F_NYEC_PA_BY_DATE add DNPARCR_ID number null;

update F_NYEC_PA_BY_DATE set DNPAMAR_ID=265,DNPARCR_ID=265;
commit;

alter table F_NYEC_PA_BY_DATE modify (DNPAMAR_ID not null);
alter table F_NYEC_PA_BY_DATE modify (DNPARCR_ID not null);

alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAMAR_FK 
foreign key (DNPAMAR_ID) references D_NYEC_PA_MA_REASON(DNPAMAR_ID);

alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPARCR_FK 
foreign key (DNPARCR_ID) references D_NYEC_PA_REV_CLEAR_REASON(DNPARCR_ID);

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
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 and INVENTORY_COUNT = 0 then 0
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
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
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
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only; 




