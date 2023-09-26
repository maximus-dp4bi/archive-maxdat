--TX PROCESS LETTERS
create table D_PL_CURRENT
  (
   PL_BI_ID number,
   LETTER_REQUEST_ID number not null,
   CREATE_DATE date not null,
   CREATED_BY varchar2(50),
   REQUEST_DATE date,
   INSTANCE_STATUS varchar2(10) not null,
   LETTER_TYPE varchar2(64),
   PROGRAM varchar2(256),
   CASE_ID  number,
   COUNTY_CODE varchar2(10),
   ZIP_CODE number,
   LANGUAGE varchar2(32),
   REPRINT varchar2(1),
   REQUEST_DRIVER_TYPE varchar2(10),
   REQUEST_DRIVER_TABLE varchar2(32),
   LETTER_STATUS varchar2(256) not null,   
   LETTER_STATUS_DATE date not null,   
   SENT_DATE date,
   PRINT_DATE date,
   MAILED_DATE date,
   RETURN_DATE date,
   RETURN_REASON varchar2(256),
   REJECTION_REASON varchar2(256),
   REQUEST_ERROR_REASON varchar2(4000),
   TRANSMITTED_FILE_NAME varchar2(1000),
   TRANSMITTED_FILE_DATE date,
   LETTER_RESPONSE_FILE_NAME varchar2(1000),
   LETTER_RESPONSE_FILE_DATE  date,
   LAST_UPDATE_DATE  date,
   LAST_UPDATED_BY_NAME varchar2(50),
   NEWBORN_FLAG varchar2(1) ,
   TASK_ID number,
   CANCEL_DATE date,
   CANCEL_BY varchar2(50),
   CANCEL_REASON varchar2(100 byte),
   CANCEL_METHOD varchar2(50 byte),
   COMPLETE_DATE date,
   PROCESS_LTR_REQUEST_START_DATE date,
   PROCESS_LTR_REQUEST_END_DATE date,
   SEND_TO_MAIL_HOUSE_START_DATE date,
   SEND_TO_MAIL_HOUSE_END_DATE  date,
   RECEIVE_CONFIRM_START_DATE date,
   RECEIVE_CONFIRM_END_DATE date,   
   AGE_IN_BUSINESS_DAYS number,
   AGE_IN_CALENDAR_DAYS number,
   TIMELINESS_STATUS varchar2(20),
   JEOPARDY_STATUS varchar2(1),
   SLA_CATEGORY varchar2(32),
   SLA_DAYS varchar2(20),
   SLA_DAYS_TYPE varchar2(1),
   SLA_JEOPARDY_DATE  date,
   SLA_JEOPARDY_DAYS number,
   SLA_TARGET_DAYS  number,
   VALIDATION_FLAG varchar2(1),
   OUTCOME_FLAG varchar2(1),
   WORK_REQUIRED_FLAG varchar2(1),
   PROCESS_LETTERS_FLAG varchar2(1) not null,
   TRANSMIT_FLAG varchar2(1) not null,
   CONFIRMATION_FLAG varchar2(1) not null,   
   SOURCE_COMPLETE_DATE date, 
   NEW_LETTER_REQUEST_ID   NUMBER, 
   RESOLVE_RESP_START_DATE DATE,
   RESOLVE_RESP_END_DATE   DATE,
   RESOLVE_RESP_FLAG       VARCHAR2(1),
   ERROR_COUNT             NUMBER,
   LAST_ERRORED_DATE       DATE,
   LAST_ERROR_FIXED_BY     VARCHAR2(80),
   LETTER_REJECTED_FLAG    VARCHAR2(1),
   CREATED_BY_ID           VARCHAR2(80),
   LAST_UPDATED_BY_ID      VARCHAR2(80),
   CANCEL_BY_ID            VARCHAR2(80),
   EPM_MAIL_DATE_FOR_CASE  DATE,
   LETTER_DEFINITION_ID NUMBER(18,0)
	)
tablespace MAXDAT_DATA parallel;
  
alter table D_PL_CURRENT add constraint DPLCUR_PK primary key (PL_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DPLCUR_UIX1 on D_PL_CURRENT (LETTER_REQUEST_ID) online tablespace MAXDAT_INDX parallel compute statistics;

CREATE INDEX DPLCUR_CASELTR_IX1 ON D_PL_CURRENT(case_id, letter_type,letter_status) online tablespace MAXDAT_INDX parallel compute statistics;

CREATE INDEX   DPLCUR_LTRREQUESTDT_IX1 ON D_PL_CURRENT(REQUEST_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index DPLCUR_LTRCREATEDT_IX2 ON D_PL_CURRENT(CREATE_DATE) TABLESPACE MAXDAT_INDX;

CREATE INDEX DPLCUR_LTRTYPE_IX3 ON D_PL_CURRENT(INSTANCE_STATUS,LETTER_STATUS) TABLESPACE MAXDAT_INDX;

CREATE INDEX DPLCUR_LTRTYPE_IX4 ON D_PL_CURRENT(LETTER_DEFINITION_ID) TABLESPACE MAXDAT_INDX;

create index DPLCUR_LTRSENTDT_IX1 ON D_PL_CURRENT(SENT_DATE) TABLESPACE MAXDAT_INDX;


grant select on D_PL_CURRENT to MAXDAT_READ_ONLY;


create or replace view D_PL_CURRENT_SV as
select PL_BI_ID,
  LETTER_REQUEST_ID,
  CREATE_DATE,
  CREATED_BY,
  REQUEST_DATE,
  INSTANCE_STATUS,
  pl.LETTER_TYPE,
  PROGRAM,
  CASE_ID,
  pl.COUNTY_CODE,
  ZIP_CODE,
  LANGUAGE,
  REPRINT,
  pl.REQUEST_DRIVER_TYPE,
  pl.REQUEST_DRIVER_TABLE,
  LETTER_STATUS,
  LETTER_STATUS_DATE,
  SENT_DATE,
  PRINT_DATE,
  MAILED_DATE,
  RETURN_DATE,
  RETURN_REASON,
  REJECTION_REASON,
  REQUEST_ERROR_REASON,
  TRANSMITTED_FILE_NAME,
  TRANSMITTED_FILE_DATE,
  LETTER_RESPONSE_FILE_NAME,
  LETTER_RESPONSE_FILE_DATE,
  LAST_UPDATE_DATE,
  LAST_UPDATED_BY_NAME,
  NEWBORN_FLAG,
  TASK_ID,
  CANCEL_DATE,
  CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  COMPLETE_DATE,
  PROCESS_LTR_REQUEST_START_DATE,
  PROCESS_LTR_REQUEST_END_DATE,
  SEND_TO_MAIL_HOUSE_START_DATE,
  SEND_TO_MAIL_HOUSE_END_DATE,
  RECEIVE_CONFIRM_START_DATE,
  RECEIVE_CONFIRM_END_DATE,
  AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  JEOPARDY_STATUS,
  SLA_CATEGORY,
  SLA_DAYS,
  SLA_DAYS_TYPE,
  SLA_JEOPARDY_DATE,
  SLA_JEOPARDY_DAYS,
  SLA_TARGET_DAYS,
  VALIDATION_FLAG,
  OUTCOME_FLAG,
  WORK_REQUIRED_FLAG,
  PROCESS_LETTERS_FLAG,
  TRANSMIT_FLAG,
  CONFIRMATION_FLAG,
  SOURCE_COMPLETE_DATE,
  NEW_LETTER_REQUEST_ID,
  RESOLVE_RESP_START_DATE,
  RESOLVE_RESP_END_DATE,
  RESOLVE_RESP_FLAG,
  CREATED_BY_ID,
  LAST_UPDATED_BY_ID,
  CANCEL_BY_ID,
  ERROR_COUNT,
  LAST_ERRORED_DATE,
  LETTER_REJECTED_FLAG,
  LAST_ERROR_FIXED_BY,
  EPM_MAIL_DATE_FOR_CASE,
  pl.LETTER_DEFINITION_ID
from D_PL_CURRENT pl 
with read only;


GRANT select on D_PL_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_PL_COUNTY_SERVICE_AREA_SV
as
SELECT DISTINCT dc.county_code, csda_name,csda_code,managed_care_program 
FROM emrs_d_county dc
 INNER JOIN emrs_d_care_serv_deliv_area da
    ON dc.csdaid = da.csda_code
 INNER JOIN d_letter_definition ld
    ON da.managed_care_program = COALESCE(ld.letter_program,'MEDICAID')
WHERE da.csda_code != 'DENTAL'
with read only;

GRANT select on D_PL_COUNTY_SERVICE_AREA_SV to MAXDAT_READ_ONLY;

create or replace view D_PL_ZIP_SERVICE_AREA_SV 
as
SELECT DISTINCT z.zip_code, z.zip_county, csda_name,csda_code,managed_care_program 
FROM emrs_d_zipcode z
 INNER JOIN emrs_d_county dc
   ON z.zip_county = dc.county_code
 INNER JOIN emrs_d_care_serv_deliv_area da
    ON dc.csdaid = da.csda_code
 INNER JOIN d_letter_definition ld
    ON da.managed_care_program = COALESCE(ld.letter_program,'MEDICAID')
WHERE da.csda_code != 'DENTAL'
with read only;

GRANT select on D_PL_ZIP_SERVICE_AREA_SV to MAXDAT_READ_ONLY;



-----  D_PL_LETTER_STATUS   DPLLS_ID  
create sequence SEQ_DPLLS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PL_LETTER_STATUS
  (DPLLS_ID number not null, 
   LETTER_STATUS varchar2(256))
tablespace MAXDAT_DATA;

alter table D_PL_LETTER_STATUS add constraint DPLLS_PK primary key (DPLLS_ID) using index tablespace MAXDAT_INDX;

create unique index DPLLS_UIX1 on D_PL_LETTER_STATUS (LETTER_STATUS) tablespace MAXDAT_INDX parallel compute statistics;


grant select on D_PI_LETTER_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PL_LETTER_STATUS_SV as
select * from D_PL_LETTER_STATUS
with read only;

insert into D_PL_LETTER_STATUS (DPLLS_ID,LETTER_STATUS) values (SEQ_DPLLS_ID.NEXTVAL,null);
commit;

grant select on D_PL_LETTER_STATUS_SV to MAXDAT_READ_ONLY;


create or replace view D_PL_CLIENT_SUB_SV as
select * 
from CORP_ETL_PROC_LETTERS_CHD
with read only;


grant select on D_PL_CLIENT_SUB_SV to MAXDAT_READ_ONLY;



create sequence SEQ_FPLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_PL_BY_DATE 
  (FPLBD_ID number not null,
   D_DATE date not null,
   BUCKET_START_DATE date not null, 
   BUCKET_END_DATE date not null,
   PL_BI_ID number not null, 
   DPLLS_ID  number not null,
   CREATION_COUNT number,
   INVENTORY_COUNT number,
   COMPLETION_COUNT number,
   LETTER_STATUS_DATE date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_PL_BY_DATE add constraint FPLBD_PK primary key (FPLBD_ID) using index tablespace MAXDAT_INDX;

alter table F_PL_BY_DATE add constraint FPLBD_DPLLS_FK foreign key (DPLLS_ID) references D_PL_LETTER_STATUS(DPLLS_ID);
alter table F_PL_BY_DATE add constraint FPLBD_DPLCUR_FK foreign key (PL_BI_ID) references D_PL_CURRENT(PL_BI_ID);

create unique index FPLBD_UIX1 on F_PL_BY_DATE (PL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FPLBD_UIX2 on F_PL_BY_DATE (PL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FPLBD_IX1 on F_PL_BY_DATE (LETTER_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FPLBD_IXL1 on F_PL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL2 on F_PL_BY_DATE (PL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL3 on F_PL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL4 on F_PL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;


grant select on F_PL_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_PL_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FPLBD_ID,
  BUCKET_START_DATE D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,   
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from F_PL_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,   
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  F_PL_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,   
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_PL_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,   
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from
  BPM_D_DATES bdd,
  F_PL_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;


grant select on F_PL_BY_DATE_SV to MAXDAT_READ_ONLY;


