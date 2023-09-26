show errors;
 
 ---Create tables
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_ATTENDANCE';
   if c = 1 then
      execute immediate 'drop table SC_ATTENDANCE cascade constraints';
   end if;
end;
/
 
 create table DP_SCORECARD.SC_ATTENDANCE
(
  sc_attendance_id  NUMBER not null,
  staff_id          NUMBER,
  entry_date        DATE,
  sc_all_id         NUMBER,
  absence_type      VARCHAR2(300),
  point_value       NUMBER,
  create_by         VARCHAR2(100),
  create_datetime   DATE,
  balance           NUMBER,
  incentive_balance NUMBER,
  total_balance     NUMBER,
  incentive_flag    VARCHAR2(1),
  LAST_UPDATED_BY   varchar2(100),
  LAST_UPDATED_DATETIME DATE
)  TABLESPACE MAXDAT_DATA;

create index DP_SCORECARD.SCA_STAFF_ID on DP_SCORECARD.SC_ATTENDANCE (STAFF_ID) TABLESPACE MAXDAT_INDX;
alter table DP_SCORECARD.SC_ATTENDANCE
  add primary key (sc_attendance_id);
 
    GRANT select on DP_SCORECARD.SC_ATTENDANCE to MAXDAT_READ_ONLY;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_ATTENDANCE TO MAXDAT_MSTR_TRX_RPT;

 
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_ATTENDANCE_ABSENCE_LKUP';
   if c = 1 then
      execute immediate 'drop table SC_ATTENDANCE_ABSENCE_LKUP cascade constraints';
   end if;
end;
/
   
  
create table DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
(
  sc_all_id       NUMBER not null,
  absence_type    VARCHAR2(300),
  point_value     NUMBER,
  end_date        DATE,
  create_by       VARCHAR2(50),
  create_datetime DATE,
  incentive_flag  VARCHAR2(1)
) TABLESPACE MAXDAT_DATA;

alter table DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
  add primary key (sc_all_id);

    GRANT select on DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP to MAXDAT_READ_ONLY;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP TO MAXDAT_MSTR_TRX_RPT;
  
  
  declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_ATTENDANCE_INITIAL_SCORE';
   if c = 1 then
      execute immediate 'drop table SC_ATTENDANCE_INITIAL_SCORE cascade constraints';
   end if;
end;
/
 
create table DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
(
  staff_id             NUMBER not null,
  attendance_points    NUMBER,
  incentive_points     NUMBER,
  start_date           DATE
) TABLESPACE MAXDAT_DATA;

alter table DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
  add primary key (staff_id);
  
    GRANT select on DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE to MAXDAT_READ_ONLY;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_CORRECTIVE_ACTION_LKUP';
   if c = 1 then
      execute immediate 'drop table SC_CORRECTIVE_ACTION_LKUP cascade constraints';
   end if;
end;
/
 create table DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP
(
  cal_id                 NUMBER not null,
  correction_action_type VARCHAR2(250),
  end_date               DATE,
  create_by              VARCHAR2(50),
  create_datetime        DATE
) TABLESPACE MAXDAT_DATA;

alter table DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP
  add primary key (CAL_ID);

    GRANT select on DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP to MAXDAT_READ_ONLY;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP TO MAXDAT_MSTR_TRX_RPT;

  declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_CORRECTIVE_ACTION';
   if c = 1 then
      execute immediate 'drop table SC_CORRECTIVE_ACTION cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_CORRECTIVE_ACTION
(
  ca_id                   NUMBER not null,
  staff_id                NUMBER,
  ca_entry_date           DATE,
  cal_id                  NUMBER,
  unsatisfactory_behavior VARCHAR2(250),
  comments                VARCHAR2(1000),
  create_by               VARCHAR2(100),
  create_datetime         DATE,
  LAST_UPDATED_BY         varchar2(100),
  LAST_UPDATED_DATETIME   DATE
) TABLESPACE MAXDAT_DATA;

create index DP_SCORECARD.CA_STAFF_ID on DP_SCORECARD.SC_CORRECTIVE_ACTION (STAFF_ID) TABLESPACE MAXDAT_INDX;
alter table DP_SCORECARD.SC_CORRECTIVE_ACTION
  add primary key (ca_id);
  
GRANT select on DP_SCORECARD.SC_CORRECTIVE_ACTION to MAXDAT_READ_ONLY;
GRANT select, insert, update, delete on DP_SCORECARD.SC_CORRECTIVE_ACTION to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_CORRECTIVE_ACTION TO MAXDAT_MSTR_TRX_RPT;

  declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_DISCUSSION_LKUP';
   if c = 1 then
      execute immediate 'drop table SC_DISCUSSION_LKUP cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_DISCUSSION_LKUP
(
  dl_id                 NUMBER not null,
  discussion_topic      VARCHAR2(250),
  end_date              DATE,
  create_by             VARCHAR2(50),
  create_datetime       DATE
) TABLESPACE MAXDAT_DATA;

alter table DP_SCORECARD.SC_DISCUSSION_LKUP
  add primary key (dl_id);

    GRANT select on DP_SCORECARD.SC_DISCUSSION_LKUP to MAXDAT_READ_ONLY;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_DISCUSSION_LKUP to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_DISCUSSION_LKUP TO MAXDAT_MSTR_TRX_RPT;

  declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_PERFORMANCE_TRACKER';
   if c = 1 then
      execute immediate 'drop table SC_PERFORMANCE_TRACKER cascade constraints';
   end if;
end;
/
  
create table DP_SCORECARD.SC_PERFORMANCE_TRACKER
(
  pt_id                   NUMBER not null,
  staff_id                NUMBER,
  pt_entry_date           DATE,
  dl_id                   NUMBER,
  comments                VARCHAR2(1000),
  create_by               VARCHAR2(100),
  create_datetime         DATE,
  LAST_UPDATED_BY         varchar2(100),
  LAST_UPDATED_DATETIME   DATE
) TABLESPACE MAXDAT_DATA;

create index DP_SCORECARD.PT_STAFF_ID on DP_SCORECARD.SC_PERFORMANCE_TRACKER (STAFF_ID) TABLESPACE MAXDAT_INDX;
alter table DP_SCORECARD.SC_PERFORMANCE_TRACKER
  add primary key (pt_id);

GRANT select on DP_SCORECARD.SC_PERFORMANCE_TRACKER to MAXDAT_READ_ONLY;
GRANT select, insert, update, delete on DP_SCORECARD.SC_PERFORMANCE_TRACKER to MAXDAT;
GRANT insert, update, delete ON DP_SCORECARD.SC_PERFORMANCE_TRACKER TO MAXDAT_MSTR_TRX_RPT;


	declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_GOAL_TYPE_LKUP';
   if c = 1 then
      execute immediate 'drop table SC_GOAL_TYPE_LKUP cascade constraints';
   end if;
end;
/

  create table DP_SCORECARD.SC_GOAL_TYPE_LKUP
(
  gtl_id                 NUMBER not null,
  goal_type              VARCHAR2(250),
  end_date               DATE,
  create_by              VARCHAR2(50),
  create_datetime        DATE
) TABLESPACE MAXDAT_DATA;

alter table DP_SCORECARD.SC_GOAL_TYPE_LKUP
  add primary key (GTL_ID);
  
GRANT select on DP_SCORECARD.SC_GOAL_TYPE_LKUP to MAXDAT_READ_ONLY;  
GRANT select, insert, update, delete on DP_SCORECARD.SC_GOAL_TYPE_LKUP to MAXDAT;  
GRANT insert, update, delete ON DP_SCORECARD.SC_GOAL_TYPE_LKUP TO MAXDAT_MSTR_TRX_RPT;

  declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_GOAL';
   if c = 1 then
      execute immediate 'drop table SC_GOAL cascade constraints';
   end if;
end;
/

  create table DP_SCORECARD.SC_GOAL
(
  goal_id                 NUMBER not null,
  staff_id                NUMBER,
  goal_entry_date         DATE,
  gtl_id                  NUMBER,
  goal_description        VARCHAR2(100),
  goal_date               DATE,
  progress_note           VARCHAR2(500),
  create_by               VARCHAR2(100),
  create_datetime         DATE,
  LAST_UPDATED_BY         varchar2(100),
  LAST_UPDATED_DATETIME   DATE
) TABLESPACE MAXDAT_DATA;

create index DP_SCORECARD.SC_GOAL_STAFF_ID on DP_SCORECARD.SC_GOAL (STAFF_ID) TABLESPACE MAXDAT_INDX;
alter table DP_SCORECARD.SC_GOAL
  add primary key (goal_id);

GRANT select on DP_SCORECARD.SC_GOAL to MAXDAT_READ_ONLY;  
GRANT select, insert, update, delete on DP_SCORECARD.SC_GOAL to MAXDAT;  
GRANT insert, update, delete ON DP_SCORECARD.SC_GOAL TO MAXDAT_MSTR_TRX_RPT;
	
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_EXCLUSION';
   if c = 1 then
      execute immediate 'drop table SC_EXCLUSION cascade constraints';
   end if;
end;
/

CREATE TABLE SC_EXCLUSION 
(exclusion_ID number(38,0) NOT NULL
,supervisor_id  NUMBER(38,0) NOT NULL
,agent_id NUMBER(38,0)
,staff_id  NUMBER(38,0)
,exclusion_date  date NOT NULL
,exclusion_flag varchar2(1) 
,exclusion_comment varchar2(400)
,Create_date date NOT NULL
,Create_by number(38,0) Not null
,  CONSTRAINT SC_EXCLUSION_pk primary key
  (
    exclusion_id
  )
enable
)
tablespace MAXDAT_DATA parallel;

alter table sc_exclusion add CONSTRAINT flag_check check (exclusion_flag in ('Y','N'));

grant select on SC_EXCLUSION to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_EXCLUSION to MAXDAT;
GRANT select, insert, update, delete ON SC_EXCLUSION TO MAXDAT_MSTR_TRX_RPT; 

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_LAG_TIME';
   if c = 1 then
      execute immediate 'drop table SC_LAG_TIME cascade constraints';
   end if;
end;
/

CREATE TABLE SC_LAG_TIME 
(lag_date  date NOT NULL
,agent_id number(38,0) not null
,supervisor_id number(38,0) not null
,Tot_Sched_Productive_Time VARCHAR2(50) 
 ,create_by VARCHAR2(100)
 ,create_date DATE
 ,adherence_flag number(1) default null
,CONSTRAINT SC_LAG_TIME_pk primary key
  (
    lag_date
	,agent_id
	,supervisor_id
  )
enable
)
tablespace MAXDAT_DATA ;

grant select on SC_LAG_TIME to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_LAG_TIME to MAXDAT; 
GRANT insert, update, delete ON DP_SCORECARD.SC_LAG_TIME TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SCORECARD_ATTENDANCE_MTHLY';
   if c = 1 then
      execute immediate 'drop table SCORECARD_ATTENDANCE_MTHLY cascade constraints';
   end if;
end;
/

create table scorecard_attendance_mthly
(MANAGER_STAFF_ID	NUMBER(38,0),
MANAGER_NAME	VARCHAR2(100),
SUPERVISOR_STAFF_ID	NUMBER(38,0),
SUPERVISOR_NAME	VARCHAR2(100),
STAFF_STAFF_ID	NUMBER(38,0),
STAFF_STAFF_NAME	VARCHAR2(100),
DATES_MONTH	VARCHAR2(36),
DATES_MONTH_NUM	VARCHAR2(6),
DATES_YEAR	VARCHAR2(41),
BALANCE	NUMBER,
TOTAL_BALANCE	NUMBER,
SC_ATTENDANCE_ID	NUMBER
)
tablespace MAXDAT_DATA parallel;

create index sc_atten_mthly_mang_ndx on scorecard_attendance_mthly (MANAGER_STAFF_ID) TABLESPACE MAXDAT_INDX;
create index sc_atten_mthly_supvr_ndx on scorecard_attendance_mthly (SUPERVISOR_STAFF_ID) TABLESPACE MAXDAT_INDX;
create index sc_atten_mthly_staff_ndx on scorecard_attendance_mthly (STAFF_STAFF_ID) TABLESPACE MAXDAT_INDX;
create index sc_atten_mthly_staff_mnth_ndx on scorecard_attendance_mthly (STAFF_STAFF_ID,DATES_MONTH_NUM) TABLESPACE MAXDAT_INDX;

grant select on scorecard_attendance_mthly to MAXDAT_READ_ONLY;
grant select, insert, update, delete on scorecard_attendance_mthly to MAXDAT;  
GRANT insert, update, delete ON DP_SCORECARD.SC_ATTENDANCE TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SCORECARD_HIERARCHY';
   if c = 1 then
      execute immediate 'drop table SCORECARD_HIERARCHY cascade constraints';
   end if;
end;
/

Create table scorecard_hierarchy
(admin_id number(38,0), 
       sr_director_name varchar2(100),
       sr_director_staff_id number(38,0),
       sr_director_natid varchar2(250),
       director_name varchar2(100),
       director_staff_id number(38,0),
       director_natid varchar2(250),
       sr_manager_name varchar2(100),
       sr_manager_staff_id number(38,0),
       sr_manager_natid varchar2(250),
       manager_name varchar2(100),
       manager_staff_id number(38,0),
       manager_natid varchar2(250),
       supervisor_name varchar2(100),
       supervisor_staff_id number(38,0),
       supervisor_natid varchar2(250),
       staff_staff_id number(38,0),
       staff_staff_name varchar2(100),
       staff_natid varchar2(250),
       hire_date date,
       position varchar2(50),
       office varchar2(50),
       termination_date date
)
tablespace MAXDAT_DATA parallel;

create index sc_heir_sr_dir_staff_ndx on scorecard_hierarchy (sr_director_staff_id) TABLESPACE MAXDAT_INDX;
create index sc_heir_dir_staff_ndx on scorecard_hierarchy (director_staff_id) TABLESPACE MAXDAT_INDX;
create index sc_heir_sr_mang_staff_ndx on scorecard_hierarchy (sr_manager_staff_id) TABLESPACE MAXDAT_INDX;
create index sc_heir_supvr_staff_ndx on scorecard_hierarchy (supervisor_staff_id) TABLESPACE MAXDAT_INDX;
create index sc_heir_staff_staff_ndx on scorecard_hierarchy (staff_staff_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX sc_hier_mang_staff_id_NDX ON scorecard_hierarchy (MANAGER_STAFF_ID ASC) TABLESPACE MAXDAT_INDX; 


grant select on scorecard_hierarchy to MAXDAT_READ_ONLY;  
 grant select, insert, update, delete on scorecard_hierarchy to MAXDAT;  
GRANT insert, update, delete ON DP_SCORECARD.scorecard_hierarchy TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SCORECARD_HIERARCHY_UM';
   if c = 1 then
      execute immediate 'drop table SCORECARD_HIERARCHY_UM cascade constraints';
   end if;
end;
/

CREATE TABLE SCORECARD_HIERARCHY_UM 
(UM_Staff_id NUMBER(38,0)
,UM_Natid VARCHAR2(250)
,UM_Name VARCHAR2(100)
)
TABLESPACE maxdat_data PARALLEL;

GRANT SELECT,INSERT,UPDATE,DELETE  ON scorecard_hierarchy_um TO MAXDAT;
GRANT SELECT ON scorecard_hierarchy_um TO MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_WRAP_UP_ERROR';
   if c = 1 then
      execute immediate 'drop table SC_WRAP_UP_ERROR cascade constraints';
   end if;
end;
/

CREATE TABLE SC_WRAP_UP_ERROR
(WUE_Date		date not null
,Agent_ID		number(38,0) NOT NULL
,Wrap_up_error	number(6,0)
,CREATE_DATE	DATE
,CREATE_BY		VARCHAR2(50)
,  CONSTRAINT SC_WRAP_UP_ERROR_pk primary key
  (
    WUE_Date
	,Agent_ID
  )
enable
)
tablespace MAXDAT_DATA parallel;

grant select on SC_WRAP_UP_ERROR to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_WRAP_UP_ERROR to MAXDAT; 
GRANT insert, update, delete ON DP_SCORECARD.SC_WRAP_UP_ERROR TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_NON_STD_USE';
   if c = 1 then
      execute immediate 'drop table SC_NON_STD_USE cascade constraints';
   end if;
end;
/

CREATE TABLE SC_NON_STD_USE 
(Call_Record_ID VARCHAR(64) NOT NULL
,Customer_count  NUMBER(6,0) 
,Call_Wrap_up_count NUMBER(6,0)
,Call_Date  DATE NOT NULL
,Call_Time  VARCHAR2(8) 
,Employee_ID	VARCHAR2(250) NOT NULL
,CALL_DT	DATE NOT NULL
,CREATE_DATE	DATE
,CREATE_BY		VARCHAR2(250)
,  CONSTRAINT SC_NON_STD_USE_pk primary key
  (
    Call_Record_ID
	,CALL_DT
	,Employee_ID
  )
enable
)
tablespace MAXDAT_DATA parallel;

grant select on SC_NON_STD_USE to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_NON_STD_USE to MAXDAT; 
GRANT insert, update, delete ON DP_SCORECARD.SC_NON_STD_USE TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_AGENT_STAT';
   if c = 1 then
      execute immediate 'drop table SC_AGENT_STAT cascade constraints';
   end if;
end;
/

CREATE TABLE SC_AGENT_STAT 
(AS_Date DATE NOt NULL
,Agent_ID NUMBER(38,0) NOT NULL
,Supervisor_ID NUMBER(38,0)
,Calls_Answered  NUMBER(6,0)
,Short_Calls_Answered NUMBER(6,0)
,Average_Handle_time VARCHAR2(50)
,Tot_Return_to_Queue NUMBER(6,0)
,Tot_Return_to_Queue_TimeOut Number(6,0)
,Tot_Sched_Productive_Time VARCHAR2(50)
,Actual_Productive_Time VARCHAR2(50)
,Talk_Time VARCHAR2(50)
,Wrap_Up_Time VARCHAR2(50)
,Logged_in_Time VARCHAR2(50)
,Not_Ready_Time VARCHAR2(50)
,Break_Time VARCHAR2(50)
,Lunch_Time VARCHAR2(50)
,EXCLUSION_FLAG VARCHAR2(1) default 'N'
,CREATE_DATE	DATE
,CREATE_BY		VARCHAR2(50)
,  CONSTRAINT SC_AGENT_STAT_pk primary key
  (
    AS_Date
	,Agent_ID
  )
enable
)
tablespace MAXDAT_DATA parallel;

grant select on SC_AGENT_STAT to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_AGENT_STAT to MAXDAT; 
GRANT select, insert, update, delete ON SC_AGENT_STAT TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_CC';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_CC cascade constraints';
   end if;
end;
/

  CREATE TABLE DP_SCORECARD.SC_SUMMARY_CC 
   (	STAFF_STAFF_ID NUMBER(38,0), 
	STAFF_STAFF_NAME VARCHAR2(100 BYTE), 
	DATES_MONTH VARCHAR2(36 BYTE), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	DATES_YEAR VARCHAR2(41 BYTE), 
	EXCLUSION_FLAG VARCHAR2(1 BYTE), 
	TOT_CALLS_ANSWERED NUMBER, 
	TOT_SHORT_CALLS_ANSWERED NUMBER, 
	TOT_TOT_RETURN_TO_QUEUE NUMBER, 
	TOT_AVERAGE_HANDLE_TIME NUMBER, 
	TOT_SCHED_PRODUCTIVE_TIME NUMBER, 
	TOT_ACTUAL_PRODUCTIVE_TIME NUMBER, 
	TOT_TALK_TIME NUMBER, 
	TOT_WRAP_UP_TIME NUMBER, 
	TOT_LOGGED_IN_TIME NUMBER, 
	TOT_NOT_READY_TIME NUMBER, 
	TOT_BREAK_TIME NUMBER, 
	TOT_LUNCH_TIME NUMBER, 
	QCS_PERFORMED NUMBER, 
	AVG_QC_SCORE NUMBER, 
	TOT_INCIDENTS_COMPLETED NUMBER, 
	DAYS_INCIDENTS_COMPLETED NUMBER, 
	TOT_DEFECTS_COMPLETED NUMBER, 
	DAYS_DEFECTS_COMPLETED NUMBER, 
	LAG_TIME_TOT_SCHED_PROD_TIME NUMBER, 
	TOT_CALL_RECORDS NUMBER, 
	TOT_CUSTOMER_COUNT NUMBER, 
	TOT_CALL_WRAP_UP_COUNT NUMBER, 
	TOT_WRAP_UP_ERROR NUMBER, 
	DAYS_SHORT_CALLS_GT_10 NUMBER, 
	DAYS_CALLS_ANSWERED NUMBER
   ) 
  TABLESPACE MAXDAT_DATA parallel;

 create index sc_summary_cc_staff_id_ndx on SC_SUMMARY_CC (staff_staff_id) TABLESPACE MAXDAT_INDX;
 
grant select on SC_SUMMARY_CC to MAXDAT_READ_ONLY; 
grant ALTER, DELETE, INDEX, INSERT, UPDATE, SELECT, REFERENCES  on SC_SUMMARY_CC to MAXDAT; 
GRANT select, insert, update, delete ON SC_SUMMARY_CC TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_BO';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_BO cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_SUMMARY_BO
(
  staff_id             NUMBER,
  dates_month_num      VARCHAR2(6),
  dates_year           VARCHAR2(41),
  event_name_sort      NUMBER,
  event_name           VARCHAR2(300),
  event_subname_sort   NUMBER,
  event_subname        VARCHAR2(300),
  metric               number
);

grant select on SC_SUMMARY_BO to MAXDAT_READ_ONLY; 
grant ALTER, DELETE, INDEX, INSERT, UPDATE, SELECT, REFERENCES  on SC_SUMMARY_BO to MAXDAT; 
GRANT select, insert, update, delete ON SC_SUMMARY_BO TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_PRODUCTION_BO';
   if c = 1 then
      execute immediate 'drop table SC_PRODUCTION_BO cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_PRODUCTION_BO
(
  staff_id             NUMBER,
  dates                DATE,
  event_name_sort      NUMBER,
  event_name           VARCHAR2(300),
  event_subname_sort   NUMBER,
  event_subname        VARCHAR2(300),
  metric               number
);

grant select on SC_PRODUCTION_BO to MAXDAT_READ_ONLY; 
grant ALTER, DELETE, INDEX, INSERT, UPDATE, SELECT, REFERENCES  on SC_PRODUCTION_BO to MAXDAT; 
GRANT select, insert, update, delete ON SC_PRODUCTION_BO TO MAXDAT_MSTR_TRX_RPT;

create table DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
(
  supervisor_staff_id          NUMBER(38),
  dates_month                  VARCHAR2(36),
  dates_month_num              VARCHAR2(6),
  dates_year                   VARCHAR2(41),
  exclusion_flag               VARCHAR2(1),
  tot_calls_answered           NUMBER,
  tot_short_calls_answered     NUMBER,
  tot_tot_return_to_queue      NUMBER,
  tot_average_handle_time      NUMBER,
  tot_sched_productive_time    NUMBER,
  tot_actual_productive_time   NUMBER,
  tot_talk_time                NUMBER,
  tot_wrap_up_time             NUMBER,
  tot_logged_in_time           NUMBER,
  tot_not_ready_time           NUMBER,
  tot_break_time               NUMBER,
  tot_lunch_time               NUMBER,
  qcs_performed                NUMBER,
  avg_qc_score                 NUMBER,
  tot_incidents_completed      NUMBER,
  days_incidents_completed     NUMBER,
  tot_defects_completed        NUMBER,
  days_defects_completed       NUMBER,
  lag_time_tot_sched_prod_time NUMBER,
  tot_call_records             NUMBER,
  tot_customer_count           NUMBER,
  tot_call_wrap_up_count       NUMBER,
  tot_wrap_up_error            NUMBER,
  days_short_calls_gt_10       NUMBER,
  days_calls_answered          NUMBER,
  adherence                    NUMBER,
  tot_return_to_queue_timeout  NUMBER,
  avg_attendance_balance       NUMBER,
  avg_attendance_total_balance NUMBER
);

create index DP_SCORECARD.SC_SUMMARY_CC_RU_SUP_ID_NDX on DP_SCORECARD.SC_SUMMARY_CC_ROLLUP (supervisor_staff_id);

GRANT select, insert, update, delete on SC_SUMMARY_CC_ROLLUP to MAXDAT; 

create table DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
(
  office         VARCHAR2(100),
  building       VARCHAR2(100)
);

GRANT select on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT_READ_ONLY;
GRANT select, insert, update, delete on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT;

