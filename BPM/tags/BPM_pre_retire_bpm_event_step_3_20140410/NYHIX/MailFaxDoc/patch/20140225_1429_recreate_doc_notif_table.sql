Drop Table Document_Notification_Stg;

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
Grant Select On Document_Notification_Stg To Maxdat_Read_Only;