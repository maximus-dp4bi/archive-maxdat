-- MAXdat Semantic Model for Process Incidents with V2 History.

-- Required when creating tables with computed columns.
set ansi_nulls on;
set ansi_padding on;
set ansi_warnings on;
set concat_null_yields_null on;
set numeric_roundabort off;
set quoted_identifier on;

create sequence MAXDAT.SEQ_PI_BI_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_CURRENT
  ("PI_BI_ID"                       int not null,
   "Incident ID"                    int,
   "Incident Tracking Number"       varchar(32),
   INSTANCE_START_DATE              as "Create Date",
   INSTANCE_END_DATE                as coalesce("Complete Date","Cancel Date"),
   "Receipt Date"                   datetime,
   "Create Date"                    datetime,
   "Created By Group"               varchar(80),
   "Origin ID"                      int,
   CHANNEL                          varchar(80),
   "Age in Business Days"           int,
   "Age in Calendar Days"           int,
   "Process Client Notification ID" int,
   "Cur Instance Status"            varchar(10),
   "Cancel Date"                    datetime,
   "Incident Type"                  varchar(80),
   "Cur Incident About"             varchar(80),
   "Cur Incident Reason"            varchar(80),
   "About Provider ID"              int,
   "About Plan Code"                varchar(32),
   "Cur Incident Status"            varchar(80),
   "Cur Incident Status Date"       datetime,
   "Status Age in Business Days"    int,
   "Status Age in Calendar Days"    int,
   "Cur Jeopardy Status"            varchar(2),
   "Jeopardy Status Date"           datetime,
   "Complete Date"                  datetime,
   "Reported By"                    varchar(80),
   "Reporter Relationship"          varchar(64),
   "Case ID"                        int,
   "Cur Enrollment Status"          varchar(32),
   PRIORITY                         varchar(256),
   PROGRAM                          varchar(32),
   "Sub-Program"                    varchar(32),
   "Cur Last Update Date"           datetime,
   "Cur Last Update By Name"        varchar(100),
   "Plan Code"                      varchar(32),
   "Provider ID"                    int,
   "Action Type"                    varchar(64),
   "Resolution Type"                varchar(64),
   "Notify Client Flag"             varchar(1),
   "Process Clnt Notify Start Dt"   datetime,
   "Process Clnt Notify End Dt"     datetime,
   "Process Clnt Notify Flag"       varchar(1),
   "Escalate Incident Flag"         varchar(1),
   "Escalate to State Dt"           datetime,
   "Cur Task ID"                    int,
   "State Received Appeal Date"     datetime,
   "Hearing Date"                   datetime,
   "Selection ID"                   int,
   "Timeliness Status"              varchar(20),
   "EB Follow-Up Needed Flag"       varchar(1),
   "Other Party Name"               varchar(80),
   "Research Incident St Dt"        datetime,
   "Research Incident End Dt"       datetime,
   "Process Incident St Dt"         datetime,
   "Process Incident End Dt"        datetime,
   "Process Incident Flag"          varchar(1),
   "Return Incident Flag"           varchar(1),
   "Complete Incident St Dt"        datetime,
   "Complete Incident End Dt"       datetime,
   "Complete Incident Flag"         varchar(1),
   "Return to MMS Dt"               datetime,
   "Created By Name"                varchar(100),
   "Generic Field 1"                varchar(50),
   "Generic Field 2"                varchar(50),
   "Generic Field 3"                varchar(50),
   "Generic Field 4"                varchar(50),
   "Generic Field 5"                varchar(50),
   "Enrollee RIN"                   varchar(30),
   "Reporter Name"                  varchar(80),
   "Research Incident Flag"         varchar(1),
   CANCEL_BY                        varchar(80),
   CANCEL_METHOD                    varchar(80),
   CANCEL_REASON                    varchar(80),
   "COUNTY_CODE"                    varchar(32),
   "COUNTY_NAME"    			    varchar(64),
   "ACTION_COMMENTS"                varchar(MAX),
   "INCIDENT_DESCRIPTION"           varchar(MAX),
   "RESOLUTION_DESCRIPTION"         varchar(MAX));

alter table MAXDAT.D_PI_CURRENT add constraint DPICUR_PK primary key (PI_BI_ID);

create unique index DPICUR_UIX1 on MAXDAT.D_PI_CURRENT ("Incident ID");
go

grant select on MAXDAT.D_PI_CURRENT to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_CURRENT_SV as 
select * from MAXDAT.D_PI_CURRENT;
go

grant select on MAXDAT.D_PI_CURRENT_SV to MAXDAT_READ_ONLY;
go

create view MAXDAT.INCIDENT_DESC_SV as
select 
  "Incident ID" INCIDENT_ID,
  "INCIDENT_DESCRIPTION" INCIDENT_DESCRIPTION
from MAXDAT.D_PI_CURRENT;
go

grant select on MAXDAT.INCIDENT_DESC_SV to MAXDAT_READ_ONLY;
go

create view MAXDAT.RESOLUTION_DESC_SV as
select 
  "Incident ID" INCIDENT_ID,
  "RESOLUTION_DESCRIPTION" RESOLUTION_DESCRIPTION
from MAXDAT.D_PI_CURRENT;
go

grant select on MAXDAT.RESOLUTION_DESC_SV to MAXDAT_READ_ONLY;
go


-- D_PI_INSTANCE_STATUS
create sequence MAXDAT.SEQ_DPIIS_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_INSTANCE_STATUS 
  (DPIIS_ID          int not null,
   "Instance Status" varchar(10));

alter table MAXDAT.D_PI_INSTANCE_STATUS add constraint DPIIS_PK primary key (DPIIS_ID);

create unique index DPIIS_UIX1 on MAXDAT.D_PI_INSTANCE_STATUS ("Instance Status");
go

grant select on MAXDAT.D_PI_INSTANCE_STATUS to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_INSTANCE_STATUS_SV as
select * from MAXDAT.D_PI_INSTANCE_STATUS;
go

insert into MAXDAT.D_PI_INSTANCE_STATUS (DPIIS_ID ,"Instance Status") values (next value for MAXDAT.SEQ_DPIIS_ID,null);

grant select on MAXDAT.D_PI_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;
go


-- D_PI_INCIDENT_ABOUT
create sequence MAXDAT.SEQ_DPIIA_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_INCIDENT_ABOUT 
  (DPIIA_ID         int not null,
   "Incident About" varchar(80));

alter table MAXDAT.D_PI_INCIDENT_ABOUT add constraint DPIIA_PK primary key (DPIIA_ID);

create unique index DPIIA_UIX1 on MAXDAT.D_PI_INCIDENT_ABOUT ("Incident About");
go

grant select on MAXDAT.D_PI_INCIDENT_ABOUT to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_INCIDENT_ABOUT_SV as
select * from MAXDAT.D_PI_INCIDENT_ABOUT;
go

insert into MAXDAT.D_PI_INCIDENT_ABOUT (DPIIA_ID ,"Incident About") values (next value for MAXDAT.SEQ_DPIIA_ID,null);

grant select on MAXDAT.D_PI_INCIDENT_ABOUT_SV to MAXDAT_READ_ONLY;
go


-- D_PI_INCIDENT_REASON
create sequence MAXDAT.SEQ_DPIIR_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_INCIDENT_REASON 
  (DPIIR_ID          int not null,
   "Incident Reason" varchar(80));

alter table MAXDAT.D_PI_INCIDENT_REASON add constraint DPIIR_PK primary key (DPIIR_ID);

create unique index DPIIR_UIX1 on MAXDAT.D_PI_INCIDENT_REASON ("Incident Reason");
go

grant select on MAXDAT.D_PI_INCIDENT_REASON to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_INCIDENT_REASON_SV as
select * from MAXDAT.D_PI_INCIDENT_REASON;
go

insert into MAXDAT.D_PI_INCIDENT_REASON (DPIIR_ID ,"Incident Reason") values (next value for MAXDAT.SEQ_DPIIR_ID,null);

grant select on MAXDAT.D_PI_INCIDENT_REASON_SV to MAXDAT_READ_ONLY;
go


--D_PI_INCIDENT_STATUS
create sequence MAXDAT.SEQ_DPIISS_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_INCIDENT_STATUS 
  (DPIISS_ID         int not null,
   "Incident Status" varchar(80));

alter table MAXDAT.D_PI_INCIDENT_STATUS add constraint DPIISS_PK primary key (DPIISS_ID);

create unique index DPIISS_UIX1 on MAXDAT.D_PI_INCIDENT_STATUS ("Incident Status")
go

create view MAXDAT.D_PI_INCIDENT_STATUS_SV as
select * from MAXDAT.D_PI_INCIDENT_STATUS;
go

grant select on MAXDAT.D_PI_INCIDENT_STATUS to MAXDAT_READ_ONLY;
go

insert into MAXDAT.D_PI_INCIDENT_STATUS (DPIISS_ID ,"Incident Status") values (next value for MAXDAT.SEQ_DPIISS_ID,null);

grant select on MAXDAT.D_PI_INCIDENT_STATUS_SV to MAXDAT_READ_ONLY;
go


-- D_PI_JEOPARDY_STATUS
create sequence MAXDAT.SEQ_DPIJS_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_JEOPARDY_STATUS 
  (DPIJS_ID          int not null,
   "Jeopardy Status" varchar(2));

alter table MAXDAT.D_PI_JEOPARDY_STATUS add constraint DPIJS_PK primary key (DPIJS_ID);

create unique index DPIJS_UIX1 on MAXDAT.D_PI_JEOPARDY_STATUS ("Jeopardy Status");
go

grant select on MAXDAT.D_PI_JEOPARDY_STATUS to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_JEOPARDY_STATUS_SV as
select * from MAXDAT.D_PI_JEOPARDY_STATUS;
go

insert into MAXDAT.D_PI_JEOPARDY_STATUS (DPIJS_ID ,"Jeopardy Status") values (next value for MAXDAT.SEQ_DPIJS_ID,null);

grant select on MAXDAT.D_PI_JEOPARDY_STATUS_SV to MAXDAT_READ_ONLY;
go


-- D_PI_ENROLLMENT_STATUS
create sequence MAXDAT.SEQ_DPIES_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_ENROLLMENT_STATUS 
  (DPIES_ID            int not null,
   "Enrollment Status" varchar(32));

alter table MAXDAT.D_PI_ENROLLMENT_STATUS add constraint DPIES_PK primary key (DPIES_ID);

create unique index DPIES_UIX1 on MAXDAT.D_PI_ENROLLMENT_STATUS ("Enrollment Status");
go

grant select on MAXDAT.D_PI_ENROLLMENT_STATUS to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_ENROLLMENT_STATUS_SV as
select * from MAXDAT.D_PI_ENROLLMENT_STATUS;
go

insert into MAXDAT.D_PI_ENROLLMENT_STATUS (DPIES_ID ,"Enrollment Status") values (next value for MAXDAT.SEQ_DPIES_ID,null);

grant select on MAXDAT.D_PI_ENROLLMENT_STATUS_SV to MAXDAT_READ_ONLY;
go


-- D_PI_LAST_UPDATE_BY
create sequence MAXDAT.SEQ_DPIUB_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_LAST_UPDATE_BY 
  (DPIUB_ID              int not null,
   "Last Update By Name" varchar(100));

alter table MAXDAT.D_PI_LAST_UPDATE_BY add constraint DPILUB_PK primary key (DPIUB_ID);

create unique index DPIUB_UIX1 on MAXDAT.D_PI_LAST_UPDATE_BY ("Last Update By Name");
go

grant select on MAXDAT.D_PI_LAST_UPDATE_BY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_LAST_UPDATE_BY_SV as
select * from MAXDAT.D_PI_LAST_UPDATE_BY;
go

insert into MAXDAT.D_PI_LAST_UPDATE_BY (DPIUB_ID ,"Last Update By Name") values (next value for MAXDAT.SEQ_DPIUB_ID,null);

grant select on MAXDAT.D_PI_LAST_UPDATE_BY_SV to MAXDAT_READ_ONLY;
go


-- D_PI_TASK_ID
create sequence MAXDAT.SEQ_DPITI_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_TASK_ID 
  (DPITI_ID  int not null, 
   "Task ID" int);

alter table MAXDAT.D_PI_TASK_ID add constraint DPITI_PK primary key (DPITI_ID);

create unique index DPITI_UIX1 on MAXDAT.D_PI_TASK_ID ("Task ID"); 
go

grant select on MAXDAT.D_PI_TASK_ID to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_TASK_ID_SV as
select * from MAXDAT.D_PI_TASK_ID;
go

insert into MAXDAT.D_PI_TASK_ID (DPITI_ID ,"Task ID") values (next value for MAXDAT.SEQ_DPITI_ID,null);

grant select on MAXDAT.D_PI_TASK_ID_SV to MAXDAT_READ_ONLY;
go


-- Fact D_PI_HISTORY
create sequence MAXDAT.SEQ_DPIH_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_PI_HISTORY 
  (DPIH_ID                int not null,
   LAST_EVENT_DT         datetime not null,
   BUCKET_START_DATE      date not null, 
   BUCKET_END_DATE        date not null,
   PI_BI_ID               int not null, 
   DPIIS_ID               int not null, 
   DPIIA_ID               int not null,
   DPIIR_ID               int not null,
   DPIISS_ID              int not null,
   DPIJS_ID               int not null,
   DPIES_ID               int not null,
   DPIUB_ID               int not null,
   DPITI_ID               int not null,
   "Incident Status Date" datetime,
   "Last Update Date"     datetime);

alter table MAXDAT.D_PI_HISTORY add constraint DPIH_PK primary key (DPIH_ID);

alter table MAXDAT.D_PI_HISTORY add constraint D_PI_HISTORY_LAST_EVENT_DT check (LAST_EVENT_DT >= BUCKET_START_DATE and convert(date,LAST_EVENT_DT) <= BUCKET_END_DATE);
alter table MAXDAT.D_PI_HISTORY add constraint D_PI_HISTORY_BUCKET_DATE check (BUCKET_START_DATE <= BUCKET_END_DATE);

alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPICUR_FK foreign key (PI_BI_ID)references MAXDAT.D_PI_CURRENT (PI_BI_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIIS_FK foreign key (DPIIS_ID) references MAXDAT.D_PI_INSTANCE_STATUS (DPIIS_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIIA_FK foreign key (DPIIA_ID) references MAXDAT.D_PI_INCIDENT_ABOUT (DPIIA_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIIR_FK foreign key (DPIIR_ID) references MAXDAT.D_PI_INCIDENT_REASON (DPIIR_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIISS_FK foreign key (DPIISS_ID) references MAXDAT.D_PI_INCIDENT_STATUS (DPIISS_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIJS_FK foreign key (DPIJS_ID) references MAXDAT.D_PI_JEOPARDY_STATUS (DPIJS_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIES_FK foreign key (DPIES_ID) references MAXDAT.D_PI_ENROLLMENT_STATUS (DPIES_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPIUB_FK foreign key (DPIUB_ID) references MAXDAT.D_PI_LAST_UPDATE_BY (DPIUB_ID);
alter table MAXDAT.D_PI_HISTORY add constraint DPIH_DPITI_FK foreign key (DPITI_ID) references MAXDAT.D_PI_TASK_ID (DPITI_ID);

create unique index DPIH_UIX2 on MAXDAT.D_PI_HISTORY (PI_BI_ID,BUCKET_START_DATE); 

create index DPIH_IX1 on MAXDAT.D_PI_HISTORY ("Incident Status Date");
create index DPIH_IX2 on MAXDAT.D_PI_HISTORY ("Last Update Date");

create index DPIH_IX3 on MAXDAT.D_PI_HISTORY (BUCKET_END_DATE);
create index DPIH_IX4 on MAXDAT.D_PI_HISTORY (PI_BI_ID);
create index DPIH_IX5 on MAXDAT.D_PI_HISTORY (BUCKET_START_DATE,BUCKET_END_DATE);
go

grant select on MAXDAT.D_PI_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_PI_HISTORY_SV as
select
  h.DPIH_ID,
  bdd.D_DATE,
  h.PI_BI_ID, 
  h.DPIIS_ID,
  h.DPIIA_ID,
  h.DPIIR_ID,
  h.DPIISS_ID,
  h.DPIJS_ID,
  h.DPIES_ID,
  h.DPIUB_ID,
  h.DPITI_ID,
  h."Incident Status Date",
  h."Last Update Date"
from MAXDAT.D_PI_HISTORY h 
join MAXDAT.BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE and bdd.D_DATE <= h.BUCKET_END_DATE);
go

grant select on MAXDAT.D_PI_HISTORY_SV to MAXDAT_READ_ONLY;
go

--Replace fact view 
create view MAXDAT.F_PI_BY_DATE_SV as 
select
  d.PI_BI_ID,
  bdd.D_DATE,
  case when bdd.D_DATE = convert(datetime,convert(date,d."Create Date")) then 1 else 0 end as creation_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d."Complete Date")) then 0 else 1 end as inventory_count,
  case when (bdd.D_DATE = convert(datetime,convert(date,d."Complete Date")) or bdd.D_DATE = convert(datetime,convert(date,d."Cancel Date"))) then 1 else 0 end as completion_count
from MAXDAT.D_DATES bdd 
join MAXDAT.D_PI_CURRENT d on (bdd.D_DATE >= convert(datetime,convert(date,d.INSTANCE_START_DATE)) and (bdd.D_DATE <= d.INSTANCE_END_DATE or d.INSTANCE_END_DATE is null))
                                  or bdd.D_DATE = convert(datetime,convert(date,d.INSTANCE_START_DATE))
                                  or bdd.D_DATE = convert(datetime,convert(date,d.INSTANCE_END_DATE));
go

grant select on MAXDAT.F_PI_BY_DATE_SV to MAXDAT_READ_ONLY;
go