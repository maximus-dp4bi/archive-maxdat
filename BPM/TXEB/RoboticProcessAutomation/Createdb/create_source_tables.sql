declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='NOTE';
    if c = 1 then
       execute immediate 'drop table NOTE cascade constraints';
    end if;
 end;
 /
 

CREATE TABLE NOTE
	(
	  NOTE_ID              NUMBER (18) NOT NULL
	, CREATED_BY           VARCHAR2 (80)
	, CREATED_BY_SEC_GROUP NUMBER (16)
	, CREATED_TS           DATE
	, NOTE_REFID           NUMBER (18)
	, CATEGORY_CD          VARCHAR2 (32)
	, NOTE_TYPE_CD         VARCHAR2 (32)
	, SUBJECT              VARCHAR2 (80)
	, SUBJECT_CANON        VARCHAR2 (80)
	, NOTE_TEXT            VARCHAR2 (4000)
	, UPDATED_BY           VARCHAR2 (80)
	, UPDATE_TS            DATE
	, MUTABLE_IND          NUMBER (1)
	, MISCELLANEOUS_1      VARCHAR2 (64)
	, MISCELLANEOUS_2      VARCHAR2 (64)
	, MISCELLANEOUS_3      VARCHAR2 (64)
	, MISCELLANEOUS_4      VARCHAR2 (64)
	, MISCELLANEOUS_5      VARCHAR2 (64)
	, IS_ACTIVE_IND        NUMBER (1)
	, CASE_ID              NUMBER (18)
	, CLIENT_ID            NUMBER (18)
	, REF_TYPE1            VARCHAR2 (32)
	, REF_ID1              NUMBER (18)
	, REF_TYPE2            VARCHAR2 (32)
	, REF_ID2              NUMBER (18)
	, SOURCE               VARCHAR2 (80),
	CONSTRAINT RPA_PK_NOTE PRIMARY KEY (NOTE_ID)
	);



declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='DOCUMENT';
    if c = 1 then
       execute immediate 'drop table DOCUMENT cascade constraints';
    end if;
 end;
 /
 

CREATE TABLE DOCUMENT
	(
	  DOCUMENT_ID            NUMBER (18) NOT NULL
	, DCN                    VARCHAR2 (256)
	, DOC_TYPE_CD            VARCHAR2 (32)
	, DOC_STATUS_CD          VARCHAR2 (32)
	, DOCUMENT_SET_ID        NUMBER (18)
	, LETTER_REQUEST_ID      NUMBER (18)
	, SCAN_DATE              DATE
	, RELEASE_DATE           DATE
	, LANGUAGE_CD            VARCHAR2 (32)
	, PAGE_COUNT             NUMBER (18)
	, IMAGE_ONLY_IND         NUMBER (1)
	, BATCH_UPLOAD_IND       NUMBER (1)
	, RESCAN_IND             NUMBER (1)
	, RETURN_MAIL_IND        NUMBER (1)
	, RETURN_MAIL_REASON_CD  VARCHAR2 (32)
	, RESCAN_COUNT           NUMBER (18)
	, CREATED_BY             VARCHAR2 (80)
	, CREATE_TS              DATE
	, UPDATED_BY             VARCHAR2 (80)
	, UPDATE_TS              DATE
	, NOTE_REF_ID            VARCHAR2 (32)
	, TRASHED_DOC_IND        NUMBER (1)
	, EXPEDITED_IND          NUMBER (1)
	, RESEARCH_REQUESTED_IND NUMBER (1)
	, DOC_FORM_TYPE          VARCHAR2 (70)
	, ORIG_DOC_TYPE_CD       VARCHAR2 (32)
	, ORIG_DOC_FORM_TYPE     VARCHAR2 (32)
	, LAST_TRASHED_BY        VARCHAR2 (80)
	, LAST_TRASHED_TS        DATE
	, ACCESS_PERMISSION      VARCHAR2 (512)
	, GENERIC_FIELD1_TXT     VARCHAR2 (256)
	, GENERIC_FIELD2_TXT     VARCHAR2 (256)
	, GENERIC_FIELD3_TXT     VARCHAR2 (256)
	, GENERIC_FIELD4_TXT     VARCHAR2 (256)
	, GENERIC_FIELD5_TXT     VARCHAR2 (256)
	, XML_META_DATA          CLOB,
	CONSTRAINT RPA_DOCUMENT_PK PRIMARY KEY (DOCUMENT_ID)
	);


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EVENT';
    if c = 1 then
       execute immediate 'drop table EVENT cascade constraints';
    end if;
 end;
 /


CREATE TABLE EVENT
	(
	  EVENT_ID            NUMBER (18) NOT NULL
	, EVENT_TYPE_CD       VARCHAR2 (32)
	, CONTEXT             VARCHAR2 (1000)
	, COMMENTS            VARCHAR2 (2500)
	, CREATE_TS           DATE
	, CREATED_BY          VARCHAR2 (80)
	, UPDATE_TS           DATE
	, UPDATED_BY          VARCHAR2 (80)
	, REF_TYPE            VARCHAR2 (32)
	, REF_ID              NUMBER (18)
	, EVENT_LEVEL         NUMBER (8)
	, IMAGE_REPO_REF_ID   NUMBER (18)
	, EFFECTIVE_DATE      DATE
	, CASE_ID             NUMBER (18)
	, CLIENT_ID           NUMBER (18)
	, CALL_RECORD_ID      NUMBER (18)
	, TASK_INSTANCE_ID    NUMBER (18)
	, CSCL_ID             NUMBER (18)
	, DISABLED_IND        NUMBER
	, GENERIC_FIELD1_DATE DATE
	, GENERIC_FIELD2_DATE DATE
	, GENERIC_FIELD3_NUM  NUMBER (18)
	, GENERIC_FIELD4_NUM  NUMBER (18)
	, GENERIC_FIELD5_TXT  VARCHAR2 (256)
	, GENERIC_FIELD6_TXT  VARCHAR2 (256)
	, GENERIC_FIELD7_TXT  VARCHAR2 (256)
	, GENERIC_FIELD8_TXT  VARCHAR2 (256)
	, GENERIC_FIELD9_TXT  VARCHAR2 (256)
	, GENERIC_FIELD10_TXT VARCHAR2 (256),
	CONSTRAINT RPA_PK_EVENT PRIMARY KEY (EVENT_ID)
	);


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='ENUM_BIZ_EVENT_TYPE';
    if c = 1 then
       execute immediate 'drop table ENUM_BIZ_EVENT_TYPE cascade constraints';
    end if;
 end;
 /


CREATE TABLE ENUM_BIZ_EVENT_TYPE
	(
	  VALUE                VARCHAR2 (32) NOT NULL
	, DESCRIPTION          VARCHAR2 (256)
	, REPORT_LABEL         VARCHAR2 (64)
	, SCOPE                VARCHAR2 (128)
	, CREATED_BY           VARCHAR2 (80)
	, CREATE_TS            DATE
	, UPDATED_BY           VARCHAR2 (80)
	, UPDATE_TS            DATE
	, ORDER_BY_DEFAULT     NUMBER (10)
	, EFFECTIVE_END_DATE   DATE
	, EFFECTIVE_START_DATE DATE
	, EVENT_LEVEL          NUMBER (8)
	, EVENT_MODULE         VARCHAR2 (32)
	, EVENT_CATEGORY       VARCHAR2 (32)
	, EXCLUDE_ACTION_IND   NUMBER (1) DEFAULT 0
	, EVENT_OBSERVERS      VARCHAR2 (512),
	CONSTRAINT RPA_PK_ENUM_BIZ_EVENT_TYPE PRIMARY KEY (VALUE)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='CALL_RECORD';
    if c = 1 then
       execute immediate 'drop table CALL_RECORD cascade constraints';
    end if;
 end;
 /

CREATE TABLE CALL_RECORD
	(
	  CALL_RECORD_ID              NUMBER (18) NOT NULL
	, CALL_TYPE_CD                VARCHAR2 (64)
	, CALLER_TYPE_CD              VARCHAR2 (64)
	, CALL_TRACKING_NUMBER        VARCHAR2 (32)
	, WORKER_ID                   VARCHAR2 (32)
	, WORKER_USERNAME             VARCHAR2 (32)
	, LANGUAGE_CD                 VARCHAR2 (32)
	, CALL_START_TS               DATE
	, CALL_END_TS                 DATE
	, CALLER_PHONE                VARCHAR2 (16)
	, EXT_TELEPHONY_REF           VARCHAR2 (32)
	, CREATED_BY                  VARCHAR2 (32)
	, CREATE_TS                   DATE
	, UPDATED_BY                  VARCHAR2 (32)
	, UPDATE_TS                   DATE
	, NOTE_REF_ID                 NUMBER (18)
	, CALLER_FIRST_NAME           VARCHAR2 (50)
	, CALLER_FIRST_NAME_CANON     VARCHAR2 (50)
	, CALLER_FIRST_NAME_SOUNDLIKE VARCHAR2 (50)
	, CALLER_LAST_NAME            VARCHAR2 (50)
	, CALLER_LAST_NAME_CANON      VARCHAR2 (50)
	, CALLER_LAST_NAME_SOUNDLIKE  VARCHAR2 (50)
	, CALL_START_NDT              NUMBER (18)
	, CALL_RECORD_FIELD1          VARCHAR2 (80)
	, CALL_RECORD_FIELD2          VARCHAR2 (80)
	, CALL_RECORD_FIELD3          VARCHAR2 (80)
	, CALL_RECORD_FIELD4          VARCHAR2 (80)
	, CALL_RECORD_FIELD5          VARCHAR2 (80)
	, PARENT_CALL_RECORD_ID       NUMBER (18)
	, CALL_RECORD_FIELD1_SUPPORT  VARCHAR2 (256)
	, CALL_RECORD_FIELD2_SUPPORT  VARCHAR2 (256)
	, CALL_RECORD_FIELD3_SUPPORT  VARCHAR2 (256)
	, CALL_RECORD_FIELD4_SUPPORT  VARCHAR2 (256)
	, CALL_RECORD_FIELD5_SUPPORT  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD1  DATE
	, CALL_RECORD_GENERIC_FIELD2  DATE
	, CALL_RECORD_GENERIC_FIELD3  NUMBER (18)
	, CALL_RECORD_GENERIC_FIELD4  NUMBER (18)
	, CALL_RECORD_GENERIC_FIELD5  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD6  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD7  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD8  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD9  VARCHAR2 (256)
	, CALL_RECORD_GENERIC_FIELD10 VARCHAR2 (256)
	, AUTHORIZED_CONTACT_ID       NUMBER (18),
	CONSTRAINT RPA_PK_CALL_RECORD PRIMARY KEY (CALL_RECORD_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='CLIENT_DATA';
    if c = 1 then
       execute immediate 'drop table CLIENT_DATA cascade constraints';
    end if;
 end;
 /

CREATE TABLE CLIENT_DATA
	(
	  CLIENT_DATA_ID          NUMBER (18) NOT NULL
	, FORM_DATA_ID            NUMBER (18)
	, CLIENT_CIN              VARCHAR2 (128)
	, PROGRAM                 VARCHAR2 (32)
	, PREGNANT_MEMBER         VARCHAR2 (15)
	, OBGYN                   VARCHAR2 (128)
	, OTHER_INS               VARCHAR2 (15)
	, OTHER_INS_TYPE          VARCHAR2 (32)
	, INS_NAME                VARCHAR2 (128)
	, INS_GROUP_NUM           VARCHAR2 (32)
	, INS_POLICY_HOLDER_FNAME VARCHAR2 (32)
	, INS_POLICY_HOLDER_LNAME VARCHAR2 (32)
	, INS_POLICY_NUM          VARCHAR2 (128)
	, SHCN                    VARCHAR2 (15)
	, INS_SHCN_EXCEPTION      VARCHAR2 (15)
	, CREATED_BY              VARCHAR2 (80)
	, CREATE_TS               DATE
	, UPDATED_BY              VARCHAR2 (80)
	, UPDATE_TS               DATE,
	CONSTRAINT RPA_PK_CLIENT_DATA PRIMARY KEY (CLIENT_DATA_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='FORM_DATA';
    if c = 1 then
       execute immediate 'drop table FORM_DATA cascade constraints';
    end if;
 end;
 /

CREATE TABLE FORM_DATA
	(
	  FORM_DATA_ID NUMBER (18) NOT NULL
	, DOCUMENT_ID  NUMBER (18)
	, CASE_NUMBER  VARCHAR2 (128)
	, LANG_SPOKEN  VARCHAR2 (32)
	, OTHER_LANG   VARCHAR2 (32)
	, CREATED_BY   VARCHAR2 (80)
	, CREATE_TS    DATE
	, UPDATED_BY   VARCHAR2 (80)
	, UPDATE_TS    DATE,
	CONSTRAINT RPA_PK_FORM_DATA PRIMARY KEY (FORM_DATA_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='PLAN_INFO_DATA';
    if c = 1 then
       execute immediate 'drop table PLAN_INFO_DATA cascade constraints';
    end if;
 end;
 /

CREATE TABLE PLAN_INFO_DATA
	(
	  PLAN_INFO_ID             NUMBER (18) NOT NULL
	, CLIENT_DATA_ID           NUMBER (18)
	, PLAN_INFO_TYPE           VARCHAR2 (128)
	, PLAN_OPT1                VARCHAR2 (64)
	, PLAN_OPT2                VARCHAR2 (64)
	, PCP_OPT1                 VARCHAR2 (64)
	, PCP_OPT2                 VARCHAR2 (64)
	, PCP_PHONE1               VARCHAR2 (32)
	, PCP_PHONE2               VARCHAR2 (32)
	, PLAN_EXCEPTION           VARCHAR2 (128)
	, PCP_EXCEPTION            VARCHAR2 (128)
	, CREATED_BY               VARCHAR2 (80)
	, CREATE_TS                DATE
	, UPDATED_BY               VARCHAR2 (80)
	, UPDATE_TS                DATE
	, TX_CLIENT_ELIG_STATUS_ID NUMBER
	, DECISION_CD              VARCHAR2 (10),
	CONSTRAINT RPA_PK_PLAN_INFO_DATA PRIMARY KEY (PLAN_INFO_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='STEP_INSTANCE';
    if c = 1 then
       execute immediate 'drop table STEP_INSTANCE cascade constraints';
    end if;
 end;
 /


CREATE TABLE STEP_INSTANCE
	(
	  STEP_INSTANCE_ID         NUMBER (18)
	, STATUS                   VARCHAR2 (32)
	, CREATE_TS                DATE
	, COMPLETED_TS             DATE
	, ESCALATED_IND            NUMBER (1)
	, STEP_DUE_TS              DATE
	, FORWARDED_IND            NUMBER (1)
	, ESCALATE_TO              VARCHAR2 (80)
	, FORWARDED_BY             VARCHAR2 (80)
	, OWNER                    VARCHAR2 (80)
	, INPUT_DATA               CLOB
	, OUTPUT_DATA              CLOB
	, LOCKED_ID                NUMBER (18)
	, GROUP_STEP_DEFINITION_ID NUMBER (18)
	, GROUP_ID                 NUMBER (18)
	, TEAM_ID                  NUMBER (18)
	, PROCESS_ID               NUMBER (18)
	, PRIORITY_CD              VARCHAR2 (32)
	, PROCESS_ROUTER_ID        NUMBER (18)
	, PROCESS_INSTANCE_ID      NUMBER (18)
	, CASE_ID                  NUMBER (18)
	, CLIENT_ID                NUMBER (18)
	, REF_ID                   NUMBER (18)
	, REF_TYPE                 VARCHAR2 (64)
	, STEP_DEFINITION_ID       NUMBER (18)
	, CREATED_BY               VARCHAR2 (80)
	, SUSPENDED_TS             DATE
	, COMMENTS                 VARCHAR2 (4000)
	, CREATE_NDT               NUMBER (18)
	, STEP_DUE_NDT             NUMBER (18),
	CONSTRAINT RPA_PK_STEP_INSTANCE PRIMARY KEY (STEP_INSTANCE_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='SYS_TRAN_DOC_SET';
    if c = 1 then
       execute immediate 'drop table SYS_TRAN_DOC_SET cascade constraints';
    end if;
 end;
 /

CREATE TABLE SYS_TRAN_DOC_SET
	(
	  SYS_TRAN_DOC_SET_ID NUMBER (38) NOT NULL
	, SYS_TRA_ID          NUMBER (38)
	, DOCUMENT_SET_ID     NUMBER (18)
	, CREATED_BY          VARCHAR2 (80)
	, CREATE_TS           DATE
	, UPDATED_BY          VARCHAR2 (80)
	, UPDATE_TS           DATE,
	CONSTRAINT RPA_PK_SYS_TRAN_DOC_SET_ID PRIMARY KEY (SYS_TRAN_DOC_SET_ID)
	);

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='SYS_TRANSACTIONS';
    if c = 1 then
       execute immediate 'drop table SYS_TRANSACTIONS cascade constraints';
    end if;
 end;
 /

CREATE TABLE EB.SYS_TRANSACTIONS
	(
	  SYS_TRA_ID          NUMBER (38) NOT NULL
	, EXT_TRAN_DATE       TIMESTAMP
	, SYS_ORG_PRG_INT_ID  NUMBER (38) NOT NULL
	, EXT_TRAN_ID         VARCHAR2 (100)
	, EXT_FAM_ID          VARCHAR2 (38)
	, REF_TRAN_ID         NUMBER (38)
	, CURR_TRA_STA_LKP_ID NUMBER (38)
	, CURR_TRA_STG_LKP_ID NUMBER (38)
	, SYS_TRA_TYP_LKP_ID  NUMBER (38)
	, SYS_AUD_ID          NUMBER (38)
	, CREATED_BY          VARCHAR2 (30) NOT NULL
	, CREATION_DATE       DATE NOT NULL
	, LAST_UPDATED_BY     VARCHAR2 (30) NOT NULL
	, LAST_UPDATE_DATE    DATE NOT NULL
	, STAFF_ASSIGNED_TO   VARCHAR2 (30)
	, RANK                NUMBER (3)
	, EXT_MSG_ID          VARCHAR2 (100)
	, JOB_ID              NUMBER (38)
	, ACTION_NAME         VARCHAR2 (30)
	, COMMENTS            VARCHAR2 (4000)
	, EXT_TRAN_ID_NUM     NUMBER
	, CASE_RANK           NUMBER
	, CLIENT_RANK         NUMBER,
	CONSTRAINT PK_SYS_TRA PRIMARY KEY (SYS_TRA_ID)
	);
