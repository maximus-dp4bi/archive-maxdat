/* Drop Tables
drop table F_NYHIX_MFD_BY_DATE_V2;
drop table D_NYHIX_MFD_TIME_STATUS_V2;
drop table D_NYHIX_MFD_FORM_TYPE_V2;
drop table D_NYHIX_MFD_DOC_SUB_TYPE_V2;
drop table D_NYHIX_MFD_ENV_STATUS_V2;
drop table D_NYHIX_MFD_DOC_STATUS_v2;
drop table D_NYHIX_MFD_DOC_TYPE_V2;
drop table D_NYHIX_MFD_INS_STATUS_V2;
drop table D_NYHIX_MFD_CURRENT_V2;
*/

-- D_NYHIX_MFD_CURRENT NYHIX_MFD_BI_ID
create table D_NYHIX_MFD_CURRENT_V2
(NYHIX_MFD_BI_ID NUMBER(18,0) NOT NULL,
EEMFDB_ID NUMBER(18,0),
INSTANCE_STATUS VARCHAR2(32 BYTE),
INSTANCE_START_DATE DATE,
INSTANCE_END_DATE DATE,
COMPLETE_DT DATE,
CANCEL_DT DATE,
CANCEL_BY VARCHAR2(32 BYTE),
CANCEL_REASON VARCHAR2(32 BYTE),
CANCEL_METHOD VARCHAR2(32 BYTE),
DCN VARCHAR2(256 BYTE) NOT NULL,
CREATE_DT DATE,
RECEIVED_DT DATE,
DOC_TYPE_CD VARCHAR2(32 BYTE),
PAGE_COUNT NUMBER(18,0),
ECN VARCHAR2(256 BYTE),
CHANNEL VARCHAR2(32 BYTE),
KOFAX_DCN VARCHAR2(256 BYTE),
BATCH_ID	NUMBER(38,0),
BATCH_NAME VARCHAR2(256 BYTE),
DOC_STATUS_CD VARCHAR2(32 BYTE),
DOC_STATUS VARCHAR2(32 BYTE),
DOC_STATUS_DT DATE,
DOC_UPDATE_DT DATE,
DOC_UPDATED_BY_STAFF_ID VARCHAR2(50 BYTE),
DOC_UPDATED_BY VARCHAR2(32 BYTE),
APP_DOC_DATA_ID NUMBER(18,0),
PRIORITY NUMBER(2,0),
FORM_TYPE_CD VARCHAR2(256 BYTE),
FREE_FORM_TXT_IND VARCHAR2(1 BYTE),
PREVIOUS_KOFAX_DCN VARCHAR2(50 BYTE),
SCAN_DT	DATE,
RELEASE_DT DATE,
APP_DOC_TRACKER_ID NUMBER(18,0),
ENV_STATUS_CD VARCHAR2(32 BYTE),
ENV_STATUS VARCHAR2(256 BYTE),
ENV_STATUS_DT DATE,
SLA_COMPLETE_DT DATE,
ENV_UPDATE_DT DATE,
ENV_UPDATED_BY_STAFF_ID VARCHAR2(50 BYTE),
ENV_UPDATED_BY VARCHAR2(32 BYTE),
SLA_COMPLETE VARCHAR2(1 BYTE),
MAXE_ORIGINATION_DT DATE,
RESCANNED_IND VARCHAR2(1 BYTE),
RETURNED_MAIL_IND VARCHAR2(1 BYTE),
RETURNED_MAIL_REASON VARCHAR2(32 BYTE),
RESCAN_COUNT NUMBER(18,0),
NOTE_ID VARCHAR2(32 BYTE),
ASF_PROCESS_DOC VARCHAR2(1 BYTE),
ASF_CANCEL_DOC VARCHAR2(1 BYTE),
TRASHED_DT DATE,
TRASHED_BY VARCHAR2(32 BYTE),
TRASHED_IND VARCHAR2(1 BYTE),
ORIG_DOC_TYPE_CD	VARCHAR2(32 BYTE),
ORIG_DOC_FORM_TYPE_CD VARCHAR2(32 BYTE),
RESEARCH_REQ_IND VARCHAR2(1 BYTE),
EXPEDIATED_IND VARCHAR2(1 BYTE),
STG_EXTRACT_DATE	DATE,
STG_LAST_UPDATE_DATE DATE,
AGE_IN_BUSINESS_DAYS NUMBER(18,0),
AGE_IN_CALENDAR_DAYS NUMBER(18,0),
TIMELINESS_STATUS VARCHAR2(256 BYTE) DEFAULT 'Not Complete',
TIMELINESS_DAYS NUMBER(18,0),
TIMELINESS_DAYS_TYPE VARCHAR2(1 BYTE),
TIMELINESS_DATE DATE,
JEOPARDY_FLAG VARCHAR2(3 BYTE) DEFAULT 'N',
JEOPARDY_DAYS NUMBER(18,0),
JEOPARDY_DAYS_TYPE VARCHAR2(1 BYTE),
JEOPARDY_DATE DATE,
SLA_RECEIVED_DATE DATE,
SLA_AGE_IN_BUSINESS_DAYS NUMBER(18,0),
SLA_TIMELINESS_STATUS VARCHAR2(256 BYTE) DEFAULT 'Not Complete',
DOC_TYPE VARCHAR2(32 BYTE),
FORM_TYPE VARCHAR2(64 BYTE),
TARGET_DAYS NUMBER(18,0),
STG_DONE_DATE DATE,
LAST_EVENT_DATE DATE)
tablespace MAXDAT_DATA parallel;

--Primary Key
alter table D_NYHIX_MFD_CURRENT_V2 add constraint DMFD_PK primary key (NYHIX_MFD_BI_ID) using index tablespace MAXDAT_INDX;

--Indexes
create index DMFDCU_IX1 on D_NYHIX_MFD_CURRENT_V2 (INSTANCE_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index DMFDCU_IX2 on D_NYHIX_MFD_CURRENT_V2 (INSTANCE_END_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index DMFDCU_IX3 on D_NYHIX_MFD_CURRENT_V2 (DCN) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_NYHIX_MFD_CURRENT_V2 for D_NYHIX_MFD_CURRENT_V2;
grant select on D_NYHIX_MFD_CURRENT_V2 to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV_V2
AS
  SELECT
    NYHIX_MFD_BI_ID,
    EEMFDB_ID,
    INSTANCE_STATUS,
    INSTANCE_START_DATE,
    INSTANCE_END_DATE,
    COMPLETE_DT,
    CANCEL_DT,
    CASE
      WHEN LENGTH(S1.LAST_NAME || ', ' || S1.FIRST_NAME) > 2  THEN S1.LAST_NAME || ', '  || S1.FIRST_NAME
      WHEN LENGTH(E1.LAST_NAME || ', ' || E1.FIRST_NAME) > 2  THEN E1.LAST_NAME || ', '  || E1.FIRST_NAME
      ELSE C.CANCEL_BY
    END AS CANCEL_BY,
    CANCEL_REASON,
    CANCEL_METHOD,
    DCN,
    CREATE_DT,
    RECEIVED_DT,
    DOC_TYPE_CD,
    PAGE_COUNT,
    ECN,
    CHANNEL,
    KOFAX_DCN,
    BATCH_ID,
    BATCH_NAME,
    DOC_STATUS_CD,
    DOC_STATUS,
    DOC_STATUS_DT,
    DOC_UPDATE_DT,
    DOC_UPDATED_BY_STAFF_ID,
    CASE
      WHEN LENGTH(S2.LAST_NAME || ', ' || S2.FIRST_NAME) > 2  THEN S2.LAST_NAME || ', '  || S2.FIRST_NAME
      WHEN LENGTH(E2.LAST_NAME || ', ' || E2.FIRST_NAME) > 2  THEN E2.LAST_NAME || ', '  || E2.FIRST_NAME
      ELSE C.DOC_UPDATED_BY_STAFF_ID
    END AS DOC_UPDATED_BY,
    APP_DOC_DATA_ID,
    PRIORITY,
    FORM_TYPE_CD,
    FREE_FORM_TXT_IND,
    PREVIOUS_KOFAX_DCN,
    SCAN_DT,
    RELEASE_DT,
    APP_DOC_TRACKER_ID,
    ENV_STATUS_CD,
    ENV_STATUS,
    ENV_STATUS_DT,
    SLA_COMPLETE_DT,
    ENV_UPDATE_DT,
    ENV_UPDATED_BY_STAFF_ID,
    TRASHED_BY,
    SLA_COMPLETE,
    MAXE_ORIGINATION_DT,
    RESCANNED_IND,
    RETURNED_MAIL_IND,
    RETURNED_MAIL_REASON,
    RESCAN_COUNT,
    NOTE_ID,
    ASF_PROCESS_DOC,
    ASF_CANCEL_DOC,
    TRASHED_DT,
    CASE
      WHEN LENGTH(S3.LAST_NAME || ', ' || S3.FIRST_NAME) > 2  THEN S3.LAST_NAME || ', '  || S3.FIRST_NAME
      WHEN LENGTH(E3.LAST_NAME || ', ' || E3.FIRST_NAME) > 2  THEN E3.LAST_NAME || ', '  || E3.FIRST_NAME
      ELSE C.ENV_UPDATED_BY_STAFF_ID
    END AS ENV_UPDATED_BY,
    TRASHED_IND,
    ORIG_DOC_TYPE_CD,
    ORIG_DOC_FORM_TYPE_CD,
    RESEARCH_REQ_IND,
    EXPEDIATED_IND,
    STG_EXTRACT_DATE,
    STG_LAST_UPDATE_DATE,
    AGE_IN_BUSINESS_DAYS,
    AGE_IN_CALENDAR_DAYS,
    TIMELINESS_STATUS,
    TIMELINESS_DAYS,
    TIMELINESS_DAYS_TYPE,
    TIMELINESS_DATE,
    JEOPARDY_FLAG,
    JEOPARDY_DAYS,
    JEOPARDY_DAYS_TYPE,
    JEOPARDY_DATE,
    SLA_RECEIVED_DATE,
    SLA_AGE_IN_BUSINESS_DAYS,
    SLA_TIMELINESS_STATUS,
    DOC_TYPE,
    FORM_TYPE,
    TARGET_DAYS
  FROM
    D_NYHIX_MFD_CURRENT_V2 C
  LEFT JOIN STAFF_STG S1  ON    cast(S1.STAFF_ID as Char(8)) = cast(C.CANCEL_BY as Char(8))
  LEFT JOIN STAFF_STG S2  ON    cast(S2.STAFF_ID as Char(8)) = cast(C.DOC_UPDATED_BY_STAFF_ID as Char(8))
  LEFT JOIN STAFF_STG S3  ON    cast(S3.STAFF_ID as Char(8)) = cast(C.ENV_UPDATED_BY_STAFF_ID as Char(8)) 
  LEFT JOIN STAFF_STG E1  ON    E1.EXT_STAFF_NUMBER = C.CANCEL_BY
  LEFT JOIN STAFF_STG E2  ON    E2.EXT_STAFF_NUMBER = C.DOC_UPDATED_BY_STAFF_ID
  LEFT JOIN STAFF_STG E3  ON    E3.EXT_STAFF_NUMBER = C.ENV_UPDATED_BY_STAFF_ID;

create or replace public synonym D_NYHIX_MFD_CURRENT_SV_V2 for D_NYHIX_MFD_CURRENT_SV_V2;
grant select on D_NYHIX_MFD_CURRENT_SV_V2 to MAXDAT_READ_ONLY;

-- D_NYHIX_MFD_INS_STATUS  SEQ_DNMFDIS_ID is already present
/*
create sequence SEQ_DNMFDIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_INS_STATUS_V2 
 (DNMFDIS_ID number not null,
 INSTANCE_STATUS varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_INS_STATUS_V2 add constraint DMFDIS_PK primary key (DNMFDIS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDIS_UIX1 on D_NYHIX_MFD_INS_STATUS_V2 ("INSTANCE_STATUS") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_INS_STATUS_V2 for D_NYHIX_MFD_INS_STATUS_V2;
grant select on D_NYHIX_MFD_INS_STATUS_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_INS_STATUS_SV_V2 as
select * from D_NYHIX_MFD_INS_STATUS_V2
with read only;

-- D_NYHIX_MFD_DOC_TYPE  SEQ_DNMFDDT_ID is already present
/*
create sequence SEQ_DNMFDDT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_DOC_TYPE_V2
 (DNMFDDT_ID number not null,
  DOC_TYPE varchar2(64) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_DOC_TYPE_V2 add constraint DMFDDT_PK primary key (DNMFDDT_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDDT_UIX1 on D_NYHIX_MFD_DOC_TYPE_V2 ("DOC_TYPE") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_DOC_TYPE_V2 for D_NYHIX_MFD_DOC_TYPE_V2;
grant select on D_NYHIX_MFD_DOC_TYPE_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_DOC_TYPE_SV_V2 as
select * from D_NYHIX_MFD_DOC_TYPE_V2
with read only;

-- D_NYHIX_MFD_DOC_STATUS  SEQ_DNMFDDS_ID is already present
/*
create sequence SEQ_DNMFDDS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_DOC_STATUS_V2 
 (DNMFDDS_ID number not null,
  DOC_STATUS varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_DOC_STATUS_V2 add constraint DMFDDS_PK primary key (DNMFDDS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDDS_UIX1 on D_NYHIX_MFD_DOC_STATUS_V2 ("DOC_STATUS") online tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_DOC_STATUS_V2 for D_NYHIX_MFD_DOC_STATUS_V2;
grant select on D_NYHIX_MFD_DOC_STATUS_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_DOC_STATUS_SV_V2 as
select * from D_NYHIX_MFD_DOC_STATUS_V2
with read only;

create or replace public synonym D_NYHIX_MFD_DOC_STATUS_SV_V2 for D_NYHIX_MFD_DOC_STATUS_SV_V2;
grant select on D_NYHIX_MFD_DOC_STATUS_SV_V2 to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_ENV_STATUS  SEQ_DNMFDES_ID  is already present
/*
create sequence SEQ_DNMFDES_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_ENV_STATUS_V2 
 (DNMFDES_ID number not null, 
  ENV_STATUS varchar2(64) not null) 
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_ENV_STATUS_V2 add constraint DMFDES_PK primary key (DNMFDES_ID) using index tablespace MAXDAT_INDX;

alter index DMFDES_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DMFDES_UIX1 on D_NYHIX_MFD_ENV_STATUS_V2 ("ENV_STATUS") online tablespace 
MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_ENV_STATUS_V2 for D_NYHIX_MFD_ENV_STATUS_V2;
grant select on D_NYHIX_MFD_ENV_STATUS_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_ENV_STATUS_SV_V2 as
select * from D_NYHIX_MFD_ENV_STATUS_V2
with read only;

create or replace public synonym D_NYHIX_MFD_ENV_STATUS_SV_V2 for D_NYHIX_MFD_ENV_STATUS_SV_V2;
grant select on D_NYHIX_MFD_ENV_STATUS_SV_V2 to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_FORM_TYPE  SEQ_DNMFDFT_ID is already present
/*
create sequence SEQ_DNMFDFT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_FORM_TYPE_V2
 (DNMFDFT_ID number not null, 
  FORM_TYPE varchar2(64))
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_FORM_TYPE_V2 add constraint DMFDFT_PK primary key (DNMFDFT_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDFT_UIX1 on D_NYHIX_MFD_FORM_TYPE_V2 ("FORM_TYPE") online tablespace MAXDAT_INDX 
parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_FORM_TYPE_V2 for D_NYHIX_MFD_FORM_TYPE_V2;
grant select on D_NYHIX_MFD_FORM_TYPE_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_FORM_TYPE_SV_V2 as
select * from D_NYHIX_MFD_FORM_TYPE_V2
with read only;

create or replace public synonym D_NYHIX_MFD_FORM_TYPE_SV_V2 for D_NYHIX_MFD_FORM_TYPE_SV_V2;
grant select on D_NYHIX_MFD_FORM_TYPE_SV_V2 to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_TIME_STATUS SEQ_DNMFDTS_ID is already present 
/*
create sequence SEQ_DNMFDTS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
*/

create table D_NYHIX_MFD_TIME_STATUS_V2 
 (DNMFDTS_ID number not null, 
  TIMELINESS_STATUS varchar2(256) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_TIME_STATUS_V2 add constraint DMFDTS_PK primary key (DNMFDTS_ID) using index tablespace MAXDAT_INDX;

create unique index DMFDTS_UIX1 on D_NYHIX_MFD_TIME_STATUS_V2 ("TIMELINESS_STATUS") online 
tablespace MAXDAT_INDX parallel compute statistics; 

create or replace public synonym D_NYHIX_MFD_TIME_STATUS_V2 for D_NYHIX_MFD_TIME_STATUS_V2;
grant select on D_NYHIX_MFD_TIME_STATUS_V2 to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_TIME_STATUS_SV_V2 as
select * from D_NYHIX_MFD_TIME_STATUS_V2
with read only;

create or replace public synonym D_NYHIX_MFD_TIME_STATUS_SV_V2 for D_NYHIX_MFD_TIME_STATUS_SV_V2;
grant select on D_NYHIX_MFD_TIME_STATUS_SV_V2 to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_HISTORY_V2 
create sequence SEQ_DMFDBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_HISTORY_V2 
(DMFDBD_ID NUMBER NOT NULL,
BUCKET_START_DATE DATE NOT NULL,
BUCKET_END_DATE DATE NOT NULL,
NYHIX_MFD_BI_ID NUMBER NOT NULL,
DNMFDDT_ID NUMBER NOT NULL,
DNMFDDS_ID NUMBER NOT NULL,
DNMFDES_ID NUMBER NOT NULL,
DNMFDFT_ID NUMBER(18,0) NOT NULL,
DNMFDTS_ID NUMBER NOT NULL,
DNMFDIS_ID NUMBER NOT NULL, 
DOC_STATUS_DT DATE NOT NULL,
ENV_STATUS_DT DATE,
AGE_IN_BUSINESS_DAYS NUMBER(18,0) NOT NULL,
AGE_IN_CALENDAR_DAYS NUMBER(18,0) NOT NULL,
LAST_EVENT_DATE DATE NOT NULL)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table D_NYHIX_MFD_HISTORY_V2 add constraint DMFDBD_PK primary key (DMFDBD_ID) using index tablespace MAXDAT_INDX;
alter table D_NYHIX_MFD_HISTORY_V2 add constraint DMFDBD_DNMFDDT_FK foreign key (DNMFDDT_ID) references D_NYHIX_MFD_DOC_TYPE_V2 (DNMFDDT_ID);
alter table D_NYHIX_MFD_HISTORY_V2  add constraint DMFDBD_DNMFDDS_FK foreign key (DNMFDDS_ID) references D_NYHIX_MFD_DOC_STATUS_V2 (DNMFDDS_ID);
alter table D_NYHIX_MFD_HISTORY_V2  add constraint DMFDBD_DNMFDES_FK foreign key (DNMFDES_ID) references D_NYHIX_MFD_ENV_STATUS_V2 (DNMFDES_ID);
alter table D_NYHIX_MFD_HISTORY_V2 add constraint DMFDBD_DNMFDFT_FK foreign key (DNMFDFT_ID) references D_NYHIX_MFD_FORM_TYPE_V2 (DNMFDFT_ID);
alter table D_NYHIX_MFD_HISTORY_V2 add constraint DMFDBD_DNMFDTS_FK foreign key (DNMFDTS_ID) references D_NYHIX_MFD_TIME_STATUS_V2 (DNMFDTS_ID);
alter table D_NYHIX_MFD_HISTORY_V2  add constraint DMFDBD_DNMFDIS_FK foreign key (DNMFDIS_ID) references D_NYHIX_MFD_INS_STATUS_V2(DNMFDIS_ID);
alter table D_NYHIX_MFD_HISTORY_V2 add constraint DMFDBD_NYHIX_MFD_BI_ID_FK foreign key (NYHIX_MFD_BI_ID) references D_NYHIX_MFD_CURRENT_V2(NYHIX_MFD_BI_ID);

create unique index DMFDBD_UIX1 on D_NYHIX_MFD_HISTORY_V2 (NYHIX_MFD_BI_ID,LAST_EVENT_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index DMFDBD_UIX2 on D_NYHIX_MFD_HISTORY_V2 (NYHIX_MFD_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index DMFDBD_IX1 on D_NYHIX_MFD_HISTORY_V2 (DOC_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics; 
create index DMFDBD_IX2 on D_NYHIX_MFD_HISTORY_V2 (ENV_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics; 

create index DMFDBD_IXL2 on D_NYHIX_MFD_HISTORY_V2 (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index DMFDBD_IXL3 on D_NYHIX_MFD_HISTORY_V2 (NYHIX_MFD_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view D_NYHIX_MFD_HISTORY_SV_V2
as
SELECT
  h.DMFDBD_ID,
  bdd.D_DATE,
  h.NYHIX_MFD_BI_ID,
  h.DNMFDDT_ID,
  h.DNMFDDS_ID,
  h.DNMFDES_ID,
  h.DNMFDFT_ID,
  h.DNMFDTS_ID,
  h.DNMFDIS_ID,
  h.DOC_STATUS_DT,
  h.ENV_STATUS_DT,
  h.AGE_IN_BUSINESS_DAYS,
  h.AGE_IN_CALENDAR_DAYS
FROM D_NYHIX_MFD_HISTORY_V2 h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

create or replace public synonym D_NYHIX_MFD_HISTORY_SV_V2 for D_NYHIX_MFD_HISTORY_SV_V2;
grant select on D_NYHIX_MFD_HISTORY_SV_V2 to MAXDAT_READ_ONLY;

--Replace fact view 
Create or replace view F_NYHIX_MFD_BY_DATE_SV_V2
as
Select 
d.NYHIX_MFD_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT,
CASE WHEN bdd.D_DATE = trunc(d.ENV_STATUS_DT)
            AND d.env_status = 'COMPLETEDRELEASED'
            AND d.cancel_dt is null
     THEN 1 
     ELSE 0
END AS SLA_SATISFIED_COUNT
FROM BPM_D_DATES bdd JOIN D_NYHIX_MFD_CURRENT_V2 d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));

create or replace public synonym F_NYHIX_MFD_BY_DATE_SV_V2 for F_NYHIX_MFD_BY_DATE_SV_V2;
grant select on F_NYHIX_MFD_BY_DATE_SV_V2 to MAXDAT_READ_ONLY;

