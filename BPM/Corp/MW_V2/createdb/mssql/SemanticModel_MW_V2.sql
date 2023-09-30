-- MAXdat Semantic Model for Manage Work V2.

-- Required when creating tables with computed columns.
set ansi_nulls on;
set ansi_padding on;
set ansi_warnings on;
set concat_null_yields_null on;
set numeric_roundabort off;
set quoted_identifier on;

create sequence MAXDAT.SEQ_MW_BI_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;
 
create table MAXDAT.D_MW_V2_CURRENT
  (MW_BI_ID                   int not null,
   AGE_IN_BUSINESS_DAYS       int default 0 not null,
   AGE_IN_CALENDAR_DAYS       int default 0 not null,
   CANCELLED_BY_STAFF_ID      int,
   CANCEL_METHOD              varchar(50),
   CANCEL_REASON              varchar(256),
   CANCEL_WORK_DATE           datetime,
   CASE_ID                    int,
   CLIENT_ID                  int, 
   COMPLETE_DATE              datetime,
   CREATE_DATE                datetime not null,
   CURR_CREATED_BY_STAFF_ID   int,
   ESCALATED_FLAG             varchar(1) default 'N' not null,
   CURR_ESCALATED_TO_STAFF_ID int,
   CURR_FORWARDED_BY_STAFF_ID int,
   FORWARDED_FLAG             varchar(1) default 'N' not null,
   CURR_BUSINESS_UNIT_ID      int,
   INSTANCE_START_DATE        as "CREATE_DATE",
   INSTANCE_END_DATE          as coalesce("COMPLETE_DATE","CANCEL_WORK_DATE"),
   JEOPARDY_FLAG              varchar(1) default 'N' not null,
   CURR_LAST_UPD_BY_STAFF_ID  int,
   CURR_LAST_UPDATE_DATE      datetime not null,
   LAST_EVENT_DATE            datetime,
   CURR_OWNER_STAFF_ID        int,
   PARENT_TASK_ID             int,  
   SOURCE_REFERENCE_ID        int,
   SOURCE_REFERENCE_TYPE      varchar(30),
   CURR_STATUS_DATE           datetime not null,
   STATUS_AGE_IN_BUS_DAYS     int default 0 not null,
   STATUS_AGE_IN_CAL_DAYS     int default 0 not null,
   STG_EXTRACT_DATE           datetime default getdate() not null,  -- set via trigger
   STG_LAST_UPDATE_DATE       datetime default getdate() not null,  -- set via trigger
   STAGE_DONE_DATE            datetime,
   TASK_ID                    int not null,
   TASK_PRIORITY              varchar(50),
   CURR_TASK_STATUS           varchar(50) not null,  ----- Is it CURRENT_TASK_STATUS ? hISTORY NOT NEEDED THOUGH.
   TASK_TYPE_ID               int not null,
   CURR_TEAM_ID               int,
   TIMELINESS_STATUS          varchar(20) default 'Not Complete' not null,
   UNIT_OF_WORK               varchar(30),
   CURR_WORK_RECEIPT_DATE     datetime,
   SOURCE_PROCESS_ID          int, 
   SOURCE_PROCESS_INSTANCE_ID int);

alter table MAXDAT.D_MW_V2_CURRENT add constraint DMWCUR_V2_PK primary key (MW_BI_ID);

create unique index DMWCUR_V2_UNIQ_TASK_ID on MAXDAT.D_MW_V2_CURRENT (TASK_ID);
create index DMWCUR_V2_CANCELLED_STF_ID on MAXDAT.D_MW_V2_CURRENT (CANCELLED_BY_STAFF_ID);
create index DMWCUR_V2_CREATED_STF_ID on MAXDAT.D_MW_V2_CURRENT (CURR_CREATED_BY_STAFF_ID);
create index DMWCUR_V2_ESCALATED_STF_ID on MAXDAT.D_MW_V2_CURRENT (CURR_ESCALATED_TO_STAFF_ID);
create index DMWCUR_V2_FORWARDED_STF_ID on MAXDAT.D_MW_V2_CURRENT (CURR_FORWARDED_BY_STAFF_ID);
create index DMWCUR_V2_LAST_UPD_BY_STF_ID on MAXDAT.D_MW_V2_CURRENT (CURR_LAST_UPD_BY_STAFF_ID);
create index DMWCUR_V2_OWNER_STF_ID on MAXDAT.D_MW_V2_CURRENT (CURR_OWNER_STAFF_ID);
create index DMWCUR_V2_CURR_TASK_TYPE_ID on MAXDAT.D_MW_V2_CURRENT (TASK_TYPE_ID) ;
create index DMWCUR_V2_CURR_BUSUNIT_ID on MAXDAT.D_MW_V2_CURRENT (CURR_BUSINESS_UNIT_ID);
create index DMWCUR_V2_CURR_TEAM_ID on MAXDAT.D_MW_V2_CURRENT (CURR_TEAM_ID);
go

grant select on MAXDAT.D_MW_V2_CURRENT to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_MW_V2_CURRENT_SV as
select * from MAXDAT.D_MW_V2_CURRENT;  
go

grant select on MAXDAT.D_MW_V2_CURRENT_SV to MAXDAT_READ_ONLY;
go


-- Task Type
create sequence MAXDAT.SEQ_TASK_TYPE_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_TASK_TYPES
  (TASK_TYPE_ID      int not null,
   TASK_NAME         varchar(50),
   TASK_DESCRIPTION  varchar(MAX),
   OPERATIONS_GROUP  varchar(50),
   SLA_DAYS          int,
   SLA_DAYS_TYPE     varchar(1),
   SLA_TARGET_DAYS   int,
   SLA_JEOPARDY_DAYS int,
   UNIT_OF_WORK      varchar(30));

alter table MAXDAT.D_TASK_TYPES add constraint PK_TASK_TYPE_ID primary key (TASK_TYPE_ID);
go

grant select on MAXDAT.D_TASK_TYPES to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_TASK_TYPES_SV as
select * from MAXDAT.D_TASK_TYPES;
go

insert into MAXDAT.D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK)
values (next value for MAXDAT.SEQ_TASK_TYPE_ID,null,null,null,null,null,null,null,null);

grant select on MAXDAT.D_TASK_TYPES_SV to MAXDAT_READ_ONLY;
go


--- Business Unit
create sequence MAXDAT.SEQ_BUSINESS_UNIT_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_BUSINESS_UNITS
  (BUSINESS_UNIT_ID          int not null,
   BUSINESS_UNIT_NAME        varchar(80),
   BUSINESS_UNIT_DESCRIPTION varchar(1000));

alter table MAXDAT.D_BUSINESS_UNITS add constraint PK_BUS_UNIT_ID primary key (BUSINESS_UNIT_ID) ;
go

grant select on MAXDAT.D_BUSINESS_UNITS to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_BUSINESS_UNITS_SV as
select * from MAXDAT.D_BUSINESS_UNITS;
go

insert into MAXDAT.D_BUSINESS_UNITS (BUSINESS_UNIT_ID,BUSINESS_UNIT_NAME,BUSINESS_UNIT_DESCRIPTION)
values (next value for MAXDAT.SEQ_BUSINESS_UNIT_ID,null,null);

grant select on MAXDAT.D_BUSINESS_UNITS_SV to MAXDAT_READ_ONLY;
go


-- Team
create sequence MAXDAT.SEQ_TEAM_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_TEAMS
  (TEAM_ID                  int not null,
   TEAM_NAME                varchar(80),
   TEAM_DESCRIPTION         varchar(1000),
   PARENT_TEAM_ID           int,
   TEAM_SUPERVISOR_STAFF_ID int);

alter table MAXDAT.D_TEAMS add constraint PK_TEAM_ID primary key (TEAM_ID);
go

grant select on MAXDAT.D_TEAMS to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_TEAMS_SV as
select * from MAXDAT.D_TEAMS;
go

insert into MAXDAT.TEAMS (TEAM_ID,TEAM_NAME,TEAM_DESCRIPTION,PARENT_TEAM_ID,TEAM_SUPERVISOR_STAFF_ID)
values (next value for MAXDAT.SEQ_BUSINESS_UNIT_ID,null,null,null,null);

grant select on MAXDAT.D_TEAMS_SV to MAXDAT_READ_ONLY;
go


-- History
create sequence MAXDAT.SEQ_DMWBD_ID
  minvalue 1
  start with 265
  increment by 1
  cache 20;

create table MAXDAT.D_MW_V2_HISTORY
  (DMWBD_ID          int not null,
   LAST_EVENT_DT     datetime not null,
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE   date not null,
   MW_BI_ID          int not null,
   TASK_STATUS       varchar(32) not null, 
   BUSINESS_UNIT_ID  int not null, 
   TEAM_ID           int not null, 
   LAST_UPDATE_DATE  datetime not null,
   STATUS_DATE       datetime not null,
   WORK_RECEIPT_DATE datetime not null);

alter table MAXDAT.D_MW_V2_HISTORY add constraint DMWBD_ID_PK primary key (DMWBD_ID);

alter table MAXDAT.D_MW_V2_HISTORY add constraint D_MW_V2_HISTORY_LAST_EVENT_DT check (LAST_EVENT_DT >= BUCKET_START_DATE and convert(date,LAST_EVENT_DT) <= BUCKET_END_DATE);
alter table MAXDAT.D_MW_V2_HISTORY add constraint D_MW_V2_HISTORY_BUCKET_DATE check (BUCKET_START_DATE <= BUCKET_END_DATE);

alter table MAXDAT.D_MW_V2_HISTORY add constraint DMWBD_DMW_BUS_UNIT_ID_FK foreign key (BUSINESS_UNIT_ID) references MAXDAT.D_BUSINESS_UNITS (BUSINESS_UNIT_ID);
alter table MAXDAT.D_MW_V2_HISTORY add constraint DMWBD_DMW_TEAM_ID_FK foreign key (TEAM_ID) references MAXDAT.D_TEAMS (TEAM_ID);
alter table MAXDAT.D_MW_V2_HISTORY add constraint DMWBD_MW_BI_ID_FK foreign key (MW_BI_ID) references MAXDAT.D_MW_V2_CURRENT (MW_BI_ID);

create unique index DMWBD_UIX2 on MAXDAT.D_MW_V2_HISTORY (MW_BI_ID, BUCKET_START_DATE);
create index DMWBD_IX2 on MAXDAT.D_MW_V2_HISTORY (BUCKET_START_DATE,BUCKET_END_DATE);
create index DMWBD_IX3 on MAXDAT.D_MW_V2_HISTORY (MW_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE);
go

grant select on MAXDAT.D_MW_V2_HISTORY to MAXDAT_READ_ONLY;
go

create view MAXDAT.D_MW_V2_HISTORY_SV as
select
  h.DMWBD_ID,
  bdd.D_DATE,
  h.MW_BI_ID,
  h.TASK_STATUS,
  h.BUSINESS_UNIT_ID,
  h.TEAM_ID,
  h.LAST_UPDATE_DATE,
  h.STATUS_DATE,
  h.WORK_RECEIPT_DATE
from MAXDAT.D_MW_V2_HISTORY h 
join MAXDAT.BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE and bdd.D_DATE <= h.BUCKET_END_DATE);
go

grant select on MAXDAT.D_MW_V2_HISTORY_SV to MAXDAT_READ_ONLY;
go


--Replace fact view 
create view MAXDAT.F_MW_V2_BY_DATE_SV as 
select
  d.MW_BI_ID,
  bdd.D_DATE,
  case when bdd.D_DATE = convert(datetime,convert(date,d.CREATE_DATE)) then 1 else 0 end as creation_count,
  case when bdd.D_DATE = convert(datetime,convert(date,d.COMPLETE_DATE)) then 0 else 1 end as inventory_count,
  case when (bdd.D_DATE = convert(datetime,convert(date,d.COMPLETE_DATE)) or bdd.D_DATE = convert(datetime,convert(date,d.CANCEL_WORK_DATE))) then 1 else 0 end as completion_count
from MAXDAT.D_DATES bdd 
join MAXDAT.D_MW_V2_CURRENT d on (bdd.D_DATE >= convert(datetime,convert(date,d.INSTANCE_START_DATE)) and (bdd.D_DATE <= d.INSTANCE_END_DATE or d.INSTANCE_END_DATE is null))
                                  or bdd.D_DATE = convert(datetime,convert(date,d.INSTANCE_START_DATE))
                                  or bdd.D_DATE = convert(datetime,convert(date,d.INSTANCE_END_DATE));
go

grant select on MAXDAT.F_MW_V2_BY_DATE_SV to MAXDAT_READ_ONLY;
go