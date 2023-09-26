-- MAXDat tables DDL for UK HWS Assessments.

create table MAXDAT.APPOINTMENT_DATE_HISTORY
  (APPOINTMENT_ID                int not null,
   APPOINTMENT_DATE_EFFECTIVE_DT datetime not null,
   RESCHEDULE_END_DT             datetime not null,
   APPOINTMENT_DT                datetime not null,
   NEW_APPOINTMENT_DT            datetime,
   APPOINTMENT_RESCHEDULED_DT    datetime,
   APPOINTMENT_RESCHEDULE_REASON varchar(200),
  constraint APPT_RESCHEDULE_HISTORY_PK primary key clustered (APPOINTMENT_ID,APPOINTMENT_DATE_EFFECTIVE_DT));
go

grant select on MAXDAT.APPOINTMENT_DATE_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.APPOINTMENT_DATE_HISTORY_SV as
select * from MAXDAT.APPOINTMENT_DATE_HISTORY;
go

grant select on MAXDAT.APPOINTMENT_DATE_HISTORY_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.APPOINTMENT_STATUS_HISTORY
  (APPOINTMENT_ID                  int not null,
   APPOINTMENT_STATUS_EFFECTIVE_DT datetime not null,
   APPOINTMENT_STATUS_END_DT       datetime not null,
   APPOINTMENT_STATUS_ID           int not null,
  constraint APPOINTMENT_STATUS_HISTORY_PK primary key clustered (APPOINTMENT_ID,APPOINTMENT_STATUS_EFFECTIVE_DT));
go

alter table MAXDAT.APPOINTMENT_STATUS_HISTORY add constraint APPOINTMENT_STATUS_HISTORY_STATUS_DT check (APPOINTMENT_STATUS_EFFECTIVE_DT <= APPOINTMENT_STATUS_END_DT);

grant select on MAXDAT.APPOINTMENT_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.APPOINTMENT_STATUS_HISTORY_SV as
select * from MAXDAT.APPOINTMENT_STATUS_HISTORY;
go

grant select on MAXDAT.APPOINTMENT_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go

create table MAXDAT.D_APPOINTMENT_STATUS_HISTORY
  (APPOINTMENT_ID        int not null,
   LAST_EVENT_DT         datetime not null,
   BUCKET_START_DATE     date not null,
   BUCKET_END_DATE       date not null,
   APPOINTMENT_STATUS_ID int not null,
  constraint D_APPOINTMENT_STATUS_HISTORY_PK primary key clustered (APPOINTMENT_ID,BUCKET_START_DATE));
go

alter table MAXDAT.D_APPOINTMENT_STATUS_HISTORY add constraint D_APPOINTMENT_STATUS_HISTORY_LAST_EVENT_DT check (LAST_EVENT_DT >= BUCKET_START_DATE and convert(date,LAST_EVENT_DT) <= BUCKET_END_DATE);
alter table MAXDAT.D_APPOINTMENT_STATUS_HISTORY add constraint D_APPOINTMENT_STATUS_HISTORY_BUCKET_DATE check (BUCKET_START_DATE <= BUCKET_END_DATE);

grant select on MAXDAT.D_APPOINTMENT_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_APPOINTMENT_STATUS_HISTORY_SV as
select
  h.APPOINTMENT_ID,
  bdd.D_DATE,
  h.APPOINTMENT_STATUS_ID
from MAXDAT.D_APPOINTMENT_STATUS_HISTORY h 
join MAXDAT.BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE and bdd.D_DATE <= h.BUCKET_END_DATE);
go

grant select on MAXDAT.D_APPOINTMENT_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go

create view MAXDAT.F_APPOINTMENT_STATUS_HISTORY_BY_DATE_SV as 
select
  d.APPOINTMENT_ID,
  bdd.D_DATE,
  case when bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_BOOKED_DT)) then 1 else 0 end as creation_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_DT)) then 0 else 1 end as inventory_count,
  case when (bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_DT)) or bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_CANCEL_DT))) then 1 else 0 end as completion_count
from MAXDAT.D_DATES bdd 
join MAXDAT.APPOINTMENTS d on (bdd.D_DATE >= convert(datetime,convert(date,d.APPOINTMENT_BOOKED_DT)) and (bdd.D_DATE <= d.APPOINTMENT_DT or d.APPOINTMENT_DT is null))
                               or bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_BOOKED_DT))
                               or bdd.D_DATE = convert(datetime,convert(date,d.APPOINTMENT_DT));
go

grant select on MAXDAT.F_APPOINTMENT_STATUS_HISTORY_BY_DATE_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.APPOINTMENTS
  (APPOINTMENT_ID            int not null,
   CASE_ID                   int not null,
   RESOURCE_ID               int not null,
   ASSESSMENT_ID             int not null,
   CLINIC_ID                 uniqueidentifier,
   CLINIC_NAME               varchar(200),
   CLINICIAN_ID              uniqueidentifier not null,
   CLINICIAN_NAME            varchar(200),
   ISFACETOFACE              bit,
   APPOINTMENT_DT            datetime,
   APPOINTMENT_BOOKED_DT     datetime,
   APPOINTMENT_STATUS_ID     int,
   APPOINTMENT_STATUS        varchar(50),
   APPOINTMENT_STATUS_DT     datetime,
   ELAPSED_TIME              int,
   APPOINTMENT_TYPE_ID       int,
   APPOINTMENT_TYPE          varchar(50),
   TRAVEL_TIME               int,
   RESCHEDULED_DT            datetime,
   RESCHEDULE_REASON         varchar(200),
   APPOINTMENT_CANCEL_DT     datetime,
   APPOINTMENT_CANCEL_REASON varchar(250),
  constraint APPOINTMENTS_PK primary key clustered (APPOINTMENT_ID));
go

grant select on MAXDAT.APPOINTMENTS to MAXDAT_READ_ONLY;
go

create view MAXDAT.APPOINTMENTS_SV as
select * from MAXDAT.APPOINTMENTS;
go

grant select on MAXDAT.APPOINTMENTS_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.ASSESSMENT_STATUS_HISTORY
  (ASSESSMENT_ID                  int not null,
   ASSESSMENT_STATUS_EFFECTIVE_DT datetime not null,
   ASSESSMENT_STATUS_END_DT       datetime not null,
   ASSESSMENT_STATUS_ID           int not null,
  constraint ASSESSMENT_STATUS_HISTORY_PK primary key clustered (ASSESSMENT_ID,ASSESSMENT_STATUS_EFFECTIVE_DT));
go

alter table MAXDAT.ASSESSMENT_STATUS_HISTORY add constraint ASSESSMENT_STATUS_HISTORY_STATUS_DT check (ASSESSMENT_STATUS_EFFECTIVE_DT <= ASSESSMENT_STATUS_END_DT);

grant select on MAXDAT.ASSESSMENT_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.ASSESSMENT_STATUS_HISTORY_SV as
select * from MAXDAT.ASSESSMENT_STATUS_HISTORY;
go

grant select on MAXDAT.ASSESSMENT_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.D_ASSESSMENT_STATUS_HISTORY
  (ASSESSMENT_ID        int not null,
   LAST_EVENT_DT        datetime not null,
   BUCKET_START_DATE    date not null,
   BUCKET_END_DATE      date not null,
   ASSESSMENT_STATUS_ID int not null,
  constraint D_ASSESSMENT_STATUS_HISTORY_PK primary key clustered (ASSESSMENT_ID,BUCKET_START_DATE));
go

alter table MAXDAT.D_ASSESSMENT_STATUS_HISTORY add constraint D_ASSESSMENT_STATUS_HISTORY_LAST_EVENT_DT check (LAST_EVENT_DT >= BUCKET_START_DATE and convert(date,LAST_EVENT_DT) <= BUCKET_END_DATE);
alter table MAXDAT.D_ASSESSMENT_STATUS_HISTORY add constraint D_ASSESSMENT_STATUS_HISTORY_BUCKET_DATE check (BUCKET_START_DATE <= BUCKET_END_DATE);

grant select on MAXDAT.D_ASSESSMENT_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_ASSESSMENT_STATUS_HISTORY_SV as
select
  h.ASSESSMENT_ID,
  bdd.D_DATE,
  h.ASSESSMENT_STATUS_ID
from MAXDAT.D_ASSESSMENT_STATUS_HISTORY h 
join MAXDAT.BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE and bdd.D_DATE <= h.BUCKET_END_DATE);
go

grant select on MAXDAT.D_ASSESSMENT_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go

create view MAXDAT.F_ASSESSMENT_STATUS_HISTORY_BY_DATE_SV as 
select
  d.ASSESSMENT_ID,
  bdd.D_DATE,
  case when bdd.D_DATE = convert(datetime,convert(date,d.ASSESSMENT_START_DT)) then 1 else 0 end as creation_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.ASSESSMENT_END_DT)) then 0 else 1 end as inventory_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.ASSESSMENT_END_DT)) then 1 else 0 end as completion_count
from MAXDAT.D_DATES bdd 
join MAXDAT.ASSESSMENTS d on (bdd.D_DATE >= convert(datetime,convert(date,d.ASSESSMENT_START_DT)) and (bdd.D_DATE <= d.ASSESSMENT_END_DT or d.ASSESSMENT_END_DT is null))
                               or bdd.D_DATE = convert(datetime,convert(date,d.ASSESSMENT_START_DT))
                               or bdd.D_DATE = convert(datetime,convert(date,d.ASSESSMENT_END_DT));
go

grant select on MAXDAT.F_ASSESSMENT_STATUS_HISTORY_BY_DATE_SV to MAXDAT_READ_ONLY;
go



create table MAXDAT.ASSESSMENT_OUTCOMES
  (ASSESSMENT_ID                   int not null,
   ASSESSMENT_OUTCOME_ID           int not null,
   ASSESSMENT_OUTCOME_NAME         varchar(MAX) not null,
   ASSESSMENT_OUTCOME_EFFECTIVE_DT datetime not null,
  constraint ASSESSMENT_OUTCOMES_PK primary key clustered (ASSESSMENT_ID,ASSESSMENT_OUTCOME_ID));
go

grant select on MAXDAT.ASSESSMENT_OUTCOMES to MAXDAT_READ_ONLY;
go

create view MAXDAT.ASSESSMENT_OUTCOMES_SV as
select * from MAXDAT.ASSESSMENT_OUTCOMES;
go

grant select on MAXDAT.ASSESSMENT_OUTCOMES_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.ASSESSMENTS
  (ASSESSMENT_ID                int not null,
   ASSESSMENT_SEQUENCE          int default 0 not null,
   CASE_ID                      int not null,
   ASSESSMENT_REQUIRED_DT       datetime,
   ASSESSMENT_STATUS_ID         int,
   ASSESSMENT_STATUS            varchar(50) not null,
   ASSESSMENT_START_DT          datetime,
   ASSESSMENT_STATUS_DT         datetime not null,
   ASSESSMENT_CONSENT           bit not null,
   ASSESSMENT_TYPE_ID           int,
   ASSESSMENT_TYPE              varchar(50),
   ASSESSMENT_END_DT            datetime,
   ASSESSMENT_CALL_BACK_IND     bit,
   ASSESSMENT_LAST_UPDATE_DT    datetime not null,
   PROFESSIONAL_ID              int,
   PROFESSIONAL_DISCIPLINE      varchar(MAX),
   PREASSESSMENT_COMPLETE_IND   bit,
   FIT_STATUS_ID                int,
   FIT_STATUS                   varchar(20),
   RTW_OPTIONS                  varchar(100),
   RECOMMENDED_RTW_DATE         date,
   NEXT_TOUCHPOINT              varchar(MAX),
   NEXT_TOUCHPOINT_DT           datetime,
   EMPLOYEE_REVIEW_RTWP         bit,
   ASSESSMENT_NOT_CONDUCTED_DTL varchar(MAX),
   ASSESSMENT_CANCEL_DT         datetime,
   ASSESSMENT_CANCEL_REASON     varchar(MAX),
   RTWP_ID                      integer,
   PUBLISH_TO_EMPLOYEE_DT       datetime,
   PUBLISH_TO_EMPLOYER_DT       datetime,
   PUBLISH_TO_GP_DT             datetime,
   PUBLISH_TO_3RDPARTY_DT       datetime,
   RTWP_EXPIRY_DATE             date,
 constraint ASSESSMENT_PK primary key clustered (ASSESSMENT_ID));
go

grant select on MAXDAT.ASSESSMENTS to MAXDAT_READ_ONLY;
go

create view MAXDAT.ASSESSMENTS_SV as
select * from MAXDAT.ASSESSMENTS;
go

grant select on MAXDAT.ASSESSMENTS_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.CASE_STATUS_HISTORY
  (CASE_ID                  int not null,
   CASE_STATUS_EFFECTIVE_DT datetime not null,
   CASE_STATUS_END_DT       datetime not null,
   CASE_STATUS_ID           int not null,
  constraint CASE_STATUS_HISTORY_PK primary key clustered (CASE_ID,CASE_STATUS_EFFECTIVE_DT));
go

alter table MAXDAT.CASE_STATUS_HISTORY add constraint CASE_STATUS_HISTORY_STATUS_DT check (CASE_STATUS_EFFECTIVE_DT <= CASE_STATUS_END_DT);

grant select on MAXDAT.CASE_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.CASE_STATUS_HISTORY_SV as
select * from MAXDAT.CASE_STATUS_HISTORY;
go

grant select on MAXDAT.CASE_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.D_CASE_STATUS_HISTORY
  (CASE_ID           int not null,
   LAST_EVENT_DT     datetime not null,
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE   date not null,
   CASE_STATUS_ID    int not null,
  constraint D_CASE_STATUS_HISTORY_PK primary key clustered (CASE_ID,BUCKET_START_DATE));
go

alter table MAXDAT.D_CASE_STATUS_HISTORY add constraint D_CASE_STATUS_HISTORY_LAST_EVENT_DT check (LAST_EVENT_DT >= BUCKET_START_DATE and convert(date,LAST_EVENT_DT) <= BUCKET_END_DATE);
alter table MAXDAT.D_CASE_STATUS_HISTORY add constraint D_CASE_STATUS_HISTORY_BUCKET_DATE check (BUCKET_START_DATE <= BUCKET_END_DATE);

grant select on MAXDAT.D_CASE_STATUS_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_CASE_STATUS_HISTORY_SV as
select
  h.CASE_ID,
  bdd.D_DATE,
  h.CASE_STATUS_ID
from MAXDAT.D_CASE_STATUS_HISTORY h 
join MAXDAT.BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE and bdd.D_DATE <= h.BUCKET_END_DATE);
go

grant select on MAXDAT.D_CASE_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;
go

create view MAXDAT.F_CASE_STATUS_HISTORY_BY_DATE_SV as 
select
  d.CASE_ID,
  bdd.D_DATE,
  case when bdd.D_DATE = convert(datetime,convert(date,d.CASE_CREATE_DT)) then 1 else 0 end as creation_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.CASE_CLOSED_DT)) then 0 else 1 end as inventory_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.CASE_CLOSED_DT)) then 1 else 0 end as completion_count
from MAXDAT.D_DATES bdd 
join MAXDAT.CASES d on (bdd.D_DATE >= convert(datetime,convert(date,d.CASE_CREATE_DT)) and (bdd.D_DATE <= d.CASE_CLOSED_DT or d.CASE_CLOSED_DT is null))
                               or bdd.D_DATE = convert(datetime,convert(date,d.CASE_CLOSED_DT))
                               or bdd.D_DATE = convert(datetime,convert(date,d.CASE_CLOSED_DT));
go

grant select on MAXDAT.F_CASE_STATUS_HISTORY_BY_DATE_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.CASES
  (CASE_ID                        int not null,
   CASE_STATUS_ID                 int,
   CASE_STATUS                    varchar(50) not null,
   CURRENT_STATUS_DT              datetime not null,
   CASENUMBER                     varchar(50),
   CASE_CREATE_DT                 datetime not null,
   CASE_MANAGER_ID                int not null,
   CASE_DISCHARGE_DT              datetime,
   CASE_FAMILY_ID                 int,
   CASE_FAMILY                    uniqueidentifier,
   CASE_CLOSED_DT                 datetime,
   DISCHARGE_REASON_ID            int,
   DISCHARGE_REASON               varchar(100),
   IS_MARKED_FOR_DELETION         bit,
   RECALL_DT                      datetime,
   REFERRAL_ID                    int not null,
   REFERRAL_EMPLOYEECONSENT       bit not null,
   REFERRAL_RECEIPT_DT            datetime not null,
   REFERRAL_DIAGNOSISFROMFITNOTE  varchar(500),
   REFERRAL_FIT_NOTE_EXPIRY_DATE  date,
   REFERRAL_SOURCE_ID             int,
   REFERRAL_SOURCE                varchar(10) not null,
   REFERRAL_CREATED_BY            varchar(50),
   REFERRAL_REASONFORREFERRAL     varchar(512),
   REFERRAL_ABSENCE_START_DATE    date,
   REFERRAL_MAIN_HEALTH_CONDITION varchar(20),
   REFERRAL_FURTHER_INFORMATION   varchar(500),
   REFERRAL_CHANNEL               varchar(50) not null,
   ELIGIBILITY_SESSION_ID         varchar(50),
   ISGEOGRAPHICALLYELIGIBLE       bit,
   ISINPAIDEMPLOYMENT             bit,
   ISABSENTFROMWORK               bit,
   ISREFERREDINLAST12MONTHS       bit,
   EMPLOYEECONSENTED              bit,
   ISVALID                        bit,
   ELIGIBILITY_FLAG               bit not null,
   EMPLOYEE_ID                    int not null,
   EMPLOYEE_GENDER                varchar(25),
   EMPLOYEE_DATE_OF_BIRTH         date,
   EMPLOYEE_AGE                   as case 
									when dateadd(year,datediff(year,EMPLOYEE_DATE_OF_BIRTH,REFERRAL_RECEIPT_DT),EMPLOYEE_DATE_OF_BIRTH) > REFERRAL_RECEIPT_DT 
									  then datediff(year,EMPLOYEE_DATE_OF_BIRTH,REFERRAL_RECEIPT_DT) - 1
                                    else datediff(year,EMPLOYEE_DATE_OF_BIRTH,REFERRAL_RECEIPT_DT)
									end,
   EMPLOYEE_JOB_TITLE             varchar(100),
   EMPLOYEE_JOB_ACTIVITIES        varchar(100),
   EMPLOYEE_WORKINGPATTERNS       varchar(100),
   EMPLOYEE_HARDOFHEARING_PREF    varchar(50),
   EMPLOYEE_LANGUAGE_PREF         varchar(2),
   EMPLOYEE_TRANSLATION_REQUIRED  nvarchar(50),
   EMPLOYEE_POSTCODE              varchar(10),
   EMPLOYEE_COMMS_PREF            varchar(50),
   EMPLOYEE_RECEIVE_SMS           bit,
   EMPLOYEE_RECEIVE_EMAIL         bit,
   ABSENT_FROM_WORK               bit,
   FIT_NOTE_IND                   bit,
   NO_FIT_NOTE_REASON             varchar(MAX),
   ADVICELINE_IND                 bit,
   FULL_PART_TIME                 varchar(50),
   EMPLOYEE_WORK_HOURS_ID         int,
   EMPLOYEE_WORK_HOURS            varchar(50),
   EMPLOYEE_ETHNICITY_ID          int,
   EMPLOYEE_ETHNICITY             nvarchar(500),
   EMPLOYEE_DISABILITY            varchar(50),
   ADDITIONAL_SUPPORT_NEEDS       varchar(200),
   EMPLOYEE_ENGAGED_OCC_HEALTH    varchar(MAX),
   EMPLOYER_ID                    int not null,
   EMPLOYER_IDENTIFIER            varchar(35),
   EMPLOYER_EMPLOYERNAME          varchar(100),
   EMPLOYER_JOBTITLE              varchar(100),
   EMPLOYER_POSTCODE              varchar(10),
   EMPLOYER_HARDOFHEARING_PREF    varchar(50),
   EMPLOYER_LANGUAGE_PREF         varchar(2),
   EMPLOYER_COMMS_PREF            varchar(50),
   EMPLOYER_OCC_SECTOR            nvarchar(500),
   EMPLOYER_NAME                  nvarchar(100),
   EMPLOYER_SIZE                  varchar(500),
   EMPLOYER_OFFERED_SERVICES      bit,
   EMPLOYER_OCC_HEALTH_SERVICE    bit,
   EMPLOYER_ASSISTANCE_PROGRAMME  bit,
   EMPLOYER_COUNSELLING_SERVICE   bit,
   EMPLOYER_PHYSIOTHERAPY_SERVICE bit,
   EMPLOYER_OTHER_SERVICE         bit,
   EMPLOYER_TYPE                  varchar(MAX),
   GP_ID                          int not null,
   GP_PRACTICE_CD                 varchar(20),
   GP_PRACTICE_NAME               varchar(100),
   GP_POSTCODE                    varchar(10),
   GP_HARDOFHEARING_PREF          varchar(50),
   GP_LANGUAGE_PREF               varchar(2),
   GP_COMMS_PREF                  varchar(50),
   INITIAL_CONTACT_DT             datetime,
   MISSING_INFORMATION_IND        bit,
   MISSING_INFORMATION_DUE_DT     datetime,
   DROP_SERVICE_DT                datetime,
   CASE_DROP_REASON               varchar(50),
   CASE_ESCALATED_DT              datetime,
   CASE_ESCALATED_TO              varchar(100),
   DISCHARGE_DUE_DT               datetime,
   RETURN_TO_WORK_DATE            date,
   FOLLOW_UP_REQUEST_SENT_DT      datetime,
   REGION						  varchar(100),
  constraint CASE_ID primary key clustered (CASE_ID));
go

grant select on MAXDAT.CASES to MAXDAT_READ_ONLY;
go

create view MAXDAT.CASES_SV as
select * from MAXDAT.CASES;
go

grant select on MAXDAT.CASES_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.DWP_INTERVENTIONS
  (ASSESSMENT_ID                 int not null,
   DWP_INTERVENTION_ID           int not null,
   DWP_INTERVENTION_NAME         varchar(MAX) not null,
   DWP_INTERVENTION_EFFECTIVE_DT datetime  not null,
  constraint DWP_INTERVENTIONS_PK primary key clustered (DWP_INTERVENTION_ID,ASSESSMENT_ID));
go

grant select on MAXDAT.DWP_INTERVENTIONS to MAXDAT_READ_ONLY;
go

create view MAXDAT.DWP_INTERVENTIONS_SV as
select * from MAXDAT.DWP_INTERVENTIONS;
go

grant select on MAXDAT.DWP_INTERVENTIONS_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.DWP_SIGNPOSTING
  (ASSESSMENT_ID                int not null,
   DWP_SIGNPOSTING_ID           int not null,
   DWP_SIGNPOSTING_NAME         varchar(MAX) not null,
   DWP_SIGNPOSTING_EFFECTIVE_DT datetime not null
  constraint DWP_SIGNPOSTING_PK primary key clustered (DWP_SIGNPOSTING_ID,ASSESSMENT_ID));
go


grant select on MAXDAT.DWP_SIGNPOSTING to MAXDAT_READ_ONLY;
go

create view MAXDAT.DWP_SIGNPOSTING_SV as
select * from MAXDAT.DWP_SIGNPOSTING;
go

grant select on MAXDAT.DWP_SIGNPOSTING_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.OBSTACLES
  (OBSTACLE_ID              int not null,
   OBSTACLE_TYPE            varchar(100) not null,
   OBSTACLE_DETAIL          varchar(MAX) not null,
   IS_PRIMARY               bit not null,
   CONSENT_PUBLISH_GP       bit,
   CONSENT_PUBLISH_EMPLOYER bit,
   CONSENT_PUBLISH_3RDPARTY bit,
   ASSESSMENT_ID            int not null,
  constraint OBSTACLE_PK primary key clustered (OBSTACLE_ID));
go

grant select on MAXDAT.OBSTACLES to MAXDAT_READ_ONLY;
go

create view MAXDAT.OBSTACLES_SV as
select * from MAXDAT.OBSTACLES;
go

grant select on MAXDAT.OBSTACLES_SV to MAXDAT_READ_ONLY;
go


create sequence MAXDAT.SEQ_RSA_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.RECOM_SIGNPOSTING_ADJUST
  (RSA_ID          int not null,
   RSA_TYPE        varchar(50) not null,
   RSA_CATEGORY    varchar(200),
   RSA_NAME        varchar(500),
   RSA_TEXT        varchar(500),
   RSA_TARGET_DATE date,
   OBSTACLE_ID     int not null,
  constraint RECOMMENDATIONS_SIGNPOSTING_PK primary key clustered (RSA_ID));
go

grant select on MAXDAT.RECOM_SIGNPOSTING_ADJUST to MAXDAT_READ_ONLY;
go

create view MAXDAT.RECOM_SIGNPOSTING_ADJUST_SV as
select * from MAXDAT.RECOM_SIGNPOSTING_ADJUST;
go

grant select on MAXDAT.RESOLUTION_DESC_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.RESOURCES
  (RESOURCE_ID    int not null,
   ACCOUNTNAME    varchar(100),
   AGENT_ID       varchar(30),
   RESOURCE_IS_HP bit,
   CTATEAM_ID     int,
  constraint RESOURCE_ID primary key clustered (RESOURCE_ID));
go

grant select on MAXDAT.RESOURCES to MAXDAT_READ_ONLY;
go

create view MAXDAT.RESOURCES_SV as
select * from MAXDAT.RESOURCES;
go

grant select on MAXDAT.RESOURCES_SV to MAXDAT_READ_ONLY;
go


create table MAXDAT.SLA_CONFIG
  (SLA_ID         int not null,
   SLA_NAME       varchar(MAX),
   SLA_VALUE_TYPE varchar(MAX),
   SLA_VALUE      int,
   TARGET_VALUE   int,
   JEOPARDY_VALUE int,
   EFFECTIVE_DT   datetime,
   END_DT         datetime,
  constraint SLA_ID_PK primary key clustered (SLA_ID));
go

grant select on MAXDAT.SLA_CONFIG to MAXDAT_READ_ONLY;
go

create view MAXDAT.SLA_CONFIG_SV as
select * from MAXDAT.SLA_CONFIG;
go

grant select on MAXDAT.SLA_CONFIG_SV to MAXDAT_READ_ONLY;
go


alter table MAXDAT.APPOINTMENT_STATUS_HISTORY add constraint APPOINTMENT_STATUS_HISTORY_APPOINTMENTS_FK 
  foreign key (APPOINTMENT_ID) references MAXDAT.APPOINTMENTS (APPOINTMENT_ID);

alter table MAXDAT.APPOINTMENTS add constraint APPOINTMENTS_CASES_FK 
  foreign key (CASE_ID) references MAXDAT.CASES (CASE_ID);

alter table MAXDAT.APPOINTMENT_DATE_HISTORY add constraint APPOINTMENT_DATE_HISTORY_APPOINTMENTS_FK 
  foreign key (APPOINTMENT_ID) references MAXDAT.APPOINTMENTS (APPOINTMENT_ID);

alter table MAXDAT.APPOINTMENTS add constraint APPOINTMENTS_RESOURCES_FK 
  foreign key (RESOURCE_ID) references MAXDAT.RESOURCES (RESOURCE_ID);

alter table MAXDAT.APPOINTMENTS add constraint APPOINTMENTS_ASSESSMENT_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.ASSESSMENT_OUTCOMES add constraint ASSESSMENT_OUTCOMES_ASSESSMENTS_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.ASSESSMENT_STATUS_HISTORY add constraint ASSESSMENT_STATUS_HISTORY_ASSESSMENTS_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.ASSESSMENTS add constraint ASSESSMENT_CASE_FK 
  foreign key (CASE_ID) references MAXDAT.CASES(CASE_ID);

alter table MAXDAT.CASE_STATUS_HISTORY add constraint CASE_STATUS_HISTORY_CASES_FK 
  foreign key (CASE_ID) references MAXDAT.CASES (CASE_ID);

alter table MAXDAT.CASES add constraint CASE_RESOURCE_FK 
  foreign key (CASE_MANAGER_ID) references MAXDAT.RESOURCES (RESOURCE_ID);
 
alter table MAXDAT.DWP_INTERVENTIONS add constraint DWP_INTERVENTIONS_ASSESSMENTS_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.DWP_SIGNPOSTING add constraint DWP_SIGNPOSTING_ASSESSMENTS_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.OBSTACLES add constraint ASSESSMENT_FK 
  foreign key (ASSESSMENT_ID) references MAXDAT.ASSESSMENTS (ASSESSMENT_ID);

alter table MAXDAT.RECOM_SIGNPOSTING_ADJUST add constraint RECOM_SIGNPOSTING_ADJUST_OBSTACLES_FK 
  foreign key (OBSTACLE_ID) references MAXDAT.OBSTACLES (OBSTACLE_ID);
