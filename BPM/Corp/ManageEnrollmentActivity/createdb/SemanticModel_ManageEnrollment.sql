create table D_ME_CURRENT
  (ME_BI_ID                       number(18),
   CLIENT_ENROLL_STATUS_ID        number(18),
   CLIENT_ID                      number(18),
   CREATE_DT                      date,
   CASE_ID                        number(18),
   CLIENT_CIN                     varchar2(32),
   NEWBORN_FLG                    varchar2(1),
   SERVICE_AREA                   varchar2(32),
   COUNTY_CODE                    varchar2(32),
   ZIP_CODE                       varchar2(80),
   AGE_IN_BUSINESS_DAYS           number(18),
   AGE_IN_CALENDAR_DAYS           number(18),
   CUR_ENROLLMENT_STATUS_CODE     varchar2(32),    
   CUR_ENROLLMENT_STATUS_DATE     date,
   AUTO_ASSIGNMENT_DUE_DATE       date,
   ENRL_PACKET_REQUEST_ID         number(18),
   ENRL_PACKET_REQUEST_DATE       date,
   ENROLL_FEE_AMNT_DUE            number,
   ENROLL_FEE_AMNT_PAID           number,
   ENROLL_FEE_RECVD_DATE          date,
   CHIP_PLAN_CHANGE_NOTICE_ID     number(18),
   CHIP_PLAN_CHANGE_MAILED_DATE   date,
   CHIP_ENROLL_MI_NOTICE_ID       number(18),
   CHIP_ENROLL_MI_SENT_DATE       date,
   PLAN_TYPE                      varchar2(32),
   PROGRAM_TYPE                   varchar2(32),
   SELECTION_METHOD               varchar2(32),
   SELECTION_CREATED_BY_NAME      varchar2(80),
   SELECTION_CREATE_DATE          date,
   SELECTION_LAST_UPD_BY_NAME     varchar2(80),
   SELECTION_LAST_UPDATE_DATE     date,
   SELECTION_AUTO_PROCESSED       varchar2(1),
   VALID_SLCN_RECEIVED_START_DATE date,
   VALID_SLCN_RECEIVED_END_DATE   date,
   SEND_ENROLL_PKT_START_DATE     date,
   SEND_ENROLL_PKT_END_DATE       date,
   FIRST_FOLLOW_UP_ID             varchar2(37),
   FIRST_FOLLOW_UP_TYPE_CODE      varchar2(40),
   FIRST_FOLLOW_UP_START_DATE     date,
   FIRST_FOLLOW_UP_END_DATE       date,
   SECOND_FOLLOW_UP_ID            varchar2(37),
   SECOND_FOLLOW_UP_TYPE_CODE     varchar2(40),
   SECOND_FOLLOW_UP_START_DATE    date,
   SECOND_FOLLOW_UP_END_DATE      date,
   THIRD_FOLLOW_UP_ID             varchar2(37),
   THIRD_FOLLOW_UP_TYPE_CODE      varchar2(40),
   THIRD_FOLLOW_UP_START_DATE     date,
   THIRD_FOLLOW_UP_END_DATE       date,
   FOURTH_FOLLOW_UP_ID            varchar2(37),
   FOURTH_FOLLOW_UP_TYPE_CODE     varchar2(40),
   FOURTH_FOLLOW_UP_START_DATE    date,
   FOURTH_FOLLOW_UP_END_DATE      date,
   AUTO_ASSIGN_START_DATE         date,
   AUTO_ASSIGN_END_DATE           date,
   WAIT_ENROLL_FEE_START_DATE     date,
   WAIT_ENROLL_FEE_END_DATE       date,
   INSTANCE_STATUS                varchar2(10),
   COMPLETE_DATE                  date,
   CANCEL_ENROLL_ACTIVITY_DATE    date,
   CANCEL_REASON                  varchar2(100),
   CANCEL_METHOD                  varchar2(20),
   CANCELLED_BY   	              varchar2(80),
   -- ASF flags.
   CANCEL_ENRL_ACTIVITY_FLAG      varchar2(1), 
   SEND_ENROLL_PACKET_FLAG        varchar2(1),  
   SELECTIONS_RECEIVED_FLAG       varchar2(1), 
   FIRST_FOLLOW_UP_COMP_FLAG      varchar2(1), 
   SECOND_FOLLOW_UP_COMP_FLAG     varchar2(1), 
   THIRD_FOLLOW_UP_COMP_FLAG      varchar2(1), 
   FOURTH_FOLLOW_UP_COMP_FLAG     varchar2(1), 
   AUTO_ASSIGN_FLAG               varchar2(1), 
   WAIT_FOR_FEE_FLAG              varchar2(1), 
   -- Gateway flags.
   ENROLL_PACKET_REQUIRED_FLAG    varchar2(1),
   FIRST_FOLLOW_UP_REQ_FLAG       varchar2(1),
   SECOND_FOLLOW_UP_REQ_FLAG      varchar2(1),
   THIRD_FOLLOW_UP_REQ_FLAG       varchar2(1),
   FOURTH_FOLLOW_UP_REQ_FLAG      varchar2(1),
   REQ_FEE_PAID_FLAG              varchar2(1),
   --   
   AUTO_ASSIGN_TIMELY_STATUS     varchar2(10),  
   AUTO_ASSIGN_SLA_DAYS          number(18),
   AUTO_ASSIGN_SLA_DAYS_TYPE     varchar2(1),
   ENROLL_PACKET_TIMELY_STATUS   varchar2(10),  
   ENROLL_PACKET_SLA_DAYS        number(18),
   ENROLL_PACKET_SLA_DAYS_TYPE   varchar2(1),
   FIRST_FOLLOWUP_TIMELY_STATUS  varchar2(10), 
   FIRST_FOLLOWUP_SLA_DAYS       number(18),
   FIRST_FOLLOWUP_SLA_DAYS_TYPE  varchar2(1),
   SECOND_FOLLOWUP_TIMELY_STATUS varchar2(10),  
   SECOND_FOLLOWUP_SLA_DAYS      number(18),
   SECOND_FOLLOWUP_SLA_DAYS_TYPE varchar2(1),
   THIRD_FOLLOWUP_TIMELY_STATUS  varchar2(10),
   THIRD_FOLLOWUP_SLA_DAYS       number(18),
   THIRD_FOLLOWUP_SLA_DAYS_TYPE  varchar2(1),
   FOURTH_FOLLOWUP_TIMELY_STATUS varchar2(10),
   FOURTH_FOLLOWUP_SLA_DAYS      number(18),
   FOURTH_FOLLOWUP_SLA_DAYS_TYPE varchar2(1),
   FIRST_FOLLOW_UP_TYPE          varchar2(200), 
   SECOND_FOLLOW_UP_TYPE         varchar2(200),
   THIRD_FOLLOW_UP_TYPE          varchar2(200),
   FOURTH_FOLLOW_UP_TYPE         varchar2(200),
   ENROLLMENT_FEE_REQUIRED       varchar2(1),
   ENROLLMENT_ACTIVITY_OUTCOME   varchar2(200),
   DAYS_TO_AUTO_ASSIGNMENT       number(18),
   --
   GENERIC_FIELD_1               varchar2(50),
   GENERIC_FIELD_2               varchar2(50),
   GENERIC_FIELD_3               varchar2(50),
   GENERIC_FIELD_4               varchar2(50),
   GENERIC_FIELD_5               varchar2(50),
   SUBPROGRAM_TYPE               varchar2(32))
tablespace MAXDAT_DATA parallel;

alter table D_ME_CURRENT add constraint DMECUR_PK primary key (ME_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DMECUR_UIX1 on D_ME_CURRENT (CLIENT_ENROLL_STATUS_ID) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_ME_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_ME_CURRENT_SV as
select * from D_ME_CURRENT
with read only;

grant select on D_ME_CURRENT_SV to MAXDAT_READ_ONLY;


------------------------------------------------------------------------------------------------------------
-- D_ME_ENRL_STATUS_CODE   DMESC_ID  "Enrollment Status Code"         VARCHAR2(32),
create sequence SEQ_DMESC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table D_ME_ENRL_STATUS_CODE 
  (DMESC_ID number, 
   ENROLLMENT_STATUS_CODE varchar2(32))
tablespace MAXDAT_DATA;

alter table D_ME_ENRL_STATUS_CODE add constraint DMESC_PK primary key (DMESC_ID) using index tablespace MAXDAT_INDX;

create unique index DMESC_UIX1 on D_ME_ENRL_STATUS_CODE (ENROLLMENT_STATUS_CODE) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_ME_ENRL_STATUS_CODE to MAXDAT_READ_ONLY;

create or replace view D_ME_ENRL_STATUS_CODE_SV as
select * from D_ME_ENRL_STATUS_CODE
with read only;

grant select on D_ME_ENRL_STATUS_CODE_SV to MAXDAT_READ_ONLY;

insert into D_ME_ENRL_STATUS_CODE (DMESC_ID ,ENROLLMENT_STATUS_CODE) values (SEQ_DMESC_ID.NEXTVAL,null);
commit;


--------------------------------------------------------------------------------------------------
create sequence SEQ_FMEBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

create table F_ME_BY_DATE 
  (FMEBD_ID number not null,
	 D_DATE date not null,
	 BUCKET_START_DATE date not null, 
	 BUCKET_END_DATE date not null,
	 ME_BI_ID number not null, 
	 DMESC_ID number not null,
	 CREATION_COUNT number,
	 INVENTORY_COUNT number,
	 COMPLETION_COUNT number,
	 ENROLLMENT_STATUS_DATE date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA;

alter table F_ME_BY_DATE add constraint FMEBD_PK primary key (FMEBD_ID) using index tablespace MAXDAT_INDX;

alter table F_ME_BY_DATE add constraint FMEBD_DMECUR_FK foreign key (ME_BI_ID)references D_ME_CURRENT (ME_BI_ID);
alter table F_ME_BY_DATE add constraint FMEBD_ID_FK foreign key (DMESC_ID) references D_ME_ENRL_STATUS_CODE (DMESC_ID);

create unique index FMEBD_UIX1 on F_ME_BY_DATE (ME_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMEBD_UIX2 on F_ME_BY_DATE (ME_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMEBD_IX1 on F_ME_BY_DATE (ENROLLMENT_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FMEBD_IXL1 on F_ME_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL2 on F_ME_BY_DATE (ME_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL3 on F_ME_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMEBD_IXL4 on F_ME_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_ME_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_ME_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FMEBD_ID,
  BUCKET_START_DATE D_DATE,
  ME_BI_ID, 
  DMESC_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from F_ME_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FMEBD_ID,
  bdd.D_DATE,
  ME_BI_ID, 
  DMESC_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from 
  F_ME_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMEBD_ID,
  bdd.D_DATE,
  ME_BI_ID, 
  DMESC_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_ME_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FMEBD_ID,
  bdd.D_DATE,
  ME_BI_ID, 
  DMESC_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  ENROLLMENT_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_ME_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_ME_BY_DATE_SV to MAXDAT_READ_ONLY;

