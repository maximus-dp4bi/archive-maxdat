﻿/*
Created: 11/7/2019
Modified: 12/3/2019
Model: maxbae_maxbaeprd Mart Layer Tables and Views
Database: MS SQL Server 2016
*/
use MAXBAE
go
-- Create tables section -------------------------------------------------

-- Table maxbaeprd.D_CALENDAR_DLY

CREATE TABLE [maxbaeprd].[D_CALENDAR_DLY]
(
 [DT] Date NOT NULL,
 [DAY] Varchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAY_NAME] Varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAY_OF_WEEK] Varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAY_OF_MONTH] Varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAY_OF_YEAR] Varchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MONTH] Varchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MONTH_NUM] Varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MONTH_NAME] Varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [WEEK_OF_MONTH] Varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [WEEK_OF_YEAR] Varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [YEAR] Varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [WEEKEND_FLAG] Char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.D_CALENDAR_DLY

ALTER TABLE [maxbaeprd].[D_CALENDAR_DLY] ADD CONSTRAINT [PK_D_CALENDAR_DLY] PRIMARY KEY ([DT])
 ON [PRIMARY]
go

-- Table maxbaeprd.D_EMPLOYEE_DLY

CREATE TABLE [maxbaeprd].[D_EMPLOYEE_DLY]
(
 [DT] Date DEFAULT (CONVERT([date],getdate())) NOT NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [FIRST_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [LAST_NAME] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [FULL_NAME] Nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [POSITION_TITLE] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [POSITION_TITLE_EFF_DT] Date NULL,
 [DAYS_IN_POSITION] Int NULL,
 [EMPLOYMENT_CATEGORY] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [STATUS] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [STATUS_EFF_DT] Date NULL,
 [DAYS_IN_STATUS] Int NULL,
 [CITY] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [STATE] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ORG_ID_DELTEK] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [LABOR_LOCATION_DESC_DELTEK] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ORG_ID_WORKDAY] Nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROJECT_ID_WORKDAY] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROJECT_NAME_WORKDAY] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SITE_BARTECH] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ACCOUNT_CD_CD_BARTECH] Varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [HOURLY_RT] Decimal(18,6) NULL,
 [HOURLY_RT_EFF_DT] Date NULL,
 [DAYS_IN_HOURLY_RT] Int NULL,
 [EMP_ID_MGR_LVL_1] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_NAME_LVL_1] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_LVL_1_EFF_DT] Date NULL,
 [DAYS_IN_MGR_LVL_1] Int NULL,
 [EMP_ID_MGR_LVL_2] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_NAME_LVL_2] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_LVL_2_EFF_DT] Date NULL,
 [DAYS_IN_MGR_LVL_2] Int NULL,
 [EMP_ID_MGR_LVL_3] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_NAME_LVL_3] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MGR_LVL_3_EFF_DT] Date NULL,
 [DAYS_IN_MGR_LVL_3] Int NULL,
 [ORIGINAL_HIRE_DT] Date NULL,
 [LENGTH_OF_SERVICE] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAYS_SINCE_ORIGINAL_HIRE] Int NULL,
 [LAST_HIRE_DT] Date NULL,
 [DAYS_SINCE_LAST_HIRE] Int NULL,
 [CONVERSION_DT] Date NULL,
 [DAYS_SINCE_CONVERSION] Int NULL,
 [CONTINUOUS_SERVICE_DT] Date NULL,
 [LOA_END_DT] Date NULL,
 [DAYS_SINCE_LOA_END] Int NULL,
 [TERMINATION_DT] Date NULL,
 [DAYS_SINCE_TERMINATION] Int NULL,
 [TERMINATION_REASON] Nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [TERMINATION_CATEGORY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [HIRING_TEST_SCORE] Numeric(4,2) NULL,
 [TRAINING_DAYS] Numeric(3,1) NULL,
 [SUPPLIER] Nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SUPPLIER_EFF_DT] Date NULL,
 [REHIRE_DT] Date NULL,
 [DAYS_SINCE_REHIRE] Int NULL,
 [WORK_DAYS_PER_WK] Int NULL,
 [LANGUAGE_1] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [LANGUAGE_2] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MULTILINGUAL] Bit NULL,
 [ROLE] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SITE_WFM] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [TEAM] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [TEAM_SET_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [TEAM_SET_NAME_EFF_DT] Date NULL,
 [WORK_STATUS] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MANAGEMENT_UNIT_NAME] Nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [JOB_TITLE] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SITE_ACD] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROJECT_ID_ACD] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROJECT_NAME_ACD] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROGRAM_ID_ACD] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PROGRAM_NAME_ACD] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.D_EMPLOYEE_DLY

ALTER TABLE [maxbaeprd].[D_EMPLOYEE_DLY] ADD CONSTRAINT [PK_D_EMPLOYEE_DLY] PRIMARY KEY ([DT],[PERSON_ID])
 ON [PRIMARY]
go

-- Table maxbaeprd.F_ACD_EMPLOYEE_DLY

CREATE TABLE [maxbaeprd].[F_ACD_EMPLOYEE_DLY]
(
 [DT] Date NOT NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_ID] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_LOGON_ID] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_FIRST_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [AGENT_LAST_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [BREAK_TIME] Decimal(18,3) NULL,
 [LUNCH_TIME] Decimal(18,3) NULL,
 [MEETING] Decimal(18,3) NULL,
 [NR_NOT_PRODUCTIVE] Decimal(18,3) NULL,
 [NR_PRODUCTIVE] Decimal(18,3) NULL,
 [TRAINING] Decimal(18,3) NULL,
 [SYSTEM_ISSUE] Decimal(18,3) NULL,
 [END_OF_SHIFT] Decimal(18,3) NULL,
 [AGENT_BY_DT_FIRST_LOGIN_DT] Datetime NULL,
 [AGENT_BY_DT_LAST_LOGOUT_DT] Datetime NULL,
 [ABD_HANDLE_CALLS_CNT] Int NULL,
 [ABD_INTERNAL_CALLS_CNT] Int NULL,
 [ABD_EXTERNAL_CALLS_CNT] Int NULL,
 [ABD_HANDLE_TIME] Decimal(18,3) NULL,
 [ABD_INTERNAL] Decimal(18,3) NULL,
 [ABD_EXTERNAL] Decimal(18,3) NULL,
 [ABD_HOLD] Decimal(18,3) NULL,
 [ABD_RING] Decimal(18,3) NULL,
 [ABD_TALK] Decimal(18,3) NULL,
 [ABD_WRAP] Decimal(18,3) NULL,
 [ABD_IDLE] Decimal(18,3) NULL,
 [ABD_NOT_READY] Decimal(18,3) NULL,
 [ABD_LOGIN] Decimal(18,3) NULL,
 [AT_WORK_AVAILABILITY] Decimal(18,3) NULL,
 [AVAILABILITY_TOTAL_UTILIZATION] Decimal(18,3) NULL,
 [OCCUPANCY] Decimal(18,3) NULL,
 [TOTAL_READY_TIME] Decimal(18,3) NULL,
 [CALLS_PER_READY_HOUR] Decimal(18,3) NULL,
 [PRODUCTIVE_MINUTES] Decimal(18,3) NULL,
 [BILLABLE_MINUTES] Decimal(18,3) NULL,
 [AT_WORK_PAID_MINUTES] Decimal(18,3) NULL,
 [DLY_QUEUE_CNT] Int NULL,
 [ACW] Decimal(18,3) NULL,
 [CREATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.F_ACD_EMPLOYEE_DLY

ALTER TABLE [maxbaeprd].[F_ACD_EMPLOYEE_DLY] ADD CONSTRAINT [PK_F_ACD_EMPLOYEE_DLY] PRIMARY KEY ([PERSON_ID],[DT])
 ON [PRIMARY]
go

-- Table maxbaeprd.F_CM_EMPLOYEE_DLY

CREATE TABLE [maxbaeprd].[F_CM_EMPLOYEE_DLY]
(
 [DT] Date NOT NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [DIRECTION] Varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [ENGAGE_DIRECTION] Varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_LOGON_ID] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [AGENT_FIRST_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [AGENT_LAST_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DLY_CALL_CNT] Int NULL,
 [DLY_SILENCE_DURATION_MAX] Decimal(18,3) NULL,
 [DLY_SILENCE_PERCENT] Decimal(18,3) NULL,
 [DLY_AHT] Decimal(18,3) NULL,
 [DLY_AGITATION] Decimal(18,3) NULL,
 [DLY_INBOUND_AUTHENTICATION] Decimal(18,3) NULL,
 [DLY_INBOUND_CLOSING] Decimal(18,3) NULL,
 [DLY_COMPLIMENTS] Decimal(18,3) NULL,
 [DLY_DISSATISFACTION] Decimal(18,3) NULL,
 [DLY_EMPATHY] Decimal(18,3) NULL,
 [DLY_EMPATHY_AFTER_DISSAT] Decimal(18,3) NULL,
 [DLY_ESCALATION] Decimal(18,3) NULL,
 [DLY_HOLD_IMMEDIATE] Decimal(18,3) NULL,
 [DLY_HOLD_BEGINNING] Decimal(18,3) NULL,
 [DLY_INBOUND_GREETING] Decimal(18,3) NULL,
 [DLY_HOLD_LANGUAGE] Decimal(18,3) NULL,
 [DLY_HOLD_NEAR_TRANSFER] Decimal(18,3) NULL,
 [DLY_POLITENESS] Decimal(18,3) NULL,
 [DLY_TRANSFER_LANGUAGE] Decimal(18,3) NULL,
 [DLY_UNDERSTANDIBILITY_ISSUES_MULTIPLE] Decimal(18,3) NULL,
 [DLY_WALKED_DOWN_DISSAT] Decimal(18,3) NULL,
 [DLY_AGENT_OWNERSHIP] Decimal(18,3) NULL,
 [DLY_EMOTIONAL_CONTENT] Decimal(18,3) NULL,
 [DLY_EXCESSIVE_SILENCE] Decimal(18,3) NULL,
 [DLY_LONGEST_CONTACTS] Decimal(18,3) NULL,
 [DLY_CONFUSION] Decimal(18,3) NULL,
 [DLY_AGENT_QUALITY] Decimal(18,3) NULL,
 [DLY_CUSTOMER_SATISFACTION] Decimal(18,3) NULL,
 [DLY_INBOUND_CUST_EXP] Decimal(18,3) NULL,
 [DLY_DS_AGENT_PERFORMANCE] Decimal(18,3) NULL,
 [DLY_UNDERSTANDIBILITY] Decimal(18,3) NULL,
 [DLY_EMOTION] Decimal(18,3) NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.F_CM_EMPLOYEE_DLY

ALTER TABLE [maxbaeprd].[F_CM_EMPLOYEE_DLY] ADD CONSTRAINT [PK_F_CM_EMPLOYEE_DLY] PRIMARY KEY ([DT],[DIRECTION],[PERSON_ID],[ENGAGE_DIRECTION])
 ON [PRIMARY]
go

-- Table maxbaeprd.F_WFM_EMPLOYEE_ADHERENCE_DLY

CREATE TABLE [maxbaeprd].[F_WFM_EMPLOYEE_ADHERENCE_DLY]
(
 [DT] Date NOT NULL,
 [INT_START_TIME] Time(7) NOT NULL,
 [INTERVAL_START_DT] Datetime NOT NULL,
 [MANAGEMENT_UNIT_TIME_ZONE_NAME] Varchar(34) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MANAGEMENT_UNIT_ID] Int NULL,
 [MANAGEMENT_UNIT_NAME] Varchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_WFM_ID] Int NULL,
 [ACD_ID] Int NULL,
 [AGENT_LOGON_ID] Varchar(256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [AGENT_FULL_NAME] Varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MODIFIED_DT] Datetime NULL,
 [SCHEDULED_ACTIVITY_NAME] Varchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SCHEDULED_ACTIVITY_DURATION] Decimal(18,3) NULL,
 [IN_ADHERENCE_DURATION] Decimal(18,3) NULL,
 [OUT_ADHERENCE_DURATION] Decimal(18,3) NULL,
 [INTERVAL_DURATION] Decimal(18,3) NULL,
 [ADHERENCE_PCT] Decimal(18,3) NULL,
 [EXTERNAL_ID] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Table maxbaeprd.F_WFM_EMPLOYEE_DLY

CREATE TABLE [maxbaeprd].[F_WFM_EMPLOYEE_DLY]
(
 [DT] Date NOT NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_WFM_ID] Nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [FIRST_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [LAST_NAME] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [DAILY_SCHEDULE_RULE_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAILY_SCHEDULE_CHANGE] Binary(1) NULL,
 [WEEKLY_SCHEDULE_CHANGE] Int NULL,
 [SCHEDULE_LENGTH] Decimal(18,3) NULL,
 [ADJUSTED_ACTUAL_LENGTH] Decimal(18,3) NULL,
 [OFF_PHONE_ACTIVITY] Decimal(18,3) NULL,
 [PLANNED_ABSENTEEISM] Decimal(18,3) NULL,
 [UNPLANNED_ABSENTEEISM] Decimal(18,3) NULL,
 [AVAILABILITY] Decimal(18,3) NULL,
 [VTO] Decimal(18,3) NULL,
 [PTO] Decimal(18,3) NULL,
 [OVERTIME_HOURS] Decimal(18,3) NULL,
 [TRAINING_HOURS] Decimal(18,3) NULL,
 [LUNCH_HOURS] Decimal(18,3) NULL,
 [BREAK_HOURS] Decimal(18,3) NULL,
 [LATE_ARRIVAL] Decimal(18,3) NULL,
 [EARLY_DEPARTURE] Decimal(18,3) NULL,
 [KINCARE] Decimal(18,3) NULL,
 [LWOP] Decimal(18,3) NULL,
 [NCNS] Decimal(18,3) NULL,
 [JURY_DUTY] Decimal(18,3) NULL,
 [LOA] Decimal(18,3) NULL,
 [SICK_PAID] Decimal(18,3) NULL,
 [OUT_OF_OFFICE_PAID] Decimal(18,3) NULL,
 [FMLA] Decimal(18,3) NULL,
 [MILITARY_LEAVE] Decimal(18,3) NULL,
 [SCHEDULE_ADHERENCE] Decimal(18,3) NULL,
 [ATTENDANCE] Decimal(18,3) NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.F_WFM_EMPLOYEE_DLY

ALTER TABLE [maxbaeprd].[F_WFM_EMPLOYEE_DLY] ADD CONSTRAINT [PK_F_WFM_EMPLOYEE_DLY] PRIMARY KEY ([PERSON_ID],[DT])
 ON [PRIMARY]
go

-- Table maxbaeprd.F_WFM_EMPLOYEE_SCHEDULE_DLY

CREATE TABLE [maxbaeprd].[F_WFM_EMPLOYEE_SCHEDULE_DLY]
(
 [DT] Date NOT NULL,
 [PERSON_ID] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_WFM_ID] Nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [FIRST_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [LAST_NAME] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DAILY_SCHEDULE_RULE_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [IS_CURRENT_SCHEDULE] Varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [SCHEDULE_START_DT] Datetime NULL,
 [SCHEDULE_END_DT] Datetime NULL,
 [ABSENTEEISM_START_DT] Datetime NOT NULL,
 [ABSENTEEISM_END_DT] Datetime NOT NULL,
 [MANAGEMENT_UNIT_TIME_ZONE_NAME] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ABSENTEEISM_TYPE] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ACTIVITY_DURATION_MIN] Decimal(18,3) NULL,
 [SCHEDULE_DURATION_MIN] Decimal(18,3) NULL,
 [IS_PAID_ACTIVITY] Varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Add keys for table maxbaeprd.F_WFM_EMPLOYEE_SCHEDULE_DLY

ALTER TABLE [maxbaeprd].[F_WFM_EMPLOYEE_SCHEDULE_DLY] ADD CONSTRAINT [PK_F_WFM_EMPLOYEE_SCHEDULE_DLY] PRIMARY KEY ([PERSON_ID],[DT],[ABSENTEEISM_START_DT],[ABSENTEEISM_END_DT])
 ON [PRIMARY]
go

-- Create views section -------------------------------------------------

CREATE VIEW [maxbaeprd].[AGENT_ADHERENCE_SV] AS
SELECT [INT_START_DT] AS [INT_START_DATE], [INT_START_TIME], [INTERVAL_START_DT], [MANAGEMENT_UNIT_TIME_ZONE_NAME], [MANAGEMENT_UNIT_ID], [MANAGEMENT_UNIT_NAME], [AGENT_WFM_ID], [ACD_ID], [AGENT_LOGON_ID], [AGENT_FULL_NAME], [MODIFIED_DT], [SCHEDULED_ACTIVITY_NAME], [SCHEDULED_ACTIVITY_DURATION] AS [SCHEDULED_ACTIVITY_DURATION_SEC], [IN_ADHERENCE_DURATION] AS [IN_ADHERENCE_DURATION_SEC], [OUT_ADHERENCE_DURATION] AS [OUT_ADHERENCE_DURATION_SEC], [INTERVAL_DURATION] AS [INTERVAL_DURATION_SEC], [ADHERENCE_PCT], [EXTERNAL_ID]
FROM [maxbaeprd].[BSE_WFM_AGENT_ADHERENCE]
go

CREATE VIEW [maxbaeprd].[D_CALENDAR_DLY_V] AS
SELECT [DT], [DAY], [DAY_NAME], [DAY_OF_WEEK], [DAY_OF_MONTH], [DAY_OF_YEAR], [MONTH], [MONTH_NUM], [MONTH_NAME], [WEEK_OF_MONTH], [WEEK_OF_YEAR], [YEAR], [WEEKEND_FLAG], [CREATE_DT], [CREATED_BY], [UPDATE_DT], [UPDATED_BY]
FROM [maxbaeprd].[D_CALENDAR_DLY]
go

CREATE VIEW [maxbaeprd].[D_EMPLOYEE_DLY_V] AS
SELECT [e].[DT], [e].[PERSON_ID], [e].[FIRST_NAME], [e].[LAST_NAME], [e].[FULL_NAME], [e].[POSITION_TITLE], [e].[POSITION_TITLE_EFF_DT], [e].[DAYS_IN_POSITION], [e].[EMPLOYMENT_CATEGORY], [e].[STATUS], [e].[STATUS_EFF_DT], [e].[DAYS_IN_STATUS], [e].[CITY], [e].[STATE], [e].[ORG_ID_DELTEK], [e].[LABOR_LOCATION_DESC_DELTEK], [e].[ORG_ID_WORKDAY], [e].[PROJECT_ID_WORKDAY], [e].[PROJECT_NAME_WORKDAY], [e].[SITE_BARTECH], [e].[ACCOUNT_CD_CD_BARTECH], [e].[HOURLY_RT], [e].[HOURLY_RT_EFF_DT], [e].[DAYS_IN_HOURLY_RT], [e].[EMP_ID_MGR_LVL_1], [e].[MGR_NAME_LVL_1], [e].[MGR_LVL_1_EFF_DT], [e].[DAYS_IN_MGR_LVL_1], [e].[EMP_ID_MGR_LVL_2], [e].[MGR_NAME_LVL_2], [e].[MGR_LVL_2_EFF_DT], [e].[DAYS_IN_MGR_LVL_2], [e].[EMP_ID_MGR_LVL_3], [e].[MGR_NAME_LVL_3], [e].[MGR_LVL_3_EFF_DT], [e].[DAYS_IN_MGR_LVL_3], [e].[ORIGINAL_HIRE_DT], [e].[LENGTH_OF_SERVICE], [e].[DAYS_SINCE_ORIGINAL_HIRE], [e].[LAST_HIRE_DT], [e].[DAYS_SINCE_LAST_HIRE], [e].[CONVERSION_DT], [e].[DAYS_SINCE_CONVERSION], [e].[CONTINUOUS_SERVICE_DT], [e].[LOA_END_DT], [e].[DAYS_SINCE_LOA_END], [e].[TERMINATION_DT], [e].[DAYS_SINCE_TERMINATION], [e].[TERMINATION_REASON], [e].[TERMINATION_CATEGORY], [e].[HIRING_TEST_SCORE], [e].[TRAINING_DAYS], [e].[SUPPLIER], [e].[SUPPLIER_EFF_DT], [e].[REHIRE_DT], [e].[DAYS_SINCE_REHIRE], [e].[WORK_DAYS_PER_WK], [e].[LANGUAGE_1], [e].[LANGUAGE_2], [e].[MULTILINGUAL], [e].[ROLE], [e].[SITE_WFM], [e].[TEAM], [e].[TEAM_SET_NAME], [e].[TEAM_SET_NAME_EFF_DT], [e].[WORK_STATUS], [e].[MANAGEMENT_UNIT_NAME], [e].[JOB_TITLE], [e].[SITE_ACD], [e].[PROJECT_ID_ACD], [e].[PROJECT_NAME_ACD], [e].[PROGRAM_ID_ACD], [e].[PROGRAM_NAME_ACD], [e].[CREATE_DT], [e].[CREATED_BY], [e].[UPDATE_DT], [e].[UPDATED_BY]
FROM [maxbaeprd].[D_EMPLOYEE_DLY] [e]
go

CREATE VIEW [maxbaeprd].[F_ACD_EMPLOYEE_DLY_V] AS
SELECT [acd].[DT], [acd].[PERSON_ID], [acd].[AGENT_ID], [acd].[AGENT_LOGON_ID], [acd].[AGENT_FIRST_NAME], [acd].[AGENT_LAST_NAME], [acd].[BREAK_TIME], [acd].[MEETING], [acd].[NR_NOT_PRODUCTIVE], [acd].[NR_PRODUCTIVE], [acd].[TRAINING], [acd].[SYSTEM_ISSUE], [acd].[END_OF_SHIFT], [acd].[AGENT_BY_DT_FIRST_LOGIN_DT], [acd].[AGENT_BY_DT_LAST_LOGOUT_DT], [acd].[ABD_HANDLE_CALLS_CNT], [acd].[ABD_INTERNAL_CALLS_CNT], [acd].[ABD_EXTERNAL_CALLS_CNT], [acd].[ABD_HANDLE_TIME], [acd].[ABD_INTERNAL], [acd].[ABD_EXTERNAL], [acd].[ABD_HOLD], [acd].[ABD_RING], [acd].[ABD_TALK], [acd].[ABD_WRAP], [acd].[ABD_IDLE], [acd].[ABD_NOT_READY], [acd].[ABD_LOGIN], [acd].[AT_WORK_AVAILABILITY], [acd].[AVAILABILITY_TOTAL_UTILIZATION], [acd].[OCCUPANCY], [acd].[TOTAL_READY_TIME], [acd].[CALLS_PER_READY_HOUR], [acd].[PRODUCTIVE_MINUTES], [acd].[BILLABLE_MINUTES], [acd].[AT_WORK_PAID_MINUTES], [acd].[DLY_QUEUE_CNT], [acd].[CREATE_DT], [acd].[UPDATED_BY], [acd].[CREATED_BY], [acd].[UPDATE_DT], [acd].[LUNCH_TIME], [acd].[ACW]
FROM [maxbaeprd].[F_ACD_EMPLOYEE_DLY] [acd]
go

CREATE VIEW [maxbaeprd].[F_CM_EMPLOYEE_DLY_V] AS
SELECT [cm].[DT], [cm].[PERSON_ID], [cm].[DIRECTION], [cm].[ENGAGE_DIRECTION], [cm].[AGENT_LOGON_ID], [cm].[AGENT_FIRST_NAME], [cm].[AGENT_LAST_NAME], [cm].[DLY_CALL_CNT], [cm].[DLY_SILENCE_DURATION_MAX], [cm].[DLY_SILENCE_PERCENT], [cm].[DLY_AHT], [cm].[DLY_AGITATION], [cm].[DLY_INBOUND_AUTHENTICATION], [cm].[DLY_INBOUND_CLOSING], [cm].[DLY_COMPLIMENTS], [cm].[DLY_DISSATISFACTION], [cm].[DLY_EMPATHY], [cm].[DLY_EMPATHY_AFTER_DISSAT], [cm].[DLY_ESCALATION], [cm].[DLY_HOLD_IMMEDIATE], [cm].[DLY_HOLD_BEGINNING], [cm].[DLY_INBOUND_GREETING], [cm].[DLY_HOLD_LANGUAGE], [cm].[DLY_HOLD_NEAR_TRANSFER], [cm].[DLY_POLITENESS], [cm].[DLY_TRANSFER_LANGUAGE], [cm].[DLY_UNDERSTANDIBILITY_ISSUES_MULTIPLE], [cm].[DLY_WALKED_DOWN_DISSAT], [cm].[DLY_AGENT_OWNERSHIP], [cm].[DLY_EMOTIONAL_CONTENT], [cm].[DLY_EXCESSIVE_SILENCE], [cm].[DLY_LONGEST_CONTACTS], [cm].[DLY_CONFUSION], [cm].[DLY_AGENT_QUALITY], [cm].[DLY_CUSTOMER_SATISFACTION], [cm].[DLY_INBOUND_CUST_EXP], [cm].[DLY_DS_AGENT_PERFORMANCE], [cm].[DLY_UNDERSTANDIBILITY], [cm].[DLY_EMOTION], [cm].[CREATE_DT], [cm].[CREATED_BY], [cm].[UPDATE_DT], [cm].[UPDATED_BY]
FROM [maxbaeprd].[F_CM_EMPLOYEE_DLY] [cm]
go

CREATE VIEW [maxbaeprd].[F_WFM_EMPLOYEE_ADHERENCE_DLY_V] AS
SELECT [DT], [INT_START_TIME], [INTERVAL_START_DT], [MANAGEMENT_UNIT_TIME_ZONE_NAME], [MANAGEMENT_UNIT_ID], [MANAGEMENT_UNIT_NAME], [PERSON_ID], [AGENT_WFM_ID], [ACD_ID], [AGENT_LOGON_ID], [AGENT_FULL_NAME], [MODIFIED_DT], [SCHEDULED_ACTIVITY_NAME], [SCHEDULED_ACTIVITY_DURATION], [IN_ADHERENCE_DURATION], [OUT_ADHERENCE_DURATION], [INTERVAL_DURATION], [ADHERENCE_PCT], [EXTERNAL_ID], [CREATE_DT], [CREATED_BY], [UPDATE_DT], [UPDATED_BY]
FROM [maxbaeprd].[F_WFM_EMPLOYEE_ADHERENCE_DLY]
go

CREATE VIEW [maxbaeprd].[F_WFM_EMPLOYEE_DLY_V] AS
SELECT [wfm].[DT], [wfm].[PERSON_ID], [wfm].[AGENT_WFM_ID], [wfm].[FIRST_NAME], [wfm].[LAST_NAME], [wfm].[DAILY_SCHEDULE_RULE_NAME], [wfm].[DAILY_SCHEDULE_CHANGE], [wfm].[WEEKLY_SCHEDULE_CHANGE], [wfm].[SCHEDULE_LENGTH], [wfm].[ADJUSTED_ACTUAL_LENGTH], [wfm].[OFF_PHONE_ACTIVITY], [wfm].[PLANNED_ABSENTEEISM], [wfm].[UNPLANNED_ABSENTEEISM], [wfm].[AVAILABILITY], [wfm].[VTO], [wfm].[PTO], [wfm].[OVERTIME_HOURS], [wfm].[TRAINING_HOURS], [wfm].[LUNCH_HOURS], [wfm].[BREAK_HOURS], [wfm].[LATE_ARRIVAL], [wfm].[EARLY_DEPARTURE], [wfm].[KINCARE], [wfm].[LWOP], [wfm].[NCNS], [wfm].[JURY_DUTY], [wfm].[LOA], [wfm].[SICK_PAID], [wfm].[OUT_OF_OFFICE_PAID], [wfm].[FMLA], [wfm].[MILITARY_LEAVE], [wfm].[SCHEDULE_ADHERENCE], [wfm].[ATTENDANCE], [wfm].[CREATE_DT], [wfm].[CREATED_BY], [wfm].[UPDATE_DT], [wfm].[UPDATED_BY]
FROM [maxbaeprd].[F_WFM_EMPLOYEE_DLY] [wfm]
go

CREATE VIEW [maxbaeprd].[F_WFM_EMPLOYEE_SCHEDULE_DLY_V] AS
SELECT [DT], [PERSON_ID], [AGENT_WFM_ID], [FIRST_NAME], [LAST_NAME], [DAILY_SCHEDULE_RULE_NAME], [IS_CURRENT_SCHEDULE], [SCHEDULE_START_DT], [SCHEDULE_END_DT], [ABSENTEEISM_START_DT], [ABSENTEEISM_END_DT], [MANAGEMENT_UNIT_TIME_ZONE_NAME], [ABSENTEEISM_TYPE], [ACTIVITY_DURATION_MIN], [SCHEDULE_DURATION_MIN], [IS_PAID_ACTIVITY], [CREATE_DT], [CREATED_BY], [UPDATE_DT], [UPDATED_BY]
FROM [maxbaeprd].[F_WFM_EMPLOYEE_SCHEDULE_DLY]
go
