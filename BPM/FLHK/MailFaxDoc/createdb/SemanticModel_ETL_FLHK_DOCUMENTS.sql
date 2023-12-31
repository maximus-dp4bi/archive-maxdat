-- D_FLHK_DOCUMENTS_CURRENT FLHK_MFD_BI_ID

create table D_FLHK_DOCUMENTS_CURRENT_V2
(FLHK_DOC_BI_ID NUMBER(18,0) NOT NULL,
 EDDB_ID NUMBER(18,0) not null,
 DCN varchar2(256) not null,
 DCN_CREATE_DT date not null,
 KOFAX_DCN varchar2(256) not null,
 ECN varchar2(256),
 KOFAX_ECN varchar2(256),
 BATCH_ID number(18,0) not null,
 DOC_TYPE varchar2(32) not null,
 CHANNEL varchar2(32) not null,
 VIDA_SOURCE varchar2(256) not null,
 ACCOUNT_NUM number(18,0) not null,
 WEB_CONFIRM_ID varchar2(19) not null,
 RECEIPT_DT date not null,
 SCAN_DT date not null,
 RELEASE_DT date not null,
 UNREADABLE varchar2(1),
 MISSING_PAGES varchar2(1),
 ALREADY_WORKED varchar2(1),
 FORWARD_ADDRESS varchar2(1),
 IMAGE_LOCATION varchar2(256),
 RENEWAL_DOC_FLAG varchar2(1) not null,
 NEW_APP_FLAG varchar2(1) not null,
 LETTER_ID varchar2(32) not null,
 PAYMENT_AMT number(18,0) not null,
 PAYMENT_NUM varchar2(25) not null,
 INSTANCE_STATUS varchar2(256) not null,
 INSTANCE_STATUS_DT date not null,
 INSTANCE_COMPLETE_DT date,
 ASSD_CREATE_DOC_IN_VIDA date,
 ASED_CREATE_DOC_IN_VIDA date,
 ASF_CREATE_DOC_IN_VIDA varchar2(1) not null,
 GWF_WORK_REQUIRED varchar2(1),
 WORK_REQUEST_ID number(18,0),
 WORK_COMPLETE_DT date,
 WR_CREATED_DATE date,
 CANCEL_DT date,
 INSERTED varchar2(1) not null,
 UPDATED varchar(1) not null,
 INSTANCE_START_DT date,
 INSTANCE_END_DT date,
 LAST_EVENT_DATE date not null,
 STG_EXTRACT_DT date not null,
 STG_LAST_UPDATE_DT date not null,
 STG_DONE_DT date, 
 AGE_BUSINESS_DAYS number(18,0),
 AGE_BUSINESS_DAYS_DOC_RCPT_DT number(18,0),
 AGE_CALENDAR_DAYS number(18,0),
 AGE_BUSINESS_HOURS number(18,0),
 JEOPARDY_FLAG varchar2(2),
 SLA_Days number(18,0),
 SLA_Days_Type varchar2(1),
 SLA_Jeopardy_Days number(18,0),
 SLA_Jeopardy_Date date,
 SLA_Target_Days number(18,0),
 DCN_TIMELINESS_STATUS varchar2(32) default 'Timeliness Not Required');

--Primary Key
alter table D_FLHK_DOCUMENTS_CURRENT_V2 add constraint DFDCU_PK primary key (FLHK_DOC_BI_ID);

--Indexes
create index DFDCU_IX1 on D_FLHK_DOCUMENTS_CURRENT_V2 (INSTANCE_START_DT); 
create index DFDCU_IX2 on D_FLHK_DOCUMENTS_CURRENT_V2 (INSTANCE_END_DT); 
create index DFDCU_IX3 on D_FLHK_DOCUMENTS_CURRENT_V2 (DCN); 

CREATE OR REPLACE VIEW D_FLHK_DOCUMENTS_CURRENT_V2_SV
AS SELECT * FROM D_FLHK_DOCUMENTS_CURRENT_V2;

-- D_FLHK_DOCUMENTS_HISTORY 
create sequence SEQ_DFDH_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_FLHK_DOCUMENTS_HISTORY_V2
(DFDH_ID NUMBER NOT NULL,
 BUCKET_START_DATE DATE NOT NULL,
 BUCKET_END_DATE DATE NOT NULL,
 FLHK_DOC_BI_ID NUMBER(18,0) NOT NULL,
 RELEASE_DT DATE NOT NULL,
 INSTANCE_STATUS VARCHAR2(32) NOT NULL,
 INSTANCE_STATUS_DT DATE NOT NULL,
 LAST_EVENT_DATE DATE NOT NULL)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')));

alter table D_FLHK_DOCUMENTS_HISTORY_V2 add constraint DFDH_PK primary key (DFDH_ID);
alter table D_FLHK_DOCUMENTS_HISTORY_V2 add constraint DFDH_FLHK_DOC_BI_ID_FK foreign key (FLHK_DOC_BI_ID) references D_FLHK_DOCUMENTS_CURRENT_V2(FLHK_DOC_BI_ID);

create unique index DFDH_UIX1 on D_FLHK_DOCUMENTS_HISTORY_V2 (FLHK_DOC_BI_ID,LAST_EVENT_DATE); 
create unique index DFDH_UIX2 on D_FLHK_DOCUMENTS_HISTORY_V2 (FLHK_DOC_BI_ID,BUCKET_START_DATE);

create index DFDH_IXL2 on D_FLHK_DOCUMENTS_HISTORY_V2 (BUCKET_START_DATE,BUCKET_END_DATE);
create index DFDH_IXL3 on D_FLHK_DOCUMENTS_HISTORY_V2 (FLHK_DOC_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE);

create or replace view D_FLHK_DOCUMENTS_HISTORY_V2_SV
as
select
  H.DFDH_ID,
  B.D_DATE,
  H.FLHK_DOC_BI_ID,
  H.RELEASE_DT,
  H.INSTANCE_STATUS,
  H.INSTANCE_STATUS_DT,
  case when (D.INSTANCE_COMPLETE_DT is not null and B.D_DATE = TRUNC(D.INSTANCE_COMPLETE_DT)) or (D.CANCEL_DT is not null and B.D_DATE = TRUNC(D.CANCEL_DT)) then 'NA'
     when BPM_COMMON.BUS_DAYS_BETWEEN(D.DCN_CREATE_DT, B.D_DATE) >= D.SLA_JEOPARDY_DAYS then 'Y'
     else 'N' end as JEOPARDY_FLAG
from D_FLHK_DOCUMENTS_HISTORY_V2 H
join D_FLHK_DOCUMENTS_CURRENT_V2 D on (H.FLHK_DOC_BI_ID = D.FLHK_DOC_BI_ID)
join BPM_D_DATES B on (B.D_DATE >= H.BUCKET_START_DATE and B.D_DATE <= H.BUCKET_END_DATE);


--Replace fact view 
Create or replace view F_FLHK_DOCUMENTS_BY_DATE_V2_SV
as
Select 
d.FLHK_DOC_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.DCN_CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.INSTANCE_COMPLETE_DT) OR d.INSTANCE_COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.INSTANCE_COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT
FROM BPM_D_DATES bdd JOIN D_FLHK_DOCUMENTS_CURRENT_V2 d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DT) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DT),sysdate));



