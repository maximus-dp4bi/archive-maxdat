CREATE TABLE D_COMPLAINT_CURRENT
(	CMPL_BI_ID                          NUMBER,
  CHANNEL                             VARCHAR2(80),
  CREATED_BY_GROUP                    VARCHAR2(80),
  CREATED_BY_NAME                     VARCHAR2(100),
  INCIDENT_ID                         NUMBER(18,0),
  INCIDENT_TRACKING_NUMBER            VARCHAR2(32),
  CREATE_DATE                         DATE  ,                 
  ATMPT_TO_RES_INCIDENT_END           DATE ,            
  ATMPT_TO_RES_INCIDENT_START         DATE ,
  ATMPT_TO_RES_INCIDENT_SUPV_END      DATE ,
  ATMPT_TO_RES_INCIDENT_SUPV_ST       DATE ,
  RESOLVE_INCIDENT_END                DATE ,
  RESOLVE_INCIDENT_START              DATE ,
  WITHDRAW_INCIDENT_END               DATE ,
  WITHDRAW_INCIDENT_START             DATE ,
  PERFORM_FOLLOWUP_ACTIONS_END        DATE ,
  PERFORM_FOLLOWUP_ACTIONS_START      DATE ,
  ABOUT_PLAN_CODE                     VARCHAR2(32),
  ABOUT_PROVIDER_ID                   NUMBER(18,0),
  CUR_ACTION_Comments                 VARCHAR2(4000),
  ACTION_TYPE                         VARCHAR2(64), 
  CANCEL_BY                           VARCHAR2(80),
  CANCEL_DATE                         DATE,
  CANCEL_METHOD                       VARCHAR2(40),
  CANCEL_REASON                       VARCHAR2(40),
  CUR_CURRENT_TASK_ID                 NUMBER(18,0),
  DATA_ENTRY_TASK_ID                  NUMBER(18,0),
  CUR_ENROLLMENT_STATUS               VARCHAR2(32),
  CUR_INCIDENT_ABOUT                  VARCHAR2(80),
  CUR_INCIDENT_DESCRIPTION            VARCHAR2(4000),
  CUR_INCIDENT_REASON                 VARCHAR2(80),
  CUR_INCIDENT_STATUS                 VARCHAR2(80),
  CUR_INCIDENT_STATUS_DATE            DATE,
  INSTANCE_COMPLETE_DATE              DATE,
  CUR_INSTANCE_STATUS                 VARCHAR2(10),
  CUR_LAST_UPDATE_BY_NAME             VARCHAR2(100),
  CUR_LAST_UPDATE_DATE                DATE ,
  LAST_UPDATED_BY                     VARCHAR2(80),
  CLIENT_ID                           NUMBER(18,0),
  OTHER_PARTY_NAME                    VARCHAR2(64),
  PRIORITY                            VARCHAR2(256),
  REPORTED_BY                         VARCHAR2(80),
  REPORTER_RELATIONSHIP               VARCHAR2(64),
  CUR_RESOLUTION_DESCRIPTION          VARCHAR2(4000),
  RESOLUTION_TYPE                     VARCHAR2(64),
  CASE_ID                             NUMBER(18,0),
  FORWARDED_FLAG                      VARCHAR2(1),
  INCIDENT_TYPE                       VARCHAR2(80),
  FORWARDED_To                        VARCHAR2(50),
  SLA_DAYS_TYPE                       VARCHAR2(50),
  SLA_JEOPARDY_DATE                   DATE,       
  SLA_JEOPARDY_DAYS                   NUMBER,
  SLA_Target_DAYS                     NUMBER,
  Age_IN_BUSINESS_DAYS                NUMBER,            
  Age_IN_CALENDAR_DAYS                NUMBER,
  JEOPARDY_DAYS_TYPE                  VARCHAR2(50),
  JEOPARDY_FLAG                       VARCHAR2(30),
  TIMELINESS_STATUS                   VARCHAR2(30),
  INCIDENT_FWD_TIMELINESS_STATUS      VARCHAR2(30),
  INCIDENT_FORWARDING_TARGET          VARCHAR2(30)
) 
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_CURRENT add constraint DCMPLCUR_PK primary key (CMPL_BI_ID);
alter index DCMPLCUR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLISD_UIX1 on  D_COMPLAINT_CURRENT (INSTANCE_COMPLETE_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index DCMPLII_UIX1 on D_COMPLAINT_CURRENT (INCIDENT_ID) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_COMPLAINT_CURRENT_SV as
select * from D_COMPLAINT_CURRENT
with read only;


--Action_Comments  DCMPLAC_ID
create sequence SEQ_DCMPLAC_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_ACTION_COMMENTS 
            (DCMPLAC_ID number not null, 
            ACTION_COMMENTS varchar2(4000) )
tablespace   MAXDAT_DATA parallel;

alter table D_COMPLAINT_ACTION_COMMENTS add constraint DCMPLAC_PK primary key (DCMPLAC_ID);
alter index DCMPLAC_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLAC_UIX1 on D_COMPLAINT_ACTION_COMMENTS (ACTION_COMMENTS) online tablespace MAXDAT_INDX parallel compute statistics; 
insert into D_COMPLAINT_ACTION_COMMENTS (DCMPLAC_ID ,ACTION_COMMENTS) values (SEQ_DCMPLAC_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_ACTION_COMMENTS_SV as
select * from D_COMPLAINT_ACTION_COMMENTS
with read only;



--Enrollment_Status  DCMPLES_ID
create sequence SEQ_DCMPLES_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_ENROLLMENT_STATUS
            (DCMPLES_ID number not null, 
           ENROLLMENT_STATUS varchar2(32) )
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_ENROLLMENT_STATUS add constraint DCMPLES_PK primary key (DCMPLES_ID);
alter index DCMPLES_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLES_UIX1 on D_COMPLAINT_ENROLLMENT_STATUS (ENROLLMENT_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into D_COMPLAINT_ENROLLMENT_STATUS (DCMPLES_ID ,ENROLLMENT_STATUS ) values (SEQ_DCMPLES_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_ENROLL_STATUS_SV as
select * from D_COMPLAINT_ENROLLMENT_STATUS
with read only;


--D_COMPLAINT_INCIDENT_ABOUT  DMFDOCTS_ID
create sequence SEQ_DCMPLIA_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_INCIDENT_ABOUT 
            (DCMPLIA_ID number not null, 
            INCIDENT_ABOUT varchar2(80) )
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_INCIDENT_ABOUT add constraint DCMPLIA_PK primary key (DCMPLIA_ID);
alter index DCMPLIA_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLIA_UIX1 on D_COMPLAINT_INCIDENT_ABOUT (INCIDENT_ABOUT) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into  D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID ,INCIDENT_ABOUT ) values (SEQ_DCMPLIA_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_INCIDENT_ABOUT_SV as
select * from D_COMPLAINT_INCIDENT_ABOUT
with read only;

commit;


--Incident_Description  DCMPLID_ID
create sequence SEQ_DCMPLID_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_INCIDENT_DESC
            (DCMPLID_ID number not null, 
            INCIDENT_DESCRIPTION varchar2(4000) )
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_INCIDENT_DESC add constraint DCMPLID_PK primary key (DCMPLID_ID);
alter index DCMPLID_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLID_UIX1 on D_COMPLAINT_INCIDENT_DESC (INCIDENT_DESCRIPTION) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into  D_COMPLAINT_INCIDENT_DESC (DCMPLID_ID , INCIDENT_DESCRIPTION  ) values (SEQ_DCMPLID_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_INCIDENT_DESC_SV as
select * from D_COMPLAINT_INCIDENT_DESC
with read only;



--INCIDENT_REASON  DCMPLIR_ID
create sequence SEQ_DCMPLIR_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_INCIDENT_REASON 
            (DCMPLIR_ID number not null, 
            INCIDENT_REASON VARCHAR2(80))
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_INCIDENT_REASON add constraint DCMPLIR_PK primary key (DCMPLIR_ID);
alter index DCMPLIR_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLIR_UIX1 on D_COMPLAINT_INCIDENT_REASON  (INCIDENT_REASON ) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into  D_COMPLAINT_INCIDENT_REASON (DCMPLIR_ID , INCIDENT_REASON  ) values (SEQ_DCMPLIR_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_INCIDENT_REASON_SV as
select * from D_COMPLAINT_INCIDENT_REASON
with read only;


--D_CMPL_INCIDENT_STATUS  DCMPLIS_ID
create sequence SEQ_DCMPLIS_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_INCIDENT_STATUS 
            (DCMPLIS_ID number not null, 
            INCIDENT_STATUS VARCHAR2(80) not null)
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_INCIDENT_STATUS add constraint DCMPLIS_PK primary key (DCMPLIS_ID);
alter index DCMPLIS_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLIS_UIX1 on D_COMPLAINT_INCIDENT_STATUS (INCIDENT_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace view D_COMPLAINT_INCIDENT_STATUS_SV as
select * from D_COMPLAINT_INCIDENT_STATUS
with read only;

--D_CMPL_INSTANCE_STATUS  DCMPLIS_ID
create sequence SEQ_DCMPLIN_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_INSTANCE_STATUS 
            (DCMPLIN_ID number not null, 
            INSTANCE_STATUS VARCHAR2(10) not null)
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_INSTANCE_STATUS add constraint DCMPLIN_PK primary key (DCMPLIN_ID);
alter index DCMPLIN_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLIN_UIX1 on D_COMPLAINT_INSTANCE_STATUS (INSTANCE_STATUS) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into D_COMPLAINT_INSTANCE_STATUS  (DCMPLIN_ID , INSTANCE_STATUS) values (SEQ_DCMPLIN_ID.nextval,'Active');
insert into D_COMPLAINT_INSTANCE_STATUS  (DCMPLIN_ID , INSTANCE_STATUS) values (SEQ_DCMPLIN_ID.nextval,'Complete');
commit;

create or replace view D_COMPLAINT_INSTANCE_STATUS_SV as
select * from D_COMPLAINT_INSTANCE_STATUS
with read only;

--D_CMPL_RESOLUTION_DESCRIPTION  DCMPLRD_ID
create sequence SEQ_DCMPLRD_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_COMPLAINT_RESOLUTION_DESC 
            (DCMPLRD_ID number not null, 
            RESOLUTION_DESCRIPTION VARCHAR2(4000) )
tablespace MAXDAT_DATA parallel;

alter table D_COMPLAINT_RESOLUTION_DESC add constraint DCMPLRD_PK primary key (DCMPLRD_ID);
alter index DCMPLRD_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DCMPLRD_UIX1 on D_COMPLAINT_RESOLUTION_DESC (RESOLUTION_DESCRIPTION) online tablespace MAXDAT_INDX parallel compute statistics; 

insert into  D_COMPLAINT_RESOLUTION_DESC (DCMPLRD_ID , RESOLUTION_DESCRIPTION  ) values (SEQ_DCMPLRD_ID.nextval,null);
commit;

create or replace view D_COMPLAINT_RESOLUTION_DESC_SV as
select * from D_COMPLAINT_RESOLUTION_DESC
with read only;


create sequence SEQ_FCMPLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table F_COMPLAINT_BY_DATE 
  (FCMPLBD_ID number not null,
   D_DATE DATE not null, 
   BUCKET_START_DATE DATE not null, 
   BUCKET_END_DATE DATE not null,
   CMPL_BI_ID number not null,
   DCMPLAC_ID number,
   CURRENT_TASK_ID number,
   DCMPLES_ID number,
   DCMPLIA_ID number,
   DCMPLID_ID number,
   DCMPLIR_ID number,
   DCMPLIS_ID number,
   DCMPLIN_ID number,
   DCMPLRD_ID number,
   INCIDENT_STATUS_DATE date,
   LAST_UPDATE_DATE DATE,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number
)
partition BY range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_PK primary key (FCMPLBD_ID);
alter index FCMPLBD_PK rebuild  online tablespace MAXDAT_INDX parallel;

create unique index FCMPLBD_UIX1 on F_COMPLAINT_BY_DATE (CMPL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FCMPLBD_UIX2 on F_COMPLAINT_BY_DATE (CMPL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FCMPLCBD_IXL1 on F_COMPLAINT_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLCUR_FK
foreign key (CMPL_BI_ID)references D_COMPLAINT_CURRENT (CMPL_BI_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLAC_FK
foreign key (DCMPLAC_ID) references D_COMPLAINT_ACTION_COMMENTS (DCMPLAC_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLB_FK
foreign key (DCMPLES_ID) references D_COMPLAINT_ENROLLMENT_STATUS (DCMPLES_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLTS_FK
foreign key (DCMPLIA_ID) references D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLDS_FK
foreign key (DCMPLID_ID) references D_COMPLAINT_INCIDENT_DESC (DCMPLID_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLIS_FK
foreign key (DCMPLIR_ID) references D_COMPLAINT_INCIDENT_REASON (DCMPLIR_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLJS_FK
foreign key (DCMPLIS_ID) references D_COMPLAINT_INCIDENT_STATUS (DCMPLIS_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLIN_FK
foreign key (DCMPLIN_ID) references D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID);

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLRD_FK
foreign key (DCMPLRD_ID) references D_COMPLAINT_RESOLUTION_DESC (DCMPLRD_ID);


create or replace view F_COMPLAINT_BY_DATE_SV as
select
  FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLES_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  case 
    when dense_rank() over (partition BY CMPL_BI_ID order BY CMPL_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    END CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE fcmplbd
where
  bdd.D_DATE >= fcmplbd.BUCKET_START_DATE 
  and bdd.D_DATE < fcmplbd.BUCKET_END_DATE
union all
select
 FCMPLBD_ID,
  bdd.D_DATE,
  CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLES_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  INCIDENT_STATUS_DATE,
  LAST_UPDATE_DATE,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_COMPLAINT_BY_DATE fcmplbd
where
  bdd.D_DATE = fcmplbd.BUCKET_START_DATE 
  and bdd.D_DATE = fcmplbd.BUCKET_END_DATE
with read only;




