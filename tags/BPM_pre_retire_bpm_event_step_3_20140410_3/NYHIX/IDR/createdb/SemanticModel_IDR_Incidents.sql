/*
Created on 24-Sep-2013 by Raj A.
Description: This script creates the dimension and facts table for NYHIX IDR Incidents process.
*/
CREATE TABLE D_IDR_CURRENT
(
IDR_BI_ID              number(18),
INCIDENT_ID            NUMBER(18),
CREATED_BY_GROUP       VARCHAR2(80),
CREATED_BY_NAME        VARCHAR2(150),
TRACKING_NUMBER        VARCHAR2(32),
CREATE_DT              DATE,
INCIDENT_TYPE          VARCHAR2(80),
CUR_CLIENT_ID          NUMBER(18),
ASSD_IDR_REVIEW_DOCS   DATE,
ASED_IDR_REVIEW_DOCS   DATE,
ASPB_IDR_REVIEW_DOCS   VARCHAR2(150),
ASSD_GATHER_MISS_INFO  DATE,
ASED_GATHER_MISS_INFO  DATE,
ASPB_GATHER_MISS_INFO  VARCHAR2(150),
ABOUT_PLAN_CODE        VARCHAR2(32), 
ABOUT_PROVIDER_ID      NUMBER(18), 
CUR_ACTION_COMMENTS    VARCHAR2(4000),  --CLOB in source system.
ACTION_TYPE            VARCHAR2(64), 
CANCEL_BY              VARCHAR2(150),
CANCEL_DT              DATE,
CANCEL_METHOD          VARCHAR2(30),
CANCEL_REASON          VARCHAR2(50), 
CUR_CURRENT_TASK_ID        NUMBER(38),
CUR_ENROLLMENT_STATUS      VARCHAR2(50),
CUR_INCIDENT_ABOUT         VARCHAR2(80), 
CUR_INCIDENT_DESCRIPTION   VARCHAR2(4000), --CLOB in source system.  
CUR_INCIDENT_STATUS        VARCHAR2(80),
CUR_INCIDENT_STATUS_DT     DATE,
INSTANCE_COMPLETE_DT       DATE,
CUR_COMPLETE_DT            date,
CUR_INSTANCE_STATUS        VARCHAR2(10) default 'Active' not null,
CUR_LAST_UPDATE_BY_NAME    VARCHAR2(150), 
CUR_LAST_UPDATE_BY_DT      DATE,
CUR_LAST_UPDATED_BY        VARCHAR2(80), 
OTHER_PARTY_NAME           VARCHAR2(64), 
PRIORITY                   VARCHAR2(64), 
REPORTED_BY                VARCHAR2(80), 
REPORTER_RELATIONSHIP      VARCHAR2(64), 
CUR_RESOLUTION_DESCRIPTION VARCHAR2(4000), --CLOB in source system.
CUR_RESOLUTION_TYPE        VARCHAR2(64), 
CASE_ID                NUMBER(38),
FORWARDED              VARCHAR2(1),  
FORWARDED_TO           VARCHAR2(30), 
ASF_IDR_REVIEW_DOCS    VARCHAR2(1),
ASF_GATHER_MISS_INFO   VARCHAR2(1),
GWF_CONTINUE_APPEAL    VARCHAR2(1),
JEOPARDY_DATE		   DATE,
JEOPARDY_DAYS		   NUMBER(18),
JEOPARDY_DAYS_TYPE     VARCHAR2(1),
TARGET_DAYS		   	   NUMBER(18),
AGE_IN_CALENDAR_DAYS   NUMBER(18),	
AGE_IN_BUSINESS_DAYS   NUMBER(18),
JEOPARDY_FLAG          VARCHAR2(1),
IDR_TIMELINESS_STATUS  VARCHAR2(20),
CURRENT_STEP           VARCHAR2(256),
APPELLANT_TYPE VARCHAR2(32),     
APPELLANT_TYPE_DESCRIPTION VARCHAR2(64),
REPORTER_NAME       VARCHAR2(180),
REPORTER_PHONE      VARCHAR2(32)
  ) tablespace MAXDAT_DATA parallel;
  
alter table D_IDR_CURRENT add constraint DIDRCUR_PK primary key (IDR_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRCUR_UIX1 on D_IDR_CURRENT (INCIDENT_ID) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_CURRENT FOR D_IDR_CURRENT;
grant select on D_IDR_CURRENT to MAXDAT_READ_ONLY;

CREATE PUBLIC SYNONYM D_IDR_CURRENT_SV FOR D_IDR_CURRENT_SV;
grant select on D_IDR_CURRENT_SV to MAXDAT_READ_ONLY;

------------------------------------------------------------------------------------------------------------
--D_IDR_Action_Comments    DIDRAC_ID  "Action_Comments"            VARCHAR2(100),
create sequence SEQ_DIDRAC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_Action_Comments
  (DIDRAC_ID       number, 
   Action_Comments VARCHAR2(4000))
tablespace MAXDAT_DATA;

alter table D_IDR_Action_Comments add constraint DIDRAC_PK primary key (DIDRAC_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRAC_UIX1 on D_IDR_Action_Comments (Action_Comments) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_Action_Comments_SV as
select * from D_IDR_Action_Comments
with read only;

insert into D_IDR_Action_Comments (DIDRAC_ID ,Action_Comments) values (SEQ_DIDRAC_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_Action_Comments_SV FOR D_IDR_Action_Comments_SV;
GRANT SELECT ON D_IDR_Action_Comments_SV TO MAXDAT_READ_ONLY;
------------------------------------------------------------------------------------------------------------
--D_IDR_ENROLLMENT_STATUS    DIDRES_ID  "Enrollment Status"            VARCHAR2(50),
create sequence SEQ_DIDRES_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_ENROLLMENT_STATUS
  (DIDRES_ID number, 
   ENROLLMENT_STATUS           VARCHAR2(50))
tablespace MAXDAT_DATA;

alter table D_IDR_ENROLLMENT_STATUS add constraint DIDRES_PK primary key (DIDRES_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRES_UIX1 on D_IDR_ENROLLMENT_STATUS (ENROLLMENT_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_ENROLLMENT_STATUS_SV as
select * from D_IDR_ENROLLMENT_STATUS
with read only;

insert into D_IDR_ENROLLMENT_STATUS (DIDRES_ID ,ENROLLMENT_STATUS) values (SEQ_DIDRES_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_ENROLLMENT_STATUS_SV FOR D_IDR_ENROLLMENT_STATUS_SV;
GRANT SELECT ON D_IDR_ENROLLMENT_STATUS_SV TO MAXDAT_READ_ONLY;
------------------------------------------------------------------------------------------------------------
--D_IDR_INCIDENT_ABOUT    DIDRIA_ID  "INCIDENT_ABOUT"            VARCHAR2(80),
create sequence SEQ_DIDRIA_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_INCIDENT_ABOUT
  ( DIDRIA_ID number(18), 
    INCIDENT_ABOUT           VARCHAR2(80))
tablespace MAXDAT_DATA;

alter table D_IDR_INCIDENT_ABOUT add constraint DIDRIA_PK primary key (DIDRIA_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRIA_UIX1 on D_IDR_INCIDENT_ABOUT (INCIDENT_ABOUT) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_Incident_About_SV as
select * from D_IDR_INCIDENT_ABOUT
with read only;

insert into D_IDR_INCIDENT_ABOUT (DIDRIA_ID ,INCIDENT_ABOUT) values (SEQ_DIDRIA_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_Incident_About_SV FOR D_IDR_Incident_About_SV;
grant select on D_IDR_Incident_About_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------------
--D_IDR_INCIDENT_DESCRIPTION    DIDRID_ID  "INCIDENT_DESCRIPTION"            VARCHAR2(4000),
create sequence SEQ_DIDRID_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_INCIDENT_DESCRIPTION
  ( DIDRID_ID number(18), 
    INCIDENT_DESCRIPTION           VARCHAR2(4000))
tablespace MAXDAT_DATA;

alter table D_IDR_INCIDENT_DESCRIPTION add constraint DIDRID_PK primary key (DIDRID_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRID_UIX1 on D_IDR_INCIDENT_DESCRIPTION (INCIDENT_DESCRIPTION) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_Incident_Description_SV as
select * from D_IDR_INCIDENT_DESCRIPTION
with read only;

insert into D_IDR_INCIDENT_DESCRIPTION (DIDRID_ID ,INCIDENT_DESCRIPTION) values (SEQ_DIDRID_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_Incident_Description_SV FOR D_IDR_Incident_Description_SV;
GRANT SELECT ON D_IDR_Incident_Description_SV TO MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------------
--D_IDR_INCIDENT_STATUS    DIDRIS_ID  "INCIDENT_STATUS"            VARCHAR2(30),
create sequence SEQ_DIDRIS_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_INCIDENT_STATUS
  ( DIDRIS_ID number(18), 
    INCIDENT_STATUS           VARCHAR2(80))
tablespace MAXDAT_DATA;

alter table D_IDR_INCIDENT_STATUS add constraint DIDRIS_PK primary key (DIDRIS_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRIS_UIX1 on D_IDR_INCIDENT_STATUS (INCIDENT_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_INCIDENT_STATUS_SV as
select * from D_IDR_INCIDENT_STATUS
with read only;

insert into D_IDR_INCIDENT_STATUS (DIDRIS_ID ,INCIDENT_STATUS) values (SEQ_DIDRIS_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_INCIDENT_STATUS_SV FOR D_IDR_INCIDENT_STATUS_SV;
grant select on D_IDR_INCIDENT_STATUS_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------------
--D_IDR_INSTANCE_STATUS    DIDRIN_ID  "INSTANCE_STATUS"            VARCHAR2(10),
create sequence SEQ_DIDRIN_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_INSTANCE_STATUS
  ( DIDRIN_ID number(18), 
    INSTANCE_STATUS           VARCHAR2(10))
tablespace MAXDAT_DATA;

alter table D_IDR_INSTANCE_STATUS add constraint DIDRIN_PK primary key (DIDRIN_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRIN_UIX1 on D_IDR_INSTANCE_STATUS (INSTANCE_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_Instance_Status_SV as
select * from D_IDR_INSTANCE_STATUS
with read only;

insert into D_IDR_INSTANCE_STATUS (DIDRIN_ID ,INSTANCE_STATUS) values (SEQ_DIDRIN_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_Instance_Status_SV FOR D_IDR_Instance_Status_SV;
grant select on D_IDR_Instance_Status_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------------
--D_IDR_LAST_UPDATE_BY_NAME    DIDRLUBN_ID  "LAST_UPDATE_BY_NAME"            VARCHAR2(150),
create sequence SEQ_DIDRLUBN_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_LAST_UPDATE_BY_NAME
  ( DIDRLUBN_ID number(18), 
    LAST_UPDATE_BY_NAME           VARCHAR2(150))
tablespace MAXDAT_DATA;

alter table D_IDR_LAST_UPDATE_BY_NAME add constraint DIDRLUBN_PK primary key (DIDRLUBN_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRLUBN_UIX1 on D_IDR_LAST_UPDATE_BY_NAME (LAST_UPDATE_BY_NAME) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_LAST_UPDATE_BY_NAME_SV as
select * from D_IDR_LAST_UPDATE_BY_NAME
with read only;

insert into D_IDR_LAST_UPDATE_BY_NAME (DIDRLUBN_ID ,LAST_UPDATE_BY_NAME) values (SEQ_DIDRLUBN_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_LAST_UPDATE_BY_NAME_SV FOR D_IDR_LAST_UPDATE_BY_NAME_SV;
grant select on D_IDR_LAST_UPDATE_BY_NAME_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------------
--D_IDR_LAST_UPDATED_BY    DIDRLUB_ID  "LAST_UPDATED_BY"            VARCHAR2(80),
create sequence SEQ_DIDRLUB_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_LAST_UPDATED_BY
  ( DIDRLUB_ID number(18), 
    LAST_UPDATED_BY           VARCHAR2(80))
tablespace MAXDAT_DATA;

alter table D_IDR_LAST_UPDATED_BY add constraint DIDRLUB_PK primary key (DIDRLUB_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRLUB_UIX1 on D_IDR_LAST_UPDATED_BY (LAST_UPDATED_BY) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_LAST_UPDATED_BY_SV as
select * from D_IDR_LAST_UPDATED_BY
with read only;

insert into D_IDR_LAST_UPDATED_BY (DIDRLUB_ID ,LAST_UPDATED_BY) values (SEQ_DIDRLUB_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_LAST_UPDATED_BY_SV FOR D_IDR_LAST_UPDATED_BY_SV;
grant select on D_IDR_LAST_UPDATED_BY_SV to MAXDAT_READ_ONLY;
---------------------------------------------------------------------------------------------------------
--D_IDR_RESOLUTION_DESCRIPTION    DIDRRD_ID  "RESOLUTION_DESCRIPTION"            VARCHAR2(80),
create sequence SEQ_DIDRRD_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_RESOLUTION_DESCRIPTION
  ( DIDRRD_ID number(18), 
    RESOLUTION_DESCRIPTION           VARCHAR2(4000))
tablespace MAXDAT_DATA;

alter table D_IDR_RESOLUTION_DESCRIPTION add constraint DIDRRD_PK primary key (DIDRRD_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRRD_ID_UIX1 on D_IDR_RESOLUTION_DESCRIPTION (RESOLUTION_DESCRIPTION) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_RESOLUTION_DESC_SV as
select * from D_IDR_RESOLUTION_DESCRIPTION
with read only;

insert into D_IDR_RESOLUTION_DESCRIPTION (DIDRRD_ID ,RESOLUTION_DESCRIPTION) values (SEQ_DIDRRD_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_RESOLUTION_DESC_SV FOR D_IDR_RESOLUTION_DESC_SV;
grant select on D_IDR_RESOLUTION_DESC_SV to MAXDAT_READ_ONLY;
---------------------------------------------------------------------------------------------------------
--D_IDR_RESOLUTION_TYPE    DIDRRT_ID  "RESOLUTION_TYPE"            VARCHAR2(50),
create sequence SEQ_DIDRRT_ID
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
cache 20;

create table D_IDR_RESOLUTION_TYPE
  ( DIDRRT_ID number(18), 
    RESOLUTION_TYPE           VARCHAR2(64))
tablespace MAXDAT_DATA;

alter table D_IDR_RESOLUTION_TYPE add constraint DIDRRT_PK primary key (DIDRRT_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRRT_UIX1 on D_IDR_RESOLUTION_TYPE (RESOLUTION_TYPE) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_IDR_RESOLUTION_TYPE_SV as
select * from D_IDR_RESOLUTION_TYPE
with read only;

insert into D_IDR_RESOLUTION_TYPE (DIDRRT_ID ,RESOLUTION_TYPE) values (SEQ_DIDRRT_ID.nextval,null);
commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM D_IDR_RESOLUTION_TYPE_SV FOR D_IDR_RESOLUTION_TYPE_SV;
grant select on D_IDR_RESOLUTION_TYPE_SV to MAXDAT_READ_ONLY;
---------------------------------------------------------------------------------------------------------
create sequence SEQ_FIDRBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

 create table F_IDR_BY_DATE 
	  (  FIDRBD_ID              number not null,
		 D_DATE 		        date not null,
		 BUCKET_START_DATE 	date not null, 
		 BUCKET_END_DATE 	    date not null,
		 IDR_BI_ID 			    number not null,		 
		 DIDRAC_ID              number(18),
		 CURRENT_TASK_ID 	    number(18),
		 DIDRES_ID 	            number(18),
		 DIDRIA_ID 	            number(18),
		 DIDRID_ID 			    number(18),
		 DIDRIS_ID              number(18),		 
		 DIDRIN_ID              number(18),
		 DIDRLUBN_ID            number(18),		 
		 DIDRLUB_ID             number(18),
		 DIDRRD_ID              number(18),
		 DIDRRT_ID        		  number(18),
		 CLIENT_ID 			        number,
		 INCIDENT_STATUS_DT     date,
		 LAST_UPDATE_BY_DT      date,
         COMPLETE_DT            date,
		 CREATION_COUNT   		number,
		 INVENTORY_COUNT  		number,		 
		 COMPLETION_COUNT 		number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_IDR_BY_DATE add constraint FIDRBD_PK primary key (FIDRBD_ID) using index tablespace MAXDAT_INDX;

create unique index FIDRBD_UIX1 on F_IDR_BY_DATE (IDR_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FIDRBD_UIX2 on F_IDR_BY_DATE (IDR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FIDRBD_IX1 on F_IDR_BY_DATE (LAST_UPDATE_BY_DT) online tablespace MAXDAT_INDX parallel compute statistics;
create index FIDRBD_IX2 on F_IDR_BY_DATE (INCIDENT_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics;
create index FIDRBD_IX3 on F_IDR_BY_DATE (COMPLETE_DT) online tablespace MAXDAT_INDX parallel compute statistics;

create index FIDRBD_IXL1 on F_IDR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FIDRBD_IXL2 on F_IDR_BY_DATE (IDR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FIDRBD_IXL3 on F_IDR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FIDRBD_IXL4 on F_IDR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table F_IDR_BY_DATE add constraint FIDRBD_DIDRCUR_FK foreign key (IDR_BI_ID)references D_IDR_CURRENT (IDR_BI_ID);

alter table F_IDR_BY_DATE add constraint FK_DIDRAC_ID   foreign key (DIDRAC_ID) references D_IDR_Action_Comments (DIDRAC_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRES_ID   foreign key (DIDRES_ID) references D_IDR_Enrollment_Status (DIDRES_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRIA_ID   foreign key (DIDRIA_ID) references D_IDR_Incident_About (DIDRIA_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRID_ID   foreign key (DIDRID_ID) references D_IDR_Incident_Description (DIDRID_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRIS_ID   foreign key (DIDRIS_ID) references D_IDR_Incident_Status (DIDRIS_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRIN_ID   foreign key (DIDRIN_ID) references D_IDR_Instance_Status (DIDRIN_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRLUBN_ID foreign key (DIDRLUBN_ID) references D_IDR_Last_Update_By_Name (DIDRLUBN_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRLUB_ID  foreign key (DIDRLUB_ID) references D_IDR_Last_Updated_By (DIDRLUB_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRRD_ID  foreign key (DIDRRD_ID) references D_IDR_RESOLUTION_DESCRIPTION (DIDRRD_ID);
alter table F_IDR_BY_DATE add constraint FK_DIDRRT_ID   foreign key (DIDRRT_ID) references D_IDR_Resolution_Type (DIDRRT_ID);

create or replace view F_IDR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
   FIDRBD_ID,	
	 BUCKET_START_DATE  D_DATE,	 
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from F_IDR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT, 
   COMPLETE_DT,    
   0 CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from 
  F_IDR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   0 CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from 
  F_IDR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day..
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_IDR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

commit;

--GRANTS & PUBLIC SYNONYMNS
CREATE PUBLIC SYNONYM F_IDR_BY_DATE_SV FOR F_IDR_BY_DATE_SV;
grant select on F_IDR_BY_DATE_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------
--view for current IDR incident reasons
create or replace view D_IDR_CURRENT_REASONS_SV as
select INCIDENT_ID, INCIDENT_REASON
from NYHX_ETL_IDR_INCIDENT_RSN
with read only;

create or replace public synonym D_IDR_CURRENT_REASONS_SV for D_IDR_CURRENT_REASONS_SV;
grant select on D_IDR_CURRENT_REASONS_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------