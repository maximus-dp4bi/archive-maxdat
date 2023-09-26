DECLARE

DBChangeID VARCHAR2(50) := 'TXEB-17589_1';
ExecutionOrder NUMBER(10,0) := 1;
LODNumber VARCHAR2(20) := '9.0.0';
BuildNumber VARCHAR2(10) := '1';
CreatedBy VARCHAR2(100) := 'Guy Thibodeau';
CreatedDate DATE := sysdate;
DBChangeType VARCHAR2(50) := 'DDL';
FunctionalArea VARCHAR2(50) := 'RoboticProcessAutomation';
TargetSchema VARCHAR2(50) := 'MAXDAT';
ObjectsAffected VARCHAR2(4000) := 'RPA Objects';
Comm VARCHAR2(4000) := 'CREATE NEW TABLES';
Path VARCHAR2(500) := '/Database/schema/maxdat/Objects/dp_txeb_9.0.0_1_rpa1.sql';

Rowcount NUMBER(10,0);
SqlErr VARCHAR2(500);
AlreadyRun   EXCEPTION;
PRAGMA EXCEPTION_INIT (AlreadyRun, -20003);


BEGIN

db_change_pkg.log_db_change_start (DBChangeID,ExecutionOrder,LODNumber,BuildNumber,CreatedBy,CreatedDate,DBChangeType,FunctionalArea,TargetSchema,ObjectsAffected,Comm,Path);       

-- -------------------
-- BEGIN SQL PAYLOAD
-- -------------------

execute immediate 'CREATE TABLE RPA_D_NOTE
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
	)';

execute immediate 'CREATE TABLE RPA_D_DOCUMENT
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
	, GENERIC_FIELD5_TXT     VARCHAR2 (256),
	CONSTRAINT RPA_DOCUMENT_PK PRIMARY KEY (DOCUMENT_ID)
	)';


execute immediate 'CREATE TABLE RPA_D_EVENT
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
	)';

execute immediate 'CREATE TABLE RPA_D_ENUM_BIZ_EVENT_TYPE
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
	)';

execute immediate 'CREATE TABLE RPA_D_CLIENT_DATA
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
	)';

execute immediate 'CREATE TABLE RPA_D_FORM_DATA
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
	)';

execute immediate 'CREATE TABLE RPA_D_PLAN_INFO_DATA
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
	)';

execute immediate 'CREATE TABLE RPA_D_STEP_INSTANCE
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
	)';

execute immediate 'CREATE TABLE RPA_D_HUMAN_TASK_INSTANCE
	(
	  STEP_INSTANCE_ID         NUMBER (18) NOT NULL
	, STATUS                   VARCHAR2 (32) NOT NULL
	, CREATE_TS                DATE
	, ESCALATED_IND            NUMBER (1)
	, STEP_DUE_TS              DATE
	, FORWARDED_IND            NUMBER (1)
	, ESCALATE_TO              VARCHAR2 (80)
	, FORWARDED_BY             VARCHAR2 (80)
	, OWNER                    VARCHAR2 (80)
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
	, COMMENTS                 VARCHAR2 (4000)
	, CREATE_NDT               NUMBER (18) NOT NULL
	, STEP_DUE_NDT             NUMBER (18) NOT NULL
	, HTI_GENERIC_FIELD1_DATE  DATE
	, HTI_GENERIC_FIELD2_DATE  DATE
	, HTI_GENERIC_FIELD3_NUM   NUMBER (18)
	, HTI_GENERIC_FIELD4_NUM   NUMBER (18)
	, HTI_GENERIC_FIELD5_TXT   VARCHAR2 (256)
	, HTI_GENERIC_FIELD6_TXT   VARCHAR2 (256)
	, HTI_GENERIC_FIELD7_TXT   VARCHAR2 (256)
	, HTI_GENERIC_FIELD8_TXT   VARCHAR2 (256)
	, HTI_GENERIC_FIELD9_TXT   VARCHAR2 (256)
	, HTI_GENERIC_FIELD10_TXT  VARCHAR2 (256),
	CONSTRAINT RPA_PK_HUMAN_TASK_INSTANCE PRIMARY KEY (STEP_INSTANCE_ID)
	)';
	
	execute immediate 'grant select on RPA_D_NOTE to maxdat_read_only';
	execute immediate 'grant select on RPA_D_DOCUMENT to maxdat_read_only';
	execute immediate 'grant select on RPA_D_EVENT to maxdat_read_only';
	execute immediate 'grant select on RPA_D_ENUM_BIZ_EVENT_TYPE to maxdat_read_only';
	execute immediate 'grant select on RPA_D_CLIENT_DATA to maxdat_read_only';
	execute immediate 'grant select on RPA_D_FORM_DATA to maxdat_read_only';
	execute immediate 'grant select on RPA_D_PLAN_INFO_DATA to maxdat_read_only';
	execute immediate 'grant select on RPA_D_STEP_INSTANCE to maxdat_read_only';
	execute immediate 'grant select on RPA_D_HUMAN_TASK_INSTANCE to maxdat_read_only';

-- -------------------
-- END SQL PAYLOAD
-- -------------------

Rowcount:= sql%rowcount;

db_change_pkg.log_db_change_end (DBChangeID,Rowcount,'DB Change completed successfully');

EXCEPTION

When AlreadyRun THEN
      DBMS_OUTPUT.PUT_LINE('This was run before');
      
WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(substr(SQLERRM, 1, 500));
      SqlErr:= SUBSTR(SQLERRM(SQLCODE), 1, 400);
      db_change_pkg.log_db_change_end (DBChangeID,Rowcount,'DB Change Execution Failed: ' || SqlErr);
      ROLLBACK;

END;


