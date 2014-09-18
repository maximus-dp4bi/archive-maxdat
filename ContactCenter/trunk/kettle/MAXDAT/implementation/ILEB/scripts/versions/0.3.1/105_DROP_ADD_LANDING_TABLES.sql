
DROP TABLE CC_S_TMP_AVY_AGENT;
DROP TABLE CC_S_TMP_AVY_AGENTBYAPP;
DROP TABLE CC_S_TMP_AVY_APPLICATION;
DROP TABLE CC_S_TMP_AVY_DAGENTPERFORMANCE;
DROP TABLE CC_S_TMP_AVY_IAPPLICATION;
DROP TABLE CC_S_TMP_PIPKINS_EVENT;
DROP TABLE CC_S_TMP_PIPKINS_OFFICE;
DROP TABLE CC_S_TMP_PIPKINS_STAFF_INFO;
DROP TABLE CC_S_TMP_PIPKINS_STF_TO_OFFICE;
DROP TABLE CC_S_TMP_PIPKINS_SUP_TO_STAFF;
DROP TABLE CC_S_TMP_PIPKINS_TASK;
DROP TABLE CC_S_TMP_PIPKINS_TIMEZONE;
COMMIT;

CREATE TABLE CC_S_TMP_AVY_AGENT
  (
    USER_ID       VARCHAR2 (32 CHAR) NOT NULL ,
    TELSETLOGINID NUMBER (16) ,
    SURNAME       VARCHAR2 (64 CHAR) ,
    GIVENNAME     VARCHAR2 (64 CHAR) ,
    DEPARTMENT    VARCHAR2 (64 CHAR) ,
    TITLE         VARCHAR2 (64 CHAR)
  )
  LOGGING ;
ALTER TABLE CC_S_TMP_AVY_AGENT ADD CONSTRAINT CC_S_TMP_AVY_AGENT_PK PRIMARY KEY
(
  USER_ID
)
;

CREATE TABLE CC_S_TMP_AVY_AGENTBYAPP
  (
                  TIMESTAMP DATE ,
    AGENTLOGIN    VARCHAR2 (16) ,
    APPLICATIONID NUMBER (10) ,
    HOLDTIME      NUMBER (10)
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_AVY_APPLICATION
  (
    APPLICATIONID         NUMBER (10) NOT NULL ,
    NAME                  VARCHAR2 (30 CHAR) ,
    SERVICELEVELTHRESHOLD NUMBER (10) ,
    TEMPLATEID            NUMBER (10)
  )
  LOGGING ;
ALTER TABLE CC_S_TMP_AVY_APPLICATION ADD CONSTRAINT CC_S_TMP_AVY_APPLICATION_PK PRIMARY KEY
(
  APPLICATIONID
)
;

CREATE TABLE CC_S_TMP_AVY_DAGENTPERFORMANCE
  (
                           TIMESTAMP DATE ,
    USERID                 VARCHAR2 (32 CHAR) ,
    AGENTLOGIN             VARCHAR2 (16 CHAR) ,
    SUPERVISORLOGIN        VARCHAR2 (16 CHAR) ,
    ACDCALLSANSWERED       NUMBER (10) ,
    HOLDTIME               NUMBER (10) ,
    LOGGEDINTIME           NUMBER (10) ,
    NOTREADYTIME           NUMBER (10) ,
    RESERVEDTIME           NUMBER (10) ,
    RINGTIME               NUMBER (10) ,
    TALKTIME               NUMBER (10) ,
    WAITINGTIME            NUMBER (10) ,
    POSTCALLPROCESSINGTIME NUMBER (10) ,
    CONTACTTALKTIME        NUMBER (10) ,
    CONTACTHOLDTIME        NUMBER (10) ,
    CALLSANSWERED          NUMBER (10) ,
    SITEID                 NUMBER (10) ,
    SITE                   VARCHAR2 (30 CHAR) ,
    DNINEXTCALLSTALKTIME   NUMBER (10) ,
    DNOUTEXTCALLSTALKTIME  NUMBER (10) ,
    DNININTCALLSTALKTIME   NUMBER (10) ,
    DNOUTINTCALLSTALKTIME  NUMBER (10) ,
    DNINEXTCALLS           NUMBER (10) ,
    DNOUTEXTCALLS          NUMBER (10) ,
    DNININTCALLS           NUMBER (10) ,
    DNOUTINTCALLS          NUMBER (10) ,
    BUSYONDNTIME           NUMBER (10)
  )
  LOGGING ENABLE ROW MOVEMENT ;

CREATE TABLE CC_S_TMP_AVY_IAPPLICATION
  (
                               TIMESTAMP DATE ,
    APPLICATIONID              NUMBER (10) ,
    APPLICATION                VARCHAR2 (30 CHAR) ,
    CALLSABANDONED             NUMBER (10) ,
    CALLSABANDONEDAFTTHRESHOLD NUMBER (10) ,
    CALLSABANDONEDDELAY        NUMBER (10) ,
    CALLSANSWERED              NUMBER (10) ,
    CALLSANSWEREDAFTTHRESHOLD  NUMBER (10) ,
    CALLSANSWEREDDELAY         NUMBER (10) ,
    CALLSGIVENFORCEBUSY        NUMBER (10) ,
    CALLSGIVENFORCEDISCONNECT  NUMBER (10) ,
    CALLSGIVENFORCEOVERFLOW    NUMBER (10) ,
    CALLSOFFERED               NUMBER (10) ,
    CALLSTRANSFERREDIN         NUMBER (10) ,
    CALLSTRANSFERREDOUT        NUMBER (10) ,
    IVRABANDONED               NUMBER (10) ,
    IVRTERMINATED              NUMBER (10) ,
    IVRTRANSFERRED             NUMBER (10) ,
    POSTCALLPROCESSINGTIME     NUMBER (10) ,
    TALKTIME                   NUMBER (10) ,
    WAITTIME                   NUMBER (10) ,
    ANSDELAY2                  NUMBER (10) ,
    ANSDELAY4                  NUMBER (10) ,
    ANSDELAY6                  NUMBER (10) ,
    ANSDELAY8                  NUMBER (10) ,
    ANSDELAY10                 NUMBER (10) ,
    ANSDELAY12                 NUMBER (10) ,
    ANSDELAY14                 NUMBER (10) ,
    ANSDELAY16                 NUMBER (10) ,
    ANSDELAY18                 NUMBER (10) ,
    ANSDELAY20                 NUMBER (10) ,
    ANSDELAY22                 NUMBER (10) ,
    ANSDELAY24                 NUMBER (10) ,
    ANSDELAY26                 NUMBER (10) ,
    ANSDELAY28                 NUMBER (10) ,
    ANSDELAY30                 NUMBER (10) ,
    ANSDELAY32                 NUMBER (10) ,
    ANSDELAY34                 NUMBER (10) ,
    ANSDELAY36                 NUMBER (10) ,
    ANSDELAY38                 NUMBER (10) ,
    ANSDELAY40                 NUMBER (10) ,
    ANSDELAY42                 NUMBER (10) ,
    ANSDELAY44                 NUMBER (10) ,
    ANSDELAY46                 NUMBER (10) ,
    ANSDELAY48                 NUMBER (10) ,
    ANSDELAY50                 NUMBER (10) ,
    ANSDELAY52                 NUMBER (10) ,
    ANSDELAY54                 NUMBER (10) ,
    ANSDELAY56                 NUMBER (10) ,
    ANSDELAY58                 NUMBER (10) ,
    ANSDELAY60                 NUMBER (10) ,
    ANSDELAY70                 NUMBER (10) ,
    ANSDELAY80                 NUMBER (10) ,
    ANSDELAY90                 NUMBER (10) ,
    ANSDELAY100                NUMBER (10) ,
    ANSDELAY110                NUMBER (10) ,
    ANSDELAY120                NUMBER (10) ,
    ANSDELAY130                NUMBER (10) ,
    ANSDELAY140                NUMBER (10) ,
    ANSDELAY150                NUMBER (10) ,
    ANSDELAY160                NUMBER (10) ,
    ANSDELAY170                NUMBER (10) ,
    ANSDELAY180                NUMBER (10) ,
    ANSDELAY190                NUMBER (10) ,
    ANSDELAY200                NUMBER (10) ,
    ANSDELAY210                NUMBER (10) ,
    ANSDELAY220                NUMBER (10) ,
    ANSDELAY230                NUMBER (10) ,
    ANSDELAY240                NUMBER (10) ,
    ANSDELAY250                NUMBER (10) ,
    ANSDELAY260                NUMBER (10) ,
    ANSDELAY270                NUMBER (10) ,
    ANSDELAY280                NUMBER (10) ,
    ANSDELAY290                NUMBER (10) ,
    ANSDELAY300                NUMBER (10) ,
    ANSDELAY360                NUMBER (10) ,
    ANSDELAY420                NUMBER (10) ,
    ANSDELAY480                NUMBER (10) ,
    ANSDELAY540                NUMBER (10) ,
    ANSDELAY600                NUMBER (10) ,
    ANSDELAYBEYOND             NUMBER (10) ,
    ABDDELAY2                  NUMBER (10) ,
    ABDDELAY4                  NUMBER (10) ,
    ABDDELAY6                  NUMBER (10) ,
    ABDDELAY8                  NUMBER (10) ,
    ABDDELAY10                 NUMBER (10) ,
    ABDDELAY12                 NUMBER (10) ,
    ABDDELAY14                 NUMBER (10) ,
    ABDDELAY16                 NUMBER (10) ,
    ABDDELAY18                 NUMBER (10) ,
    ABDDELAY20                 NUMBER (10) ,
    ABDDELAY22                 NUMBER (10) ,
    ABDDELAY24                 NUMBER (10) ,
    ABDDELAY26                 NUMBER (10) ,
    ABDDELAY28                 NUMBER (10) ,
    ABDDELAY30                 NUMBER (10) ,
    ABDDELAY32                 NUMBER (10) ,
    ABDDELAY34                 NUMBER (10) ,
    ABDDELAY36                 NUMBER (10) ,
    ABDDELAY38                 NUMBER (10) ,
    ABDDELAY40                 NUMBER (10) ,
    ABDDELAY42                 NUMBER (10) ,
    ABDDELAY44                 NUMBER (10) ,
    ABDDELAY46                 NUMBER (10) ,
    ABDDELAY48                 NUMBER (10) ,
    ABDDELAY50                 NUMBER (10) ,
    ABDDELAY52                 NUMBER (10) ,
    ABDDELAY54                 NUMBER (10) ,
    ABDDELAY56                 NUMBER (10) ,
    ABDDELAY58                 NUMBER (10) ,
    ABDDELAY60                 NUMBER (10) ,
    ABDDELAY70                 NUMBER (10) ,
    ABDDELAY80                 NUMBER (10) ,
    ABDDELAY90                 NUMBER (10) ,
    ABDDELAY100                NUMBER (10) ,
    ABDDELAY110                NUMBER (10) ,
    ABDDELAY120                NUMBER (10) ,
    ABDDELAY130                NUMBER (10) ,
    ABDDELAY140                NUMBER (10) ,
    ABDDELAY150                NUMBER (10) ,
    ABDDELAY160                NUMBER (10) ,
    ABDDELAY170                NUMBER (10) ,
    ABDDELAY180                NUMBER (10) ,
    ABDDELAY190                NUMBER (10) ,
    ABDDELAY200                NUMBER (10) ,
    ABDDELAY210                NUMBER (10) ,
    ABDDELAY220                NUMBER (10) ,
    ABDDELAY230                NUMBER (10) ,
    ABDDELAY240                NUMBER (10) ,
    ABDDELAY250                NUMBER (10) ,
    ABDDELAY260                NUMBER (10) ,
    ABDDELAY270                NUMBER (10) ,
    ABDDELAY280                NUMBER (10) ,
    ABDDELAY290                NUMBER (10) ,
    ABDDELAY300                NUMBER (10) ,
    ABDDELAY360                NUMBER (10) ,
    ABDDELAY420                NUMBER (10) ,
    ABDDELAY480                NUMBER (10) ,
    ABDDELAY540                NUMBER (10) ,
    ABDDELAY600                NUMBER (10) ,
    ABDDELAYBEYOND             NUMBER (10) ,
    TIME                       VARCHAR2 (5 CHAR) ,
    CONTACTTYPE                VARCHAR2 (30 CHAR) ,
    MAXCALLSANSDELAYATSKILLSET NUMBER (10) ,
    MAXCALLSANSDELAY           NUMBER (10)
  )
  LOGGING ENABLE ROW MOVEMENT ;

CREATE TABLE CC_S_TMP_PIPKINS_EVENT
  (
    EVENT_ID                NUMBER (38) ,
    NAME                    VARCHAR2 (250 BYTE) ,
    EVENT_TYPE_GROUP_ID     NUMBER (38) ,
    EVENT_TYPE_ID           NUMBER (38) ,
    TOLERANCE_FOR_TIMECLOCK DATE ,
    DELETE_DATE             DATE ,
    TOLERANCE_FOR_ADHERING  DATE ,
    DESCRIPTION             VARCHAR2 (250 BYTE) ,
    OWNER_USER              NUMBER (38) ,
    MODIFY_USER             NUMBER (38) ,
    OWNER_DATE              DATE ,
    MODIFY_DATE             DATE ,
    WORK_CLASSIFICATION_ID  NUMBER (38)
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_OFFICE
  (
    OFFICE_ID   NUMBER (10) ,
    LOCALE_ID   NUMBER (10) ,
    TIMEZONE_ID NUMBER (10) ,
    NAME        VARCHAR2 (20) ,
    DESCRIPTION VARCHAR2 (200) ,
    DELETE_DATE DATE ,
    OWNER_USER  NUMBER (10) ,
    MODIFY_USER NUMBER (10) ,
    OWNER_DATE  DATE ,
    MODIFY_DATE DATE
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_STAFF
  (
    STAFF_ID                 NUMBER (38) ,
    STAFF_GROUP_ID           NUMBER (10) ,
    STAFF_GROUP_NAME         VARCHAR2 (50 BYTE) ,
    FIRST_NAME               VARCHAR2 (50 BYTE) ,
    MIDDLE_NAME              VARCHAR2 (50 BYTE) ,
    LAST_NAME                VARCHAR2 (50 BYTE) ,
    SUFFIX                   VARCHAR2 (50 BYTE) ,
    NATIONAL_ID              VARCHAR2 (250 BYTE) ,
    HIRE_DATE                DATE ,
    TERMINATION_DATE         DATE ,
    SCHEDULE_TYPE            NUMBER (38) ,
    DELETE_DATE              DATE ,
    SENIORITY_EFFECTIVE_DATE DATE ,
    OWNER_USER               NUMBER (38) ,
    OWNER_DATE               DATE ,
    MODIFY_USER              NUMBER (38) ,
    MODIFY_DATE              DATE ,
    SECONDARY_ID             VARCHAR2 (250 BYTE) ,
    EMAIL_ADDRESS            VARCHAR2 (250 BYTE) ,
    HOME_PHONE               VARCHAR2 (28 BYTE) ,
    WORK_PHONE               VARCHAR2 (28 BYTE) ,
    CELL_PHONE               VARCHAR2 (28) ,
    ADDRESS                  VARCHAR2 (2000 BYTE) ,
    PIP_ADDRESS              VARCHAR2 (250 BYTE) ,
    TEXT_ADDRESS             VARCHAR2 (250) ,
    TERMINATION_POLICY_ID    NUMBER (38) ,
    TERMINATION_REASON       VARCHAR2 (2000 BYTE) ,
    COMMAND_SCRIPT           VARCHAR2 (4000 BYTE) ,
    MESSAGE_BUFFER           VARCHAR2 (4000 BYTE)
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_STF_TO_OFFICE
  (
    EFFECTIVE_DATE DATE ,
    STAFF_ID       NUMBER (10) ,
    OFFICE_ID      NUMBER (10) ,
    END_DATE       DATE
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_SUP_TO_STAFF
  (
    STAFF_ID       NUMBER (38) ,
    SUPERVISOR     NUMBER (38) ,
    PRIORITY       NUMBER (38) ,
    EFFECTIVE_DATE DATE ,
    END_DATE       DATE ,
    SUPERVISOR_ID  NUMBER (38)
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_TASK
  (
    STAFF_ID                      NUMBER (38) ,
    SCHEDULE_INSTANCE_ID          NUMBER (38) ,
    TASK_START                    DATE ,
    LOCAL_TASK_START              DATE ,
    SCENARIO_GROUP_ID             NUMBER (38) ,
    TASK_END                      DATE ,
    LOCAL_TASK_END                DATE ,
    TASK_CATEGORY_ID              NUMBER (38) ,
    DURATION                      NUMBER (38) ,
    EVENT_ID                      NUMBER (38) ,
    SUPERVISOR                    NUMBER (38) ,
    TASK_EDIT_ID                  NUMBER (38) ,
    EDIT_STATE                    NUMBER (38) ,
    TASK_MODIFICATION_REQUEST_REF NUMBER (38) ,
    ALT_TASK_EDIT_ID              NUMBER (38)
  )
  LOGGING ;

CREATE TABLE CC_S_TMP_PIPKINS_TIMEZONE
  (
    TIMEZONE_ID  NUMBER (10) ,
    STD_NAME     VARCHAR2 (50) ,
    NAME         VARCHAR2 (50) ,
    START_TIME   DATE ,
    DST_OBSERVED NUMBER (10) ,
    STD_OFFSET FLOAT ,
    DST_OFFSET FLOAT ,
    START_MONTH                NUMBER (10) ,
    START_WEEK                 NUMBER (10) ,
    START_WEEK_DAY             NUMBER (10) ,
    END_TIME                   DATE ,
    END_MONTH                  NUMBER (10) ,
    END_WEEK                   NUMBER (10) ,
    END_WEEK_DAY               NUMBER (10) ,
    DST_NAME                   VARCHAR2 (50) ,
    SHIFT_YEAR1                NUMBER (10) ,
    SHIFT_YEAR1_START_TIME     DATE ,
    SHIFT_YEAR1_START_MONTH    NUMBER (10) ,
    SHIFT_YEAR1_START_WEEK     NUMBER (10) ,
    SHIFT_YEAR1_START_WEEK_DAY NUMBER (10) ,
    SHIFT_YEAR1_END_TIME       DATE ,
    SHIFT_YEAR1_END_MONTH      NUMBER (10) ,
    SHIFT_YEAR1_END_WEEK       NUMBER (10) ,
    SHIFT_YEAR1_END_WEEK_DAY   NUMBER (10) ,
    DOTNET_NAME                VARCHAR2 (50) ,
    DISPLAY_FLAG               NUMBER (10)
  )
  LOGGING ;
  
  INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('0.3.1','105','105_DROP_ADD_LANDING_TABLES');
  
  COMMIT;