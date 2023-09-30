--Custom additions to the UAT build
-- dwd 7/16/2014
ALTER TABLE corp_etl_manage_work
add (  parent_task_id         number
     , channel                varchar2(20)
     , instance_status        varchar2(20)
     , instance_start_date    date
     , instance_end_date      date
     , received_date          date
     , assigned_date          date
     , original_creation_date date
     , case_number            varchar2(100)
     );

ALTER TABLE corp_etl_manage_work_tmp
add (  parent_task_id         number
     , channel                varchar2(20)
     , instance_status        varchar2(20)
     , instance_start_date    date
     , instance_end_date      date
     , received_date          date
     , assigned_date          date
     , original_creation_date date
     , case_number            varchar2(100)
     , updated                varchar2(1)
     );

ALTER TABLE d_mw_current
add (  received_date          date
     , assigned_date          date
     , case_number            varchar2(100)
     );

ALTER TABLE f_mw_by_date
add (  received_date          date
     , assigned_date          date
     );


CREATE TABLE CADIR_MAXDAT_STG (
   ID                      NUMBER        NOT NULL ENABLE
 , C_ASSIGNMENT_FROM       NUMBER
 , C_ASSIGNMENT_TO         NUMBER
 , C_CREATED_BY            NUMBER
 , C_CREATED_ON            DATE
 , ASSIGNMENT_ID           NUMBER
 , DATA_OBJECT_KEY         VARCHAR2(10)
 , TRACKING_ID             NUMBER
 , SUBJECT_TYPE            NUMBER
 , SUBJECT_ID              NUMBER
 , ROLE_ID                 NUMBER
 , IS_CURRENT              NUMBER
 , IS_DELEGATE             NUMBER
 , IS_CREATOR              NUMBER
 , ASSIGNMENT_DATE         DATE
 , DESCRIPTION             VARCHAR2(200)
 , STG_EXTRACT_DATE        DATE          DEFAULT SYSDATE
 , STG_LAST_UPDATE_DATE    DATE          DEFAULT SYSDATE
 , PREVIOUS_ASSIGNMENT_ID  NUMBER
 , C_ASSIGNED_DATE         DATE
 , C_RECEIVED_DATE         DATE
 , C_CASE_NUMBER           VARCHAR2(100)
 , C_CLAIM_TYPE0           NUMBER(10)
);

CREATE TABLE CADIR_PERSON_STG (
   PERSON_ID    NUMBER
 , FIRST_NAME   VARCHAR2(50)
 , LAST_NAME    VARCHAR2(50)
 , MIDDLE_NAME  VARCHAR2(50)
 , NAME_TITLE   VARCHAR2(50)
 , NAME_SUFFIX  VARCHAR2(50)
);

CREATE TABLE CADIR_ROLE_STG  (
   ROLE_ID       NUMBER
 , NAME          VARCHAR2(50)
 , DESCRIPTION   VARCHAR2(200)
 , BUSINESS_KEY  VARCHAR2(50)
);

CREATE TABLE CADIR_USER_STG (
   USER_ID                NUMBER
 , LOCKED                 NUMBER
 , USERNAME               VARCHAR2(50)
 , ACC_ENHANCE            NUMBER
 , PERSON_ID              NUMBER
 , DEFAULT_ROLE_ID        NUMBER
 , DEFAULT_PREFERENCE_ID  NUMBER
 , TYPE_OF_USER           NUMBER
 , AUTHENTICATION_TYPE    NUMBER
);

CREATE TABLE CADIR_CLAIM_TYPE_STG
(
ID  NUMBER(19), 
C_ACTIVE  NUMBER(1),
C_DISPLAY_ORDER NUMBER (10),
C_NAME  VARCHAR2(255),
C_CODE VARCHAR2(255));