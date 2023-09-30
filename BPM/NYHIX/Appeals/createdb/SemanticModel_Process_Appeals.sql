create table D_APPEALS_CURRENT
  (APL_BI_ID number,
   ABOUT_PLAN_CODE varchar2(32),
   ABOUT_PLAN_NAME varchar2(64),
   ABOUT_PROVIDER_ID number,
   ABOUT_PROVIDER_NAME varchar2(100),
   ACTION_TYPE varchar2(64),
   ADVISE_TO_WTHD_IN_WRITING_END date,
   ADVISE_TO_WTHD_IN_WRITING_ST date,
   ADVISE_TO_WTHD_IN_WRT_PERF_BY varchar2(100),
   AGE_IN_BUSINESS_DAYS	number,
   AGE_IN_CALENDAR_DAYS number,
   APPEAL_HEARING_DATE date,
   APPEAL_TIMELINESS_STATUS varchar2(100),
   ASF_ADVISE_WITHDRAW varchar2(1),
   ASF_CANCEL_HEARING varchar2(1),
   ASF_CON_HEARING_PROC varchar2(1),
   ASF_CONDUCT_ST_REV varchar2(1),
   ASF_DETERMINE_VALID varchar2(1),
   ASF_GATHER_MISS_INFO varchar2(1),
   ASF_PROC_VALID_AMEND varchar2(1),
   ASF_REVIEW_APPEAL varchar2(1),
   ASF_SCHEDULE_HEARING varchar2(1),
   ASF_SHOP_REVIEW varchar2(1),
   CANCEL_BY varchar2(80),
   CANCEL_DATE date,
   CANCEL_HEARING_END date,
   CANCEL_HEARING_PERFORMED_BY varchar2(100),
   CANCEL_HEARING_START date,
   CANCEL_METHOD varchar2(40),
   CANCEL_REASON varchar2(100),
   CASE_ID number,
   CHANNEL varchar2(80),
   CONDUCT_HEARING_PROCESS_END date,
   CONDUCT_HEARING_PROCESS_START date,
   CONDUCT_STATE_REVIEW_END date,
   CONDUCT_STATE_REVIEW_START date,
   CREATE_DATE date,
   CREATED_BY_GROUP varchar2(80),
   CREATED_BY_NAME varchar2(100),
   CUR_ACTION_COMMENTS varchar2(4000),
   CUR_CONDUCT_VALIDITY_END date,
   CUR_CONDUCT_VALIDITY_START date,
   CUR_CURRENT_TASK_ID number,
   CUR_INCIDENT_ABOUT varchar2(80),
   CUR_INCIDENT_DESCRIPTION varchar2(4000),
--   CUR_INCIDENT_REASON varchar2(80),
   CUR_INCIDENT_STATUS varchar2(80),
   CUR_INCIDENT_STATUS_DATE date,
   CUR_INSTANCE_STATUS varchar2(10),
   CUR_VALIDITY_PERFORMED_BY varchar2(100),
   GATHER_MISSING_INFO_PERFORM_BY varchar2(100),
   GATHER_MISSING_INFO_START date,
   GATHER_MISSING_INFORMATION_END date,
   GWF_APPEAL_INVALID varchar2(1),
   GWF_CHANGE_ELIGIBILITY varchar2(1),
   GWF_CHANNEL varchar2(1),
   GWF_RESOLVED varchar2(1),
   GWF_SHOP_REVIEW varchar2(1),
   GWF_VALID varchar2(1),
   GWF_WITHDRAWN_IN_WRITING varchar2(1),
   HEARING_PROCESS_PERFORMED_BY varchar2(100),
   INCIDENT_ID number,
   INCIDENT_TRACKING_NUMBER varchar2(32),
   INCIDENT_TYPE varchar2(80),
   JEOPARDY_DAYS_TYPE varchar2(50),
   JEOPARDY_FLAG varchar2(30),
   LAST_UPDATE_BY_NAME varchar2(100),
   LAST_UPDATE_DATE date,
   LINKED_CLIENT number,
   OTHER_PARTY_NAME varchar2(64),
   PRIORITY varchar2(256),
   RECEIPT_DATE date,
   REPORTED_BY varchar2(80),
   REPORTER_RELATIONSHIP varchar2(64),
   RESOLUTION_DESCRIPTION varchar2(4000),
   RESOLUTION_TYPE varchar2(64),
   REVIEW_APPEAL_END date,
   REVIEW_APPEAL_START date,
   REVIEW_APPEALPERFORMED_BY varchar2(100),
   SCHEDULE_HEARING_END date,
   SCHEDULE_HEARING_PERFORMED_BY varchar2(100),
   SCHEDULE_HEARING_START date,
   SHOP_DESK_REVIEW_INFO_END date,
   SHOP_DESK_REVIEW_INFO_PRFRM_BY varchar2(100),
   SHOP_DESK_REVIEW_INFO_START date,
   SLA_JEOPARDY_DATE date,
   SLA_JEOPARDY_DAYS number,
   SLA_TARGET_DAYS number,
   STATE_REVIEW_PERFORMED_BY varchar2(100),
   VALIDITY_AMENDMENT_END	date,
   VALIDITY_AMENDMENT_PERFORM_BY varchar2(100),
   VALIDITY_AMENDMENT_START	date,
   APPEAL_DATE varchar2(64),
   APPELLANT_TYPE varchar2(32),
   APPELLANT_TYPE_DESCRIPTION varchar2(64),
   REQUESTED_HEARING_DAY varchar2(32), 
   REQUESTED_HEARING_TIME varchar2(32),
   APPEAL_HEARING_TIME varchar2(64),
   APPEAL_HEARING_LOCATION varchar2(64),
   AID_TO_CONTINUE varchar2(1),
   EXPECTED_APPEAL_REQUEST number,
   CUR_COMPLETE_DATE date,
   INSTANCE_COMPLETE_DATE date,
   CURRENT_STEP VARCHAR2(256),
   RECEIVED_DATE DATE,
   FAIR_HEARING_TRACKING_NBR VARCHAR2(100),
   APL_PRIMARY_MEMBER_ID NUMBER(18,0),
   ACCOUNT_ID VARCHAR2(30),
   NYHIX_ID VARCHAR2(30),
   PREF_LANGUAGE  varchar2(256),
   DECISION_DETAILS varchar2(30)
  )   
tablespace MAXDAT_DATA;

alter table D_APPEALS_CURRENT add constraint DAPPEALSCUR_PK primary key (APL_BI_ID) using index tablespace MAXDAT_INDX;

--create unique index DAPPEALSICD_UIX1 on  D_APPEALS_CURRENT (INSTANCE_COMPLETE_DATE) online tablespace MAXDAT_INDX compute statistics; 
create unique index DAPPEALSII_UIX1 on D_APPEALS_CURRENT (INCIDENT_ID) online tablespace MAXDAT_INDX compute statistics;
create index DAPPEALSCUR_IDX1 on D_APPEALS_CURRENT (INCIDENT_TRACKING_NUMBER) tablespace MAXDAT_INDX;

grant select on D_APPEALS_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_CURRENT_SV as
select * from D_APPEALS_CURRENT
with read only;

grant select on D_APPEALS_CURRENT_SV to MAXDAT_READ_ONLY;


--D_APPEALS_ACTION_COMMENTS  DAPLAC_ID
create sequence SEQ_DAPLAC_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_ACTION_COMMENTS 
  (DAPLAC_ID NUMBER NOT NULL, 
   ACTION_COMMENTS VARCHAR2(4000))
tablespace MAXDAT_DATA;

alter table D_APPEALS_ACTION_COMMENTS add constraint DAPLAC_PK primary key (DAPLAC_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLAC_UIX1 on D_APPEALS_ACTION_COMMENTS (ACTION_COMMENTS) online tablespace MAXDAT_INDX compute statistics;

grant select on D_APPEALS_ACTION_COMMENTS to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_ACTION_COMMENTS_SV as
select * from D_APPEALS_ACTION_COMMENTS
with read only;

grant select on D_APPEALS_ACTION_COMMENTS_SV to MAXDAT_READ_ONLY;

insert into D_APPEALS_ACTION_COMMENTS (DAPLAC_ID,ACTION_COMMENTS) values (SEQ_DAPLAC_ID.nextval,null);
commit;


--D_APPEALS_INCIDENT_ABOUT  DAPLIA_ID
create sequence SEQ_DAPLIA_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_INCIDENT_ABOUT 
  (DAPLIA_ID number not null, 
   INCIDENT_ABOUT varchar2(80))
tablespace MAXDAT_DATA;

alter table D_APPEALS_INCIDENT_ABOUT add constraint DAPLIA_PK primary key (DAPLIA_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLIA_UIX1 on D_APPEALS_INCIDENT_ABOUT(INCIDENT_ABOUT) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_APPEALS_ACTION_COMMENTS to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_INCIDENT_ABOUT_SV as
select * from D_APPEALS_INCIDENT_ABOUT
with read only;

grant select on D_APPEALS_ACTION_COMMENTS_SV to MAXDAT_READ_ONLY;

insert into D_APPEALS_INCIDENT_ABOUT (DAPLIA_ID,INCIDENT_ABOUT ) values (SEQ_DAPLIA_ID.nextval,null);
commit;


--D_APPEALS_INCIDENT_DESC  DAPLID_ID
create sequence SEQ_DAPLID_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_INCIDENT_DESC
  (DAPLID_ID number not null, 
   INCIDENT_DESCRIPTION varchar2(4000))
tablespace MAXDAT_DATA;

alter table D_APPEALS_INCIDENT_DESC add constraint DAPLID_PK primary key (DAPLID_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLID_UIX1 on D_APPEALS_INCIDENT_DESC (INCIDENT_DESCRIPTION) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_APPEALS_INCIDENT_DESC to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_INCIDENT_DESC_SV as
select * from D_APPEALS_INCIDENT_DESC
with read only;

grant select on D_APPEALS_INCIDENT_DESC_SV to MAXDAT_READ_ONLY;

insert into D_APPEALS_INCIDENT_DESC (DAPLID_ID,INCIDENT_DESCRIPTION) values (SEQ_DAPLID_ID.nextval,null);
commit;


--D_APPEALS_INCIDENT_STATUS  DAPLIS_ID
create sequence SEQ_DAPLIS_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_INCIDENT_STATUS 
  (DAPLIS_ID number not null, 
   INCIDENT_STATUS VARCHAR2(80) not null)
tablespace MAXDAT_DATA;

alter table D_APPEALS_INCIDENT_STATUS add constraint DAPLIS_PK primary key (DAPLIS_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLIS_UIX1 on D_APPEALS_INCIDENT_STATUS (INCIDENT_STATUS) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_APPEALS_INCIDENT_STATUS to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_INCIDENT_STATUS_SV as
select * from D_APPEALS_INCIDENT_STATUS
with read only;

grant select on D_APPEALS_INCIDENT_STATUS_SV to MAXDAT_READ_ONLY;


--D_APPEALS_INSTANCE_STATUS  DAPLIN_ID
create sequence SEQ_DAPLIN_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_INSTANCE_STATUS 
  (DAPLIN_ID number not null, 
   INSTANCE_STATUS VARCHAR2(10) not null)
tablespace MAXDAT_DATA;

alter table D_APPEALS_INSTANCE_STATUS add constraint DAPLIN_PK primary key (DAPLIN_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLIN_UIX1 on D_APPEALS_INSTANCE_STATUS (INSTANCE_STATUS) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_APPEALS_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_INSTANCE_STATUS_SV as
select * from D_APPEALS_INSTANCE_STATUS
with read only;

grant select on D_APPEALS_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_APPEALS_INSTANCE_STATUS (DAPLIN_ID,INSTANCE_STATUS) values (SEQ_DAPLIN_ID.nextval,'Active');
insert into D_APPEALS_INSTANCE_STATUS (DAPLIN_ID,INSTANCE_STATUS) values (SEQ_DAPLIN_ID.nextval,'Complete');
commit;


--D_APPEALS_CVPB  DAPLCVPB_ID
create sequence SEQ_DAPLCVPB_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table D_APPEALS_CVPB 
  (DAPLCVPB_ID number not null, 
   CONDUCT_VALIDITY_PERFORMED_BY VARCHAR2(100))
tablespace MAXDAT_DATA;

alter table D_APPEALS_CVPB add constraint DAPLCVPB_PK primary key (DAPLCVPB_ID) using index tablespace MAXDAT_INDX;

create unique index DAPLCVPB_UIX1 on D_APPEALS_CVPB (CONDUCT_VALIDITY_PERFORMED_BY) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_APPEALS_CVPB to MAXDAT_READ_ONLY;

create or replace view D_APPEALS_CVPB_SV as
select * from D_APPEALS_CVPB
with read only;

grant select on D_APPEALS_CVPB_SV to MAXDAT_READ_ONLY;

insert into D_APPEALS_CVPB (DAPLCVPB_ID,CONDUCT_VALIDITY_PERFORMED_BY) values (SEQ_DAPLCVPB_ID.nextval,null);
commit;


--F_APPEALS_BY_DATE FAPLBD_ID
create sequence SEQ_FAPLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
START with 265
increment BY 1
cache 20;

create table F_APPEALS_BY_DATE 
  (FAPLBD_ID number not null,
   D_DATE DATE not null, 
   BUCKET_START_DATE DATE not null, 
   BUCKET_END_DATE DATE not null,
   APL_BI_ID number not null,
   DAPLAC_ID number,
   CURRENT_TASK_ID number,
 --  DAPLES_ID number,
   DAPLIA_ID number,
   DAPLID_ID number,
   --DAPLIR_ID number,
   DAPLIS_ID number,
   DAPLIN_ID number,
   DAPLCVPB_ID number,
   INCIDENT_STATUS_DATE date,
   CONDUCT_VALIDITY_START date,
   CONDUCT_VALIDITY_END date,  
   COMPLETE_DATE date,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number)
partition BY range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA;

alter table F_APPEALS_BY_DATE add constraint FAPLBD_PK primary key (FAPLBD_ID) using index tablespace MAXDAT_INDX;

alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPPEALSCUR_FK foreign key (APL_BI_ID)references D_APPEALS_CURRENT (APL_BI_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLAC_FK foreign key (DAPLAC_ID) references D_APPEALS_ACTION_COMMENTS (DAPLAC_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLIA_FK foreign key (DAPLIA_ID) references D_APPEALS_INCIDENT_ABOUT (DAPLIA_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLID_FK foreign key (DAPLID_ID) references D_APPEALS_INCIDENT_DESC (DAPLID_ID);
--alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLIR_FK foreign key (DAPLIR_ID) references D_APPEALS_INCIDENT_REASON (DAPLIR_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLIS_FK foreign key (DAPLIS_ID) references D_APPEALS_INCIDENT_STATUS (DAPLIS_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLIN_FK foreign key (DAPLIN_ID) references D_APPEALS_INSTANCE_STATUS (DAPLIN_ID);
alter table F_APPEALS_BY_DATE add constraint FAPLBD_DAPLCVPB_FK foreign key (DAPLCVPB_ID) references D_APPEALS_CVPB (DAPLCVPB_ID);

create unique index FAPLBD_UIX1 on F_APPEALS_BY_DATE (APL_BI_ID,D_DATE) online tablespace MAXDAT_INDX compute statistics; 
create unique index FAPLBD_UIX2 on F_APPEALS_BY_DATE (APL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX compute statistics; 

create index FAPLBD_IX1 on F_APPEALS_BY_DATE (INCIDENT_STATUS_DATE) online tablespace MAXDAT_INDX compute statistics;
create index FAPLBD_IX2 on F_APPEALS_BY_DATE (CONDUCT_VALIDITY_START) online tablespace MAXDAT_INDX compute statistics;
create index FAPLBD_IX3 on F_APPEALS_BY_DATE (CONDUCT_VALIDITY_END) online tablespace MAXDAT_INDX compute statistics;
create index FAPLBD_IX4 on F_APPEALS_BY_DATE (COMPLETE_DATE) online tablespace MAXDAT_INDX compute statistics;

create index FAPLBD_IXL1 on F_APPEALS_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX compute statistics;
create index FAPLBD_IXL2 on F_APPEALS_BY_DATE (APL_BI_ID) local online tablespace MAXDAT_INDX compute statistics;
create index FAPLBD_IXL3 on F_APPEALS_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX compute statistics;
create index FNPABD_IXL4 on F_APPEALS_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX compute statistics;

grant select on F_APPEALS_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_APPEALS_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FAPLBD_ID,
  BUCKET_START_DATE D_DATE,
  APL_BI_ID,
  DAPLAC_ID,  
  DAPLIA_ID,
  DAPLID_ID,
  --DAPLIR_ID,
  DAPLIS_ID,
  DAPLIN_ID,
  DAPLCVPB_ID,
  INCIDENT_STATUS_DATE,
  CONDUCT_VALIDITY_START,
  CONDUCT_VALIDITY_END,   
  COMPLETE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_APPEALS_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FAPLBD_ID,
  bdd.D_DATE,
  APL_BI_ID,
  DAPLAC_ID,  
  DAPLIA_ID,
  DAPLID_ID,
  --DAPLIR_ID,
  DAPLIS_ID,
  DAPLIN_ID,
  DAPLCVPB_ID,
  INCIDENT_STATUS_DATE,
  CONDUCT_VALIDITY_START,
  CONDUCT_VALIDITY_END,   
  COMPLETE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_APPEALS_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FAPLBD_ID,
  bdd.D_DATE,
  APL_BI_ID,
  DAPLAC_ID,  
  DAPLIA_ID,
  DAPLID_ID,
  --DAPLIR_ID,
  DAPLIS_ID,
  DAPLIN_ID,
  DAPLCVPB_ID,
  INCIDENT_STATUS_DATE,
  CONDUCT_VALIDITY_START,
  CONDUCT_VALIDITY_END,   
  COMPLETE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_APPEALS_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FAPLBD_ID,
  bdd.D_DATE,
  APL_BI_ID,
  DAPLAC_ID,  
  DAPLIA_ID,
  DAPLID_ID,
  --DAPLIR_ID,
  DAPLIS_ID,
  DAPLIN_ID,
  DAPLCVPB_ID,
  INCIDENT_STATUS_DATE,
  CONDUCT_VALIDITY_START,
  CONDUCT_VALIDITY_END,   
  COMPLETE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_APPEALS_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_APPEALS_BY_DATE_SV to MAXDAT_READ_ONLY;


--view for current incident reasons
create or replace view D_APPEALS_CURRENT_REASONS_SV as
select 
  INCIDENT_ID, 
  INCIDENT_REASON
from NYHBE_ETL_PROCESS_APPEALS_RSN
with read only;

grant select on D_APPEALS_CURRENT_REASONS_SV to MAXDAT_READ_ONLY;

create OR REPLACE VIEW D_APPEALS_SCHEDULER_SV    
(
NEPAS_ID                       
,INCIDENT_APPOINTMENT_LINK_ID   
,INCIDENT_HEADER_ID             
,CREATED_BY                     
,CREATE_DT                      
,ITEM_STATUS_CD                 
,CATEGORY_CD                    
,PRIORITY_CD                    
,START_DT                       
,END_DT                         
,UPDATE_DT                      
)  AS
SELECT 
NEPAS_ID                       
,INCIDENT_APPOINTMENT_LINK_ID   
,INCIDENT_HEADER_ID             
,CREATED_BY                     
,CREATE_DT                      
,ITEM_STATUS_CD                 
,CATEGORY_CD                    
,PRIORITY_CD                    
,START_DT                       
,END_DT                         
,UPDATE_DT  
FROM NYHBE_ETL_APPEALS_SCHEDULER
WITH READ ONLY;

GRANT SELECT ON D_APPEALS_SCHEDULER_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON D_APPEALS_SCHEDULER_SV TO DP_SCORECARD;  

declare  c int;
begin
   select count(*) into c from user_objects where object_type = 'SEQUENCE' and object_name ='SEQ_NEPAS_ID';
   if c = 1 then
      execute immediate 'DROP SEQUENCE SEQ_NEPAS_ID';
   end if;
end;
/

CREATE SEQUENCE SEQ_NEPAS_ID -- FOR NYHBE_ETL_APPEALS_SCHEDULER
    START WITH 10
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCYCLE
    NOORDER
    CACHE 20;
