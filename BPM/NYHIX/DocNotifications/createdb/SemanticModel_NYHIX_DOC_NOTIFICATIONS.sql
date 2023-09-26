/* Drop Tables
drop table D_NYHIX_DOC_NOTIF_HISTORY;
drop table D_NYHIX_DOC_NOTIF_CURRENT;
*/

-- D_NYHIX_DOC_NOTIF_CURRENT NYHIX_DN_BI_ID
create table D_NYHIX_DOC_NOTIF_CURRENT
(NYHIX_DN_BI_ID NUMBER(18,0) NOT NULL,
EDNDB_ID number(18,0) not null,
DOC_NOTIFICATION_ID number(18,0) not null,
KOFAX_DCN varchar2(256),
INSTANCE_STATUS varchar2(32) not null,
INSTANCE_START_DATE date,
INSTANCE_END_DATE date,
COMPLETE_DT date,
CANCEL_DT date,
CANCEL_BY_ID varchar2(32),
CANCEL_BY varchar2(100),
CANCEL_REASON  varchar2(100),
CANCEL_METHOD  varchar2(32),
CREATE_DT date,
CREATED_BY_ID varchar2(32),
CREATED_BY varchar2(100),
UPDATE_DT date,
UPDATED_BY_ID varchar2(32),
UPDATED_BY varchar2(100),
STATUS_CD varchar2(64),
STATUS varchar2(64),
HXID varchar2(64),
HX_ACCOUNT_ID varchar2(64),
ACCOUNT_ID number(18,0),
DESCRIPTION varchar2(512),
PROCESSED_IND varchar2(1) default 'N',
PROCESS_INSTANCE_ID number(18,0),
ERROR_CD varchar2(256),
NOTIFICATION_DT varchar2(64),
CHANNEL varchar2(100),
ASSD_PROCESS_DN date,
ASED_PROCESS_DN date,
ASF_VERIFY_DN varchar2(1)  default 'N' not null,
STG_EXTRACT_DATE date,
STAGE_DONE_DATE date,
STG_LAST_UPDATE_DATE date,
LAST_EVENT_DATE date,
AGE_IN_BUSINESS_DAYS number(18,0),
AGE_IN_CALENDAR_DAYS number(18,0),
TIMELINESS_STATUS varchar2(100) default 'Not Complete' not null,
TIMELINESS_DAYS number(18,0),
TIMELINESS_DAYS_TYPE varchar2(1),
TIMELINESS_DATE date,
JEOPARDY_FLAG varchar2(3),
JEOPARDY_DAYS number(18,0),
JEOPARDY_DAYS_TYPE varchar2(1),
JEOPARDY_DATE date,
TARGET_DAYS number(18,0)
) tablespace MAXDAT_DATA parallel 4;

--Primary Key
alter table D_NYHIX_DOC_NOTIF_CURRENT add constraint DDN_PK primary key (NYHIX_DN_BI_ID) using index tablespace MAXDAT_INDX;

--Indexes
create index DDNCU_IX1 on D_NYHIX_DOC_NOTIF_CURRENT (INSTANCE_START_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DDNCU_IX2 on D_NYHIX_DOC_NOTIF_CURRENT (INSTANCE_END_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DDNCU_IX3 on D_NYHIX_DOC_NOTIF_CURRENT (KOFAX_DCN) online tablespace MAXDAT_INDX parallel 4 compute statistics;

grant select on D_NYHIX_DOC_NOTIF_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_DOC_NOTIF_CURRENT_SV 
as
SELECT
  NYHIX_DN_BI_ID,
  EDNDB_ID,
  DOC_NOTIFICATION_ID,
  KOFAX_DCN,
  INSTANCE_STATUS,
  INSTANCE_START_DATE,
  INSTANCE_END_DATE,
  COMPLETE_DT,
  CANCEL_DT,
  CANCEL_BY_ID,
  CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  CREATE_DT,
  CREATED_BY_ID,
  CREATED_BY,
  UPDATE_DT,
  UPDATED_BY_ID,
  UPDATED_BY,
  STATUS_CD,
  STATUS,
  HXID,
  HX_ACCOUNT_ID,
  ACCOUNT_ID,
  DESCRIPTION,
  PROCESSED_IND,
  PROCESS_INSTANCE_ID,
  ERROR_CD,
  NOTIFICATION_DT,
  CHANNEL,
  ASSD_PROCESS_DN,
  ASED_PROCESS_DN,
  ASF_VERIFY_DN,
  STG_EXTRACT_DATE,
  STAGE_DONE_DATE,
  STG_LAST_UPDATE_DATE,
  LAST_EVENT_DATE,
  AGE_IN_BUSINESS_DAYS CURR_AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS CURR_AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  TIMELINESS_DAYS,
  TIMELINESS_DAYS_TYPE,
  TIMELINESS_DATE,
  JEOPARDY_FLAG CURR_JEOPARDY_FLAG,
  JEOPARDY_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_DATE,
  TARGET_DAYS
FROM
  MAXDAT.D_NYHIX_DOC_NOTIF_CURRENT ;

grant select on D_NYHIX_DOC_NOTIF_CURRENT_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_DOC_NOTIF_HISTORY_V2 
create sequence SEQ_DDNBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_DOC_NOTIF_HISTORY 
(DDNBD_ID NUMBER NOT NULL,
BUCKET_START_DATE DATE NOT NULL,
BUCKET_END_DATE DATE NOT NULL,
NYHIX_DN_BI_ID NUMBER NOT NULL,
STATUS_CD varchar2(64),
STATUS varchar2(64),
LAST_EVENT_DATE DATE NOT NULL)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel 4;

alter table D_NYHIX_DOC_NOTIF_HISTORY add constraint DDNBD_PK primary key (DDNBD_ID) using index tablespace MAXDAT_INDX;
alter table D_NYHIX_DOC_NOTIF_HISTORY add constraint DDNBD_NYHIX_DN_BI_ID_FK foreign key (NYHIX_DN_BI_ID) references D_NYHIX_DOC_NOTIF_CURRENT(NYHIX_DN_BI_ID);

create unique index DDNBDN_UIX1 on D_NYHIX_DOC_NOTIF_HISTORY (NYHIX_DN_BI_ID,LAST_EVENT_DATE) online tablespace MAXDAT_INDX parallel  4 compute statistics; 
create unique index DDNBDN_UIX2 on D_NYHIX_DOC_NOTIF_HISTORY (NYHIX_DN_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;

create index DDNBDN_IXL1 on D_NYHIX_DOC_NOTIF_HISTORY (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DDNBDN_IXL2 on D_NYHIX_DOC_NOTIF_HISTORY (NYHIX_DN_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;

--Replace History View
create or replace view D_NYHIX_DOC_NOTIF_HISTORY_SV
as
SELECT
  h.DDNBD_ID,
  b.D_DATE,
  h.NYHIX_DN_BI_ID,
  h.STATUS_CD,
  h.STATUS,
  BPM_COMMON.BUS_DAYS_BETWEEN(d.create_dt, b.d_date) as AGE_IN_BUSINESS_DAYS,
  Case when (ROUND(trunc(b.D_DATE) - trunc(d.create_dt))) > 0 then (ROUND(trunc(b.D_DATE) - trunc(d.create_dt))) else 0 end as AGE_IN_CALENDAR_DAYS,
  case when (d.COMPLETE_DT is not null and b.D_DATE = trunc(d.COMPLETE_DT)) or (d.cancel_dt is not null and b.D_DATE = trunc(d.CANCEL_DT)) then 'N/A'
     when BPM_COMMON.BUS_DAYS_BETWEEN(d.create_dt, b.d_date) >= d.JEOPARDY_DAYS then 'Y'
     else 'N' end as JEOPARDY_FLAG
FROM D_NYHIX_DOC_NOTIF_HISTORY h 
JOIN D_NYHIX_DOC_NOTIF_CURRENT d on (h.NYHIX_DN_BI_ID = d.NYHIX_DN_BI_ID)
JOIN BPM_D_DATES B on (B.D_DATE >= H.BUCKET_START_DATE and B.D_DATE <= H.BUCKET_END_DATE);


grant select on D_NYHIX_DOC_NOTIF_HISTORY_SV to MAXDAT_READ_ONLY;


--Replace Fact view
Create or replace view F_NYHIX_DOC_NOTIF_BY_DATE_SV
as
Select 
d.NYHIX_DN_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_DT) THEN 1 else 0 END AS CANCEL_COUNT
FROM 
BPM_D_DATES bdd 
INNER JOIN D_NYHIX_DOC_NOTIF_CURRENT d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));

