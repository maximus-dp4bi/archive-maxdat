declare  c int;
begin
   select count(*) into c from user_tables where table_name ='D_MFB_CURRENT';
   if c = 1 then
      execute immediate 'drop table D_MFB_CURRENT cascade constraints';
   end if;
end;
/

create table D_MFB_CURRENT
  (MFB_BI_ID number not null,
   BATCH_GUID VARCHAR2(38) NOT NULL,
   BATCH_ID number not null,
   BATCH_NAME varchar2(255) not null,
   CREATION_STATION_ID varchar2(32) not null,
   BATCH_CREATED_BY varchar2(80),
   CREATION_USER_ID varchar2(50) not null,
   BATCH_CLASS varchar2(32) not null,
   BATCH_CLASS_DESCRIPTION varchar2(80),
   BATCH_TYPE varchar2(38),
   CREATE_DT date not null,
   COMPLETE_DT date,
   INSTANCE_STATUS varchar2(30) not null,
   INSTANCE_STATUS_DT date not null,
   BATCH_PAGE_COUNT number,
   BATCH_DOC_COUNT number,
   BATCH_ENVELOPE_COUNT number,
   CANCEL_DT date,
   CANCEL_BY varchar2(80),
   CANCEL_REASON varchar2(80),
   CANCEL_METHOD varchar2(80),
   SCAN_BATCH_FLAG varchar2(1) default 'N',
   PERFORM_SCAN_START date,
   PERFORM_SCAN_END date,
   PERFORM_SCAN_PERFORMED_BY varchar2(80),
   PERFORM_QC_FLAG varchar2(1) default 'N',
   PERFORM_QC_START date,
   PERFORM_QC_END date,
   PERFORM_QC_PERFORMED_BY varchar2(80),
   KOFAX_QC_REASON varchar2(100),
   CLASSIFICATION_FLAG varchar2(1) default 'N',
   CLASSIFICATION_START date,
   CLASSIFICATION_END date,
   CLASSIFICATION_DT date,
   RECOGNITION_FLAG varchar2(1) default 'N',
   RECOGNITION_START date,
   RECOGNITION_END date,
   RECOGNITION_DT date,
   VALIDATE_DATA_FLAG varchar2(1) default 'N',
   VALIDATE_DATA_START date,
   VALIDATE_DATA_END date,
   VALIDATE_DATA_PERFORMED_BY varchar2(80),
   VALIDATION_DT date,
   CREATE_PDF_FLAG varchar2(1) default 'N',
   CREATE_PDFS_START date,
   CREATE_PDFS_END date,
   POPULATE_REPORTS_DATA_FLAG varchar2(1) default 'N',
   POPULATE_REPORTS_DATA_START date,
   POPULATE_REPORTS_DATA_END date,
   RELEASE_TO_DMS_FLAG varchar2(1) default 'N',
   RELEASE_TO_DMS_START date,
   RELEASE_TO_DMS_END date,
   BATCH_PRIORITY number not null,
   BATCH_DELETED varchar2(1),
   PAGES_SCANNED varchar2(1),
   DOCUMENTS_CREATED varchar2(1),
   DOCUMENTS_DELETED varchar2(1),
   PAGES_REPLACED_FLAG varchar2(1),
   PAGES_DELETED_FLAG varchar2(1),
   AGE_IN_BUSINESS_DAYS number,
   AGE_IN_CALENDAR_DAYS number,
   TIMELINESS_STATUS varchar2(20),
   TIMELINESS_DAYS number,
   TIMELINESS_DAYS_TYPE varchar2(2),
   TIMELINESS_DT date,
   JEOPARDY_FLAG varchar2(3),
   JEOPARDY_DAYS number,
   JEOPARDY_DAYS_TYPE varchar2(2),
   JEOPARDY_DT date,
   TARGET_DAYS number,
   BATCH_COMPLETE_DT date null,
   CURRENT_BATCH_MODULE_ID varchar2(38) null,
   GWF_QC_REQUIRED varchar2(1) null,
   CURRENT_STEP varchar2(100) null)
tablespace MAXDAT_DATA parallel;

alter table D_MFB_CURRENT add constraint DMFBCUR_PK primary key (MFB_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DMFBCUR_UIX1 on D_MFB_CURRENT (BATCH_GUID) online tablespace MAXDAT_INDX parallel compute statistics;
CREATE INDEX DMFBCUR_IX1 ON D_MFB_CURRENT (BATCH_CLASS) online tablespace MAXDAT_INDX parallel compute statistics;
CREATE INDEX DMFBCUR_IX2 ON D_MFB_CURRENT (BATCH_TYPE) online tablespace MAXDAT_INDX parallel compute statistics;
CREATE INDEX DMFBCUR_IX3 ON D_MFB_CURRENT (BATCH_COMPLETE_DT) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_MFB_CURRENT for D_MFB_CURRENT;
grant select on D_MFB_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_MFB_CURRENT_SV as
select * from D_MFB_CURRENT
with read only;

create or replace public synonym D_MFB_CURRENT_SV for D_MFB_CURRENT_SV;
grant select on D_MFB_CURRENT_SV to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_objects where object_name ='SEQ_FMFBBD_ID';
   if c = 1 then
      execute immediate 'drop sequence SEQ_FMFBBD_ID';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from user_objects where object_name ='SEQ_FMFBBH_ID';
   if c = 0 then
      execute immediate 'create sequence SEQ_FMFBBH_ID minvalue 1 maxvalue 999999999999999999999999999 start with 265 increment by 1 cache 20';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='F_MFB_BY_HOUR';
   if c = 1 then
      execute immediate 'drop table F_MFB_BY_HOUR cascade constraints';
   end if;
end;
/

create table F_MFB_BY_HOUR
  (FMFBBH_ID number not null,
	 D_DATE date not null,
	 BUCKET_START_DATE date not null,
	 BUCKET_END_DATE date not null,
	 MFB_BI_ID number not null,
	 CREATION_COUNT number,
	 INVENTORY_COUNT number,
	 COMPLETION_COUNT number)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'hour'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_MFB_BY_HOUR add constraint FMFBBH_PK primary key (FMFBBH_ID) using index tablespace MAXDAT_INDX;

alter table F_MFB_BY_HOUR add constraint FMFBBH_DMFBCUR_FK foreign key (MFB_BI_ID)references D_MFB_CURRENT (MFB_BI_ID);

create unique index FMFBBH_UIX1 on F_MFB_BY_HOUR (MFB_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FMFBBH_UIX2 on F_MFB_BY_HOUR (MFB_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FMFBBH_IXL1 on F_MFB_BY_HOUR (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFBBH_IXL2 on F_MFB_BY_HOUR (MFB_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFBBH_IXL3 on F_MFB_BY_HOUR (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FMFBBH_IXL4 on F_MFB_BY_HOUR (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_MFB_BY_HOUR for F_MFB_BY_HOUR;
grant select on F_MFB_BY_HOUR to MAXDAT_READ_ONLY;

create or replace view F_MFB_BY_HOUR_SV as
-- First hour plus interpolate hours until before the next hour with an update.
select
  FMFBBH_ID,
  BUCKET_START_DATE d_date_hour,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_MFB_BY_HOUR
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First hour (again) and all hours with interpolated hours in-between, except completion hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion hour when not completed on the first hour.
select
  FMFBBH_ID,
  bdh.D_DATE_HOUR,
  MFB_BI_ID, 
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  F_MFB_BY_HOUR,
  BPM_D_DATE_HOUR_SV bdh
where
  bdh.D_DATE_HOUR >= BUCKET_START_DATE
  and bdh.D_DATE_HOUR = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_MFB_BY_HOUR_SV for F_MFB_BY_HOUR_SV;
grant select on F_MFB_BY_HOUR_SV to MAXDAT_READ_ONLY;

create or replace view D_MFFORM_CURRENT_SV as
select 
  BATCH_GUID,
  FORM_TYPE_ENTRY_ID,
  BATCH_MODULE_ID,
  TYPE_NAME,
  DOC_CLASS_NAME,
  DOC_COUNT AS DOCUMENT_COUNT,
  REJECTED_DOCS,
  PAGES,
  REJECTED_PAGES,
  COMPLETED_DOCS,
  COMPLETED_PAGES
from CORP_ETL_MFB_FORM
with read only;

create or replace public synonym D_MFFORM_CURRENT_SV for D_MFFORM_CURRENT_SV;
grant select on D_MFFORM_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_MFENV_CURRENT_SV as
select
  BATCH_GUID,
  ECN,
  ENV_RECEIPT_DATE as ENVELOPE_RECEIPT_DT,
  ENV_CREATION_DATE as ENVELOPE_CREATION_DT,
  ENV_DOC_COUNT as ENVELOPE_DOC_COUNT,
  ENV_PAGE_COUNT as ENVELOPE_PAGE_COUNT
from CORP_ETL_MFB_ENVELOPE
with read only;

create or replace public synonym D_MFENV_CURRENT_SV for D_MFENV_CURRENT_SV;
grant select on D_MFENV_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_MFBDOC_CURRENT_SV as
select
  ECN,
  BATCH_GUID,
  DOC_ID as DOCUMENT_ID,
  DCN,
  DOC_ORDER_NUMBER,
  TYPE_NAME,
  DOC_CLASS as DOCUMENT_CLASS,
  DOC_RECEIPT_DT as DOCUMENT_RECEIPT_DT,
  DOC_CREATION_DT as DOCUMENT_CREATION_DT,
  DOC_PAGE_COUNT as DOCUMENT_PAGE_COUNT,
  CLASSIFIED_DOC as CLASSIFIED_DOCUMENT,
  DELETED,
  CONFIDENCE,
  CONFIDENT
from CORP_ETL_MFB_DOCUMENT
with read only;

create or replace public synonym D_MFBDOC_CURRENT_SV for D_MFBDOC_CURRENT_SV;
grant select on D_MFBDOC_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_MFBBATCH_EVENTS_CURRENT_SV as
select 
  BATCH_MODULE_ID,
  BATCH_GUID,
  MODULE_LAUNCH_ID,
  MODULE_UNIQUE_ID,
  MODULE_NAME,
  MODULE_CLOSE_ID as MODULE_CLOSE_UNIQUE_ID,
  MODULE_CLOSE_NAME,
  BATCH_STATUS,
  MODULE_START_DT,
  MODULE_END_DT,
  USER_NAME as MODULE_LAUNCH_USER_NAME,
  STATION_ID,
  SITE_NAME,
  SITE_ID,
  BATCH_DELETED,
  DOC_PAGES as PAGES_PER_DOCUMENT,
  PAGES_SCANNED,
  PAGES_DELETED,
  DOCS_CREATED as DOCUMENTS_CREATED,
  DOCS_DELETED as DOCUMENTS_DELETED,
  PAGES_REPLACED
from CORP_ETL_MFB_BATCH_EVENTS
with read only;

create or replace public synonym D_MFBBATCH_EVENTS_CURRENT_SV for D_MFBBATCH_EVENTS_CURRENT_SV;
grant select on D_MFBBATCH_EVENTS_CURRENT_SV to MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_MFBBATCH_EVENTS_CURMOD_SV AS 
SELECT c.CURRENT_BATCH_MODULE_ID, 
  c.BATCH_GUID, 
  e.MODULE_LAUNCH_ID, 
  e.MODULE_UNIQUE_ID, 
  e.MODULE_NAME, 
  e.MODULE_CLOSE_ID AS MODULE_CLOSE_UNIQUE_ID, 
  e.MODULE_CLOSE_NAME, 
  e.BATCH_STATUS, 
  e.MODULE_START_DT, 
  e.MODULE_END_DT, 
  e.USER_NAME AS MODULE_LAUNCH_USER_NAME, 
  e.STATION_ID, 
  e.SITE_NAME, 
  e.SITE_ID, 
  e.BATCH_DELETED, 
  e.DOC_PAGES AS PAGES_PER_DOCUMENT, 
  e.PAGES_SCANNED, 
  e.PAGES_DELETED, 
  e.DOCS_CREATED AS DOCUMENTS_CREATED, 
  e.DOCS_DELETED AS DOCUMENTS_DELETED, 
  e.PAGES_REPLACED 
FROM CORP_ETL_MFB_BATCH_EVENTS e, D_MFB_CURRENT c 
WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID 
WITH READ ONLY;

create or replace public synonym D_MFBBATCH_EVENTS_CURMOD_SV for D_MFBBATCH_EVENTS_CURMOD_SV;
grant select on D_MFBBATCH_EVENTS_CURMOD_SV to MAXDAT_READ_ONLY;

