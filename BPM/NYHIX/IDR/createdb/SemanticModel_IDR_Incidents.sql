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
REPORTER_PHONE      VARCHAR2(32),
CHANNEL 	    VARCHAR2(80),
ACCOUNT_ID 		VARCHAR2(30),
PREF_LANGUAGE  varchar2(256)

  ) tablespace MAXDAT_DATA;
  
alter table D_IDR_CURRENT add constraint DIDRCUR_PK primary key (IDR_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DIDRCUR_UIX1 on D_IDR_CURRENT (INCIDENT_ID) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

--GRANTS
grant select on D_IDR_CURRENT to MAXDAT_READ_ONLY;
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

create unique index DIDRAC_UIX1 on D_IDR_Action_Comments (Action_Comments) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_Action_Comments_SV as
select * from D_IDR_Action_Comments
with read only;

insert into D_IDR_Action_Comments (DIDRAC_ID ,Action_Comments) values (SEQ_DIDRAC_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRES_UIX1 on D_IDR_ENROLLMENT_STATUS (ENROLLMENT_STATUS) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_ENROLLMENT_STATUS_SV as
select * from D_IDR_ENROLLMENT_STATUS
with read only;

insert into D_IDR_ENROLLMENT_STATUS (DIDRES_ID ,ENROLLMENT_STATUS) values (SEQ_DIDRES_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRIA_UIX1 on D_IDR_INCIDENT_ABOUT (INCIDENT_ABOUT) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_Incident_About_SV as
select * from D_IDR_INCIDENT_ABOUT
with read only;

insert into D_IDR_INCIDENT_ABOUT (DIDRIA_ID ,INCIDENT_ABOUT) values (SEQ_DIDRIA_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRID_UIX1 on D_IDR_INCIDENT_DESCRIPTION (INCIDENT_DESCRIPTION) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_Incident_Description_SV as
select * from D_IDR_INCIDENT_DESCRIPTION
with read only;

insert into D_IDR_INCIDENT_DESCRIPTION (DIDRID_ID ,INCIDENT_DESCRIPTION) values (SEQ_DIDRID_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRIS_UIX1 on D_IDR_INCIDENT_STATUS (INCIDENT_STATUS) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_INCIDENT_STATUS_SV as
select * from D_IDR_INCIDENT_STATUS
with read only;

insert into D_IDR_INCIDENT_STATUS (DIDRIS_ID ,INCIDENT_STATUS) values (SEQ_DIDRIS_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRIN_UIX1 on D_IDR_INSTANCE_STATUS (INSTANCE_STATUS) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_Instance_Status_SV as
select * from D_IDR_INSTANCE_STATUS
with read only;

insert into D_IDR_INSTANCE_STATUS (DIDRIN_ID ,INSTANCE_STATUS) values (SEQ_DIDRIN_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRLUBN_UIX1 on D_IDR_LAST_UPDATE_BY_NAME (LAST_UPDATE_BY_NAME) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_LAST_UPDATE_BY_NAME_SV as
select * from D_IDR_LAST_UPDATE_BY_NAME
with read only;

insert into D_IDR_LAST_UPDATE_BY_NAME (DIDRLUBN_ID ,LAST_UPDATE_BY_NAME) values (SEQ_DIDRLUBN_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRLUB_UIX1 on D_IDR_LAST_UPDATED_BY (LAST_UPDATED_BY) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_LAST_UPDATED_BY_SV as
select * from D_IDR_LAST_UPDATED_BY
with read only;

insert into D_IDR_LAST_UPDATED_BY (DIDRLUB_ID ,LAST_UPDATED_BY) values (SEQ_DIDRLUB_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRRD_ID_UIX1 on D_IDR_RESOLUTION_DESCRIPTION (RESOLUTION_DESCRIPTION) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_RESOLUTION_DESC_SV as
select * from D_IDR_RESOLUTION_DESCRIPTION
with read only;

insert into D_IDR_RESOLUTION_DESCRIPTION (DIDRRD_ID ,RESOLUTION_DESCRIPTION) values (SEQ_DIDRRD_ID.nextval,null);
commit;

--GRANTS
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

create unique index DIDRRT_UIX1 on D_IDR_RESOLUTION_TYPE (RESOLUTION_TYPE) online tablespace MAXDAT_INDX compute statistics; 

create or replace view D_IDR_RESOLUTION_TYPE_SV as
select * from D_IDR_RESOLUTION_TYPE
with read only;

insert into D_IDR_RESOLUTION_TYPE (DIDRRT_ID ,RESOLUTION_TYPE) values (SEQ_DIDRRT_ID.nextval,null);
commit;

--GRANTS 
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
tablespace MAXDAT_DATA;

alter table F_IDR_BY_DATE add constraint FIDRBD_PK primary key (FIDRBD_ID) using index tablespace MAXDAT_INDX;

create unique index FIDRBD_UIX1 on F_IDR_BY_DATE (IDR_BI_ID,D_DATE) online tablespace MAXDAT_INDX compute statistics; 
create unique index FIDRBD_UIX2 on F_IDR_BY_DATE (IDR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX compute statistics; 

create index FIDRBD_IX1 on F_IDR_BY_DATE (LAST_UPDATE_BY_DT) online tablespace MAXDAT_INDX compute statistics;
create index FIDRBD_IX2 on F_IDR_BY_DATE (INCIDENT_STATUS_DT) online tablespace MAXDAT_INDX compute statistics;
create index FIDRBD_IX3 on F_IDR_BY_DATE (COMPLETE_DT) online tablespace MAXDAT_INDX compute statistics;

create index FIDRBD_IXL1 on F_IDR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX compute statistics;
create index FIDRBD_IXL2 on F_IDR_BY_DATE (IDR_BI_ID) local online tablespace MAXDAT_INDX compute statistics;
create index FIDRBD_IXL3 on F_IDR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX compute statistics;
create index FIDRBD_IXL4 on F_IDR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX compute statistics;

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

--GRANTS
grant select on F_IDR_BY_DATE_SV to MAXDAT_READ_ONLY;

--------------------------------------------------------------------------------------
--view for current IDR incident reasons
create or replace view D_IDR_CURRENT_REASONS_SV as
select INCIDENT_ID, INCIDENT_REASON
from NYHX_ETL_IDR_INCIDENT_RSN
with read only;

grant select on D_IDR_CURRENT_REASONS_SV to MAXDAT_READ_ONLY;
--------------------------------------------------------------------------------------------
Create table maxdat.incident_status_lookup
(
Incident_status varchar2(80),
Status_cd varchar2(80),
start_stop varchar2(10),
module varchar2(80)
)
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

grant select on incident_status_lookup to MAXDAT_READ_ONLY;
grant select on incident_status_lookup to DP_SCORECARD;

insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Validity Check','APPEAL_VALID','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Hearing Set','HEAR_NO_DISP','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Notice of Dismissal','NOTICE_OF_DISMISSAL','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Schedule Hearing','SCHED_HEAR','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal','VALID_APPEAL','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Denied ATC','VALID_APPEAL_DENIED_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Granted ATC','VALID_APPEAL_GRANTED_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Process ATC','VALID_APPEAL_PROCESS_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('SBM Desk Review','SHOP_REVIEW','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed','APPEAL_CLOSED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Duplicate/Error','INC_CLOSED_DUP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Failed to Attend Hearing','APL_CLOS_FAIL_TO_ATND_HEARING','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Non-Sworn Cancellation','APPEAL_CLOSE_NON_SWORN_CANCEL','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Written Withdrawal','APPEAL_CLOSED_WRITTEN_WITHDRL','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissed','DISMISSED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissed - Death','DIS_DEATH','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Action Required','RETURN_ACTION_REQUIRED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - ARU Action Completed','APPEAL_CLOSED_ARU_ACTION','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - DOH Action Completed','APPEAL_CLOSED_DOH_ACTION_COMP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to ARU QC','REFER_TO_ARU_QC','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH Application Support','RETN_REF_TO_DOH_APPLN_SUPPORT','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH APTC/QHP/Plan Management','RETN_REF_TO_DOH_APTC_QHP_PLAN','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH MA/FHP','RETURNED_REFER_TO_DOH_MA_FHP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH TPHI','RETURNED_REFER_TO_DOH_TPHI','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Open','APPEAL_OPEN','START','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Adjournment','ADJOURNMENT','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Adjournment - Awaiting Documentation','ADJOURNMENT_AWAITING_DOCUMENT','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Validity Amendment - Individual','AWAIT_VALID_INDV','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissal - Failed to Attend Hearing','DIS_NO_ATTEND','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Invalid with Right to Cure','INVALID_RIGHT_TO_CURE','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Non-Sworn Cancellation','NON_SWORN_CANCELLATION','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Pending Withdrawal/Cancellation','PENDING_WITHDRAWAL_CANCEL','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Request to Vacate Dismissal','REQ_VACATE_DISM','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Reschedule Hearing','RESCHED_HEAR_DOH_REQ','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Written Withdrawal','AWAIT_WITH','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Written Withdrawal','AWAIT_WITH','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Follow up Required','FOLLOW_UP_REQUIRED','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Appeals','REFERRED_TO_STATE_APPEALS','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Application Support','REFERRED_TO_STATE_APP_SUP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-APTC/QHP Plan Management','REFERRED_TO_STATE_RESEARCH','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-CHP','REFERRED_TO_STATE_CHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Financial Management','REFERRED_TO_STATE_FINANCE_MGT','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-MA/FHP','REFERRED_TO_STATE_MA_FHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Medicaid Managed Care','REFERRED_TO_STATE_MANAGED_CARE','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-SHOP','REFERRED_TO_STATE_SHOP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-TPHI','REFERRED_TO_STATE_TPHI','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to Supervisor','REFERRED_TO_SUPERVISOR','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Sent In Error','SENT_IN_ERROR','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Appeals','STATE_SUP_APPEALS','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Application Support','STATE_SUP_APP_SUP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-APTC/QHP Plan Management','STATE_SUP_RESEARCH','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-CHP','STATE_SUP_CHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Financial Management','STATE_SUP_FM','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-MA/FHP','STATE_SUP_MA_FHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Managed Care','STATE_SUP_MC','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-SHOP','STATE_SUP_SHOP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-TPHI','STATE_SUP_TPHI','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Transition','STATE_SUP_TRANSITION','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Documentation','AWAIT_DOC','COUNT','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Closed - Duplicate/Error','INCIDENT_CLOSED','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Not Resolved','CLOSED_IDR_FAIL','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Resolved','CLOSED_IDR_SUCCESS','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Open','INCIDENT_OPEN','START','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-NY Appeals','REFER_TO_APPEAL','COUNT','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-NY Appeals','REF_APPEALS_SUPER','COUNT','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Withdrawn','REFERRAL WITHDRAWN','FINISH','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Closed','REFERRAL CLOSED','FINISH','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Open','REFERRAL_OPEN','START','REFERRAL');

commit;


CREATE OR REPLACE VIEW MAXDAT.D_INCIDENT_STATUS_HISTORY_SV
AS
WITH get_basic AS
(
SELECT distinct
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_HEADER_ID AS INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
lag(INCIDENT_STATUS,1) OVER (PARTITION BY incident_header_id ORDER BY create_ts) AS prev_incident_status,
CREATE_TS INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
lead(create_ts,1) OVER (PARTITION BY incident_header_id ORDER BY create_ts,INCIDENT_HEADER_STAT_HIST_ID) as end_date
from
INCIDENT_HEADER_STAT_HIST_STG ishs1),
get_hearing as
(SELECT 
     a.INCIDENT_HEADER_STAT_HIST_ID
    ,a.incident_id
    , a.INCIDENT_STATUS
    , max(b.appeal_hearing_date) OVER (PARTITION BY a.incident_id) max_appeal_hearing_date
FROM get_basic a
JOIN MAXDAT.d_appeals_current b
ON a.INCIDENT_ID = b.incident_id
WHERE b.appeal_hearing_date IS NOT null
)
,get_status as
(
SELECT DISTINCT-- a.hearing_dismissed, 
a.INCIDENT_HEADER_STAT_HIST_ID
, max(a.max_appeal_hearing_date) OVER (PARTITION BY a.incident_id) resch_appeal_hearing_date
FROM get_hearing a
JOIN get_basic c
ON c.INCIDENT_HEADER_STAT_HIST_ID = a.INCIDENT_HEADER_STAT_HIST_ID
WHERE a.INCIDENT_STATUS = 'Hearing Set'
AND c.prev_incident_status IN ('Reschedule Hearing','Request to Vacate Dismissal')
AND a.max_appeal_hearing_date IS NOT NULL
)
, get_hearing_list AS (
SELECT distinct
INCIDENT_HEADER_STAT_HIST_ID hearing_id,
max(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id) max_hearing_id,
lag(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id ORDER BY INCIDENT_HEADER_STAT_HIST_ID) lag_hearing_id,
min(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id) min_hearing_id,
INCIDENT_ID 
from
get_basic   
WHERE incident_status = 'Hearing Set'
)
, get_dismissed_list AS (
SELECT distinct
INCIDENT_HEADER_STAT_HIST_ID dismissed_id,
INCIDENT_ID
from
get_basic  
WHERE incident_status = 'Request to Vacate Dismissal'
)
,get_vacated AS (
SELECT distinct
a.hearing_id,
a.max_hearing_id,
b.dismissed_id,
a.lag_hearing_id,
a.min_hearing_id,
a.incident_id 
FROM get_hearing_list a
LEFT JOIN get_dismissed_list b
ON a.incident_id = b.incident_id
WHERE b.dismissed_id IS NOT NULL
AND b.dismissed_id < a.max_hearing_id
)
SELECT distinct
b.INCIDENT_HEADER_STAT_HIST_ID,
b.INCIDENT_ID,
b.status_cd,
b.INCIDENT_STATUS,
b.INCIDENT_STATUS_DT,
b.CREATED_BY,
b.CREATED_BY_STAFF_ID,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN b.INCIDENT_STATUS_DT ELSE b.END_DATE END end_date,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE bus_days_between(b.INCIDENT_STATUS_DT, nvl(b.end_date,SYSDATE)) end age_in_business_days,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE trunc(nvl(b.end_date,SYSDATE)) - trunc(b.INCIDENT_STATUS_DT) end age_in_calendar_days,
CASE WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) < nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1) 
          THEN 0 -- UPD1_450          
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE)
          THEN 0 -- UPD1_410
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND c.dismissed_id < c.hearing_id
          THEN bus_days_between(a.resch_appeal_hearing_date,nvl(b.end_date,SYSDATE)) -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) = nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,1) > nvl(c.lag_hearing_id,9999999999)  AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1)  AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE)          
          THEN 0 -- UPD1_430
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND c.dismissed_id > c.hearing_id AND c.hearing_id < c.max_hearing_id
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) = nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,1) > nvl(c.lag_hearing_id,9999999999) AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1) AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE)
          THEN bus_days_between(d.max_appeal_hearing_date,nvl(b.end_date,SYSDATE)) -- UPD1_440
     WHEN b.incident_status = 'Hearing Set' AND ((a.resch_appeal_hearing_date IS NULL) OR (d.max_appeal_hearing_date IS NULL)) AND c.hearing_id > c.min_hearing_id
          THEN 0 -- UPD4_060, UPD4_070
     WHEN b.incident_status NOT IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) 
          THEN bus_days_between(b.INCIDENT_STATUS_DT, nvl(b.end_date,SYSDATE))
     ELSE 0 end age_in_business_days_flow,
CASE WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) < nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1) 
          THEN 0 -- UPD1_450          
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE) 
          THEN 0 -- UPD1_410
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND c.dismissed_id > c.hearing_id AND c.hearing_id < c.max_hearing_id
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(a.resch_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND c.dismissed_id < c.hearing_id
          THEN trunc(nvl(trunc(b.end_date) - a.resch_appeal_hearing_date,SYSDATE))  -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) = nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,1) > nvl(c.lag_hearing_id,9999999999) AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1) AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE)          
          THEN 0 -- UPD1_430
     WHEN b.incident_status = 'Hearing Set' AND nvl(c.hearing_id,999999999) = nvl(c.max_hearing_id,1) AND nvl(c.dismissed_id,1) > nvl(c.lag_hearing_id,9999999999) AND nvl(c.dismissed_id,9999999999) < nvl(c.hearing_id,1) AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE)
          THEN trunc(nvl(trunc(b.end_date) - a.resch_appeal_hearing_date,SYSDATE)) -- UPD1_440
     WHEN b.incident_status = 'Hearing Set' AND ((a.resch_appeal_hearing_date IS NULL) OR (d.max_appeal_hearing_date IS NULL)) AND c.hearing_id > c.min_hearing_id
          THEN 0 -- UPD4_060, UPD4_070
     WHEN b.incident_status NOT IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) 
          THEN trunc(nvl(b.end_date,SYSDATE)) - trunc(b.INCIDENT_STATUS_DT) 
     ELSE 0 END age_in_calendar_days_flow
FROM get_basic b
left JOIN get_status a
ON a.INCIDENT_HEADER_STAT_HIST_ID = b.INCIDENT_HEADER_STAT_HIST_ID 
LEFT JOIN get_vacated c
ON a.INCIDENT_HEADER_STAT_HIST_ID = c.hearing_id
LEFT JOIN get_hearing d
ON a.a.INCIDENT_HEADER_STAT_HIST_ID = d.INCIDENT_HEADER_STAT_HIST_ID
with read only;

GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO DP_SCORECARD;

CREATE OR REPLACE VIEW D_IDR_CURRENT_SV
AS select IDR_BI_ID,
INCIDENT_ID,
CREATED_BY_GROUP,
CREATED_BY_NAME,
TRACKING_NUMBER,
CREATE_DT,
INCIDENT_TYPE,
CUR_CLIENT_ID,
ASSD_IDR_REVIEW_DOCS,
ASED_IDR_REVIEW_DOCS,
ASPB_IDR_REVIEW_DOCS,
ASSD_GATHER_MISS_INFO,
ASED_GATHER_MISS_INFO,
ASPB_GATHER_MISS_INFO,
ABOUT_PLAN_CODE,
ABOUT_PROVIDER_ID,
CUR_ACTION_COMMENTS,
ACTION_TYPE,
CANCEL_BY,
CANCEL_DT,
CANCEL_METHOD,
CANCEL_REASON,
CUR_CURRENT_TASK_ID,
CUR_ENROLLMENT_STATUS,
CUR_INCIDENT_ABOUT,
CUR_INCIDENT_DESCRIPTION,
CUR_INCIDENT_STATUS,
CUR_INCIDENT_STATUS_DT,
INSTANCE_COMPLETE_DT,
CUR_COMPLETE_DT,
CUR_INSTANCE_STATUS,
CUR_LAST_UPDATE_BY_NAME,
CUR_LAST_UPDATE_BY_DT,
CUR_LAST_UPDATED_BY,
OTHER_PARTY_NAME,
PRIORITY,
REPORTED_BY,
REPORTER_RELATIONSHIP,
CUR_RESOLUTION_DESCRIPTION,
CUR_RESOLUTION_TYPE,
CASE_ID,
FORWARDED,
FORWARDED_TO,
ASF_IDR_REVIEW_DOCS,
ASF_GATHER_MISS_INFO,
GWF_CONTINUE_APPEAL,
JEOPARDY_DATE,
JEOPARDY_DAYS,
JEOPARDY_DAYS_TYPE,
TARGET_DAYS,
AGE_IN_CALENDAR_DAYS,
AGE_IN_BUSINESS_DAYS,
JEOPARDY_FLAG,
IDR_TIMELINESS_STATUS,
CURRENT_STEP,
APPELLANT_TYPE,
APPELLANT_TYPE_DESCRIPTION,
REPORTER_NAME,
REPORTER_PHONE,
CHANNEL,
ACCOUNT_ID,
PREF_LANGUAGE
from D_IDR_CURRENT WITH READ ONLY;

grant select on D_IDR_CURRENT_SV to MAXDAT_READ_ONLY;
