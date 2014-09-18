-- Patch to UAT for all the small changes that have been made:
-- dwd 7/23
--
-- Adding the control to limit search
INSERT INTO corp_etl_control VALUES (
	 'MW_MAX_PROCESSED_ID'
	,'N'
	,'1'
	,'This is a control to limit how many 2 rows MW looks at to insert'
	,sysdate
	,sysdate);
COMMIT;


-- rebuild the temp table
DROP TABLE CORP_ETL_MANAGE_WORK_TMP;


CREATE TABLE CORP_ETL_MANAGE_WORK_TMP (
     CEMW_ID                 NUMBER
   , ASF_CANCEL_WORK         VARCHAR2(1)
   , ASF_COMPLETE_WORK       VARCHAR2(1)
   , AGE_IN_BUSINESS_DAYS    NUMBER
   , AGE_IN_CALENDAR_DAYS    NUMBER
   , CANCEL_WORK_DATE        DATE
   , CANCEL_WORK_FLAG        VARCHAR2(1)
   , COMPLETE_DATE           DATE
   , COMPLETE_FLAG           VARCHAR2(1)
   , CREATE_DATE             DATE
   , CREATED_BY_NAME         VARCHAR2(100)
   , ESCALATED_FLAG          VARCHAR2(1)
   , ESCALATED_TO_NAME       VARCHAR2(100)
   , FORWARDED_BY_NAME       VARCHAR2(100)
   , FORWARDED_FLAG          VARCHAR2(1)
   , GROUP_NAME              VARCHAR2(100)
   , GROUP_PARENT_NAME       VARCHAR2(100)
   , GROUP_SUPERVISOR_NAME   VARCHAR2(100)
   , JEOPARDY_FLAG           VARCHAR2(1)
   , LAST_UPDATE_BY_NAME     VARCHAR2(100)
   , LAST_UPDATE_DATE        DATE
   , OWNER_NAME              VARCHAR2(100)
   , SLA_DAYS                NUMBER
   , SLA_DAYS_TYPE           VARCHAR2(1)
   , SLA_JEOPARDY_DAYS       NUMBER
   , SLA_TARGET_DAYS         NUMBER
   , SOURCE_REFERENCE_ID     NUMBER
   , SOURCE_REFERENCE_TYPE   VARCHAR2(30)
   , STATUS_AGE_IN_BUS_DAYS  NUMBER
   , STATUS_AGE_IN_CAL_DAYS  NUMBER
   , STATUS_DATE             DATE
   , TASK_ID                 NUMBER
   , TASK_STATUS             VARCHAR2(50)
   , TASK_TYPE               VARCHAR2(100)
   , TEAM_NAME               VARCHAR2(100)
   , TEAM_PARENT_NAME        VARCHAR2(100)
   , TEAM_SUPERVISOR_NAME    VARCHAR2(100)
   , TIMELINESS_STATUS       VARCHAR2(20)
   , UNIT_OF_WORK            VARCHAR2(30)
   , STG_EXTRACT_DATE        DATE
   , STG_LAST_UPDATE_DATE    DATE
   , STAGE_DONE_DATE         DATE
   , DATE_TODAY              DATE
   , CASE_ID                 NUMBER
   , CLIENT_ID               NUMBER
   , CANCEL_METHOD           VARCHAR2(50)
   , CANCEL_REASON           VARCHAR2(256)
   , CANCEL_BY               VARCHAR2(50)
   , TASK_PRIORITY           VARCHAR2(50)
   , PARENT_TASK_ID          NUMBER
   , CHANNEL                 VARCHAR2(20)
   , INSTANCE_STATUS         VARCHAR2(20)
   , INSTANCE_START_DATE     DATE
   , INSTANCE_END_DATE       DATE
   , RECEIVED_DATE           DATE
   , ASSIGNED_DATE           DATE
   , ORIGINAL_CREATION_DATE  DATE
   , CASE_NUMBER             VARCHAR2(100)
   , UPDATED                 VARCHAR2(1)
)
tablespace MAXDAT_DATA;

-- Create/Recreate indexes 
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX1 on  CORP_ETL_MANAGE_WORK_TMP (TASK_ID)  tablespace MAXDAT_INDX;
create unique index  CORP_ETL_MANAGE_WORK_TMP_IX2 on  CORP_ETL_MANAGE_WORK_TMP (CEMW_ID)  tablespace MAXDAT_INDX;
create index IDX_MANAGE_WORK_TMP_CASE_ID          on CORP_ETL_MANAGE_WORK_TMP (case_id)   TABLESPACE MAXDAT_INDX;
create index IDX_MANAGE_WORK_TMP_CLIENT_ID        on CORP_ETL_MANAGE_WORK_TMP (client_id) TABLESPACE MAXDAT_INDX;

grant select on  CORP_ETL_MANAGE_WORK_TMP to MAXDAT_READ_ONLY;

Grant select on CADIR_MAXDAT_STG to MAXDAT_READ_ONLY;

Grant select on CADIR_PERSON_STG to MAXDAT_READ_ONLY;

Grant select on CADIR_ROLE_STG  to MAXDAT_READ_ONLY;

Grant select on CADIR_USER_STG to MAXDAT_READ_ONLY;

CREATE TABLE CADIR_CLAIM_TYPE_STG
(
ID  NUMBER(19), 
C_ACTIVE  NUMBER(1),
C_DISPLAY_ORDER NUMBER (10),
C_NAME  VARCHAR2(255),
C_CODE VARCHAR2(255))
tablespace MAXDAT_DATA;

Grant select on CADIR_CLAIM_TYPE_STG to MAXDAT_READ_ONLY;

CREATE TABLE CADIR_MANAGEWORK_LOGGING (
  START_DATE DATE
, END_DATE   DATE
, MODULE     VARCHAR2(20)
)
TABLESPACE MAXDAT_DATA ;

Grant select on CADIR_MANAGEWORK_LOGGING to MAXDAT_READ_ONLY;

