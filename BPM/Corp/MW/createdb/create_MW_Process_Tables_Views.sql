CREATE TABLE PROCESS_STG
    (
      PROCESS_ID       NUMBER (18) NOT NULL
    , NAME             VARCHAR2 (50)
    , DESCRIPTION      VARCHAR2 (4000)
    , VERSION_ID       NUMBER (18)
    , TIME_TO_COMPLETE NUMBER (9)
    , TIME_UNIT_CD     VARCHAR2 (32),
    CONSTRAINT PK_PROCESS_STG PRIMARY KEY (PROCESS_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

CREATE INDEX NDX_PROCESS_NAME
    ON PROCESS_STG (NAME)
    TABLESPACE MAXDAT_INDX;

GRANT SELECT ON PROCESS_STG TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW PROCESS_STG_SV AS
SELECT
    PROCESS_ID
    , NAME
    , DESCRIPTION
    , VERSION_ID
    , TIME_TO_COMPLETE
    , TIME_UNIT_CD
FROM PROCESS_STG
WITH READ ONLY;

GRANT SELECT ON PROCESS_STG_SV TO MAXDAT_READ_ONLY;


CREATE TABLE PROCESS_INSTANCE_STG
    (
      PROCESS_INSTANCE_ID        NUMBER (18) NOT NULL
    , PARENT_PROCESS_INSTANCE_ID NUMBER (18)
    , PROCESS_ID                 NUMBER (18)
    , STATUS                     VARCHAR2 (32)
    , CREATE_TS                  DATE
    , COMPLETED_TS               DATE
    , PROCESS_ROUTER_ID          NUMBER (18)
    , VERSION_ID                 NUMBER (18)
    , PROCESS_DUE_TS             DATE,
    CONSTRAINT PK_PROCESS_INSTANCE PRIMARY KEY (PROCESS_INSTANCE_ID)
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

CREATE INDEX IDX_PROCESS_INST_PARNT_INST_ID
    ON PROCESS_INSTANCE_STG (PARENT_PROCESS_INSTANCE_ID)
    TABLESPACE MAXDAT_INDX;

CREATE INDEX PROCESS_INSTANCE_ROUTE_ID
    ON PROCESS_INSTANCE_STG (PROCESS_ROUTER_ID)
    TABLESPACE MAXDAT_INDX;

CREATE INDEX PROCESS_INSTANCE_PROCESS_ID
    ON PROCESS_INSTANCE_STG (PROCESS_ID)
    TABLESPACE MAXDAT_INDX;

CREATE INDEX PROCESS_INSTANCE_STATUS
    ON PROCESS_INSTANCE_STG (STATUS)
    TABLESPACE MAXDAT_INDX;


GRANT SELECT ON PROCESS_INSTANCE_STG TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW PROCESS_INSTANCE_STG_SV AS
SELECT
    PROCESS_INSTANCE_ID
    , PARENT_PROCESS_INSTANCE_ID
    , PROCESS_ID
    , STATUS
    , CREATE_TS
    , COMPLETED_TS
    , PROCESS_ROUTER_ID
    , VERSION_ID
    , PROCESS_DUE_TS
FROM PROCESS_INSTANCE_STG
WITH READ ONLY;

GRANT SELECT ON PROCESS_INSTANCE_STG_SV TO MAXDAT_READ_ONLY;

CREATE TABLE LETTERS_STG 
(
  LETTER_ID                             NUMBER(18, 0) NOT NULL 
, LETTER_REQUESTED_ON                   DATE 
, LETTER_STATUS_CD                      VARCHAR2(32) 
, LETTER_STATUS                         VARCHAR2(256) 
, LETTER_CREATE_TS                      DATE 
, LETTER_UPDATE_TS                      DATE 
, LETTER_SENT_ON                        DATE 
, PROGRAM_CODE                          VARCHAR2(32) 
, PROGRAM                               VARCHAR2(50) 
, DRIVER_TABLE_NAME                     VARCHAR2(60) 
, LETTER_MAILED_DATE                    DATE 
, LETTER_REJECT_REASON_CD               VARCHAR2(32) 
, LETTER_REJECT_REASON                  VARCHAR2(100) 
, LETTER_PRINTED_ON                     DATE 
, LETTER_ERROR_CODES                    VARCHAR2(4000) 
, RESIDENCE_COUNTY                      VARCHAR2(64) 
, RESIDENCE_ZIP_CODE                    VARCHAR2(32) 
, LETTER_CASE_ID                        NUMBER(18, 0) 
, LETTER_PARENT_LMREQ_ID                NUMBER(18, 0) 
, LETTER_REF_TYPE                       VARCHAR2(40) 
, LETTER_TYPE_CD                        VARCHAR2(40) 
, LETTER_TYPE                           VARCHAR2(100) 
, LETTER_REQUEST_TYPE                   VARCHAR2(2) 
, LETTER_LANG_CD                        VARCHAR2(32) 
, LANGUAGE                              VARCHAR2(20) 
, LETTER_DRIVER_TYPE                    VARCHAR2(4) 
, LET_MATERIAL_REQUEST_ID               NUMBER(18, 0) 
, LETTER_CREATED_BY                     VARCHAR2(80) 
, LETTER_RETURN_REASON_CD               VARCHAR2(32) 
, RETURN_REASON                         VARCHAR2(100) 
, LETTER_UPDATED_BY                     VARCHAR2(80) 
, LETTER_RETURN_DATE                    DATE 
) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX LETTERS_ID_STG_IDX ON LETTERS_STG (LETTER_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTERS_REQUEST_TYPE_STG_IDX ON LETTERS_STG (LETTER_REQUEST_TYPE ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTERS_SENT_ON_STG_IDX ON LETTERS_STG (LETTER_SENT_ON ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTERS_STG_IDX ON LETTERS_STG (LETTER_TYPE_CD ASC, LETTER_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTERS_TYPE_CD_STG_IDX ON LETTERS_STG (LETTER_TYPE_CD ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON LETTERS_STG TO MAXDAT_READ_ONLY;

CREATE TABLE GROUP_STEP_DEFINITION_STG
(	
    GROUP_STEP_DEFINITION_ID                        NUMBER(18,0) NOT NULL ENABLE, 
	EFFECTIVE_START_TS                              DATE, 
	EFFECTIVE_END_TS                                DATE, 
	FORWARDING_RULE_CD                              VARCHAR2(32), 
	ESCALATION_RULE_CD                              VARCHAR2(32), 
	GROUP_ID                                        NUMBER(18,0), 
	STEP_DEFINITION_ID                              NUMBER(18,0), 
	CREATED_BY                                      VARCHAR2(80), 
	CREATE_TS                                       DATE, 
	UPDATED_BY                                      VARCHAR2(80), 
	UPDATE_TS                                       DATE, 
    CONSTRAINT XPKGROUP_STEP_DEFINITION PRIMARY KEY (GROUP_STEP_DEFINITION_ID) ENABLE
) 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON GROUP_STEP_DEFINITION_STG TO MAXDAT_READ_ONLY;

CREATE TABLE GROUP_STEP_DEFN_DEFAULT_STG
(	
    GROUP_STEP_DEFN_DEFAULT_ID                      NUMBER(18,0) NOT NULL ENABLE, 
	EFFECTIVE_START_TS                              DATE, 
	EFFECTIVE_END_TS                                DATE, 
	STEP_DEFINITION_ID                              NUMBER(18,0), 
	GROUP_STEP_DEFINITION_ID                        NUMBER(18,0), 
    CONSTRAINT XPKGROUP_STEP_DEFN_DEFAULT PRIMARY KEY (GROUP_STEP_DEFN_DEFAULT_ID) ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON GROUP_STEP_DEFN_DEFAULT_STG TO MAXDAT_READ_ONLY;

CREATE TABLE GATHER_STATS_TABLE_CONFIG
(
    TABLE_NAME                                      VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	GATHER_STATS_PERIODICALLY                       VARCHAR2(1 BYTE) NOT NULL ENABLE, 
    CONSTRAINT GATHER_STATS_PER_CHECK CHECK (GATHER_STATS_PERIODICALLY in ('Y','N')) ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON GATHER_STATS_TABLE_CONFIG TO MAXDAT_READ_ONLY;

create or replace package MAXDAT_STATISTICS is
/*=================================================================================
||Purpose : This package is to insert and update statistics on MAXDAT tables only.
||          There are 3 calls: 1)A call to do all the tables that are flagged in the lookup,
||          2)A call to do a table on demand to be called from SQL and 3)A call with
||          return values to be called from kettle.
||=================================================================================
|| Revisions:
|| DWD  02/04/2014  Written
|| DWD  02/06/2014  Added a lkup table to flag tables to be done in the All_Stats
|| DWD  02/10/2014  Randy change the name of the table and package
|| DWD  02/12/2014  Added bpm logging and added an "order by" to table_stats so that
||                    if process has to be restarted - will do oldest stat first
|| DWD  02/13/2014  Randy changed the table name again and a column name
||=================================================================================*/

/*
|| Declaring Constants
*/
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
SVN_FILE_URL varchar2(200) := '$URL$';
SVN_REVISION varchar2(20) := '$Revision$';
SVN_REVISION_DATE varchar2(60) := '$Date$';
SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

k_Deg  constant number  := 16;

-- All Tables
procedure All_Stats (p_Degree in number default k_Deg);

-- Single Table
procedure Table_Stats (p_Table in varchar2, p_Degree in number default k_Deg);

-- Kettle Call
procedure Kettle_Stats (p_Table in varchar2, p_Degree in number default null);

-- Create the Scheduler Job
procedure Create_Stats_Job;

-- Start Stats Scheduler Job
procedure Start_Sched;

-- Stopping Stats Scheduler Job
procedure Stop_Sched;

end MAXDAT_STATISTICS;
/
create or replace package body MAXDAT_STATISTICS is

/*
|| All Tables in MAXDAT Schema
*/
procedure All_Stats (
      p_Degree in number default k_Deg
) is
    v_ErrStr  varchar2(4000);

begin
   v_ErrStr := 'These tables did not complete:';

   -- Begin a loop through the tables
   for r_Tname in
      (select L.table_name
       from  gather_stats_table_config L
          ,  all_tables                A
       where L.table_name = A.table_name
         and L.gather_stats_periodically = 'Y'
       order by last_analyzed)
   loop
      begin  --Anon blk 1
         DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => r_Tname.table_name, CASCADE => TRUE,
                                       DEGREE  =>  p_Degree, ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                       METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

      exception
         when others then
            v_ErrStr := v_ErrStr||' '||r_Tname.table_name;
      end;  --Anon blk 1
   end loop;

   -- Insert the run time and any tables that failed into BPM Logging
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.ALL_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.ALL_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end All_Stats;

/*
|| A Single Specified Table in the MAXDAT Schema
*/
procedure Table_Stats (
      p_Table  in varchar2
    , p_Degree in number    default k_Deg
) is
    v_ErrStr  varchar2(4000);

 begin  --Anon blk 1
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => p_Table, CASCADE => TRUE,
                                       DEGREE  =>  p_Degree, ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                       METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

   -- Insert the run time
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.TABLE_STATS',
                     p_log_message => 'Success for table '||p_Table||', Degree '||p_Degree,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.TABLE_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end Table_Stats;

/*
|| A Single Specified Table called by a Kettle Procedure
*/
procedure Kettle_Stats (
      p_Table  in  varchar2
    , p_Degree in number    default null
) is
    v_ErrStr  varchar2(4000);
    v_Degree  number;

begin
   -- Checking for param. Had issues to pass null and use default
   if p_Degree is null then
      v_Degree := 16;
   else
      v_Degree := p_Degree;
   end if;

   DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => p_Table, CASCADE => TRUE, DEGREE  => v_Degree,
       ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE, METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

   -- Insert the run time
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.KETTLE_STATS',
                     p_log_message => 'Success for Kettle table '||p_Table||', using Degree '||p_Degree,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := '(Kettle Call)  '||sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.KETTLE_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end Kettle_Stats;

procedure Create_Stats_Job
is
begin
   dbms_scheduler.create_job(job_name => 'MXDAT_STAT_BTCH_TBLS', job_type => 'STORED_PROCEDURE',
                             job_action => 'maxdat_statistics.all_stats', start_date => sysdate,
                             repeat_interval => 'FREQ=DAILY;byhour=22',
                             enabled => true, auto_drop => false);
end;

procedure Start_Sched
is
begin
   dbms_scheduler.enable('MXDAT_STAT_BTCH_TBLS');
end;

procedure Stop_Sched
is
begin
   dbms_scheduler.disable('MXDAT_STAT_BTCH_TBLS');
end;

end MAXDAT_STATISTICS;
/

CREATE TABLE D_MW_TASK_STATUS
(	
    DMWTS_ID                                                NUMBER, 
	"Task Status"                                           VARCHAR2(50)
) 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX DMWTS_UIX1 ON D_MW_TASK_STATUS ("Task Status" ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX DMWTS_PK ON D_MW_TASK_STATUS (DMWTS_ID ASC) 
TABLESPACE MAXDAT_INDX;


CREATE TABLE D_MW_TASK_TYPE
(	
    DMWTT_ID                                NUMBER, 
	"Group Name"                            VARCHAR2(100), 
	"Group Parent Name"                     VARCHAR2(100), 
	"Group Supervisor Name"                 VARCHAR2(100), 
	"Task Type"                             VARCHAR2(100), 
	"Team Name"                             VARCHAR2(100), 
	"Team Parent Name"                      VARCHAR2(100), 
	"Team Supervisor Name"                  VARCHAR2(100)
) 
TABLESPACE MAXDAT_DATA;

SET DEFINE OFF;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (265,'Enrollment Unit',null,', ','Document Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (266,'Research ES2 Unit',null,', ','Expedite P1 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (267,'Research ES2 Unit',null,', ','Patient Registration Form Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (268,'Case Maintenance ES2 Unit',null,', ','Enrollment Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (269,'Research ES2 Unit',null,', ','Insurance Card Creation Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (270,'Research ES2 Unit',null,', ','Research Task - General',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (271,'Research ES2 Unit',null,', ','Manual Human Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (272,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (273,'Case Maintenance ES2 Unit',null,', ','Renewal - Change Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (274,'Research ES2 Unit',null,', ','Expedite P2 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (275,'Application Processing',null,', ','Manual Human Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (276,'Case Maintenance ES2 Unit',null,', ','Add a Member Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (277,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (278,'Research ES2 Unit',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (279,'Enrollment Unit',null,', ','Manual Enrollment Request-Esc',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (280,'Case Maintenance ES2 Unit',null,', ','MI Received - Transition Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (281,'Call Center',null,'Admin, System','CSR General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (282,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (283,'Case Maintenance ES2 Unit',null,', ','Disenroll  CHP+ - 1 year old ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (284,'Enrollment Unit',null,', ','Manual Enrollment Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (285,'Case Maintenance ES2 Unit',null,', ','MI Received - Non MAXIMUS Case ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (336,'Research ES2 Unit',null,', ','Research Task - General','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (337,'SystemAdmin',null,'Admin, System','Backlog Application Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (341,'Research ES2 Unit',null,', ','State Data Entry','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (345,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (346,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (348,'Appeals Coordinator',null,', ','Medicaid - Dispute Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (352,'Research ES2 Unit',null,', ','Application Problem Resolution','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (353,'Enrollment Unit',null,', ','Process Refund',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (354,'Enrollment Unit',null,', ','Process Refund','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (355,'Research ES2 Unit',null,', ','Research Task - General','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (364,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (373,'Enrollment Unit',null,', ','Process Refund','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (374,'Application Processing',null,', ','State Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (377,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (381,'Case Maintenance ES2 Unit',null,', ','Disenroll  CHP+ - 1 year old ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (386,'SystemAdmin',null,'Admin, System','State Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (391,'Application Processing',null,', ','New App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (392,'Application Processing',null,', ','New App Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (395,'Application Processing',null,', ','Renewal App Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (403,'Application Processing',null,', ','Add a Member Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (404,'Research ES2 Unit',null,', ','Expedite P1 Request Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (408,'Application Processing',null,', ','New App Data Entry','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (409,'Application Processing',null,', ','MI Received via Phone task ','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (411,'Call Center',null,'Admin, System','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (412,'Call Center',null,'Admin, System','General Reminder Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (416,'Application Processing',null,', ','MI Received via Phone task ','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (423,'Call Center',null,'Admin, System','State Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (428,'Call Center',null,'Admin, System','EC Supervisor Complaints',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (429,'Call Center',null,'Admin, System','EC Supervisor Complaints','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (430,'Research ES2 Unit',null,', ','State Data Entry','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (435,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (439,'Application Processing',null,', ','State Data Entry','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (440,'Case Maintenance ES2 Unit',null,', ','State Data Entry','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (441,'Case Maintenance ES2 Unit',null,', ','Good Faith Effort',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (442,'Case Maintenance ES2 Unit',null,', ','Good Faith Effort','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (444,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (446,'Research ES2 Unit',null,', ','State Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (447,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (448,'Research ES2 Unit',null,', ','State Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (449,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (450,'Research ES2 Unit',null,', ','Research Task - General','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (452,'Research ES2 Unit',null,', ','Document Problem Resolution','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (456,'Research ES2 Unit',null,', ','General Reminder Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (457,'Application Processing',null,', ','General Reminder Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (458,'Research ES2 Unit',null,', ','Document Problem Resolution','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (466,'Research ES2 Unit',null,', ','General Reminder Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (467,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (476,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (479,'Appeals Coordinator',null,', ','EC Complaints','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (488,'State Eligibility',null,'Admin, System','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (489,'Appeals Coordinator',null,', ','CHP+ Appeal Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (496,'Application Processing',null,', ','Expedite P1 Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (503,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (504,'Application Processing',null,', ','Missing Info Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (505,'Application Processing',null,', ','Missing Info Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (506,'Application Processing',null,', ','Missing Info Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (301,'Research ES2 Unit',null,', ','Document Problem Resolution','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (302,'HSDE Quality Control',null,', ','HSDE-QC','HSDE QC Team 2','HSDE Quality Control','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (303,'Research ES2 Unit',null,', ','Document Problem Resolution','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (304,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (305,'Application Processing',null,', ','Backlog Application Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (306,'Application Processing',null,', ','MAXIMUS-QC','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (307,'Enrollment Unit',null,', ','Manual Enrollment Request-Esc','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (308,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (309,'Research ES2 Unit',null,', ','Research Task - General','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (310,'Application Processing',null,', ','Link Document Set','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (311,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (312,'Application Processing',null,', ','Backlog Application Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (313,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (314,'Application Processing',null,', ','Backlog Application Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (342,'Appeals Coordinator',null,', ','Medicaid - State Hearing Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (343,'Appeals Coordinator',null,', ','Medicaid - State Hearing Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (344,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (357,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (359,'Appeals Coordinator',null,', ','CHP+ Grievance Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (360,'Appeals Coordinator',null,', ','CHP+ Grievance Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (365,'Enrollment Unit',null,', ','Manual Enrollment Request-Esc','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (378,'Enrollment Unit',null,', ','Process NSF',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (379,'Enrollment Unit',null,', ','Process NSF','Enrollment Fee Team','Enrollment Unit','Law, Steven');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (407,'Research ES2 Unit',null,', ','Research Task - General','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (414,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (419,'Research ES2 Unit',null,', ','Research Task - General','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (420,'Application Processing',null,', ','State Data Entry','CBMS Help Desk Team 1','CBMS Help Desk Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (424,'Call Center',null,'Admin, System','State Data Entry','Call Center Training Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (425,'Appeals Coordinator',null,', ','CHP+ Appeal Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (453,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (454,'Application Processing',null,', ','General Reminder Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (464,'State Eligibility',null,'Admin, System','General Reminder Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (465,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (469,'Research ES2 Unit',null,', ','State Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (509,'Application Processing',null,', ','General Reminder Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (513,'Appeals Coordinator',null,', ','Incident Document Processing',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (514,'Appeals Coordinator',null,', ','Incident Document Processing','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (537,'Application Processing',null,', ','MI Received Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (540,'Application Processing',null,', ','MI Received Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (542,'Application Processing',null,', ','Expedite P1 Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (556,'Application Processing',null,', ','New App Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (557,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (562,'Application Processing',null,', ','Expedite P1 Request Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (566,'Application Processing',null,', ','MI Received - Transition Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (567,'Liaison',null,', ','CHP+ Authorization Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (568,'Liaison',null,', ','CHP+ Authorization Task','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (569,'Application Processing',null,', ','Alternate Document VHT','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (571,'Application Processing',null,', ','Expedite P2 Request Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (573,'Liaison',null,', ','EC Complaints','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (574,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (579,'Mail Room',null,'Admin, System','General Reminder Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (586,'Application Processing',null,', ','Expedite P1 Request Task','QA Team 1','Quality Assurance','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (589,'Mail Room',null,'Admin, System','General Reminder Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (592,'Case Maintenance ES2 Unit',null,', ','Disenroll Medicaid - 19 yr old',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (593,'Case Maintenance ES2 Unit',null,', ','Disenroll Medicaid - 19 yr old','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (594,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (595,'Research ES2 Unit',null,', ','Patient Registration Form Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (597,'Application Processing',null,', ','Renewal App Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (598,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (605,'Application Processing',null,', ','Verify SVES Results','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (610,'Case Maintenance ES2 Unit',null,', ','Initiate RRR - CHP+ 1 year old ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (611,'Case Maintenance ES2 Unit',null,', ','Initiate RRR - CHP+ 1 year old ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (613,'Research ES2 Unit',null,', ','Patient Registration Form Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (614,'Application Processing',null,', ','Expedite P1 Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (615,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (616,'Case Maintenance ES2 Unit',null,', ','Disenrollment request from MCO','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (618,'Application Processing',null,', ','Alternate Document Processing','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (286,'Application Processing',null,', ','MAXIMUS-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (287,'Application Processing',null,', ','Backlog Application Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (288,'HSDE Quality Control',null,', ','HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (289,'Application Processing',null,', ','Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (290,'Application Processing',null,', ','Link Document Set','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (291,'Research ES2 Unit',null,', ','Document Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (292,'Application Processing',null,', ','State Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (293,'Enrollment Unit',null,', ','Process Enrollment Fee',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (294,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (296,'Research ES2 Unit',null,', ','Application Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (298,'Application Processing',null,', ','State Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (338,'Call Center',null,'Admin, System','EC Complaints','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (339,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (340,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (347,'Application Processing',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (349,'Application Processing',null,', ','Backlog Application Data Entry','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (350,'Application Processing',null,', ','Backlog Application Data Entry','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (351,'Application Processing',null,', ','General Reminder Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (358,'Application Processing',null,', ','State Data Entry','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (366,'Application Processing',null,', ','Expedite P1 Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (369,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (370,'Case Maintenance ES2 Unit',null,', ','MI Received - Non MAXIMUS Case ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (375,'Research ES2 Unit',null,', ','State Data Entry','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (376,'Application Processing',null,', ','MAXIMUS-QC','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (388,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (397,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (398,'Case Maintenance ES2 Unit',null,', ','MI Received - Non MAXIMUS Case ','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (400,'Application Processing',null,', ','Add a Member Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (401,'Application Processing',null,', ','Add a Member Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (405,'Research ES2 Unit',null,', ','Document Problem Resolution','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (415,'Call Center',null,'Admin, System','General Reminder Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (417,'Research ES2 Unit',null,', ','Research Task - General','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (418,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (431,'Case Maintenance ES2 Unit',null,', ','MI Received - Transition Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (436,'Application Processing',null,', ','MI Received via Phone task ','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (437,'Appeals Coordinator',null,', ','Appeals Coordinator Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (438,'Appeals Coordinator',null,', ','Appeals Coordinator Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (445,'Case Maintenance ES2 Unit',null,', ','Good Faith Effort','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (451,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (459,'Research ES2 Unit',null,', ','General Reminder Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (468,'Application Processing',null,', ','MI Received via Phone task ','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (471,'Appeals Coordinator',null,', ','Appeals Coordinator ReminderTask',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (472,'Appeals Coordinator',null,', ','Appeals Coordinator ReminderTask','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (473,'Research ES2 Unit',null,', ','General Reminder Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (474,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (486,'Case Maintenance ES2 Unit',null,', ','State Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (490,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (494,'Research ES2 Unit',null,', ','Research Task - General','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (495,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (499,'Case Maintenance ES2 Unit',null,', ','Disenrollment request from MCO',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (500,'Case Maintenance ES2 Unit',null,', ','Disenrollment request from MCO','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (507,'Research ES2 Unit',null,', ','General Reminder Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (512,'Application Processing',null,', ','Renewal App Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (528,'Application Processing',null,', ','Alternate Document VHT',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (529,'Application Processing',null,', ','MI Received Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (530,'Application Processing',null,', ','MI Received Task','Application Processing Team 2','Application Processing','Law, Steven');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (534,'Application Processing',null,', ','MI Received Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (538,'Call Center',null,'Admin, System','General Reminder Task','Call Center Training Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (541,'Research ES2 Unit',null,', ','General Reminder Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (543,'Call Center',null,'Admin, System','General Reminder Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (544,'Application Processing',null,', ','Expedite P2 Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (547,'Appeals Coordinator',null,', ','ES 2 Complaints',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (548,'Appeals Coordinator',null,', ','ES 2 Complaints','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (553,'Application Processing',null,', ','Expedite P3 Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (555,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (563,'Enrollment Unit',null,', ','Manual Enrollment Expedite',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (564,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (572,'Enrollment Unit',null,', ','Process Enrollment Fee','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (575,'Application Processing',null,', ','PEAK Change Report',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (576,'Application Processing',null,', ','PEAK Change Report','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (577,'Enrollment Unit',null,', ','Fee - Research',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (578,'Enrollment Unit',null,', ','Fee - Research','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (580,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (581,'Enrollment Unit',null,', ','Process Enrollment Fee - Lockbox',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (295,'Application Processing',null,', ','State Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (297,'Appeals Coordinator',null,', ','CHP+ Appeal Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (299,'Appeals Coordinator',null,', ','Medicaid - Dispute Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (300,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (315,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (316,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (317,'Application Processing',null,', ','MAXIMUS-QC','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (318,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (319,'Research ES2 Unit',null,', ','Application Problem Resolution','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (320,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (321,'SystemAdmin',null,'Admin, System','State Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (324,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (325,'SystemAdmin',null,'Admin, System','MAXIMUS-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (326,'SystemAdmin',null,'Admin, System','Backlog Application Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (327,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (330,'Enrollment Unit',null,', ','Process Enrollment Fee','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (331,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (361,'Appeals Coordinator',null,', ','Continuation of Benefits Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (362,'Appeals Coordinator',null,', ','Continuation of Benefits Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (363,'Application Processing',null,', ','Expedite P1 Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (367,'SystemAdmin',null,'Admin, System','State Data Entry','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (371,'Application Processing',null,', ','State Data Entry','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (387,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (394,'Application Processing',null,', ','State Data Entry','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (399,'Research ES2 Unit',null,', ','State Data Entry','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (402,'Case Maintenance ES2 Unit',null,', ','MI Received - Transition Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (406,'Application Processing',null,', ','Add a Member Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (422,'Application Processing',null,', ','MI Received via Phone task ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (434,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (460,'Research ES2 Unit',null,', ','State Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (461,'Appeals Coordinator',null,', ','Appeals Coordinator Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (462,'Application Processing',null,', ','General Reminder Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (470,'Research ES2 Unit',null,', ','General Reminder Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (477,'Enrollment Unit',null,', ','Manual Enrollment Request-Esc','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (484,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (485,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (502,'Research ES2 Unit',null,', ','State Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (515,'Application Processing',null,', ','Expedite P1 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (518,'SystemAdmin',null,'Admin, System','Alternate Document VHT',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (519,'Application Processing',null,', ','Alternate Document VHT','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (523,'Research ES2 Unit',null,', ','Expedite P3 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (524,'Application Processing',null,', ','Expedite P2 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (525,'Application Processing',null,', ','Expedite P2 Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (527,'Application Processing',null,', ','Expedite P2 Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (539,'Application Processing',null,', ','Expedite P1 Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (552,'Application Processing',null,', ','Expedite P3 Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (559,'Appeals Coordinator',null,', ','Medicaid - Dispute Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (570,'Application Processing',null,', ','Expedite P1 Request Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (582,'Enrollment Unit',null,', ','Process Enrollment Fee - Lockbox','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (583,'Application Processing',null,', ','New App Data Entry','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (584,'Liaison',null,', ','Manual Enrollment Request-Esc',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (585,'Liaison',null,', ','Manual Enrollment Request-Esc','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (587,'Enrollment Unit',null,', ','Process Enrollment Fee','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (588,'Application Processing',null,', ','MI without App Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (590,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (591,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (596,'Application Processing',null,', ','MI without App Data Entry','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (599,'Liaison',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (600,'Liaison',null,', ','General Reminder Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (601,'Quality Assurance',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (602,'HSDE Quality Control',null,', ','General Reminder Task','HSDE QC Team 1','HSDE Quality Control','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (603,'Application Processing',null,', ','Verify SVES Results',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (604,'Application Processing',null,', ','Verify SVES Results','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (606,'Application Processing',null,', ','PEAK Change Report','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (607,'Application Processing',null,', ','Missing Info Data Entry','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (608,'Application Processing',null,', ','Alternate Document Processing',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (609,'Application Processing',null,', ','Alternate Document Processing','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (612,'Application Processing',null,', ','MI without App Data Entry','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (617,'Application Processing',null,', ','Alternate Document Processing','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (619,'Application Processing',null,', ','Expedite P3 Request Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (322,'Application Processing',null,', ','MAXIMUS-QC','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (323,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (328,'Research ES2 Unit',null,', ','Application Problem Resolution','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (329,'Application Processing',null,', ','MAXIMUS-QC','QA Team 1','Quality Assurance','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (332,'Appeals Coordinator',null,', ','CHP+ Appeal Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (333,'HSDE Quality Control',null,', ','HSDE-QC','HSDE QC Team 1','HSDE Quality Control','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (334,'SystemAdmin',null,'Admin, System','State Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (335,'SystemAdmin',null,'Admin, System','MAXIMUS-QC','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (356,'Application Processing',null,', ','Link Document Set','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (368,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Case Maintenance Training','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (372,'SystemAdmin',null,'Admin, System','State Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (380,'Application Processing',null,', ','State Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (382,'Research ES2 Unit',null,', ','Expedite P1 Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (383,'Call Center',null,'Admin, System','State Data Entry','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (384,'Application Processing',null,', ','State Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (385,'Research ES2 Unit',null,', ','Research Task - General','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (389,'Application Processing',null,', ','Renewal App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (390,'Application Processing',null,', ','Renewal App Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (393,'Application Processing',null,', ','New App Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (396,'HSDE Quality Control',null,', ','HSDE-QC','HSDE Training Team','HSDE Quality Control','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (410,'Case Maintenance ES2 Unit',null,', ','MI Received via Phone task ','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (413,'Application Processing',null,', ','MI Received via Phone task ','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (421,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (426,'Application Processing',null,', ','MI Received via Phone task ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (427,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (432,'Mail Room',null,'Admin, System','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (433,'Mail Room',null,'Admin, System','General Reminder Task','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (443,'Case Maintenance ES2 Unit',null,', ','State Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (455,'Application Processing',null,', ','General Reminder Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (463,'Call Center',null,'Admin, System','General Reminder Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (475,'Application Processing',null,', ','New App Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (478,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (480,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (481,'Appeals Coordinator',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (482,'Appeals Coordinator',null,', ','General Reminder Task','Appeals Team 1','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (483,'Case Maintenance ES2 Unit',null,', ','Renewal - No Change','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (487,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (491,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (492,'SystemAdmin',null,'Admin, System','Manual Linking',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (493,'Mail Room',null,'Admin, System','Manual Linking','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (497,'Appeals Coordinator',null,', ','Medicaid - Dispute Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (498,'Research ES2 Unit',null,', ','General Reminder Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (501,'Enrollment Unit',null,', ','Manual Enrollment Request-Esc','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (508,'Case Maintenance ES2 Unit',null,', ','Disenrollment request from MCO','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (510,'Application Processing',null,', ','General Reminder Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (511,'Application Processing',null,', ','Renewal App Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (516,'Application Processing',null,', ','MI without App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (517,'Application Processing',null,', ','MI without App Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (520,'Application Processing',null,', ','Expedite P3 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (521,'Application Processing',null,', ','Expedite P3 Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (522,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (526,'Application Processing',null,', ','Missing Info Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (531,'Application Processing',null,', ','Alternate Document VHT','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (532,'Application Processing',null,', ','Expedite P3 Request Task','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (533,'Application Processing',null,', ','MI Received Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (535,'Application Processing',null,', ','MI Received - Transition Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (536,'Application Processing',null,', ','MI Received - Transition Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (545,'Application Processing',null,', ','General Reminder Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (546,'Appeals Coordinator',null,', ','EC Complaints','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (549,'Application Processing',null,', ','Expedite P2 Request Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (550,'Application Processing',null,', ','Expedite P2 Request Task','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (551,'Application Processing',null,', ','Expedite P1 Request Task','Research Team 2','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (554,'Application Processing',null,', ','Expedite P2 Request Task','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (558,'Application Processing',null,', ','MI without App Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (560,'Application Processing',null,', ','MI Received - Non MAXIMUS Case ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (561,'Application Processing',null,', ','MI Received - Non MAXIMUS Case ','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (565,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (620,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (622,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (626,'Case Maintenance ES2 Unit',null,', ','Disenrollment - PARIS',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (627,'Case Maintenance ES2 Unit',null,', ','Disenrollment - PARIS','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (628,'Liaison',null,', ','Liaison','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (630,'Liaison',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (634,'Application Processing',null,', ','Verify SVES Results','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (638,'Application Processing',null,', ','Renewal - No Change','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (641,'Application Processing',null,', ','Renewal - No Change',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (643,'Application Processing',null,', ','MI without App Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (647,'Application Processing',null,', ','Missing Info Data Entry','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (653,'Research ES2 Unit',null,', ','Liaison','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (657,'Enrollment Unit',null,', ','Fee - Research','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (705,'Buy-In Processing',null,', ','Buy-In Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (707,'Buy-In Processing',null,', ','Buy-In Link Document Set','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (709,'Buy-In Processing',null,', ','Process Medicaid Buy-In Premium','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (710,'Application Processing',null,', ','Pending Apps','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (721,'Application Processing',null,', ','Pending RRR - Due',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (725,'Application Processing',null,', ','Pending Apps - Renewals','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (727,'Call Center',null,'Admin, System','Outbound Call Request',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (728,'Call Center',null,'Admin, System','Outbound Call Request','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (740,'Appeals Coordinator',null,', ','Incident Hearing Processing',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (741,'Appeals Coordinator',null,', ','Incident Hearing Processing','Appeals Training Team','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (747,'Case Maintenance ES2 Unit',null,', ','Enrollment Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (825,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Case Maintenance Training','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (826,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Case Maintenance Training','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (827,'Application Processing',null,', ','General Reminder Task','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (828,'Application Processing',null,', ','HSDE-QC','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (946,'Buy-In Processing',null,', ','Research Task - General','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (986,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1017,'Mail Room',null,'Admin, System','General Reminder Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1019,'AwDC Processing',null,', ','AwDC Waitlist - Approved','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1035,'Application Processing',null,', ','Renewal App Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1039,'Application Processing',null,', ','Add a Member Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1047,'Buy-In Processing',null,', ','Fee - Research','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1053,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1059,'Application Processing',null,', ','State Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1065,'Research ES2 Unit',null,', ','General Reminder Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1076,'Enrollment Unit',null,', ','Process Enrollment Fee - Lockbox','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1093,'Application Processing',null,', ','Pending Apps - Duplicates','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1095,'Buy-In Processing',null,', ','Process Medicaid Buy-In Premium','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1147,'Enrollment Unit',null,', ','AwDC New App Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (631,'Liaison',null,', ','Liaison','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (636,'Call Center',null,'Admin, System','EC Complaints','Call Center Training Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (637,'Application Processing',null,', ','MI without App Data Entry','Manual Enrollment Team','Enrollment Unit','Law, Steven');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (639,'Application Processing',null,', ','Renewal - No Change','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (646,'Research ES2 Unit',null,', ','Liaison','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (655,'Research ES2 Unit',null,', ','IEVS Research',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (659,'Enrollment Unit',null,', ','Process Enrollment Fee - Lockbox','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (660,'Buy-In Processing',null,', ','Add a Member Data Entry','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (697,'AwDC Processing',null,', ','Demographic Change Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (698,'AwDC Processing',null,', ','Disenrollment Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (699,'Enrollment Unit',null,', ','Unidentified Fees',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (700,'Application Processing',null,', ','Pending Apps - Duplicates','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (701,'AwDC Processing',null,', ','Add a Member Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (702,'AwDC Processing',null,', ','Add a Member Task','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (703,'Case Maintenance ES2 Unit',null,', ','Initiate RRR - CHP+ Prenatal',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (704,'AwDC Processing',null,', ','MI Received via Phone task ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (708,'Buy-In Processing',null,', ','Good Faith Effort',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (715,'Application Processing',null,', ','AwDC New App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (723,'Research ES2 Unit',null,', ','IEVS Research','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (738,'AwDC Processing',null,', ','State Data Entry','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (739,'Buy-In Processing',null,', ','Creditable Coverage Letter Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (742,'Buy-In Processing',null,', ','Buy-In App Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (743,'Buy-In Processing',null,', ','Buy-In App Problem Resolution','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (744,'AwDC Processing',null,', ','State Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (752,'Application Processing',null,', ','Backlog Application Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (753,'Case Maintenance ES2 Unit',null,', ','Disenroll  CHP+ - 1 year old ','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (865,'Application Processing',null,', ','New App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (866,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (867,'Application Processing',null,', ','Renewal App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (868,'Application Processing',null,', ','Verify SVES Results','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (869,'Application Processing',null,', ','New App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (870,'Research ES2 Unit',null,', ','Research Task - General','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (871,'Enrollment Unit',null,', ','Fee - Research','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (872,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (873,'Enrollment Unit',null,', ','Process NSF','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (874,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (875,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (876,'SystemAdmin',null,'Admin, System','MI Received Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (877,'Application Processing',null,', ','Renewal App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (878,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (879,'Enrollment Unit',null,', ','Process Enrollment Fee - Lockbox','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (880,'Enrollment Unit',null,', ','Process Enrollment Fee','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (881,'Application Processing',null,', ','Missing Info Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (882,'Application Processing',null,', ','MI without App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (883,'Appeals Coordinator',null,', ','Incident Document Processing','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (884,'Application Processing',null,', ','Expedite P1 Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (920,'Application Processing',null,', ','Expedite P1 Request Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (935,'Research ES2 Unit',null,', ','Research Task - General','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (940,'AwDC Processing',null,', ','AwDC New App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (943,'Call Center',null,'Admin, System','General Reminder Task','Aplha Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (947,'AwDC Processing',null,', ','AwDC Renewal App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (948,'AwDC Processing',null,', ','AwDC Renewal App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (956,'Case Maintenance ES2 Unit',null,', ','State Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (957,'Research ES2 Unit',null,', ','General Reminder Task','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (962,'AwDC Processing',null,', ','AwDC App Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (963,'AwDC Processing',null,', ','AwDC App Problem Resolution','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (965,'Application Processing',null,', ','New App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (967,'Buy-In Processing',null,', ','Disenrollment Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (968,'Buy-In Processing',null,', ','Disenrollment Request Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (970,'Application Processing',null,', ','MI without App Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (983,'Enrollment Unit',null,', ','Fee - Research','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (989,'Application Processing',null,', ','New App Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (996,'Mail Room',null,'Admin, System','Link Document Set','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (997,'Mail Room',null,'Admin, System','HSDE-QC','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1000,'Mail Room',null,'Admin, System','AwDC Link Document Set','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1001,'Research ES2 Unit',null,', ','Liaison','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1032,'Application Processing',null,', ','Pending Apps - New Arrivals','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1037,'AwDC Processing',null,', ','Add a Member Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1045,'AwDC Processing',null,', ','Disenrollment Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1048,'AwDC Processing',null,', ','State Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1052,'Research ES2 Unit',null,', ','State Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1063,'Application Processing',null,', ','Alternate Document Processing','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1068,'Application Processing',null,', ','Add a Member Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (629,'Application Processing',null,', ','Liaison','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (633,'Application Processing',null,', ','Incident Document Processing',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (651,'Research ES2 Unit',null,', ','Application Problem Resolution','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (656,'Enrollment Unit',null,', ','Process NSF','Manual Enrollment Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (722,'Buy-In Processing',null,', ','Missing Info Data Entry','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (904,'Application Processing',null,', ','MI without App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (941,'Buy-In Processing',null,', ','Missing Info Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (954,'Application Processing',null,', ','MI without App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (988,'Buy-In Processing',null,', ','AwDC New App Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (993,'Buy-In Processing',null,', ','Buy-In Missing Info Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (994,'Buy-In Processing',null,', ','Buy-In Missing Info Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1005,'Application Processing',null,', ','Alternate Document Processing','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1007,'Buy-In Processing',null,', ','Fee - Research','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1066,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1075,'Call Center',null,'Admin, System','Outbound Call Request','Aplha Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1086,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1099,'Enrollment Unit',null,', ','Unidentified Fees','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1100,'Application Processing',null,', ','Pending Apps - Backlog','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1107,'Mail Room',null,'Admin, System','Buy-In Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1108,'Mail Room',null,'Admin, System','Buy-In Link Document Set','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1113,'Appeals Coordinator',null,', ','EC Complaints','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1114,'Application Processing',null,', ','AwDC Missing Info Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1116,'Application Processing',null,', ','Liaison','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1123,'SystemAdmin',null,'Admin, System','Expedite P2 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1124,'Application Processing',null,', ','Expedite P2 Request Task','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1126,'Call Center',null,'Admin, System','General Reminder Task','Call Center Training Team','Call Center','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1132,'AwDC Processing',null,', ','Good Faith Effort',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1133,'AwDC Processing',null,', ','Process Medicaid Buy-In Premium',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1134,'AwDC Processing',null,', ','Fee - Research',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1136,'Application Processing',null,', ','Pending Apps','Application Processing Team 2','Application Processing','Hipbshman, William');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1143,'Case Maintenance ES2 Unit',null,', ','Pending Apps - Duplicates','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1144,'Case Maintenance ES2 Unit',null,', ','Document Problem Resolution','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1145,'Call Center',null,'Admin, System','EC Complaints','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (623,'Application Processing',null,', ','MI without App Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (632,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (640,'HSDE Quality Control',null,', ','General Reminder Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (644,'Application Processing',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (648,'Case Maintenance ES2 Unit',null,', ','Initiate RRR-Medicaid Prenatal',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (649,'Case Maintenance ES2 Unit',null,', ','Initiate RRR-Medicaid Prenatal','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (658,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (692,'Mail Room',null,'Admin, System','Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (706,'Application Processing',null,', ','Buy-In New App Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (711,'AwDC Processing',null,', ','Creditable Coverage Letter Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (713,'AwDC Processing',null,', ','Disenrollment - PARIS',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (716,'SystemAdmin',null,'Admin, System','Patient Registration Form Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (719,'Mail Room',null,'Admin, System','Link Document Set','Mailroom Training Team','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (720,'Application Processing',null,', ','Timely Process Data Entry','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (726,'AwDC Processing',null,', ','New App Data Entry','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (729,'Liaison',null,', ','CHP+ Authorization Task','Liaison Training Team','Liaison','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (730,'Case Maintenance ES2 Unit',null,', ','Disenroll Medicaid - 1 year old ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (731,'Case Maintenance ES2 Unit',null,', ','Initiate RRR - Medicaid 1 yr old',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (732,'AwDC Processing',null,', ','PEAK Change Report',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (733,'Buy-In Processing',null,', ','Process Medicaid Buy-in Refund',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (736,'Appeals Coordinator',null,', ','Appeals Coordinator Task','System Administrators','SystemAdmin','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (749,'Enrollment Unit',null,', ','Document Problem Resolution','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (750,'Case Maintenance ES2 Unit',null,', ','Renewal - Change Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (751,'Case Maintenance ES2 Unit',null,', ','Renewal - Change Task','Case Maintenance Team 2','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (905,'Application Processing',null,', ','Add a Member Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (906,'Enrollment Unit',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (907,'Application Processing',null,', ','Renewal - No Change','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (908,'Enrollment Unit',null,', ','Process Refund','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (910,'Research ES2 Unit',null,', ','IEVS Research','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (911,'Application Processing',null,', ','Renewal - No Change','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (912,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (916,'Appeals Coordinator',null,', ','Appeals Coordinator ReminderTask','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (917,'Application Processing',null,', ','Missing Info Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (918,'Application Processing',null,', ','Liaison','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (927,'Application Processing',null,', ','Expedite P1 Request Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (928,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (932,'Buy-In Processing',null,', ','Missing Info Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (939,'Research ES2 Unit',null,', ','Application Problem Resolution','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (942,'AwDC Processing',null,', ','AwDC Document Problem Resolution','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (950,'Application Processing',null,', ','State Data Entry','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (951,'AwDC Processing',null,', ','AwDC Renewal App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (952,'Enrollment Unit',null,', ','Manual Enrollment Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (959,'Buy-In Processing',null,', ','Insurance Card Creation Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (964,'Buy-In Processing',null,', ','Buy-In Link Document Set','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (982,'AwDC Processing',null,', ','Expedite P1 Request Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (985,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (987,'Application Processing',null,', ','PEAK Change Report','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (995,'AwDC Processing',null,', ','Research Task - General','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1003,'Buy-In Processing',null,', ','Process Medicaid Buy-in NSF','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1006,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Research Team 2','Research ES2 Unit','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1010,'Buy-In Processing',null,', ','Demographic Change Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1011,'Buy-In Processing',null,', ','Demographic Change Request Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1031,'Application Processing',null,', ','AwDC New App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1036,'Case Maintenance ES2 Unit',null,', ','State Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1040,'Application Processing',null,', ','Pending Apps - New Arrivals','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1041,'Application Processing',null,', ','Pending Apps - Renewals','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1055,'Enrollment Unit',null,', ','Process Refund','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1061,'AwDC Processing',null,', ','Add a Member Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1070,'Buy-In Processing',null,', ','Add a Member Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1078,'Call Center',null,'Admin, System','Outbound Call Request','Call Center Training Team','Call Center','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1082,'Research ES2 Unit',null,', ','Patient Registration Form Task','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1087,'Application Processing',null,', ','Expedite P1 Request Task','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1102,'Appeals Coordinator',null,', ','Incident Hearing Processing','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1103,'Application Processing',null,', ','Backlog Application Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1106,'Mail Room',null,'Admin, System','Buy-In HSDE-QC','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1112,'Buy-In Processing',null,', ','Creditable Coverage Letter Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1122,'Application Processing',null,', ','Expedite P2 Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1129,'AwDC Processing',null,', ','Process Buy-In Premium Lockbox',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1130,'AwDC Processing',null,', ','Process Medicaid Buy-in Refund',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1131,'AwDC Processing',null,', ','Process Medicaid Buy-in NSF',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1141,'Enrollment Unit',null,', ','Document Problem Resolution','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (621,'Application Processing',null,', ','Missing Info Data Entry','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (645,'Application Processing',null,', ','Expedite P2 Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (652,'Enrollment Unit',null,', ','Liaison','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (746,'Application Processing',null,', ','Pending Apps - Renewals','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (805,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Case Maintenance Training','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (885,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (886,'Application Processing',null,', ','MI Received via Phone task ','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (887,'Case Maintenance ES2 Unit',null,', ','Good Faith Effort','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (888,'Enrollment Unit',null,', ','Manual Enrollment Expedite','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (889,'HSDE Quality Control',null,', ','HSDE-QC','HSDE QC Team 1','HSDE Quality Control','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (890,'Application Processing',null,', ','Link Document Set','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (891,'Application Processing',null,', ','Link Document Set','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (892,'Application Processing',null,', ','Liaison','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (893,'SystemAdmin',null,'Admin, System','CHP+ Appeal Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (895,'Application Processing',null,', ','State Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (903,'Case Maintenance ES2 Unit',null,', ','Disenrollment request from MCO','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (913,'Buy-In Processing',null,', ','Buy-In New App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (914,'Buy-In Processing',null,', ','Buy-In New App Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (930,'Application Processing',null,', ','Add a Member Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (936,'Application Processing',null,', ','Renewal - No Change','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (969,'Call Center',null,'Admin, System','EC Complaints','Aplha Team','Call Center','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (972,'Application Processing',null,', ','General Reminder Task','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (976,'Buy-In Processing',null,', ','Process Medicaid Buy-In Premium','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (981,'AwDC Processing',null,', ','Insurance Card Creation Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (991,'Research ES2 Unit',null,', ','Research Task - General','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (998,'Buy-In Processing',null,', ','PEAK Change Report',null,null,', ');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (999,'Buy-In Processing',null,', ','PEAK Change Report','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1012,'Case Maintenance ES2 Unit',null,', ','Disenroll Medicaid - 19 yr old','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1015,'Buy-In Processing',null,', ','Expedite P1 Request Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1016,'Application Processing',null,', ','MI Received via Phone task ','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1028,'AwDC Processing',null,', ','State Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1029,'Application Processing',null,', ','Missing Info Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1030,'Application Processing',null,', ','MI without App Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1034,'Application Processing',null,', ','New App Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1038,'Application Processing',null,', ','MI Received via Phone task ','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1042,'Case Maintenance ES2 Unit',null,', ','Disenrollment - PARIS','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1049,'Application Processing',null,', ','Pending RRR - Due','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1050,'Application Processing',null,', ','Pending RRR - Due','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1054,'Case Maintenance ES2 Unit',null,', ','Demographic Change Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1056,'Application Processing',null,', ','Mass Update Exception Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1057,'Application Processing',null,', ','Mass Update Exception Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1060,'Application Processing',null,', ','Verify SVES Results','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1062,'Application Processing',null,', ','New App Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1067,'Call Center',null,'Admin, System','EC Complaints','Call Center Training Team','Call Center','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1072,'Application Processing',null,', ','Pending RRR - Due','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1080,'Case Maintenance ES2 Unit',null,', ','Disenrollment Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1083,'AwDC Processing',null,', ','AwDC Missing Info Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1085,'AwDC Processing',null,', ','AwDC New App Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1094,'AwDC Processing',null,', ','MI Received via Phone task ','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1096,'Application Processing',null,', ','Expedite P1 Request Task','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1105,'Application Processing',null,', ','Renewal App Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1111,'Buy-In Processing',null,', ','Add a Member Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1120,'Buy-In Processing',null,', ','Disenrollment request from MCO',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1127,'Buy-In Processing',null,', ','AwDC Waitlist - Approved',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1148,'Application Processing',null,', ','AwDC Waitlist - Approved','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1165,'Appeals Coordinator',null,', ','EC Complaints','Appeals Training Team','Appeals Coordinator','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (635,'Research ES2 Unit',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (712,'AwDC Processing',null,', ','AwDC Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (714,'AwDC Processing',null,', ','AwDC Link Document Set','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (717,'Mail Room',null,'Admin, System','Buy-In HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (718,'Mail Room',null,'Admin, System','Buy-In HSDE-QC','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (734,'Mail Room',null,'Admin, System','AwDC HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (735,'Mail Room',null,'Admin, System','AwDC HSDE-QC','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (748,'Research ES2 Unit',null,', ','Expedite P2 Request Task','Research Team 1','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (785,'Application Processing',null,', ','Insurance Card Creation Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (845,'Application Processing',null,', ','Renewal - No Change','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (897,'Application Processing',null,', ','Alternate Document Processing','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (898,'Case Maintenance ES2 Unit',null,', ','Disenroll  CHP+ - 1 year old ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (899,'Appeals Coordinator',null,', ','Appeals Coordinator Task','Appeals Team 1','Appeals Coordinator','Bowman, James');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (900,'Application Processing',null,', ','State Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (902,'Research ES2 Unit',null,', ','Document Problem Resolution','Research Team 2','Research ES2 Unit','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (909,'Research ES2 Unit',null,', ','Document Problem Resolution','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (915,'Application Processing',null,', ','PEAK Change Report','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (919,'Mail Room',null,'Admin, System','General Reminder Task','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (921,'Application Processing',null,', ','MI Received via Phone task ','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (922,'Buy-In Processing',null,', ','Insurance Card Creation Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (923,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (924,'Buy-In Processing',null,', ','Expedite P1 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (926,'Application Processing',null,', ','Expedite P1 Request Task','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (931,'Research ES2 Unit',null,', ','Research Task - General','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (933,'Research ES2 Unit',null,', ','Research Task - General','Research Team 2','Research ES2 Unit','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (934,'Application Processing',null,', ','General Reminder Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (938,'AwDC Processing',null,', ','AwDC Link Document Set','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (944,'AwDC Processing',null,', ','AwDC HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (945,'AwDC Processing',null,', ','AwDC HSDE-QC','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (955,'AwDC Processing',null,', ','MI Received via Phone task ','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (960,'AwDC Processing',null,', ','AwDC Missing Info Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (961,'AwDC Processing',null,', ','AwDC Missing Info Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (973,'Research ES2 Unit',null,', ','General Reminder Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (977,'AwDC Processing',null,', ','Demographic Change Request Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (984,'Application Processing',null,', ','AwDC New App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (992,'AwDC Processing',null,', ','AwDC New App Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1004,'Mail Room',null,'Admin, System','AwDC HSDE-QC','Mailroom Team 1','Mail Room','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1008,'Application Processing',null,', ','Verify SVES Results','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1009,'Case Maintenance ES2 Unit',null,', ','Disenroll Medicaid - 1 year old ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1026,'Application Processing',null,', ','Pending Apps - Renewals','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1027,'Application Processing',null,', ','Pending Apps - Renewals','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1058,'AwDC Processing',null,', ','Research Task - General','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1069,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1073,'Enrollment Unit',null,', ','Fee - Research','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1074,'Application Processing',null,', ','Pending Apps - Duplicates','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1079,'AwDC Processing',null,', ','AwDC Waitlist - Approved','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1084,'Call Center',null,'Admin, System','Liaison','Call Center Training Team','Call Center','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1091,'Application Processing',null,', ','Timely Process Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1098,'Application Processing',null,', ','Pending Apps - Backlog','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1101,'Application Processing',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1109,'Buy-In Processing',null,', ','Buy-In Doc Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1110,'Buy-In Processing',null,', ','Buy-In Doc Problem Resolution','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1115,'Application Processing',null,', ','AwDC Missing Info Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1117,'Application Processing',null,', ','Alternate Document Processing','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1118,'Application Processing',null,', ','Buy-In New App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1119,'Buy-In Processing',null,', ','Buy-In New App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1128,'Application Processing',null,', ','Link Document Set','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1138,'Buy-In Processing',null,', ','Disenrollment - PARIS',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1139,'Application Processing',null,', ','AwDC Pending Apps','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1146,'Enrollment Unit',null,', ','New App Data Entry','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (625,'Application Processing',null,', ','Liaison','Application Processing Team 1','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (654,'AwDC Processing',null,', ','Missing Info Data Entry','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (661,'Buy-In Processing',null,', ','Process Buy-In Premium Lockbox',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (662,'Buy-In Processing',null,', ','Process Buy-In Premium Lockbox','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (663,'Buy-In Processing',null,', ','Process Medicaid Buy-In Premium',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (664,'Research ES2 Unit',null,', ','Disenroll  CHP+ - 1 year old ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (665,'Buy-In Processing',null,', ','Fee - Research',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (666,'Buy-In Processing',null,', ','Research Task - General',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (667,'Buy-In Processing',null,', ','Process Medicaid Buy-in NSF',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (668,'Application Processing',null,', ','Pending Apps',null,null,', ');
commit;
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (669,'Application Processing',null,', ','Buy-In New App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (670,'Application Processing',null,', ','Buy-In New App Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (671,'AwDC Processing',null,', ','AwDC Waitlist - Approved',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (672,'AwDC Processing',null,', ','AwDC Waitlist - Approved','AwDC Team 1','AwDC Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (673,'Mail Room',null,'Admin, System','HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (674,'Mail Room',null,'Admin, System','HSDE-QC','Mailroom Training Team','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (675,'Application Processing',null,', ','Pending Apps - New Arrivals',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (676,'Application Processing',null,', ','Pending Apps - New Arrivals','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (677,'Application Processing',null,', ','Pending Apps - Duplicates',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (678,'AwDC Processing',null,', ','AwDC Pending Apps',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (679,'Application Processing',null,', ','Pending Apps - Renewals',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (681,'Application Processing',null,', ','Timely Process Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (683,'Mail Room',null,'Admin, System','Link Document Set','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (686,'Application Processing',null,', ','Timely Process Data Entry','AP Training Team','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (688,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Research Training Team','Research ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (689,'Application Processing',null,', ','HSDE-QC',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (690,'Application Processing',null,', ','HSDE-QC','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (724,'Mail Room',null,'Admin, System','HSDE-QC','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (737,'Case Maintenance ES2 Unit',null,', ','Enrollment Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (745,'Call Center',null,'Admin, System','CSR General Reminder Task','Aplha Team','Call Center','Schaffer, Jerry');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (925,'Buy-In Processing',null,', ','MI Received via Phone task ',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (937,'Application Processing',null,', ','Renewal - No Change','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (949,'AwDC Processing',null,', ','AwDC New App Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (974,'Application Processing',null,', ','General Reminder Task','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (978,'Application Processing',null,', ','Add a Member Data Entry','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (990,'AwDC Processing',null,', ','Disenrollment Request Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1002,'Application Processing',null,', ','Expedite P1 Request Task','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1044,'Research ES2 Unit',null,', ','Patient Registration Form Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1046,'AwDC Processing',null,', ','Demographic Change Request Task','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1051,'Application Processing',null,', ','Renewal - No Change','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1064,'Application Processing',null,', ','Mass Update Exception Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1077,'Application Processing',null,', ','Expedite P1 Request Task','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1081,'Call Center',null,'Admin, System','Outbound Call Request','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1089,'Case Maintenance ES2 Unit',null,', ','Add a Member Task','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1090,'Application Processing',null,', ','Timely Process Data Entry','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1104,'Application Processing',null,', ','Pending Apps','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1125,'Research ES2 Unit',null,', ','Research Task - General','Manual Enrollment Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1135,'Enrollment Unit',null,', ','AwDC Waitlist - Approved','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1137,'Research ES2 Unit',null,', ','Creditable Coverage Letter Task','Research Team 2','Research ES2 Unit','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (624,'Enrollment Unit',null,', ','Liaison','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (642,'Application Processing',null,', ','Renewal - No Change','Case Maintenance Team 1','Case Maintenance ES2 Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (650,'Call Center',null,'Admin, System','Liaison','Enrollment Fee Team','Enrollment Unit','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (680,'Application Processing',null,', ','Buy-In New App Data Entry','Buy In Team 1','Buy-In Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (682,'AwDC Processing',null,', ','Insurance Card Creation Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (684,'AwDC Processing',null,', ','Research Task - General',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (685,'Research ES2 Unit',null,', ','Cost Share Manual Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (687,'AwDC Processing',null,', ','Expedite P1 Request Task',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (691,'Application Processing',null,', ','Buy-In New App Data Entry','Application Processing Team 2','Application Processing','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (693,'AwDC Processing',null,', ','AwDC New App Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (694,'AwDC Processing',null,', ','AwDC Document Problem Resolution',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (695,'Mail Room',null,'Admin, System','AwDC Link Document Set',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (696,'Mail Room',null,'Admin, System','AwDC Link Document Set','Mailroom Team 1','Mail Room','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (765,'Appeals Coordinator',null,', ','Appeals Coordinator Task','Appeals Training Team','Appeals Coordinator','Law, Steven');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (894,'Case Maintenance ES2 Unit',null,', ','Disenroll CHP+ - 19 year old','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (896,'Research ES2 Unit',null,', ','Insurance Card Creation Task','Research Team 1','Research ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (901,'Application Processing',null,', ','Link Document Set','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (929,'Enrollment Unit',null,', ','Process Enrollment Fee','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (953,'Application Processing',null,', ','AwDC New App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (958,'Buy-In Processing',null,', ','MI Received via Phone task ','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (966,'Enrollment Unit',null,', ','Fee - Research','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (971,'Research ES2 Unit',null,', ','Research Task - General','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (975,'AwDC Processing',null,', ','Creditable Coverage Letter Task','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (979,'Appeals Coordinator',null,', ','Incident Document Processing','Liaison Team 1','Liaison','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (980,'Application Processing',null,', ','Missing Info Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1013,'Application Processing',null,', ','State Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1014,'Application Processing',null,', ','MI Received via Phone task ','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1018,'Application Processing',null,', ','Missing Info Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1020,'Application Processing',null,', ','State Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1021,'Application Processing',null,', ','Pending Apps - New Arrivals','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1022,'Application Processing',null,', ','Pending Apps - New Arrivals','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1023,'Application Processing',null,', ','Pending Apps - Duplicates','Application Processing Team 1','Application Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1024,'AwDC Processing',null,', ','AwDC Pending Apps','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1025,'Application Processing',null,', ','Pending Apps - Duplicates','Application Processing Team 2','Application Processing','Hipbshman, William');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1033,'Application Processing',null,', ','State Data Entry','Enrollment Fee Team','Enrollment Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1043,'Application Processing',null,', ','Renewal App Data Entry','AwDC Team1','AwDC Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1071,'Application Processing',null,', ','Missing Info Data Entry','Buy-In Team 1','Buy-In Processing','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1088,'AwDC Processing',null,', ','Add a Member Data Entry',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1092,'Application Processing',null,', ','Timely Process Data Entry','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1097,'Application Processing',null,', ','Pending Apps - Backlog',null,null,', ');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1121,'Application Processing',null,', ','Renewal - No Change','AP Training Team','Application Processing','Fitzsimmons, Debbie');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1140,'Case Maintenance ES2 Unit',null,', ','Link Document Set','Case Maintenance Team 1','Case Maintenance ES2 Unit','Hawkins, Rene');
Insert into D_MW_TASK_TYPE (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name") values (1142,'Application Processing',null,', ','HSDE-QC','Application Processing Team 1','Application Processing','Hawkins, Rene');
commit;

CREATE UNIQUE INDEX DMWTT_UIX1 ON D_MW_TASK_TYPE ("Group Name" ASC, "Group Parent Name" ASC, "Group Supervisor Name" ASC, "Task Type" ASC, "Team Name" ASC, "Team Parent Name" ASC, "Team Supervisor Name" ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX DMWTT_PK ON D_MW_TASK_TYPE (DMWTT_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE OR REPLACE VIEW BPM_LAST_ETL_RUN_SV
AS Select
  be.bem_id,
  bsl.BSL_ID,
  bsl.NAME "Process Name",
  max(cjs.job_start_date) as "Last Completed ETL Start Time",
  max(cjs.job_end_date) as "Last Completed ETL End Time",
  nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) "Queue Hours Behind",
  count(distinct bueq.identifier) "Instances Pending",
  case when nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) = 0 then 'Complete'
  else 'Pending'
  end
  "Queue Processing"
from BPM_SOURCE_LKUP bsl
left outer join BPM_UPDATE_EVENT_QUEUE bueq on bsl.BSL_ID = bueq.BSL_ID
inner join BPM_EVENT_MASTER be on be.bem_id = bsl.bsl_id
inner join BPM_PROCESS_LKUP bpl on bpl.BPROL_ID = be.BPROL_ID
inner join corp_etl_list_lkup cell on (cell.ref_id = be.bem_id and cell.ref_type = 'BPM_EVENT_MASTER')
inner join corp_etl_job_statistics cjs on cjs.job_name = cell.value
where cjs.job_status_cd = 'COMPLETED'
group by bsl.BSL_ID,bsl.NAME,be.bem_id,cell.name;

GRANT SELECT ON BPM_LAST_ETL_RUN_SV TO MAXDAT_READ_ONLY;

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','MW_RUNALL','2002','BPM_EVENT_MASTER',2002,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);

CREATE OR REPLACE VIEW D_COATS_BPM_DATA_MODEL_SV
AS select "BDM_ID","CODE","NAME" from D_BPM_DATA_MODEL_SV WITH READ ONLY;

GRANT SELECT ON D_COATS_BPM_DATA_MODEL_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_COATS_BPM_SOURCE_LKUP_SV
AS select "BSL_ID","NAME","BSTL_ID" from D_BPM_SOURCE_LKUP_SV WITH READ ONLY;

GRANT SELECT ON D_COATS_BPM_SOURCE_LKUP_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_COATS_BUEQ_SV
AS select "BUEQ_ID","BSL_ID","BIL_ID","IDENTIFIER","EVENT_DATE","QUEUE_DATE","PROCESS_BUEQ_ID","WROTE_BPM_SEMANTIC_DATE","DATA_VERSION","OLD_DATA","NEW_DATA" from  D_BPM_UPDATE_EVENT_QUEUE_SV WITH READ ONLY;

GRANT SELECT ON D_COATS_BUEQ_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_COATS_PBQJB_SV
AS select "PBQJB_ID","PBQJ_ID","BATCH_ID","PROCESS_BUEQ_ID","BATCH_START_DATE","BATCH_END_DATE","LOCKING_START_DATE","LOCKING_END_DATE","RESERVE_START_DATE","RESERVE_END_DATE","PROC_XML_START_DATE","PROC_XML_END_DATE","NUM_SLEEP_SECONDS","NUM_QUEUE_ROWS_IN_BATCH","NUM_BPM_EVENT_INSERT","NUM_BPM_EVENT_UPDATE","NUM_BPM_SEMANTIC_INSERT","NUM_BPM_SEMANTIC_UPDATE","STATUS_DATE" from D_PROCESS_BPM_QUEUE_JOB_BAT_SV WITH READ ONLY;

GRANT SELECT ON D_COATS_PBQJB_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_COATS_PBQJ_SV
AS select "PBQJ_ID","JOB_NAME","BSL_ID","BDM_ID","BATCH_SIZE","START_DATE","END_DATE","STATUS","STATUS_DATE","ENABLED","START_REASON_ID","STOP_REASON_ID" from D_PROCESS_BPM_QUEUE_JOB_SV WITH READ ONLY;

GRANT SELECT ON D_COATS_PBQJ_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_MW_TASK_STATUS_SV
AS select "DMWTS_ID","Task Status" from D_MW_TASK_STATUS WITH READ ONLY;

GRANT SELECT ON D_MW_TASK_STATUS_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_MW_TASK_TYPE_SV
AS select "DMWTT_ID","Group Name","Group Parent Name","Group Supervisor Name","Task Type","Team Name","Team Parent Name","Team Supervisor Name" from D_MW_TASK_TYPE WITH READ ONLY;

GRANT SELECT ON D_MW_TASK_TYPE_SV TO MAXDAT_READ_ONLY;

CREATE SEQUENCE SEQ_DMWE_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_DMWF_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_DMWLUBN_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_DMWO_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_DMWTS_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_DMWTT_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_FLHK_EXT_CALL_DATA_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;
CREATE SEQUENCE SEQ_FMWBD_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20;

CREATE TABLE CLIENT_ELIG_STATUS_STG
(	
    CLIENT_ELIG_STATUS_ID           NUMBER(18,0), 
	PLAN_TYPE_CD                    VARCHAR2(32), 
	ELIG_STATUS_CD                  VARCHAR2(32), 
	START_DATE                      DATE, 
	END_DATE                        DATE, 
	CREATE_TS                       DATE, 
	CREATED_BY                      VARCHAR2(80), 
	UPDATE_TS                       DATE, 
	UPDATED_BY                      VARCHAR2(80), 
	CLIENT_ID                       NUMBER(18,0), 
	PROGRAM_CD                      VARCHAR2(32), 
	SUB_STATUS_CODES                VARCHAR2(256), 
	REASONS                         VARCHAR2(256), 
	MVX_CORE_REASON                 VARCHAR2(256), 
	DEBUG                           VARCHAR2(2000), 
	START_NDT                       NUMBER(18,0), 
	END_NDT                         NUMBER(18,0), 
    DISPOSITION_CD                  VARCHAR2(32), 
	SUBPROGRAM_TYPE                 VARCHAR2(32)
) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IDX_CL_ELIG_STAT_UPDATE_TS ON CLIENT_ELIG_STATUS_STG (UPDATE_TS ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX_CL_ELIG_STAT_CLIENT_ID ON CLIENT_ELIG_STATUS_STG (CLIENT_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX_CL_ELIG_STAT_CREATE_TS ON CLIENT_ELIG_STATUS_STG (CREATE_TS ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX PK_CLNT_ELIG_STAT_ID ON CLIENT_ELIG_STATUS_STG (CLIENT_ELIG_STATUS_ID ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON CLIENT_ELIG_STATUS_STG TO MAXDAT_READ_ONLY;

CREATE TABLE CLIENT_SUPPLEMENTARY_INFO_STG
(	
    CLIENT_ID                       NUMBER(18,0), 
	CASE_CLIENT_ID                  NUMBER(18,0), 
	CASE_ID                         NUMBER(18,0), 
	CASE_CIN                        VARCHAR2(30), 
	HOH_ID                          NUMBER(18,0), 
	CASE_STATUS                     VARCHAR2(2), 
	CASE_CLIENT_STATUS              VARCHAR2(2), 
	LAST_NAME                       VARCHAR2(40), 
	LAST_NAME_CANON                 VARCHAR2(40), 
	LAST_NAME_SOUNDLIKE             VARCHAR2(64), 
	FIRST_NAME                      VARCHAR2(25), 
	FIRST_NAME_CANON                VARCHAR2(25), 
	FIRST_NAME_SOUNDLIKE            VARCHAR2(64), 
	MIDDLE_INITIAL                  VARCHAR2(25), 
	CLIENT_CIN                      VARCHAR2(30), 
	SSN                             VARCHAR2(30), 
	GENDER_CD                       VARCHAR2(32), 
	DOB                             DATE, 
	DOB_NUM                         NUMBER(8,0), 
	CLIENT_TYPE_CD                  VARCHAR2(10), 
	ADDR_ID                         NUMBER(18,0), 
	ADDR_TYPE_CD                    VARCHAR2(32), 
	ADDR_COUNTY                     VARCHAR2(32), 
	ADDR_ZIP                        VARCHAR2(32), 
	ADDR_ZIP_FOUR                   VARCHAR2(4), 
	ADDR_ATTN                       VARCHAR2(55), 
	ADDR_STREET_1                   VARCHAR2(55), 
	ADDR_STREET_2                   VARCHAR2(55), 
	ADDR_CITY                       VARCHAR2(30), 
	ADDR_BAD_DATE                   DATE, 
	ADDR_BAD_DATE_SATISFIED         DATE, 
	CREATED_BY                      VARCHAR2(80), 
	CREATE_TS                       DATE, 
	UPDATED_BY                      VARCHAR2(80), 
	UPDATE_TS                       DATE, 
	CASE_CREATED_BY                 VARCHAR2(80), 
	CASE_CREATE_TS                  DATE, 
	CASE_UPDATED_BY                 VARCHAR2(80), 
	CASE_UPDATE_TS                  DATE, 
	PROGRAM_CD                      VARCHAR2(32), 
	ADDR_STATE_CD                   VARCHAR2(20), 
	ADDR_COUNTRY                    VARCHAR2(20), 
    CLNT_GENERIC_FIELD1_DATE        DATE, 
	CLNT_GENERIC_FIELD2_DATE        DATE, 
	CLNT_GENERIC_FIELD3_NUM         NUMBER(18,0), 
	CLNT_GENERIC_FIELD4_NUM         NUMBER(18,0), 
	CLNT_GENERIC_FIELD5_TXT         VARCHAR2(256), 
	CLNT_GENERIC_FIELD6_TXT         VARCHAR2(256), 
	CLNT_GENERIC_FIELD7_TXT         VARCHAR2(256), 
	CLNT_GENERIC_FIELD8_TXT         VARCHAR2(256), 
	CLNT_GENERIC_FIELD9_TXT         VARCHAR2(256), 
	CLNT_GENERIC_FIELD10_TXT        VARCHAR2(256), 
	CLNT_GENERIC_REF11_ID           NUMBER(18,0), 
	CLNT_GENERIC_REF12_ID           NUMBER(18,0), 
	SERVICE_AREA                    VARCHAR2(64), 
	ADDR_COUNTY_LABEL               VARCHAR2(64)
)
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX CLIENT_SUPPLEMENTARY_INFO_PK ON CLIENT_SUPPLEMENTARY_INFO_STG (CLIENT_ID ASC, PROGRAM_CD ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON CLIENT_SUPPLEMENTARY_INFO_STG TO MAXDAT_READ_ONLY;

CREATE TABLE DSSCSADDRESS
(	
    CONTACT_ID              CHAR(32) NOT NULL ENABLE, 
	ADDRESS_ID              CHAR(32) NOT NULL ENABLE, 
	DISP_NAME               NVARCHAR2(250) NOT NULL ENABLE, 
	ADDRESS                 NVARCHAR2(250), 
	DELIVERY_TYPE           NUMBER(10,0) NOT NULL ENABLE, 
	IS_DEFAULT              NUMBER(5,0) NOT NULL ENABLE, 
	DEVICE_ID               CHAR(32) NOT NULL ENABLE, 
	VERSION_ID              CHAR(32) NOT NULL ENABLE, 
	CREATION_TIME           TIMESTAMP (3) NOT NULL ENABLE, 
	MODIFICATION_TIME       TIMESTAMP (3) NOT NULL ENABLE, 
    PRIMARY KEY (ADDRESS_ID) ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON DSSCSADDRESS TO MAXDAT_READ_ONLY;

CREATE TABLE DSSMDOBJINFO
(	
    PROJECT_ID                  CHAR(32), 
	OBJECT_ID                   CHAR(32), 
	OBJECT_TYPE                 NUMBER(10,0), 
	SUBTYPE                     NUMBER(10,0), 
	OBJECT_NAME                 NVARCHAR2(250), 
	ABBREVIATION                NVARCHAR2(250), 
	DESCRIPTION                 NVARCHAR2(250), 
	VERSION_ID                  CHAR(32), 
	PARENT_ID                   CHAR(32), 
	OWNER_ID                    CHAR(32), 
	HIDDEN                      NUMBER(10,0), 
	CREATE_TIME                 TIMESTAMP (3), 
	MOD_TIME                    TIMESTAMP (3), 
	OBJECT_UNAME                NVARCHAR2(250), 
	OBJECT_STATE                NUMBER(10,0), 
	LOCALE                      NUMBER(10,0) DEFAULT 0, 
	EXTENDED_TYPE               NUMBER(10,0) DEFAULT 0, 
	VIEW_MEDIA                  NUMBER(10,0) DEFAULT 0, 
	ICON_PATH                   NVARCHAR2(250) DEFAULT ''
) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IX_OBJINFO_TYPE ON DSSMDOBJINFO (OBJECT_TYPE ASC, PROJECT_ID ASC, OBJECT_ID ASC, PARENT_ID ASC) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IX_OBJINFO_OBJECT ON DSSMDOBJINFO (OBJECT_ID ASC) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IX_OBJINFO_SUBTYPE ON DSSMDOBJINFO (SUBTYPE ASC) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IX_OBJINFO_UNAME ON DSSMDOBJINFO (OBJECT_UNAME ASC) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX IX_OBJINFO_PARENT ON DSSMDOBJINFO (PARENT_ID ASC, OBJECT_TYPE ASC) 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX SYS_C00550247 ON DSSMDOBJINFO (PROJECT_ID ASC, OBJECT_ID ASC) 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON DSSMDOBJINFO TO MAXDAT_READ_ONLY;

CREATE TABLE D_MW_LAST_UPDATE_BY_NAME
(	
    DMWLUBN_ID                      NUMBER, 
	"Last Update By Name"           VARCHAR2(100)
) 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX DMWLUBN_UIX1 ON D_MW_LAST_UPDATE_BY_NAME ("Last Update By Name" ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX DMWLUBN_PK ON D_MW_LAST_UPDATE_BY_NAME (DMWLUBN_ID ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON D_MW_LAST_UPDATE_BY_NAME TO MAXDAT_READ_ONLY;

CREATE TABLE D_MW_OWNER
(	
    DMWO_ID                     NUMBER, 
	"Owner Name"                VARCHAR2(100)
) 
TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX DMWO_UIX1 ON D_MW_OWNER ("Owner Name" ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX DMWO_PK ON D_MW_OWNER (DMWO_ID ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON D_MW_OWNER TO MAXDAT_READ_ONLY;

GRANT SELECT ON D_MW_TASK_STATUS TO MAXDAT_READ_ONLY;

GRANT SELECT ON D_MW_TASK_TYPE TO MAXDAT_READ_ONLY;

CREATE TABLE HCO_SYSTEM_LKUP
(
    SYS_ID                          NUMBER(10,0) NOT NULL ENABLE, 
	SYSTEM_NAME                     VARCHAR2(100), 
	BUS_AVAIL_STARTTIME             VARCHAR2(10), 
	BUS_AVAIL_ENDTIME               VARCHAR2(10), 
	TOTAL_BUS_AVAIL_IN_MINS         NUMBER(10,0) NOT NULL ENABLE, 
	DOWNTIME_ALLOWED_IN_MINS        NUMBER(10,0) NOT NULL ENABLE, 
	ACTIVE                          VARCHAR2(1), 
    PRIMARY KEY (SYS_ID) ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_SYSTEM_LKUP TO MAXDAT_READ_ONLY;

CREATE TABLE HCO_TRACK_DOWNTIME
(	
    TRACK_ID                            NUMBER(10,0) NOT NULL ENABLE, 
	SYS_ID                              NUMBER(10,0), 
	INCIDENT_DATE                       DATE, 
	SCHEDULED                           VARCHAR2(1), 
	TICKET_ID                           NUMBER(10,0), 
	ACTUAL_DOWNTIME_IN_MINS             NUMBER(10,0) NOT NULL ENABLE, 
	COMMENTS                            VARCHAR2(500), 
    CONSTRAINT TRACK_SYS_ID_FK FOREIGN KEY (SYS_ID)
    REFERENCES HCO_SYSTEM_LKUP (SYS_ID) ENABLE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_TRACK_DOWNTIME TO MAXDAT_READ_ONLY;
