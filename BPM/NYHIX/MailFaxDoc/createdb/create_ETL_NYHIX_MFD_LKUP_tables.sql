
drop table DOCUMENT_STG;
drop table APP_DOC_DATA_STG;
drop table APP_DOC_DATA_EXT_STG;
drop table DOCUMENT_NOTIFICATION_STG;
drop table DOCUMENT_SET_STG;
drop table DOC_LINK_STG;
drop table APP_DOC_TRACKER_STG;
drop table INCIDENT_HEADER_STG;


--Create all NYHIX MFD STG tables to LKUP Data in MAXDAT

--DOCUMENT_STG
CREATE TABLE DOCUMENT_STG
( DOCUMENT_ID NUMBER(18) NOT NULL,
 DCN VARCHAR2(256) NOT NULL,
 DOC_TYPE_CD VARCHAR2(32),
 DOC_FORM_TYPE VARCHAR2(70),
 DOCUMENT_SET_ID NUMBER(18),
 SCAN_DATE DATE,
 RELEASE_DATE DATE,
 PAGE_COUNT NUMBER(18),
 RESCAN_IND NUMBER(18),
 LANGUAGE_CD VARCHAR2(32),
 RETURN_MAIL_IND NUMBER(1),
 RETURN_MAIL_REASON_CD VARCHAR2(32),
 RESCAN_COUNT NUMBER(18),
 TRASHED_DOC_IND NUMBER(1),
 LAST_TRASHED_TS DATE,  								
 LAST_TRASHED_BY VARCHAR2(80),
 NOTE_REF_ID VARCHAR2(32),
 EXPEDITED_IND NUMBER(1),	
 RESEARCH_REQUESTED_IND NUMBER(1),								
 ORIG_DOC_TYPE_CD VARCHAR2(32),	 							
 ORIG_DOC_FORM_TYPE VARCHAR2(32), 						
 CREATE_TS DATE,
 UPDATE_TS DATE
)TABLESPACE MAXDAT_DATA PARALLEL;

--Create Indexes on Document_STG
alter table DOCUMENT_STG add constraint DCN_PK primary key (DCN) using index tablespace MAXDAT_INDX;
create unique index  NYHIX_MFD_LKUP_IX1 on  DOCUMENT_STG (DOCUMENT_ID)  online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_DOCUMENT_DS on DOCUMENT_STG (DOCUMENT_SET_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_PC on DOCUMENT_STG (PAGE_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_RI on DOCUMENT_STG (RESCAN_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_RMI on DOCUMENT_STG (RETURN_MAIL_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_RC on DOCUMENT_STG (RESCAN_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_TDI on DOCUMENT_STG (TRASHED_DOC_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_EI on DOCUMENT_STG (EXPEDITED_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_RRI on DOCUMENT_STG (RESEARCH_REQUESTED_IND) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_DOCUMENT_SD on DOCUMENT_STG (SCAN_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_RD on DOCUMENT_STG (RELEASE_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_LT on DOCUMENT_STG (LAST_TRASHED_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_CD on DOCUMENT_STG (CREATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_UD on DOCUMENT_STG (UPDATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym DOCUMENT_STG for DOCUMENT_STG;
Grant select on DOCUMENT_STG to MAXDAT_READ_ONLY;

--APP_DOC_DATA_STG

CREATE TABLE APP_DOC_DATA_STG
( APP_DOC_DATA_ID NUMBER(18),
 RECEIVED_DATE DATE,
 ECN VARCHAR2(256),
 DCN VARCHAR2(32),
 DOCUMENT_TYPE_CD VARCHAR2(32),
 CREATE_TS DATE,
 UPDATE_TS DATE,
 DOCUMENT_SET_ID NUMBER(18),
 DOCUMENT_ID NUMBER(18),
 STATUS_CD VARCHAR2(32),
 STATUS_TS DATE, 
 MEDIA_CD VARCHAR2(32),
 DOCUMENT_SUB_TYPE VARCHAR2(32),
 CREATED_BY VARCHAR2(50),
 UPDATED_BY VARCHAR2(50)
)TABLESPACE MAXDAT_DATA PARALLEL;
 
--Create Indexes on APP_DOC_DATA_STG
alter table APP_DOC_DATA_STG add constraint ADDID_PK primary key (APP_DOC_DATA_ID) using index tablespace MAXDAT_INDX;

create index IDX3_APP_DOC_DATA_DS on APP_DOC_DATA_STG(DOCUMENT_SET_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_DI on APP_DOC_DATA_STG(DOCUMENT_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_APP_DOC_DATA_RD on APP_DOC_DATA_STG(RECEIVED_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_CD on APP_DOC_DATA_STG(CREATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_UD on APP_DOC_DATA_STG(UPDATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_SD on APP_DOC_DATA_STG(STATUS_TS) online tablespace MAXDAT_INDX parallel compute statistics;


create or replace public synonym APP_DOC_DATA_STG for APP_DOC_DATA_STG;
Grant select on APP_DOC_DATA_STG to MAXDAT_READ_ONLY;
 

--APP_DOC_DATA_EXT_STG

CREATE TABLE APP_DOC_DATA_EXT_STG
( APP_DOC_DATA_EXT_ID NUMBER(18),
 APP_DOC_DATA_ID NUMBER(18),
 FREE_FORM_TEXT_IND NUMBER(1),
 KOFAX_DCN VARCHAR2(50),
 PREVIOUS_KOFAX_DCN VARCHAR2(256),
 CREATED_BY VARCHAR2(50),
 CREATED_TS DATE,
 UPDATED_BY VARCHAR2(50),
 UPDATED_TS DATE
)TABLESPACE MAXDAT_DATA PARALLEL;

--Create Indexes on APP_DOC_DATA_EXT_STG
alter table APP_DOC_DATA_EXT_STG add constraint ADDEID_PK primary key (APP_DOC_DATA_EXT_ID) using index tablespace MAXDAT_INDX;


create index IDX3_APP_DOC_DATA_EXT_AP on APP_DOC_DATA_EXT_STG(APP_DOC_DATA_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_EXT_FI on APP_DOC_DATA_EXT_STG(FREE_FORM_TEXT_IND) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_APP_DOC_DATA_EXT_CD on APP_DOC_DATA_EXT_STG(CREATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_DATA_EXT_UD on APP_DOC_DATA_EXT_STG(UPDATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;


create or replace public synonym APP_DOC_DATA_EXT_STG for APP_DOC_DATA_EXT_STG;
Grant select on APP_DOC_DATA_EXT_STG to MAXDAT_READ_ONLY;

--DOCUMENT_NOTIFICATION_STG

CREATE TABLE DOCUMENT_NOTIFICATION_STG
(DOCUMENT_NOTIFICATION_ID NUMBER(18),
 DCN VARCHAR2(256),
 DESCRIPTION VARCHAR2(512),
 CREATED_BY VARCHAR2(80),
 CREATED_TS DATE,
 UPDATED_BY VARCHAR2(80),
 UPDATED_TS DATE,
 STATUS VARCHAR2(64),
 PROCESSED_IND NUMBER(1), 
 ACCOUNT_ID NUMBER(18),
 PROCESS_INSTANCE_ID NUMBER(18),
 ERRORS	VARCHAR2(256),
 NOTIFICATION_DATE VARCHAR2(64)
)TABLESPACE MAXDAT_DATA PARALLEL;


--Create Indexes on DOCUMENT_NOTIFICATION_STG
alter table DOCUMENT_NOTIFICATION_STG add constraint DNID_PK primary key (DOCUMENT_NOTIFICATION_ID) using index tablespace MAXDAT_INDX;

create index IDX3_DOCUMENT_NOTIFICATION_PI on DOCUMENT_NOTIFICATION_STG(PROCESSED_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_NOTIFICATION_AI on DOCUMENT_NOTIFICATION_STG(ACCOUNT_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_NOTIFICATION_PII on DOCUMENT_NOTIFICATION_STG(PROCESS_INSTANCE_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_DOCUMENT_NOTIFICATION_CD on DOCUMENT_NOTIFICATION_STG(CREATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_NOTIFICATION_UD on DOCUMENT_NOTIFICATION_STG(UPDATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_NOTIFICATION_ND on DOCUMENT_NOTIFICATION_STG(NOTIFICATION_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_NOTIFICATION_DCN on DOCUMENT_NOTIFICATION_STG(DCN) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym DOCUMENT_NOTIFICATION_STG for DOCUMENT_NOTIFICATION_STG;
Grant select on DOCUMENT_NOTIFICATION_STG to MAXDAT_READ_ONLY;


--DOCUMENT_SET_STG

CREATE TABLE DOCUMENT_SET_STG
(DOCUMENT_SET_ID NUMBER(18),
 ECN VARCHAR2(256),
 DOCUMENT_COUNT NUMBER(18),
 DOC_SOURCE_CD VARCHAR2(32),
 RECEIVED_DATE DATE,
 CREATED_BY VARCHAR2(80),
 CREATE_TS DATE,
 UPDATED_BY VARCHAR2(80),
 UPDATE_TS DATE
)TABLESPACE MAXDAT_DATA PARALLEL;

--Create Indexes on DOCUMENT_SET_STG
alter table DOCUMENT_SET_STG add constraint DSID_PK primary key (DOCUMENT_SET_ID) using index tablespace MAXDAT_INDX;

create index IDX3_DOCUMENT_SET_DC on DOCUMENT_SET_STG(DOCUMENT_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_DOCUMENT_SET_RD on DOCUMENT_SET_STG(RECEIVED_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_SET_CD on DOCUMENT_SET_STG(CREATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOCUMENT_SET_UD on DOCUMENT_SET_STG(UPDATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym DOCUMENT_SET_STG for DOCUMENT_SET_STG;
Grant select on DOCUMENT_SET_STG to MAXDAT_READ_ONLY;

--DOC_LINK_STG

CREATE TABLE DOC_LINK_STG
(DOC_LINK_ID NUMBER(18),
 DOCUMENT_ID NUMBER(18),
 LINK_TYPE_CD VARCHAR2(32),
 AUTO_LINKED_IND NUMBER(1),
 CREATED_BY VARCHAR2(80),
 CREATE_TS DATE,
 UPDATED_BY VARCHAR2(80),
 UPDATE_TS DATE,
 CASE_ID	NUMBER(18),
 CLIENT_ID NUMBER(18),
 LINK_REF_ID NUMBER(18)
)TABLESPACE MAXDAT_DATA PARALLEL;

--Create Indexes on DOC_LINK_STG

alter table DOC_LINK_STG add constraint DLID_PK primary key (DOC_LINK_ID) using index tablespace MAXDAT_INDX;

create index IDX3_DOC_LINK_AL on DOC_LINK_STG(AUTO_LINKED_IND) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOC_LINK_LR on DOC_LINK_STG(LINK_REF_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_DOC_LINK_CD on DOC_LINK_STG(CREATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_DOC_LINK_UD on DOC_LINK_STG(UPDATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;


create or replace public synonym DOC_LINK_STG for DOC_LINK_STG;
Grant select on DOC_LINK_STG to MAXDAT_READ_ONLY;


--APP_DOC_TRACKER_STG

CREATE TABLE APP_DOC_TRACKER_STG
(APP_DOC_TRACKER_ID NUMBER(18),
 DOCUMENT_SET_ID NUMBER(18),
 STATUS_CD VARCHAR2(32),
 STATUS_DATE DATE,
 ECN VARCHAR2(256), 
 MEDIA_CD VARCHAR2(32),
 BATCH_NAME VARCHAR2(256),
 BATCH_ID VARCHAR2(50),
 CREATED_BY VARCHAR2(50),
 CREATED_TS DATE,
 UPDATED_BY VARCHAR2(50),
 UPDATED_TS DATE
)TABLESPACE MAXDAT_DATA PARALLEL;

alter table APP_DOC_TRACKER_STG add constraint ADTID_PK primary key (APP_DOC_TRACKER_ID) using index tablespace MAXDAT_INDX;

create index IDX3_APP_DOC_TRACKER_DS on APP_DOC_TRACKER_STG(DOCUMENT_SET_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create index IDX3_APP_DOC_TRACKER_SD on APP_DOC_TRACKER_STG(STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_TRACKER_CD on APP_DOC_TRACKER_STG(CREATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_APP_DOC_TRACKER_UD on APP_DOC_TRACKER_STG(UPDATED_TS) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym APP_DOC_TRACKER_STG for APP_DOC_TRACKER_STG;
Grant select on APP_DOC_TRACKER_STG to MAXDAT_READ_ONLY;

--INCIDENT_HEADER_STG

CREATE TABLE INCIDENT_HEADER_STG
( INCIDENT_HEADER_ID NUMBER(18),
 UPDATE_TS DATE,
 CREATE_TS DATE
)TABLESPACE MAXDAT_DATA PARALLEL;

alter table INCIDENT_HEADER_STG add constraint IHID_PK primary key (INCIDENT_HEADER_ID) using index tablespace MAXDAT_INDX;

create index IDX3_INCIDENT_HEADER_CD on INCIDENT_HEADER_STG(CREATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX3_INCIDENT_HEADER_UD on INCIDENT_HEADER_STG(UPDATE_TS) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym INCIDENT_HEADER_STG for INCIDENT_HEADER_STG;
Grant select on INCIDENT_HEADER_STG to MAXDAT_READ_ONLY;