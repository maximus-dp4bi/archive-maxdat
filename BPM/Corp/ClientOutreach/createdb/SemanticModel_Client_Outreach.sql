create table D_COR_CURRENT
  (COR_BI_ID	number,
   OUTREACH_REQUEST_ID	number	not null,
   TRACKING_NUMBER varchar2(32) not null,
   RECEIPT_DATE	date	not null,
   ORIGIN varchar2(30) not null,
   ORIGIN_ID number,
   CREATE_DATE	date	not null,
   CREATED_BY varchar2(100) not null,
   OUTREACH_REQUEST_CATEGORY varchar2(128) not null,
   OUTREACH_REQUEST_TYPE varchar2(128),
   PRIORITY varchar2(80),
   CASE_ID number,
   CLIENT_ID number,
   SERVICE_AREA varchar2(32),
   COUNTY varchar2(64),
   PROGRAM_TYPE varchar2(30),
   SUBPROGRAM_TYPE varchar2(30),
   OUTREACH_REQUEST_STATUS varchar2(128) not null,
   OUTREACH_REQUEST_STATUS_DATE	date	not null,
   VALIDATION_ERROR varchar2(50),
   NOTIFY_INVALID_INDICATOR varchar2(1) not null,
   OUTREACH_STEP_1_TYPE varchar2(30) not null,
   OUTREACH_STEP_2_TYPE varchar2(30),
   OUTREACH_STEP_3_TYPE varchar2(30),
   OUTREACH_STEP_4_TYPE varchar2(30),
   OUTREACH_STEP_5_TYPE varchar2(30),
   OUTREACH_STEP_6_TYPE varchar2(30),
   CURRENT_TASK_ID number,
   CURRENT_TASK_TYPE varchar2(50),
   CURRENT_TASK_STATUS varchar2(32),
   SURVEY_ID number,
   SURVEY_TEMPLATE_NAME varchar2(256),
   CPW_NAME_OF_REFERRER VARCHAR2(4000),
   CPW_REFERRAL_DATE varchar2(4000),
   CPW_REFERRAL_SOURCE_TYPE varchar2(4000),
   CPW_REFERRAL_SOURCE_NAME varchar2(4000),
   CPW_REFERRAL_REASON varchar2(4000),
   CPW_REFERRAL_SOURCE_PHONE VARCHAR2(4000),
   CPW_CALL_BACK_INDICATOR varchar2(4000),
   CPW_PRIORITY_STATUS_REFERRAL varchar2(4000),
   PROVREF_PROVIDER_TYPE varchar2(4000),
   PROVREF_PROVIDER_CLINIC_NAME varchar2(4000),
   PROVREF_PROVIDER_CITY varchar2(4000),
   PROVREF_PROVIDER_COUNTY varchar2(4000),
   PROVREF_PROVIDER_ZIP_CODE varchar2(4000),
   PROVREF_PROV_DATE_REFERRED varchar2(4000),
   PROVREF_MISSED_APPT_IND varchar2(4000),
   PROVREF_MISSED_APPT_DATE varchar2(4000),
   PROVREF_MISSED_APPT_TYPE varchar2(4000),
   PROVREF_MISSED_APPT_OUTCOME varchar2(4000),
   PROVREF_MISSED_APPT_REASON varchar2(4000),
   PROVREF_LEAD_TEST_IND varchar2(4000),
   PROVREF_ASSIST_WITH_TRANS varchar2(4000),
   PROVREF_ASST_SCHEDULING_APPT varchar2(4000),
   PROVREF_UPD_PATIENT_ADDRESS varchar2(4000),
   PROVREF_OTHER varchar2(4000),
   PROVREF_OTHER_COMMENT varchar2(4000),
   CHECKUP_TYPE varchar2(4000),
   CHECKUP_TEXAS_WORKS_ADV_NAME varchar2(4000),
   CHECKUP_CARETAKER_RPTS_CHKUP varchar2(4000),
   CHECKUP_PROVIDER_NAME varchar2(4000),
   CHECKUP_DATE_REPORTED_CHKP varchar2(4000),
   EE_SCHEDULE_THSTEPS_APPT_IND varchar2(4000),
   EE_TRANSPORTATION_INDICATOR varchar2(4000),
   EE_NEED_MORE_INFO_INDICATOR varchar2(4000),
   EE_NEED_MORE_INFO_MEDICAL varchar2(4000),
   EE_NEED_MORE_INFO_DENTAL varchar2(4000),
   EE_NEED_MORE_INFO_CASE_MGMT varchar2(4000),
   EE_HELP_FINDING_PROVIDER_IND varchar2(4000),
   EE_PHONE_INDICATOR varchar2(4000),
   EE_HV_INDICATOR varchar2(4000),
   EE_MAIL_INDICATOR varchar2(4000),
   EE_OTHER_LANGUAGE_INDICATOR varchar2(4000),
   EE_INTERPRETER_NEEDED_IND varchar2(4000),
   EE_LANGUAGE varchar2(4000),
   HV_REQUEST_REASON varchar2(4000),
   HV_LANG_OTHER_THAN_ENG_IND varchar2(4000),
   HV_INTERPRETER_NEEDED_IND varchar2(4000),
   HV_LANGUAGE varchar2(4000),
   REMINDER_APPOINTMENT_TYPE varchar2(4000),
   REMINDER_APPOINTMENT_DATE varchar2(4000),
   REMINDER_PROV_CLINIC_NAME varchar2(4000),
   DELAY_DAYS_1 number,
   DELAY_DAYS_1_UNIT varchar2(32),
   DELAY_DAYS_2 number,
   DELAY_DAYS_2_UNIT varchar2(32),
   DELAY_DAYS_3 number,
   DELAY_DAYS_3_UNIT varchar2(32),
   LETTER_DEFINITION_1 number,
   LETTER_DEFINITION_2 number,
   LETTER_DEFINITION_3 number,
   HUMAN_TASK_TYPE_1 varchar2(32),
   HUMAN_TASK_TYPE_2 varchar2(32),
   GENERIC_FIELD_1 varchar2(50),
   GENERIC_FIELD_2 varchar2(50) not null,
   GENERIC_FIELD_3 varchar2(50),
   GENERIC_FIELD_4 varchar2(50),
   GENERIC_FIELD_5 varchar2(50),
   NOTIFY_OUTCOME_INDICATOR varchar2(1) not null,
   CLIENT_NOTIFICATION_ID number,
   OUTCOME_NOTIFICATION_TASK_ID number,
   LAST_UPDATE_DATE	date	not null,
   LAST_UPDATE_BY varchar2(100) not null,
   FINAL_WAIT_INDICATOR varchar2(10),
   FINAL_WAIT number,
   FINAL_WAIT_UNIT varchar2(32),
   COMPLETE_DATE date,
   CANCEL_DATE date,
   CANCEL_BY varchar2(100),
   CANCEL_REASON varchar2(100),
   CANCEL_METHOD varchar2(100),
   INSTANCE_STATUS varchar2(32) not null,
   VALIDATE_OR_START_DATE date,
   VALIDATE_OR_END_DATE date,
   VALIDATE_OR_PERFORM_BY varchar2(100),
   PERFORM_OUTREACH_START_DATE date,
   PERFORM_OUTREACH_END_DATE date,
   PERFORM_OUTREACH_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP1_START_DATE date,
   PERFORM_OR_STEP1_END_DATE date,
   PERFORM_OR_STEP1_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP2_START_DATE date,
   PERFORM_OR_STEP2_END_DATE date,
   PERFORM_OR_STEP2_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP3_START_DATE date,
   PERFORM_OR_STEP3_END_DATE date,
   PERFORM_OR_STEP3_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP4_START_DATE date,
   PERFORM_OR_STEP4_END_DATE date,
   PERFORM_OR_STEP4_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP5_START_DATE date,
   PERFORM_OR_STEP5_END_DATE date,
   PERFORM_OR_STEP5_PERFORM_BY varchar2(100),
   PERFORM_OR_STEP6_START_DATE date,
   PERFORM_OR_STEP6_END_DATE date,
   PERFORM_OR_STEP6_PERFORM_BY varchar2(100),
   PERFORM_HV_START_DATE date,
   PERFORM_HV_END_DATE date,
   PERFORM_HV_PERFORM_BY varchar2(100),
   WAIT_FOR_TT_START_DATE date,
   WAIT_FOR_TT_END_DATE date,
   NOTIFY_CLIENT_START_DATE date,
   NOTIFY_CLIENT_END_DATE date,
   NOTIFY_CLIENT_PERFORM_BY varchar2(100),
   NOTIFY_REF_SOURCE_START_DATE date,
   NOTIFY_REF_SOURCE_END_DATE date,
   NOTIFY_REF_SOURCE_PERFORM_BY varchar2(100),
   AGE_IN_BUSINESS_DAYS number,
   AGE_IN_CALENDAR_DAYS number,
   SLA_DAYS varchar2(30),
   SLA_DAYS_TYPE varchar2(32),
   SLA_JEOPARDY_DAYS number,
   SLA_JEOPARDY_DATE date,
   JEOPARDY_FLAG varchar2(32),
   TIMELINESS_STATUS varchar2(32),
   CYCLE_TIME number,
   INVALID_FLAG varchar2(1),
   OUTREACH_STEP_2_FLAG varchar2(1),
   OUTREACH_STEP_3_FLAG varchar2(1),
   OUTREACH_STEP_4_FLAG varchar2(1),
   OUTREACH_STEP_5_FLAG varchar2(1),
   OUTREACH_STEP_6_FLAG varchar2(1),
   UNSUCCESSFUL_FLAG varchar2(1),
   FINAL_WAIT_FLAG varchar2(1),
   SEND_CLIENT_NOTFICATION_FLAG varchar2(1),
   NOTIFY_SOURCE_FLAG varchar2(1),
   VALIDATE_REQUEST_FLAG varchar2(1) not null,
   PERFORM_OUTREACH_FLAG varchar2(1) not null,
   NOTIFY_CLIENT_FLAG varchar2(1) not null,
   NOTIFY_REFERRAL_SOURCE_FLAG varchar2(1) not null,
   PERFORM_OR_STEP1_FLAG varchar2(1) not null,
   PERFORM_OR_STEP2_FLAG varchar2(1) not null,
   PERFORM_OR_STEP3_FLAG varchar2(1) not null,
   PERFORM_OR_STEP4_FLAG varchar2(1) not null,
   PERFORM_OR_STEP5_FLAG varchar2(1) not null,
   PERFORM_OR_STEP6_FLAG varchar2(1) not null,
   HOME_VISIT_FLAG varchar2(1) not null,
   TERMINATION_TIMER_FLAG varchar2(1) not null,
   EE_OTHER_INDICATOR varchar2(4000),
   IMAGE_REFERENCE_ID NUMBER)
tablespace MAXDAT_DATA parallel;
  
alter table D_COR_CURRENT add constraint DCORCUR_PK primary key (COR_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DCORCUR_UIX1 on D_COR_CURRENT (OUTREACH_REQUEST_ID) online tablespace MAXDAT_INDX parallel compute statistics; 

create index DCORCUR_IX2 on D_COR_CURRENT (OUTREACH_REQUEST_STATUS) online tablespace MAXDAT_INDX parallel compute statistics;
create index DCORCUR_IX3 ON D_COR_CURRENT(CREATE_DATE) TABLESPACE MAXDAT_INDX;
create index DCORCUR_IX4 ON D_COR_CURRENT(COMPLETE_DATE) TABLESPACE MAXDAT_INDX;
create index DCORCUR_IX5 ON D_COR_CURRENT(CPW_REFERRAL_SOURCE_TYPE) TABLESPACE MAXDAT_INDX;
create index DCORCUR_IX6 ON D_COR_CURRENT(CPW_REFERRAL_SOURCE_NAME) TABLESPACE MAXDAT_INDX;
create index DCORCUR_IX7 ON D_COR_CURRENT(OUTREACH_REQUEST_TYPE) TABLESPACE MAXDAT_INDX;
create index DCORCUR_IX8 ON D_COR_CURRENT(IMAGE_REFERENCE_ID) TABLESPACE MAXDAT_INDX;

grant select on D_COR_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_COR_CURRENT_SV as
select * 
from D_COR_CURRENT
with read only;

grant select on D_COR_CURRENT_SV to MAXDAT_READ_ONLY;


-- Event Child table 
create or replace view D_COR_OR_EVENT_SV as
select * 
from CORP_ETL_CLNT_OUTREACH_EVENTS
with read only;

grant select on D_COR_OR_EVENT_SV to MAXDAT_READ_ONLY;


-- Outreach CLOB OUTREACH DESCRIPTION
-- Need to confirm
create or replace view D_COR_OR_DESC_SV as
select OUTREACH_ID,OUTREACH_REQ_DESCRIPTION 
from CORP_ETL_CLNT_OUTREACH
with read only;

grant select on D_COR_OR_DESC_SV to MAXDAT_READ_ONLY;


-- View for Client Outreach related MW
create or replace view D_COR_CURRENT_TASK_SV as 
select ve.* 
from D_MW_CURRENT_SV ve
join D_COR_CURRENT cl on cl.current_task_id = "Task ID";

grant select on D_COR_CURRENT_TASK_SV to MAXDAT_READ_ONLY;


-- D_COR_COUNTY    DCORCI_ID  
create sequence SEQ_DCORCI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COR_COUNTY
  (DCORCI_ID number not null, 
   COUNTY varchar2(64))
tablespace MAXDAT_DATA;

alter table D_COR_COUNTY add constraint DCORCI_PK primary key (DCORCI_ID);
alter index DCORCI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCORCI_UIX1 on D_COR_COUNTY (COUNTY) tablespace MAXDAT_INDX parallel compute statistics;    

grant select on D_COR_COUNTY to MAXDAT_READ_ONLY;

create or replace view D_COR_COUNTY_SV as
select * from D_COR_COUNTY
with read only;

grant select on D_COR_COUNTY_SV to MAXDAT_READ_ONLY;

insert into D_COR_COUNTY (DCORCI_ID ,COUNTY) values (SEQ_DCORCI_ID.nextval,null);
commit;


-- D_COR_REQUEST_STATUS    DCORRS_ID  
create sequence SEQ_DCORRS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COR_REQUEST_STATUS
  (DCORRS_ID number not null, 
   OUTREACH_REQUEST_STATUS varchar2(128))
tablespace MAXDAT_DATA;

alter table D_COR_REQUEST_STATUS add constraint DCORRS_PK primary key (DCORRS_ID);
alter index DCORRS_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCORRS_UIX1 on D_COR_REQUEST_STATUS (OUTREACH_REQUEST_STATUS) tablespace MAXDAT_INDX parallel compute statistics;    

grant select on D_COR_REQUEST_STATUS to MAXDAT_READ_ONLY;

create or replace view D_COR_REQUEST_STATUS_SV as
select * 
from D_COR_REQUEST_STATUS
with read only;

grant select on D_COR_REQUEST_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_COR_REQUEST_STATUS (DCORRS_ID ,OUTREACH_REQUEST_STATUS) values (SEQ_DCORRS_ID.nextval,null);
commit;


-- D_COR_SURVEY_ID    DCORSI_ID  
create sequence SEQ_DCORSI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COR_SURVEY_ID
  (DCORSI_ID number not null, 
   SURVEY_ID number)
tablespace MAXDAT_DATA;

alter table D_COR_SURVEY_ID add constraint DCORSI_PK primary key (DCORSI_ID);
alter index DCORSI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCORSI_UIX1 on D_COR_SURVEY_ID (SURVEY_ID) tablespace MAXDAT_INDX parallel compute statistics;    

grant select on D_COR_SURVEY_ID to MAXDAT_READ_ONLY;

create or replace view D_COR_SURVEY_ID_SV as
select * from D_COR_SURVEY_ID
with read only;

grant select on D_COR_SURVEY_ID_SV to MAXDAT_READ_ONLY;

insert into D_COR_SURVEY_ID (DCORSI_ID ,SURVEY_ID) values (SEQ_DCORSI_ID.nextval,null);
commit;


--F_COR_BY_DATE     FCORBD_ID
create sequence SEQ_FCORBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;


create table F_COR_BY_DATE 
  (FCORBD_ID number not null,
   D_DATE date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   COR_BI_ID number not null, 
   DCORCI_ID number not null,
   DCORRS_ID number not null,
   DCORSI_ID number not null,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number,
   OUTREACH_REQUEST_STATUS_DATE date)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))      
tablespace MAXDAT_DATA parallel;

alter table F_COR_BY_DATE add constraint FCORBD_PK primary key (FCORBD_ID) using index tablespace MAXDAT_INDX;

alter table F_COR_BY_DATE add constraint FCORBD_DCORCI_FK foreign key (DCORCI_ID) references D_COR_COUNTY(DCORCI_ID);
alter table F_COR_BY_DATE add constraint FCORBD_DCORRS_FK foreign key (DCORRS_ID) references D_COR_REQUEST_STATUS(DCORRS_ID);
alter table F_COR_BY_DATE add constraint FCORBD_DCORSI_FK foreign key (DCORSI_ID) references D_COR_SURVEY_ID(DCORSI_ID);
alter table F_COR_BY_DATE add constraint FCORBD_DCORCUR_FK foreign key (COR_BI_ID) references D_COR_CURRENT(COR_BI_ID);

create unique index FCORBD_UIX1 on F_COR_BY_DATE (COR_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FCORBD_UIX2 on F_COR_BY_DATE (COR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FCORBD_IX1 on F_COR_BY_DATE (OUTREACH_REQUEST_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FCORBD_IXL1 on F_COR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCORBD_IXL2 on F_COR_BY_DATE (COR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCORBD_IXL3 on F_COR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCORBD_IXL4 on F_COR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FCORBD_IXL5 on F_COR_BY_DATE (INVENTORY_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_COR_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_COR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCORBD_ID,
  BUCKET_START_DATE D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from F_COR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from 
  F_COR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_COR_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCORBD_ID,
  bdd.D_DATE,
  COR_BI_ID, 
  DCORCI_ID ,
  DCORRS_ID,
  DCORSI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  OUTREACH_REQUEST_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_COR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_COR_BY_DATE_SV to MAXDAT_READ_ONLY;





