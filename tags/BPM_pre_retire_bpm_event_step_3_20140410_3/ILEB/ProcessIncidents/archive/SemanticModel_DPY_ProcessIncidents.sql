create table D_PI_CURRENT
  ("PI_BI_ID"                      number,
   "Incident ID"                   number,
   "Incident Tracking Number"      varchar2(32),
   "Receipt Date"                  date,
   "Create Date"                   date,
   "Created By Group"              varchar2(80),
   "Origin ID"                     number,
   CHANNEL                         varchar2(80),
   "Age in Business Days"          number,
   "Age in Calendar Days"          number,
   "Process Client Notification ID" number,
   "Cur Instance Status"           varchar2(10),
   "Cancel Date"                   date,
   "Incident Type"                 varchar2(80),
   "Cur Incident About"            varchar2(80),
   "Cur Incident Reason"           varchar2(80),
   "About Provider ID"             number,
   "About Plan Code"               varchar2(32),
   "Cur Incident Status"           varchar2(80),
   "Cur Incident Status Date"      date,
   "Status Age in Business Days"   number,
   "Status Age in Calendar Days"   number,
   "Cur Jeopardy Status"           varchar(2),
   "Jeopardy Status Date"          date,
   "Complete Date"                 date,
   "Reported By"                   varchar2(80),
   "Reporter Relationship"         varchar2(64),
   "Case ID"                       number,
   "Cur Enrollment Status"         varchar2(32),
   PRIORITY                        varchar2(256),
   PROGRAM                         varchar2(32),
   "Sub-Program"                   varchar2(32),
   "Cur Last Update Date"          date,
   "Cur Last Update By Name"       varchar2(100),
   "Plan Code"                     varchar2(32),
   "Provider ID"                   number,
   "Action Type"                   varchar2(64),
   "Resolution Type"               varchar2(64),
   "Notify Client Flag"            varchar2(1),
   "Process Clnt Notify Start Dt"  date,
   "Process Clnt Notify End Dt"    date,
   "Process Clnt Notify Flag"      varchar2(1),
   "Escalate Incident Flag"        varchar2(1),
   "Escalate to State Dt"          date,
   "Cur Task ID"                   number,
   "State Received Appeal Date"    date,
   "Hearing Date"                  date,
   "Selection ID"                  number,
   "Timeliness Status"             varchar2(20),
   "EB Follow-Up Needed Flag"      varchar2(1),
   "Other Party Name"              varchar2(80),
   "Research Incident St Dt"       date,
   "Research Incident End Dt"      date,
   "Process Incident St Dt"        date,
   "Process Incident End Dt"       date,
   "Process Incident Flag"         varchar2(1),
   "Return Incident Flag"          varchar2(1),
   "Complete Incident St Dt"       date,
   "Complete Incident End Dt"      date,
   "Complete Incident Flag"        varchar2(1),
   "Return to MMS Dt"              date,
   "Created By Name"               varchar2(100),
   "Generic Field 1"               varchar2(50),
   "Generic Field 2"               varchar2(50),
   "Generic Field 3"               varchar2(50),
   "Generic Field 4"               varchar2(50),
   "Generic Field 5"               varchar2(50),
   "Enrollee RIN"                  varchar2(30),
   "Reporter Name"                 varchar2(80),
   "Research Incident Flag"        varchar2(1))
tablespace MAXDAT_DATA parallel;

alter table D_PI_CURRENT add constraint DPICUR_PK primary key (PI_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DPICUR_UIX1 on D_PI_CURRENT ("Incident ID") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_CURRENT for D_PI_CURRENT;
grant select on D_PI_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_PI_CURRENT_SV as
select * from D_PI_CURRENT
with read only;

create or replace public synonym D_PI_CURRENT_SV for D_PI_CURRENT_SV;
grant select on D_PI_CURRENT_SV to MAXDAT_READ_ONLY;

-- D_PI_INSTANCE_STATUS    DPIIS_ID  "Instance Status"           VARCHAR2(10),
create sequence SEQ_DPIIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_INSTANCE_STATUS 
  (DPIIS_ID number,
   "Instance Status" varchar2(10))
tablespace MAXDAT_DATA;

alter table D_PI_INSTANCE_STATUS add constraint DPIIS_PK primary key (DPIIS_ID) using index tablespace MAXDAT_INDX;

create unique index DPIIS_UIX1 on D_PI_INSTANCE_STATUS ("Instance Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_INSTANCE_STATUS for D_PI_INSTANCE_STATUS;
grant select on D_PI_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PI_INSTANCE_STATUS_SV as
select * from D_PI_INSTANCE_STATUS
with read only;

create or replace public synonym D_PI_INSTANCE_STATUS_SV for D_PI_INSTANCE_STATUS_SV;
grant select on D_PI_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_PI_INSTANCE_STATUS (DPIIS_ID ,"Instance Status") values (SEQ_DPIIS_ID.NEXTVAL,null);
commit;


-- D_PI_INCIDENT_ABOUT     DPIIA_ID  "Incident About"            VARCHAR2(80),
create sequence SEQ_DPIIA_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_INCIDENT_ABOUT 
  (DPIIA_ID number,
   "Incident About" varchar2(80))
tablespace MAXDAT_DATA;

alter table D_PI_INSTANCE_ABOUT add constraint DPIIA_PK primary key (DPIIA_ID) using index tablespace MAXDAT_INDX;

create unique index DPIIA_UIX1 on D_PI_INCIDENT_ABOUT ("Incident About") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_INSTANCE_ABOUT for D_PI_INSTANCE_ABOUT;
grant select on D_PI_INSTANCE_ABOUT to MAXDAT_READ_ONLY;

create or replace view D_PI_INCIDENT_ABOUT_SV as
select * from D_PI_INCIDENT_ABOUT
with read only;

create or replace public synonym D_PI_INCIDENT_ABOUT_SV for D_PI_INCIDENT_ABOUT_SV;
grant select on D_PI_INCIDENT_ABOUT_SV to MAXDAT_READ_ONLY;

insert into D_PI_INCIDENT_ABOUT (DPIIA_ID ,"Incident About") values (SEQ_DPIIA_ID.NEXTVAL,null);
commit;


-- D_PI_INCIDENT_REASON    DPIIR_ID  "Incident Reason"           VARCHAR2(80),
create sequence SEQ_DPIIR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_INCIDENT_REASON 
  (DPIIR_ID number,
   "Incident Reason" varchar2(80))
tablespace MAXDAT_DATA;

alter table D_PI_INSTANCE_REASON add constraint DPIIR_PK primary key (DPIIR_ID) using index tablespace MAXDAT_INDX;

create unique index DPIIR_UIX1 on D_PI_INCIDENT_REASON ("Incident Reason") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_PI_INCIDENT_REASON_SV as
select * from D_PI_INCIDENT_REASON
with read only;

create or replace public synonym D_PI_INSTANCE_REASON for D_PI_INSTANCE_REASON;
grant select on D_PI_INSTANCE_REASON to MAXDAT_READ_ONLY;

insert into D_PI_INCIDENT_REASON (DPIIR_ID ,"Incident Reason") values (SEQ_DPIIR_ID.NEXTVAL,null);
commit;


-- D_PI_INCIDENT_STATUS    DPIISS_ID  "Incident Status"           VARCHAR2(80),
create sequence SEQ_DPIISS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_INCIDENT_STATUS 
  (DPIISS_ID number,
   "Incident Status" varchar2(80))
tablespace MAXDAT_DATA;

alter table D_PI_INSTANCE_STATUS add constraint DPIISS_PK primary key (DPIISS_ID) using index tablespace MAXDAT_INDX;

create unique index DPIISS_UIX1 on D_PI_INCIDENT_STATUS ("Incident Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_INSTANCE_STATUS for D_PI_INSTANCE_STATUS;
grant select on D_PI_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PI_INCIDENT_STATUS_SV as
select * from D_PI_INCIDENT_STATUS
with read only;

create or replace public synonym D_PI_INCIDENT_STATUS_SV for D_PI_INCIDENT_STATUS_SV;
grant select on D_PI_INCIDENT_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_PI_INCIDENT_STATUS (DPIISS_ID ,"Incident Status") values (SEQ_DPIISS_ID.NEXTVAL,null);
commit;


-- D_PI_JEOPARDY_STATUS    DPIJS_ID  "Jeopardy Status"           VARCHAR(1),
create sequence SEQ_DPIJS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_JEOPARDY_STATUS 
  (DPIJS_ID number,
   "Jeopardy Status" varchar(2))
tablespace MAXDAT_DATA;

alter table D_PI_JEOPARDY_STATUS add constraint DPIJS_PK primary key (DPIJS_ID) using index tablespace MAXDAT_INDX;

create unique index DPIJS_UIX1 on D_PI_JEOPARDY_STATUS ("Jeopardy Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_JEOPARDY_STATUS for D_PI_JEOPARDY_STATUS;
grant select on D_PI_JEOPARDY_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PI_JEOPARDY_STATUS_SV as
select * from D_PI_JEOPARDY_STATUS
with read only;

create or replace public synonym D_PI_JEOPARDY_STATUS_SV for D_PI_JEOPARDY_STATUS_SV;
grant select on D_PI_JEOPARDY_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_PI_JEOPARDY_STATUS (DPIJS_ID ,"Jeopardy Status") values (SEQ_DPIJS_ID.NEXTVAL,null);
commit;

-- D_PI_ENROLLMENT_STATUS  DPIES_ID  "Enrollment Status"         VARCHAR2(32),
create sequence SEQ_DPIES_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_ENROLLMENT_STATUS 
  (DPIES_ID number,
   "Enrollment Status" varchar2(32))
tablespace MAXDAT_DATA;

alter table D_PI_ENROLLMENT_STATUS add constraint DPIES_PK primary key (DPIES_ID) using index tablespace MAXDAT_INDX;

create unique index DPIES_UIX1 on D_PI_ENROLLMENT_STATUS ("Enrollment Status") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_ENROLLMENT_STATUS for D_PI_ENROLLMENT_STATUS;
grant select on D_PI_ENROLLMENT_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PI_ENROLLMENT_STATUS_SV as
select * from D_PI_ENROLLMENT_STATUS
with read only;

create or replace public synonym D_PI_ENROLLMENT_STATUS_SV for D_PI_ENROLLMENT_STATUS_SV;
grant select on D_PI_ENROLLMENT_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_PI_ENROLLMENT_STATUS (DPIES_ID ,"Enrollment Status") values (SEQ_DPIES_ID.NEXTVAL,null);
commit;


-- D_PI_LAST_UPDATE_BY     DPIUB_ID  "Last Update By Name"       VARCHAR2(100),
create sequence SEQ_DPIUB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_LAST_UPDATE_BY 
  (DPIUB_ID number,
   "Last Update By Name" varchar2(100))
tablespace MAXDAT_DATA;

alter table D_PI_LAST_UPDATE_BY add constraint DPILUB_PK primary key (DPILUB_ID) using index tablespace MAXDAT_INDX;

create unique index DPIUB_UIX1 on D_PI_LAST_UPDATE_BY ("Last Update By Name") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_LAST_UPDATE_BY for D_PI_LAST_UPDATE_BY;
grant select on D_PI_LAST_UPDATE_BY to MAXDAT_READ_ONLY;

create or replace view D_PI_LAST_UPDATE_BY_SV as
select * from D_PI_LAST_UPDATE_BY
with read only;

create or replace public synonym D_PI_LAST_UPDATE_BY_SV for D_PI_LAST_UPDATE_BY_SV;
grant select on D_PI_LAST_UPDATE_BY_SV to MAXDAT_READ_ONLY;

insert into D_PI_LAST_UPDATE_BY (DPIUB_ID ,"Last Update By Name") values (SEQ_DPIUB_ID.NEXTVAL,null);
commit;


-- D_PI_TASK_ID            DPITI_ID  "Task ID"                   NUMBER,
create sequence SEQ_DPITI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PI_TASK_ID 
  (DPITI_ID number,
   "Task ID" number)
tablespace MAXDAT_DATA;

alter table D_PI_TASK_ID add constraint DPITI_PK primary key (DPITI_ID) using index tablespace MAXDAT_INDX;

create unique index DPITI_UIX1 on D_PI_TASK_ID ("Task ID") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_PI_TASK_ID for D_PI_TASK_ID;
grant select on D_PI_TASK_ID to MAXDAT_READ_ONLY;

create or replace view D_PI_TASK_ID_SV as
select * from D_PI_TASK_ID
with read only;

insert into D_PI_TASK_ID (DPITI_ID ,"Task ID") values (SEQ_DPITI_ID.NEXTVAL,null);
commit;


create sequence SEQ_FPIBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_PI_BY_DATE 
  (FPIBD_ID number not null,
   D_DATE date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   PI_BI_ID number not null, 
   DPIIS_ID number not null,
   DPIIA_ID number not null,
   DPIIR_ID number not null,
   DPIISS_ID number not null,
   DPIJS_ID number not null,
   DPIES_ID number not null,
   DPIUB_ID number not null,
   DPITI_ID number not null,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number,
   "Incident Status Date" date,
   "Last Update Date" date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (TO_DATE('20120101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_PI_BY_DATE add constraint FPIBD_PK primary key (FPIBD_ID) using index tablespace MAXDAT_INDX;

alter table F_PI_BY_DATE add constraint FPIBD_DPICUR_FK foreign key (PI_BI_ID)references D_PI_CURRENT (PI_BI_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIIS_FK foreign key (DPIIS_ID) references D_PI_INSTANCE_STATUS (DPIIS_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIIA_FK foreign key (DPIIA_ID) references D_PI_INCIDENT_ABOUT (DPIIA_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIIR_FK foreign key (DPIIR_ID) references D_PI_INCIDENT_REASON (DPIIR_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIISS_FK foreign key (DPIISS_ID) references D_PI_INCIDENT_STATUS (DPIISS_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIJS_FK foreign key (DPIJS_ID) references D_PI_JEOPARDY_STATUS (DPIJS_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIES_FK foreign key (DPIES_ID) references D_PI_ENROLLMENT_STATUS (DPIES_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPIUB_FK foreign key (DPIUB_ID) references D_PI_LAST_UPDATE_BY (DPIUB_ID);
alter table F_PI_BY_DATE add constraint FPIBD_DPITI_FK foreign key (DPITI_ID) references D_PI_TASK_ID (DPITI_ID);

create unique index FPIBD_UIX1 on F_PI_BY_DATE (PI_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FPIBD_UIX2 on F_PI_BY_DATE (PI_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FPIBD_IX1 on F_PI_BY_DATE ("Incident Status Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IX2 on F_PI_BY_DATE ("Last Update Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FPIBD_IXL1 on F_PI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IXL2 on F_PI_BY_DATE (PI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IXL3 on F_PI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPIBD_IXL4 on F_PI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_PI_BY_DATE for F_PI_BY_DATE;
grant select on F_PI_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_PI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FPIBD_ID,
  BUCKET_START_DATE D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from F_PI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  F_PI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from
  BPM_D_DATES bdd,
  F_PI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FPIBD_ID,
  bdd.D_DATE,
  PI_BI_ID, 
  DPIIS_ID,
  DPIIA_ID,
  DPIIR_ID,
  DPIISS_ID,
  DPIJS_ID,
  DPIES_ID,
  DPIUB_ID,
  DPITI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from
  BPM_D_DATES bdd,
  F_PI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_PI_BY_DATE_SV for F_PI_BY_DATE_SV;
grant select on F_PI_BY_DATE_SV to MAXDAT_READ_ONLY;

create or replace view INCIDENT_DESC_SV as
select
  INCIDENT_ID,
  INCIDENT_DESCRIPTION
 from CORP_ETL_PROCESS_INCIDENTS
with read only;

create or replace public synonym INCIDENT_DESC_SV for INCIDENT_DESC_SV;
grant select on INCIDENT_DESC_SV to MAXDAT_READ_ONLY;
