
CREATE TABLE SEC_ROLE_STG
(
  CREATED_BY VARCHAR2(80) 
, CREATE_TS DATE 
, DESCRIPTION VARCHAR2(1000) 
, PORTAL VARCHAR2(32) 
, ROLE_NAME VARCHAR2(50) 
, SEC_ROLE_ID NUMBER(18, 0) NOT NULL 
, UPDATED_BY VARCHAR2(80) 
, UPDATE_TS DATE 
, DEPLOYMENT_NAME VARCHAR2(32) 
, ACTIVE_IND NUMBER(1, 0) 
, MAX_TASK_CLAIM_QUEUE_SIZE NUMBER(4, 0) 
, TASK_LIMIT_ENFORCED_AS_ERROR NUMBER(1, 0) 
) 
TABLESPACE MAXDAT_DATA ;

CREATE UNIQUE INDEX UK_SEC_ROLE ON SEC_ROLE_STG (SEC_ROLE_ID ASC) TABLESPACE MAXDAT_INDX ;

CREATE TABLE SEC_USER_STG 
(
  MAX_LOGIN_TRIES NUMBER(16, 0) 
, ALGORITHM VARCHAR2(255) 
, AUTH_SEQUENCE VARCHAR2(20) 
, CREATED_BY VARCHAR2(80) 
, CREATE_TS DATE 
, DESCRIPTION VARCHAR2(1000) 
, END_DATE DATE 
, LAST_LOGIN_TS DATE 
, LOGIN_NAME VARCHAR2(80) 
, PASSWORD_CHANGED_DATE DATE 
, PASSWORD_VALUE VARCHAR2(32) 
, SEC_USER_ID NUMBER(18, 0) NOT NULL 
, LOGIN_FAILURE_COUNT NUMBER(16, 0) 
, START_DATE DATE 
, STATUS VARCHAR2(64) 
, UPDATED_BY VARCHAR2(80) 
, UPDATE_TS DATE 
, INACTIVE_BASE_DATE DATE 
, NOTE_REFID NUMBER(18, 0) 
, STAFF_ID NUMBER(18, 0) 
, DEFAULT_ROLE_ID NUMBER(18, 0) 
, DEPLOYMENT_NAME VARCHAR2(80) 
)  TABLESPACE MAXDAT_DATA ;

CREATE INDEX IDX_SU_LOGIN_NME ON SEC_USER_STG (LOGIN_NAME ASC) TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX UK_SEC_USER ON SEC_USER_STG (SEC_USER_ID ASC) TABLESPACE MAXDAT_INDX; 

CREATE TABLE SEC_USER_ROLE_STG 
(
  SEC_USER_ROLE_ID NUMBER(18, 0) NOT NULL 
, SEC_USER_ID NUMBER(18, 0) 
, SEC_ROLE_ID NUMBER(18, 0) 
, START_DATE DATE 
, END_DATE DATE 
, CREATED_BY VARCHAR2(80) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80) 
, UPDATE_TS DATE 
) TABLESPACE MAXDAT_DATA ;

CREATE UNIQUE INDEX UK_SEC_USER_ROLE ON SEC_USER_ROLE_STG (SEC_USER_ROLE_ID ASC) TABLESPACE MAXDAT_INDX; 

CREATE TABLE GROUP_ROLE_STG
(
  GROUP_ID NUMBER(18, 0) NOT NULL 
, SEC_ROLE_ID NUMBER(18, 0) NOT NULL 
, CREATED_BY VARCHAR2(80) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80) 
, UPDATE_TS DATE ) TABLESPACE MAXDAT_DATA ;

CREATE UNIQUE INDEX XUKGROUP_ROLE ON GROUP_ROLE_STG (GROUP_ID ASC, SEC_ROLE_ID ASC) TABLESPACE MAXDAT_INDX;

CREATE TABLE GROUP_STAFF_STG 
(
  GROUP_STAFF_ID NUMBER(18, 0) NOT NULL 
, GROUP_ID NUMBER(18, 0) 
, STAFF_ID NUMBER(18, 0) 
, START_DATE DATE 
, END_DATE DATE 
, CREATED_BY VARCHAR2(80) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80) 
, UPDATE_TS DATE 
) TABLESPACE MAXDAT_DATA ;

CREATE UNIQUE INDEX XUKGROUP_STAFF ON GROUP_STAFF_STG (GROUP_STAFF_ID) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON SEC_USER_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON SEC_ROLE_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON SEC_USER_ROLE_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON GROUP_ROLE_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON GROUP_STAFF_STG to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_SEC_USER_SV AS
SELECT * FROM SEC_USER_STG
with read only;

CREATE OR REPLACE VIEW D_SEC_ROLE_SV AS
SELECT * FROM SEC_ROLE_STG
with read only;

CREATE OR REPLACE VIEW D_SEC_USER_ROLE_SV AS
SELECT * FROM SEC_USER_ROLE_STG
with read only;

CREATE OR REPLACE VIEW D_GROUP_ROLE_SV AS
SELECT * FROM GROUP_ROLE_STG
with read only;

CREATE OR REPLACE VIEW D_GROUP_STAFF_SV AS
SELECT * FROM GROUP_STAFF_STG
with read only;

CREATE OR REPLACE VIEW D_GROUPS_SV AS
SELECT * FROM GROUPS_STG
with read only;

GRANT SELECT ON D_SEC_USER_SV to MAXDAT_READ_ONLY;
GRANT SELECT ON D_SEC_ROLE_SV to MAXDAT_READ_ONLY;
GRANT SELECT ON D_SEC_USER_ROLE_SV to MAXDAT_READ_ONLY;
GRANT SELECT ON D_GROUP_ROLE_SV to MAXDAT_READ_ONLY;
GRANT SELECT ON D_GROUP_STAFF_SV to MAXDAT_READ_ONLY;
GRANT SELECT ON D_GROUPS_SV to MAXDAT_READ_ONLY;