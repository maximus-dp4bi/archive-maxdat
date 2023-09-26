declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_ATTENDANCE_AUDIT';
   if c = 1 then
      execute immediate 'drop table SC_ATTENDANCE_AUDIT cascade constraints';
   end if;
end;
/
CREATE TABLE DP_SCORECARD.SC_ATTENDANCE_audit
    (
      Record_type           VARCHAR2 (10)
    , Record_action         VARCHAR2 (10)
    , SC_ATTENDANCE_ID      NUMBER NOT NULL
    , STAFF_ID              NUMBER
    , ENTRY_DATE            DATE
    , SC_ALL_ID             NUMBER
    , ABSENCE_TYPE          VARCHAR2 (300)
    , POINT_VALUE           NUMBER
    , CREATE_BY             VARCHAR2 (100)
    , CREATE_DATETIME       DATE
    , BALANCE               NUMBER
    , INCENTIVE_BALANCE     NUMBER
    , TOTAL_BALANCE         NUMBER
    , INCENTIVE_FLAG        VARCHAR2 (1)
    , LAST_UPDATED_BY       VARCHAR2 (100)
    , LAST_UPDATED_DATETIME DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON DP_SCORECARD.SC_ATTENDANCE_AUDIT TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_ATTENDANCE_AUDIT TO MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_CORRECTIVE_ACTION_AUDIT';
   if c = 1 then
      execute immediate 'drop table SC_CORRECTIVE_ACTION_AUDIT cascade constraints';
   end if;
end;
/

CREATE TABLE DP_SCORECARD.SC_CORRECTIVE_ACTION_AUDIT
    (
      Record_type           VARCHAR2 (10)
    , Record_action         VARCHAR2 (10)
    , CA_ID                   NUMBER NOT NULL
    , STAFF_ID                NUMBER
    , CA_ENTRY_DATE           DATE
    , CAL_ID                  NUMBER
    , UNSATISFACTORY_BEHAVIOR VARCHAR2 (250)
    , COMMENTS                VARCHAR2 (1000)
    , CREATE_BY               VARCHAR2 (100)
    , CREATE_DATETIME         DATE
    , LAST_UPDATED_BY         VARCHAR2 (100)
    , LAST_UPDATED_DATETIME   DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON DP_SCORECARD.SC_CORRECTIVE_ACTION_AUDIT TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_CORRECTIVE_ACTION_AUDIT TO MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='DP_SCORECARD.SC_GOAL_AUDIT';
   if c = 1 then
      execute immediate 'drop table DP_SCORECARD.SC_GOAL_AUDIT cascade constraints';
   end if;
end;
/

CREATE TABLE DP_SCORECARD.SC_GOAL_audit
    (
      Record_type           VARCHAR2 (10)
    , Record_action         VARCHAR2 (10)
    , GOAL_ID               NUMBER NOT NULL
    , STAFF_ID              NUMBER
    , GOAL_ENTRY_DATE       DATE
    , GTL_ID                NUMBER
    , GOAL_DESCRIPTION      VARCHAR2 (100)
    , GOAL_DATE             DATE
    , PROGRESS_NOTE         VARCHAR2 (500)
    , CREATE_BY             VARCHAR2 (100)
    , CREATE_DATETIME       DATE
    , LAST_UPDATED_BY       VARCHAR2 (100)
    , LAST_UPDATED_DATETIME DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON DP_SCORECARD.SC_GOAL_AUDIT TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_GOAL_AUDIT TO MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_PERFORMANCE_TRACKER_AUDIT';
   if c = 1 then
      execute immediate 'drop table SC_PERFORMANCE_TRACKER_AUDIT cascade constraints';
   end if;
end;
/

CREATE TABLE DP_SCORECARD.SC_PERFORMANCE_TRACKER_audit
    (
      Record_type           VARCHAR2 (10)
    , Record_action         VARCHAR2 (10)
    , PT_ID                 NUMBER NOT NULL
    , STAFF_ID              NUMBER
    , PT_ENTRY_DATE         DATE
    , DL_ID                 NUMBER
    , COMMENTS              VARCHAR2 (1000)
    , CREATE_BY             VARCHAR2 (100)
    , CREATE_DATETIME       DATE
    , LAST_UPDATED_BY       VARCHAR2 (100)
    , LAST_UPDATED_DATETIME DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON DP_SCORECARD.SC_PERFORMANCE_TRACKER_AUDIT TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_PERFORMANCE_TRACKER_AUDIT TO MAXDAT_READ_ONLY;

