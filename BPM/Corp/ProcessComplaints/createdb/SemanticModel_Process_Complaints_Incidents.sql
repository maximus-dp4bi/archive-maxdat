create table D_COMPLAINT_CURRENT
  (CMPL_BI_ID                          number,
   CHANNEL                             varchar2(80),
   CREATED_BY_GROUP                    varchar2(80),
   CREATED_BY_NAME                     varchar2(100),
   INCIDENT_ID                         number(18,0),
   INCIDENT_TRACKING_NUMBER            varchar2(32),
   CREATE_DATE                         date,                 
   ATMPT_TO_RES_INCIDENT_END           date,            
   ATMPT_TO_RES_INCIDENT_START         date,
   ATMPT_TO_RES_INCIDENT_SUPV_END      date,
   ATMPT_TO_RES_INCIDENT_SUPV_ST       date,
   RESOLVE_INCIDENT_END                date,
   RESOLVE_INCIDENT_START              date,
   WITHDRAW_INCIDENT_END               date,
   WITHDRAW_INCIDENT_START             date,
   PERFORM_FOLLOWUP_ACTIONS_END        date,
   PERFORM_FOLLOWUP_ACTIONS_START      date,
   ABOUT_PLAN_CODE                     varchar2(32),
   ABOUT_PROVIDER_ID                   number(18,0),
   CUR_ACTION_COMMENTS                 varchar2(4000),
   ACTION_TYPE                         varchar2(64), 
   CANCEL_BY                           varchar2(80),
   CANCEL_DATE                         date,
   CANCEL_METHOD                       varchar2(40),
   CANCEL_REASON                       varchar2(40),
   CUR_CURRENT_TASK_ID                 number(18,0),
   DATA_ENTRY_TASK_ID                  number(18,0),   
   CUR_INCIDENT_ABOUT                  varchar2(80),
   CUR_INCIDENT_DESCRIPTION            varchar2(4000),
   CUR_INCIDENT_REASON                 varchar2(80),
   CUR_INCIDENT_STATUS                 varchar2(80),
   CUR_INCIDENT_STATUS_DATE            date,
   INSTANCE_COMPLETE_DATE              date,
   CUR_INSTANCE_STATUS                 varchar2(10),
   CUR_LAST_UPDATE_BY_NAME             varchar2(100),
   CUR_LAST_UPDATE_DATE                date,
   LAST_UPDATED_BY                     varchar2(80),
   CLIENT_ID                           number(18,0),
   OTHER_PARTY_NAME                    varchar2(64),
   PRIORITY                            varchar2(256),
   REPORTED_BY                         varchar2(80),
   REPORTER_RELATIONSHIP               varchar2(64),
   CUR_RESOLUTION_DESCRIPTION          varchar2(4000),
   RESOLUTION_TYPE                     varchar2(64),
   CASE_ID                             number(18,0),
   CASE_CIN 			       varchar2(30),
   FORWARDED_FLAG                      varchar2(1),
   INCIDENT_TYPE                       varchar2(80),
   FORWARDED_TO                        varchar2(50),
   SLA_DAYS_TYPE                       varchar2(50),
   SLA_JEOPARDY_DATE                   date,       
   SLA_JEOPARDY_DAYS                   number,
   SLA_TARGET_DAYS                     number,
   AGE_IN_BUSINESS_DAYS                number,            
   AGE_IN_CALENDAR_DAYS                number,
   JEOPARDY_DAYS_TYPE                  varchar2(50),
   JEOPARDY_FLAG                       varchar2(30),
   TIMELINESS_STATUS                   varchar2(30),
   INCIDENT_FWD_TIMELINESS_STATUS      varchar2(30),
   INCIDENT_FORWARDING_TARGET          varchar2(30),
   COMPLETE_DT                         date,
   FORWARD_DT                          date,
   RECEIVED_DT                         date,
   PLAN_NAME                           Varchar2(64),
   CURRENT_STEP                        varchar2(256),
   REPORTER_NAME                       varchar2(180),
   REPORTER_PHONE                      varchar2(32),
   SLA_SATISFIED                       varchar2(1),
   SLA_COMPLETE_DATE	   	       date,
   CREATED_BY_SUP                      varchar2(1),
   GWF_ESCALATE_TO_STATE               varchar2(1),
   CREATED_BY_EID                      varchar2(80),
   CREATED_BY_SUP_NAME                 varchar2(100),
   GWF_RESOLVED_EES_CSS                varchar2(30),
   GWF_RESOLVED_SUP                    varchar2(1),
   GWF_FOLLOWUP_REQ                    varchar2(1),
   GWF_RETURN_TO_STATE                 varchar2(1)) 
tablespace MAXDAT_DATA parallel 2;

alter table D_COMPLAINT_CURRENT add constraint DCMPLCUR_PK primary key (CMPL_BI_ID) using index tablespace MAXDAT_INDX;

create  index DCMPLISD_IX1 on  D_COMPLAINT_CURRENT (INSTANCE_COMPLETE_DATE) online tablespace MAXDAT_INDX parallel 2 compute statistics; 
create unique index DCMPLII_UIX1 on D_COMPLAINT_CURRENT (INCIDENT_ID) online tablespace MAXDAT_INDX parallel 2 compute statistics; 

create  index DCMPLIIA_IX1 on  D_COMPLAINT_CURRENT (CUR_INCIDENT_ABOUT) online tablespace MAXDAT_INDX parallel 2 compute statistics; 
create  index DCMPLIR_IX1 on D_COMPLAINT_CURRENT (CUR_INCIDENT_REASON) online tablespace MAXDAT_INDX parallel 2 compute statistics; 

grant select on D_COMPLAINT_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_CURRENT_SV as
select 
  CMPL_BI_ID,
  CHANNEL,
  CREATED_BY_GROUP,
  CREATED_BY_NAME,
  INCIDENT_ID,
  INCIDENT_TRACKING_NUMBER,
  CREATE_DATE,
  ATMPT_TO_RES_INCIDENT_END,
  ATMPT_TO_RES_INCIDENT_START,
  ATMPT_TO_RES_INCIDENT_SUPV_END,
  ATMPT_TO_RES_INCIDENT_SUPV_ST,
  RESOLVE_INCIDENT_END,
  RESOLVE_INCIDENT_START,
  WITHDRAW_INCIDENT_END,
  WITHDRAW_INCIDENT_START,
  PERFORM_FOLLOWUP_ACTIONS_END,
  PERFORM_FOLLOWUP_ACTIONS_START,
  ABOUT_PLAN_CODE,
  ABOUT_PROVIDER_ID,
  CUR_ACTION_COMMENTS,
  ACTION_TYPE,
  CANCEL_BY,
  CANCEL_DATE,
  CANCEL_METHOD,
  CANCEL_REASON,
  CUR_CURRENT_TASK_ID,
  DATA_ENTRY_TASK_ID,
  CUR_INCIDENT_ABOUT,
  CUR_INCIDENT_DESCRIPTION,
  CUR_INCIDENT_REASON,
  CUR_INCIDENT_STATUS,
  CUR_INCIDENT_STATUS_DATE,
  INSTANCE_COMPLETE_DATE,
  CUR_INSTANCE_STATUS,
  CUR_LAST_UPDATE_BY_NAME,
  CUR_LAST_UPDATE_DATE,
  LAST_UPDATED_BY,
  CLIENT_ID,
  OTHER_PARTY_NAME,
  PRIORITY,
  REPORTED_BY,
  REPORTER_RELATIONSHIP,
  CUR_RESOLUTION_DESCRIPTION,
  RESOLUTION_TYPE,
  CASE_ID,
  CASE_CIN,
  FORWARDED_FLAG,
  INCIDENT_TYPE,
  FORWARDED_TO,
  SLA_DAYS_TYPE,
  SLA_JEOPARDY_DATE,
  SLA_JEOPARDY_DAYS,
  SLA_TARGET_DAYS,
  AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_FLAG,
  TIMELINESS_STATUS,
  INCIDENT_FWD_TIMELINESS_STATUS,
  INCIDENT_FORWARDING_TARGET,
  COMPLETE_DT,
  FORWARD_DT,
  CURRENT_STEP,
  RECEIVED_DT,
  PLAN_NAME,
  REPORTER_NAME,
  REPORTER_PHONE,
  SLA_SATISFIED,
  CREATED_BY_SUP,
  CREATED_BY_EID,
  CREATED_BY_SUP_NAME, 
  cast('NYHBE' as varchar2(10)) project_name,
  GWF_ESCALATE_TO_STATE,
  GWF_RESOLVED_EES_CSS,
  GWF_RESOLVED_SUP,
  GWF_FOLLOWUP_REQ,
  GWF_RETURN_TO_STATE    
from D_COMPLAINT_CURRENT 
with read only;

grant select on D_COMPLAINT_CURRENT_SV to MAXDAT_READ_ONLY;


-- Action_Comments  DCMPLAC_ID
create sequence SEQ_DCMPLAC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_ACTION_COMMENTS 
  (DCMPLAC_ID number not null, 
   ACTION_COMMENTS varchar2(4000) )
tablespace MAXDAT_DATA parallel 2;

alter table D_COMPLAINT_ACTION_COMMENTS add constraint DCMPLAC_PK primary key (DCMPLAC_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLAC_UIX1 on D_COMPLAINT_ACTION_COMMENTS (ACTION_COMMENTS) online tablespace MAXDAT_INDX parallel 2 compute statistics; 

grant select on D_COMPLAINT_ACTION_COMMENTS to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_ACTION_COMMENTS_SV as
select * from D_COMPLAINT_ACTION_COMMENTS
with read only;

grant select on D_COMPLAINT_ACTION_COMMENTS_SV to MAXDAT_READ_ONLY;

insert into D_COMPLAINT_ACTION_COMMENTS (DCMPLAC_ID,ACTION_COMMENTS) values (SEQ_DCMPLAC_ID.nextval,null);
commit;


-- D_COMPLAINT_INCIDENT_ABOUT  DMFDOCTS_ID
create sequence SEQ_DCMPLIA_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_INCIDENT_ABOUT 
  (DCMPLIA_ID number not null, 
   INCIDENT_ABOUT varchar2(80))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_INCIDENT_ABOUT add constraint DCMPLIA_PK primary key (DCMPLIA_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLIA_UIX1 on D_COMPLAINT_INCIDENT_ABOUT (INCIDENT_ABOUT) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_INCIDENT_ABOUT to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_INCIDENT_ABOUT_SV as
select * from D_COMPLAINT_INCIDENT_ABOUT
with read only;

grant select on D_COMPLAINT_INCIDENT_ABOUT_SV to MAXDAT_READ_ONLY;

insert into  D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID,INCIDENT_ABOUT) values (SEQ_DCMPLIA_ID.nextval,null);
commit;


-- Incident_Description  DCMPLID_ID
create sequence SEQ_DCMPLID_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_INCIDENT_DESC
  (DCMPLID_ID number not null, 
   INCIDENT_DESCRIPTION varchar2(4000))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_INCIDENT_DESC add constraint DCMPLID_PK primary key (DCMPLID_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLID_UIX1 on D_COMPLAINT_INCIDENT_DESC (INCIDENT_DESCRIPTION) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_INCIDENT_DESC to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_INCIDENT_DESC_SV as
select * from D_COMPLAINT_INCIDENT_DESC
with read only;

grant select on D_COMPLAINT_INCIDENT_DESC_SV to MAXDAT_READ_ONLY;

insert into  D_COMPLAINT_INCIDENT_DESC (DCMPLID_ID,INCIDENT_DESCRIPTION ) values (SEQ_DCMPLID_ID.nextval,null);
commit;


-- INCIDENT_REASON  DCMPLIR_ID
create sequence SEQ_DCMPLIR_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_INCIDENT_REASON 
  (DCMPLIR_ID number not null, 
   INCIDENT_REASON varchar2(80))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_INCIDENT_REASON add constraint DCMPLIR_PK primary key (DCMPLIR_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLIR_UIX1 on D_COMPLAINT_INCIDENT_REASON  (INCIDENT_REASON ) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_INCIDENT_REASON to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_INCIDENT_REASON_SV as
select * from D_COMPLAINT_INCIDENT_REASON
with read only;

grant select on D_COMPLAINT_INCIDENT_REASON_SV to MAXDAT_READ_ONLY;

insert into  D_COMPLAINT_INCIDENT_REASON (DCMPLIR_ID,INCIDENT_REASON ) values (SEQ_DCMPLIR_ID.nextval,null);
commit;


-- D_CMPL_INCIDENT_STATUS  DCMPLIS_ID
create sequence SEQ_DCMPLIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_INCIDENT_STATUS 
  (DCMPLIS_ID number not null, 
   INCIDENT_STATUS varchar2(80) not null)
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_INCIDENT_STATUS add constraint DCMPLIS_PK primary key (DCMPLIS_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLIS_UIX1 on D_COMPLAINT_INCIDENT_STATUS (INCIDENT_STATUS) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_INCIDENT_STATUS to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_INCIDENT_STATUS_SV as
select * from D_COMPLAINT_INCIDENT_STATUS
with read only;

grant select on D_COMPLAINT_INCIDENT_STATUS to MAXDAT_READ_ONLY;


-- D_CMPL_INSTANCE_STATUS  DCMPLIS_ID
create sequence SEQ_DCMPLIN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_INSTANCE_STATUS 
  (DCMPLIN_ID number not null, 
   INSTANCE_STATUS varchar2(10) not null)
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_INSTANCE_STATUS add constraint DCMPLIN_PK primary key (DCMPLIN_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLIN_UIX1 on D_COMPLAINT_INSTANCE_STATUS (INSTANCE_STATUS) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_INSTANCE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_INSTANCE_STATUS_SV as
select * from D_COMPLAINT_INSTANCE_STATUS
with read only;

grant select on D_COMPLAINT_INSTANCE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID,INSTANCE_STATUS) values (SEQ_DCMPLIN_ID.nextval,'Active');
insert into D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID,INSTANCE_STATUS) values (SEQ_DCMPLIN_ID.nextval,'Complete');
commit;


-- D_CMPL_RESOLUTION_DESCRIPTION  DCMPLRD_ID
create sequence SEQ_DCMPLRD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_COMPLAINT_RESOLUTION_DESC 
  (DCMPLRD_ID number not null, 
   RESOLUTION_DESCRIPTION varchar2(4000))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_RESOLUTION_DESC add constraint DCMPLRD_PK primary key (DCMPLRD_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLRD_UIX1 on D_COMPLAINT_RESOLUTION_DESC (RESOLUTION_DESCRIPTION) online tablespace MAXDAT_INDX compute statistics; 

grant select on D_COMPLAINT_RESOLUTION_DESC to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_RESOLUTION_DESC_SV as
select * from D_COMPLAINT_RESOLUTION_DESC
with read only;

grant select on D_COMPLAINT_RESOLUTION_DESC_SV to MAXDAT_READ_ONLY;

insert into D_COMPLAINT_RESOLUTION_DESC (DCMPLRD_ID,RESOLUTION_DESCRIPTION) values (SEQ_DCMPLRD_ID.nextval,null);
commit;


create sequence SEQ_FCMPLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_COMPLAINT_BY_DATE 
  (FCMPLBD_ID number not null,
   D_DATE date not null, 
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   CMPL_BI_ID number not null,
   DCMPLAC_ID number,
   CURRENT_TASK_ID number,
   DCMPLIA_ID number,
   DCMPLID_ID number,
   DCMPLIR_ID number,
   DCMPLIS_ID number,
   DCMPLIN_ID number,
   DCMPLRD_ID number,
   INCIDENT_STATUS_DATE date,
   LAST_UPDATE_DATE date,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number,
   COMPLETE_DT date,
   SLA_COMPLETE_DATE date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel 4;

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_PK primary key (FCMPLBD_ID) using index tablespace MAXDAT_INDX;

alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLCUR_FK foreign key (CMPL_BI_ID)references D_COMPLAINT_CURRENT (CMPL_BI_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLAC_FK foreign key (DCMPLAC_ID) references D_COMPLAINT_ACTION_COMMENTS (DCMPLAC_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLTS_FK foreign key (DCMPLIA_ID) references D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLDS_FK foreign key (DCMPLID_ID) references D_COMPLAINT_INCIDENT_DESC (DCMPLID_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLIS_FK foreign key (DCMPLIR_ID) references D_COMPLAINT_INCIDENT_REASON (DCMPLIR_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLJS_FK foreign key (DCMPLIS_ID) references D_COMPLAINT_INCIDENT_STATUS (DCMPLIS_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLIN_FK foreign key (DCMPLIN_ID) references D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID);
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLRD_FK foreign key (DCMPLRD_ID) references D_COMPLAINT_RESOLUTION_DESC (DCMPLRD_ID);

create unique index FCMPLBD_UIX1 on F_COMPLAINT_BY_DATE (CMPL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create unique index FCMPLBD_UIX2 on F_COMPLAINT_BY_DATE (CMPL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;

create index FCMPLBD_IX1 on F_COMPLAINT_BY_DATE (INCIDENT_STATUS_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IX2 on F_COMPLAINT_BY_DATE (LAST_UPDATE_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IX3 on F_COMPLAINT_BY_DATE (COMPLETE_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;

create index FCMPLCBD_IXL1 on F_COMPLAINT_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IXL2 on F_COMPLAINT_BY_DATE (CMPL_BI_ID) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IXL3 on F_COMPLAINT_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IXL4 on F_COMPLAINT_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IXL5 on F_COMPLAINT_BY_DATE (INVENTORY_COUNT) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FCMPLBD_IXL6 on F_COMPLAINT_BY_DATE (COMPLETION_COUNT) local online tablespace MAXDAT_INDX parallel 4 compute statistics;

grant select on F_COMPLAINT_BY_DATE to MAXDAT_READ_ONLY;


create sequence SEQ_DCMPLSS_ID
minvalue 0
maxvalue 999999999999999999999999999
start with 0
increment by 1
cache 20;

create table D_COMPLAINT_SLA_SATISFIED
  (DCMPLSS_ID number not null, 
   SLA_SATISFIED varchar2(10))
tablespace MAXDAT_DATA;

alter table D_COMPLAINT_SLA_SATISFIED add constraint DCMPLSS_PK primary key (DCMPLSS_ID) using index tablespace MAXDAT_INDX;

create unique index DCMPLSS_UIX1 on D_COMPLAINT_SLA_SATISFIED (SLA_SATISFIED) online tablespace MAXDAT_INDX compute statistics; 

create or replace public synonym D_COMPLAINT_SLA_SATISFIED for D_COMPLAINT_SLA_SATISFIED;
grant select on D_COMPLAINT_SLA_SATISFIED to MAXDAT_READ_ONLY;

create or replace view D_COMPLAINT_SLA_SATISFIED_SV as
select * from D_COMPLAINT_SLA_SATISFIED
with read only;

grant select on D_COMPLAINT_SLA_SATISFIED_SV to MAXDAT_READ_ONLY;

insert into  D_COMPLAINT_SLA_SATISFIED (DCMPLSS_ID,SLA_SATISFIED ) values (SEQ_DCMPLSS_ID.nextval,'N');
insert into  D_COMPLAINT_SLA_SATISFIED (DCMPLSS_ID,SLA_SATISFIED ) values (SEQ_DCMPLSS_ID.nextval,'Y');
commit;

alter table F_COMPLAINT_BY_DATE ADD DCMPLSS_ID number;

create or replace view F_COMPLAINT_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCMPLBD_ID,
  BUCKET_START_DATE D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,  
  CASE WHEN TRUNC(cc.sla_complete_date) = bucket_start_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
  CASE WHEN cc.sla_complete_date IS NULL OR bucket_start_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bucket_start_date)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness
from F_COMPLAINT_BY_DATE f, d_complaint_current cc
where f.cmpl_bi_id = cc.cmpl_bi_id
and  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness  
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness  
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_COMPLAINT_BY_DATE_SV to MAXDAT_READ_ONLY;  


