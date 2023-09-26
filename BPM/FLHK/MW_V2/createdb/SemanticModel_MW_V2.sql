/*
Created on 21-Sep-2014 by Raj A.
Description: Create Semantic Data Model for Manage Work V2 process.
Columns added and removed are mentioned in the create_ETL_tables.sql script. 
V2 release Semantic changes include No spaces in the column name, All Caps.
*/
create table D_MW_V2_CURRENT
 (MW_BI_ID                       NUMBER NOT NULL,
  AGE_IN_BUSINESS_DAYS           NUMBER DEFAULT 0 NOT NULL,
  AGE_IN_CALENDAR_DAYS           NUMBER DEFAULT 0 NOT NULL,
  CANCELLED_BY_STAFF_ID          NUMBER,
  CANCEL_METHOD                  VARCHAR2(50),
  CANCEL_REASON                  VARCHAR2(256),
  CANCEL_WORK_DATE               DATE,
  CASE_ID                        NUMBER(18),
  CLIENT_ID                      NUMBER(18), 
  COMPLETE_DATE                  DATE,
  CREATE_DATE                    DATE not null,
  CURR_CREATED_BY_STAFF_ID	     NUMBER,
  ESCALATED_FLAG                 VARCHAR2(1) default 'N' not null,
  CURR_ESCALATED_TO_STAFF_ID	 NUMBER,
  CURR_FORWARDED_BY_STAFF_ID	 NUMBER,
  FORWARDED_FLAG                 VARCHAR2(1) default 'N' not null,
  CURR_BUSINESS_UNIT_ID          NUMBER,
  INSTANCE_START_DATE            DATE,    -- set by trigger
  INSTANCE_END_DATE              DATE,    -- set by trigger
  JEOPARDY_FLAG                  VARCHAR2(1) default 'N' not null,
  CURR_LAST_UPD_BY_STAFF_ID	     NUMBER,
  CURR_LAST_UPDATE_DATE          DATE not null,
  LAST_EVENT_DATE                DATE,
  CURR_OWNER_STAFF_ID	         NUMBER,
  PARENT_TASK_ID                 NUMBER,  
  SOURCE_REFERENCE_ID            INTEGER,
  SOURCE_REFERENCE_TYPE          VARCHAR2(30),
  CURR_STATUS_DATE               DATE not null,
  STATUS_AGE_IN_BUS_DAYS         NUMBER DEFAULT 0 NOT NULL,
  STATUS_AGE_IN_CAL_DAYS         NUMBER DEFAULT 0 NOT NULL,
  STG_EXTRACT_DATE               DATE default SYSDATE not null,  -- set via trigger
  STG_LAST_UPDATE_DATE           DATE default SYSDATE not null,  -- set via trigger
  STAGE_DONE_DATE                DATE,
  TASK_ID                        NUMBER not null,
  TASK_PRIORITY                  VARCHAR2(50),
  CURR_TASK_STATUS               VARCHAR2(50) not null,  ----- Is it CURRENT_TASK_STATUS ? hISTORY NOT NEEDED THOUGH.
  TASK_TYPE_ID                   NUMBER not null,
  CURR_TEAM_ID                   NUMBER,
  TIMELINESS_STATUS              VARCHAR2(20) default 'Not Complete' not null,
  UNIT_OF_WORK                   VARCHAR2(30),
  CURR_WORK_RECEIPT_DATE         DATE,
  SOURCE_PROCESS_ID              NUMBER(18), 
  SOURCE_PROCESS_INSTANCE_ID     NUMBER(18),
  CHANNEL                        VARCHAR2(25)  
  )
 parallel;

alter table D_MW_V2_CURRENT add constraint DMWCUR_V2_PK primary key (MW_BI_ID) using index;

create unique index DMWCUR_V2_UNIQ_TASK_ID on D_MW_V2_CURRENT (TASK_ID) online parallel compute statistics;
create index DMWCUR_V2_CANCELLED_STF_ID on D_MW_V2_CURRENT (CANCELLED_BY_STAFF_ID);
create index DMWCUR_V2_CREATED_STF_ID on D_MW_V2_CURRENT (CURR_CREATED_BY_STAFF_ID);
create index DMWCUR_V2_ESCALATED_STF_ID on D_MW_V2_CURRENT (CURR_ESCALATED_TO_STAFF_ID);
create index DMWCUR_V2_FORWARDED_STF_ID on D_MW_V2_CURRENT (CURR_FORWARDED_BY_STAFF_ID);
create index DMWCUR_V2_LAST_UPD_BY_STF_ID on D_MW_V2_CURRENT (CURR_LAST_UPD_BY_STAFF_ID);
create index DMWCUR_V2_OWNER_STF_ID on D_MW_V2_CURRENT (CURR_OWNER_STAFF_ID);
create index DMWCUR_V2_CURR_TASK_TYPE_ID on D_MW_V2_CURRENT (TASK_TYPE_ID);
create index DMWCUR_V2_CURR_BUSUNIT_ID on D_MW_V2_CURRENT (CURR_BUSINESS_UNIT_ID);
create index DMWCUR_V2_CURR_TEAM_ID on D_MW_V2_CURRENT (CURR_TEAM_ID);

----grant select on D_MW_V2_CURRENT to MAXDAT_READ_ONLY;

  create or replace view D_MW_V2_CURRENT_SV as
  select
  MW_BI_ID,                       
  AGE_IN_BUSINESS_DAYS,           
  AGE_IN_CALENDAR_DAYS,           
  CANCELLED_BY_STAFF_ID,          
  CANCEL_METHOD,                  
  CANCEL_REASON,                  
  CANCEL_WORK_DATE,               
  CASE_ID,                        
  CLIENT_ID,                      
  COMPLETE_DATE,                  
  CREATE_DATE,                    
  CURR_CREATED_BY_STAFF_ID,
  ESCALATED_FLAG,            
  CURR_ESCALATED_TO_STAFF_ID,
  CURR_FORWARDED_BY_STAFF_ID,
  FORWARDED_FLAG,            
  CURR_BUSINESS_UNIT_ID,
  INSTANCE_START_DATE,            
  INSTANCE_END_DATE,              
  JEOPARDY_FLAG,                  
  CURR_LAST_UPD_BY_STAFF_ID,
  CURR_LAST_UPDATE_DATE,
  CURR_OWNER_STAFF_ID,         
  PARENT_TASK_ID,                 
  SOURCE_REFERENCE_ID,            
  SOURCE_REFERENCE_TYPE,          
  CURR_STATUS_DATE,               
  STATUS_AGE_IN_BUS_DAYS,         
  STATUS_AGE_IN_CAL_DAYS,         
  STG_EXTRACT_DATE,               
  STG_LAST_UPDATE_DATE,           
  STAGE_DONE_DATE,                
  TASK_ID,                        
  TASK_PRIORITY,                  
  CURR_TASK_STATUS,               
  TASK_TYPE_ID,              
  CURR_TEAM_ID,
  TIMELINESS_STATUS,              
  UNIT_OF_WORK,                   
  CURR_WORK_RECEIPT_DATE,
  SOURCE_PROCESS_ID, 
  SOURCE_PROCESS_INSTANCE_ID,
  CHANNEL
from D_MW_V2_CURRENT
with read only;  

----grant select on D_MW_V2_CURRENT_SV to MAXDAT_READ_ONLY;

/*
create sequence SEQ_DMWTT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_TASK_TYPES
  (TASK_TYPE_ID      NUMBER NOT NULL,
   TASK_NAME         VARCHAR2(50),
   TASK_DESCRIPTION  VARCHAR2(4000),
   OPERATIONS_GROUP  VARCHAR2(50),
   SLA_DAYS          NUMBER,
   SLA_DAYS_TYPE     VARCHAR2(1),
   SLA_TARGET_DAYS   NUMBER,
   SLA_JEOPARDY_DAYS NUMBER,
   UNIT_OF_WORK      VARCHAR2(30) 
   );
---tablespace MAXDAT_DATA;

alter table D_TASK_TYPES add constraint PK_TASK_TYPE_ID primary key (TASK_TYPE_ID) using index;

---grant select on D_TASK_TYPES to MAXDAT_READ_ONLY;

create or replace view D_TASK_TYPES_SV as
select * from D_TASK_TYPES
with read only;

---grant select on D_TASK_TYPES_SV to MAXDAT_READ_ONLY;


create table D_BUSINESS_UNITS
  (BUSINESS_UNIT_ID          NUMBER NOT NULL,
   BUSINESS_UNIT_NAME        VARCHAR2(80),
   BUSINESS_UNIT_DESCRIPTION VARCHAR2(1000)
   );
--- tablespace MAXDAT_DATA;

alter table D_BUSINESS_UNITS add constraint PK_BUS_UNIT_ID primary key (BUSINESS_UNIT_ID) using index;

---grant select on D_BUSINESS_UNITS to MAXDAT_READ_ONLY;

create or replace view D_BUSINESS_UNITS_SV as
select * from D_BUSINESS_UNITS
with read only;

---grant select on D_BUSINESS_UNITS_SV to MAXDAT_READ_ONLY;

create table D_TEAMS
  (TEAM_ID                  NUMBER NOT NULL,
   TEAM_NAME                VARCHAR2(80),
   TEAM_DESCRIPTION         VARCHAR2(1000),
   TEAM_SUPERVISOR_STAFF_ID NUMBER
   );
---tablespace MAXDAT_DATA;

alter table D_TEAMS add constraint PK_TEAM_ID primary key (TEAM_ID) using index;

---grant select on D_TEAMS to MAXDAT_READ_ONLY;

create or replace view D_TEAMS_SV as
select * from D_TEAMS
with read only;

---grant select on D_TEAMS_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DMWBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MW_V2_HISTORY
(DMWBD_ID            NUMBER NOT NULL,
BUCKET_START_DATE    DATE NOT NULL,
BUCKET_END_DATE      DATE NOT NULL,
MW_BI_ID             NUMBER NOT NULL,
TASK_STATUS          VARCHAR2(32) NOT NULL, 
BUSINESS_UNIT_ID     NUMBER NOT NULL, 
TEAM_ID              NUMBER NOT NULL, 
LAST_UPDATE_DATE     DATE NOT NULL,
STATUS_DATE          DATE NOT NULL,
WORK_RECEIPT_DATE    DATE NOT NULL,
LAST_EVENT_DATE      DATE NOT NULL
)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
 parallel;

alter table D_MW_V2_HISTORY add constraint DMWBD_ID_PK primary key (DMWBD_ID) using index;

alter table D_MW_V2_HISTORY add constraint DMWBD_DMW_BUS_UNIT_ID_FK foreign key (BUSINESS_UNIT_ID) references D_BUSINESS_UNITS(BUSINESS_UNIT_ID);
alter table D_MW_V2_HISTORY add constraint DMWBD_DMW_TEAM_ID_FK foreign key (TEAM_ID) references D_TEAMS(TEAM_ID);
alter table D_MW_V2_HISTORY add constraint DMWBD_MW_BI_ID_FK foreign key (MW_BI_ID) references D_MW_V2_CURRENT(MW_BI_ID);

create unique index DMWBD_UIX2 on D_MW_V2_HISTORY (MW_BI_ID, BUCKET_START_DATE) online  parallel compute statistics;
create index DMWBD_IXL2 on D_MW_V2_HISTORY (BUCKET_START_DATE,BUCKET_END_DATE) local online  parallel compute statistics;
create index DMWBD_IXL3 on D_MW_V2_HISTORY (MW_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE) local online  parallel compute statistics;

---grant select on D_MW_V2_HISTORY to MAXDAT_READ_ONLY;

create or replace view D_MW_V2_HISTORY_SV
as
SELECT
  h.DMWBD_ID,
  bdd.D_DATE,
  h.MW_BI_ID,
  h.TASK_STATUS,
  h.BUSINESS_UNIT_ID,
  h.TEAM_ID,
  h.LAST_UPDATE_DATE,
  h.STATUS_DATE,
  h.WORK_RECEIPT_DATE
FROM D_MW_V2_HISTORY h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

---grant select on D_MW_V2_HISTORY_SV to MAXDAT_READ_ONLY;

--Replace fact view 
CREATE OR REPLACE VIEW F_MW_V2_BY_DATE_SV AS 
SELECT        d.MW_BI_ID,
              bdd.D_DATE,
              CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DATE) THEN 1 else 0 END AS CREATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DATE) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 1 else 0 END AS COMPLETION_COUNT
  FROM D_DATES bdd 
  JOIN D_MW_V2_CURRENT d ON (bdd.D_DATE >= TRUNC(d.INSTANCE_START_DATE) AND (bdd.D_DATE <= d.INSTANCE_END_DATE OR d.INSTANCE_END_DATE IS NULL))
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_START_DATE)
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_END_DATE);

---grant select on F_MW_V2_BY_DATE_SV to MAXDAT_READ_ONLY;