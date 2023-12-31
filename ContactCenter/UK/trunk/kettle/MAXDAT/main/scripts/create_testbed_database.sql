/****** Object:  Database [MAXDAT]    Script Date: 7/12/2013 2:22:22 PM ******/
USE uk_hws
go

drop table MAXDAT.agent;
drop table MAXDAT.Agent_Logout
drop table MAXDAT.Agent_Interval
drop table MAXDAT.Agent_Skill_Group_Interval
drop table MAXDAT.Agent_Team
drop table MAXDAT.Agent_Team_Member
drop table MAXDAT.Agent_Team_Supervisor
drop table MAXDAT.Bucket_Intervals
drop table MAXDAT.Call_Type
drop table MAXDAT.Call_Type_Interval
drop table MAXDAT.Call_Type_SG_Interval
drop table MAXDAT.CC_S_TMP_CISCO_AGENT
drop table MAXDAT.Person
drop table MAXDAT.Route_Call_Detail
drop table MAXDAT.Skill_Group
drop table MAXDAT.Skill_Group_Interval
drop table MAXDAT.Skill_Group_Member
drop table MAXDAT.Termination_Call_Detail

drop table dbo.agent;
drop table dbo.Agent_Logout
drop table dbo.Agent_Interval
drop table dbo.Agent_Skill_Group_Interval
drop table dbo.Agent_Team
drop table dbo.Agent_Team_Member
drop table dbo.Agent_Team_Supervisor
drop table dbo.Bucket_Intervals
drop table dbo.Call_Type
drop table dbo.Call_Type_Interval
drop table dbo.Call_Type_SG_Interval
drop table dbo.CC_S_TMP_CISCO_AGENT
drop table dbo.Person
drop table dbo.Route_Call_Detail
drop table dbo.Skill_Group
drop table dbo.Skill_Group_Interval
drop table dbo.Skill_Group_Member
drop table dbo.Termination_Call_Detail


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail] DROP CONSTRAINT [fk_Termination_Call_Detail_Skill_Group]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail] DROP CONSTRAINT [fk_Termination_Call_Detail_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member] DROP CONSTRAINT [fk_Skill_Group_Member_Skill_Group]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member] DROP CONSTRAINT [fk_Skill_Group_Member_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Skill_Group_Interval] DROP CONSTRAINT [fk_Skill_Group_Interval_Skill_Group]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Route_Call_Detail_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Route_Call_Detail]'))
ALTER TABLE MAXDAT.[Route_Call_Detail] DROP CONSTRAINT [fk_Route_Call_Detail_Call_Type]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval] DROP CONSTRAINT [fk_Call_Type_SG_Interval_Skill_Group]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval] DROP CONSTRAINT [fk_Call_Type_SG_Interval_Call_Type]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_Interval] DROP CONSTRAINT [fk_Call_Type_Interval_Call_Type]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Bucket_Interval]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type]'))
ALTER TABLE MAXDAT.[Call_Type] DROP CONSTRAINT [fk_Call_Type_Bucket_Interval]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent_Team]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member] DROP CONSTRAINT [fk_Agent_Team_Member_Agent_Team]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member] DROP CONSTRAINT [fk_Agent_Team_Member_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Supervisor]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team]'))
ALTER TABLE MAXDAT.[Agent_Team] DROP CONSTRAINT [fk_Agent_Team_Supervisor]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval] DROP CONSTRAINT [fk_Agent_Skill_Group_Interval_Skill_Group]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval] DROP CONSTRAINT [fk_Agent_Skill_Group_Interval_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Logout_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Logout]'))
ALTER TABLE MAXDAT.[Agent_Logout] DROP CONSTRAINT [fk_Agent_Logout_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Interval]'))
ALTER TABLE MAXDAT.[Agent_Interval] DROP CONSTRAINT [fk_Agent_Interval_Agent]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent] DROP CONSTRAINT [fk_Person]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent] DROP CONSTRAINT [fk_Agent_Person]
GO
/****** Object:  Table MAXDAT.[Termination_Call_Detail]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]') AND type in (N'U'))
DROP TABLE MAXDAT.[Termination_Call_Detail]
GO
/****** Object:  Table MAXDAT.[Skill_Group_Member]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]') AND type in (N'U'))
DROP TABLE MAXDAT.[Skill_Group_Member]
GO
/****** Object:  Table MAXDAT.[Skill_Group_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Interval]') AND type in (N'U'))
DROP TABLE MAXDAT.[Skill_Group_Interval]
GO
/****** Object:  Table MAXDAT.[Skill_Group]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group]') AND type in (N'U'))
DROP TABLE MAXDAT.[Skill_Group]
GO
/****** Object:  Table MAXDAT.[Route_Call_Detail]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Route_Call_Detail]') AND type in (N'U'))
DROP TABLE MAXDAT.[Route_Call_Detail]
GO
/****** Object:  Table MAXDAT.[Person]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Person]') AND type in (N'U'))
DROP TABLE MAXDAT.[Person]
GO
/****** Object:  Table MAXDAT.[Call_Type_SG_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]') AND type in (N'U'))
DROP TABLE MAXDAT.[Call_Type_SG_Interval]
GO
/****** Object:  Table MAXDAT.[Call_Type_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type_Interval]') AND type in (N'U'))
DROP TABLE MAXDAT.[Call_Type_Interval]
GO
/****** Object:  Table MAXDAT.[Call_Type]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type]') AND type in (N'U'))
DROP TABLE MAXDAT.[Call_Type]
GO
/****** Object:  Table MAXDAT.[Bucket_Intervals]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Bucket_Intervals]') AND type in (N'U'))
DROP TABLE MAXDAT.[Bucket_Intervals]
GO
/****** Object:  Table MAXDAT.[Agent_Team_Supervisor]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Supervisor]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Team_Supervisor]
GO
/****** Object:  Table MAXDAT.[Agent_Team_Member]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Team_Member]
GO
/****** Object:  Table MAXDAT.[Agent_Team]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Team]
GO
/****** Object:  Table MAXDAT.[Agent_Skill_Group_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Skill_Group_Interval]
GO
/****** Object:  Table MAXDAT.[Agent_Logout]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Logout]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Logout]
GO
/****** Object:  Table MAXDAT.[Agent_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Interval]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent_Interval]
GO
/****** Object:  Table MAXDAT.[Agent]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent]') AND type in (N'U'))
DROP TABLE MAXDAT.[Agent]
GO
USE [master]
GO
/****** Object:  Database [MAXDAT]    Script Date: 10/18/2013 2:24:46 PM ******/
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'ebhdsdb')
DROP DATABASE [MAXDAT]
GO




/****** Object:  Database [MAXDAT]    Script Date: 10/18/2013 2:24:46 PM *****
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ebhdsdb')
BEGIN
CREATE DATABASE [MAXDAT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ebhdsdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MAXDAT\MSSQL\DATA\ebhdsdb.mdf' , SIZE = 1312768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ebhdsdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MAXDAT\MSSQL\DATA\ebhdsdb_log.ldf' , SIZE = 3164032KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
*/

ALTER DATABASE [MAXDAT] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MAXDAT].MAXDAT.[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MAXDAT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MAXDAT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MAXDAT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MAXDAT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MAXDAT] SET ARITHABORT OFF 
GO
ALTER DATABASE [MAXDAT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MAXDAT] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MAXDAT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MAXDAT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MAXDAT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MAXDAT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MAXDAT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MAXDAT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MAXDAT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MAXDAT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MAXDAT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MAXDAT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MAXDAT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MAXDAT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MAXDAT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MAXDAT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MAXDAT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MAXDAT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MAXDAT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MAXDAT] SET  MULTI_USER 
GO
ALTER DATABASE [MAXDAT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MAXDAT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MAXDAT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MAXDAT] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MAXDAT]
GO
/****** Object:  Table MAXDAT.[Agent]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent](
	[SkillTargetID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[AgentDeskSettingsID] [int] NULL,
	[ScheduleID] [int] NULL,
	[PeripheralID] [smallint] NOT NULL,
	[EnterpriseName] [varchar](32) NOT NULL,
	[PeripheralNumber] [varchar](32) NOT NULL,
	[ConfigParam] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
	[Deleted] [bit] NOT NULL,
	[PeripheralName] [varchar](32) NULL,
	[TemporaryAgent] [bit] NOT NULL,
	[AgentStateTrace] [bit] NOT NULL,
	[SupervisorAgent] [bit] NOT NULL,
	[ChangeStamp] [int] NOT NULL,
	[UserDeletable] [bit] NOT NULL,
	[DefaultSkillGroup] [int] NULL,
 CONSTRAINT [PK_Agent] PRIMARY KEY CLUSTERED 
(
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Agent_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Interval]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Interval](
	[DateTime] [datetime] NOT NULL,
	[SkillTargetID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[MRDomainID] [int] NOT NULL,
	[RecoveryKey] [float] NOT NULL,
	[LoggedOnTime] [int] NULL,
	[AvailTime] [int] NULL,
	[NotReadyTime] [int] NULL,
	[TalkOtherTime] [int] NULL,
	[AvailableInMRDTime] [int] NULL,
	[RoutableInMRDTime] [int] NULL,
	[RouterCallsAbandQ] [int] NULL,
	[RouterQueueCalls] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[RouterCallsOffered] [int] NULL,
	[RouterCallsAband] [int] NULL,
	[RouterCallsDequeued] [int] NULL,
	[RouterCallsRedirected] [int] NULL,
	[RouterCallsAnswered] [int] NULL,
	[RouterCallsHandled] [int] NULL,
	[RouterError] [int] NULL,
	[Reserved1] [int] NULL,
	[Reserved2] [int] NULL,
	[Reserved3] [int] NULL,
	[Reserved4] [int] NULL,
	[Reserved5] [real] NULL,
	[ReportingHalfHour] [int] NULL,
	[ReportingInterval] [int] NULL,
	[NonACDLineCallsInCount] [int] NULL,
	[NonACDLineCallsOutCount] [int] NULL,
	[NonACDLineCallsInTime] [int] NULL,
	[NonACDLineCallsOutTime] [int] NULL,
	[Extension] [varchar](32) NULL,
 CONSTRAINT [pk_Agent_Interval] PRIMARY KEY CLUSTERED 
(
	[DateTime] ASC,
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Agent_Logout]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Logout]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Logout](
	[LogoutDateTime] [datetime] NOT NULL,
	[SkillTargetID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[MRDomainID] [int] NOT NULL,
	[LoginDuration] [int] NULL,
	[RecoveryKey] [float] NOT NULL,
	[ReasonCode] [int] NULL,
	[NetworkTargetID] [int] NULL,
	[Extension] [varchar](32) NULL,
	[PhoneType] [smallint] NULL,
	[RemotePhoneNumber] [varchar](32) NULL,
 CONSTRAINT [pk_Agent_Logout] PRIMARY KEY CLUSTERED 
(
	[LogoutDateTime] ASC,
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Agent_Skill_Group_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Skill_Group_Interval](
	[DateTime] [datetime] NOT NULL,
	[SkillTargetID] [int] NOT NULL,
	[SkillGroupSkillTargetID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[RecoveryKey] [float] NOT NULL,
	[AbandonRingCalls] [int] NULL,
	[AbandonRingTime] [int] NULL,
	[AbandonHoldCalls] [int] NULL,
	[AgentOutCallsTime] [int] NULL,
	[AgentOutCallsTalkTime] [int] NULL,
	[AgentOutCalls] [int] NULL,
	[AgentOutCallsOnHold] [int] NULL,
	[AgentOutCallsOnHoldTime] [int] NULL,
	[AgentTerminatedCalls] [int] NULL,
	[AnswerWaitTime] [int] NULL,
	[AvailTime] [int] NULL,
	[BusyOtherTime] [int] NULL,
	[CallbackMessagesTime] [int] NULL,
	[CallbackMessages] [int] NULL,
	[CallsAnswered] [int] NULL,
	[CallsHandled] [int] NULL,
	[ConsultativeCalls] [int] NULL,
	[ConsultativeCallsTime] [int] NULL,
	[ConferencedInCalls] [int] NULL,
	[ConferencedInCallsTime] [int] NULL,
	[ConferencedOutCalls] [int] NULL,
	[ConferencedOutCallsTime] [int] NULL,
	[HandledCallsTalkTime] [int] NULL,
	[HandledCallsTime] [int] NULL,
	[HoldTime] [int] NULL,
	[IncomingCallsOnHoldTime] [int] NULL,
	[IncomingCallsOnHold] [int] NULL,
	[InternalCallsOnHoldTime] [int] NULL,
	[InternalCallsOnHold] [int] NULL,
	[InternalCallsRcvdTime] [int] NULL,
	[InternalCallsRcvd] [int] NULL,
	[InternalCallsTime] [int] NULL,
	[InternalCalls] [int] NULL,
	[LoggedOnTime] [int] NULL,
	[NotReadyTime] [int] NULL,
	[RedirectNoAnsCalls] [int] NULL,
	[RedirectNoAnsCallsTime] [int] NULL,
	[ReservedStateTime] [int] NULL,
	[ShortCalls] [int] NULL,
	[SupervAssistCallsTime] [int] NULL,
	[SupervAssistCalls] [int] NULL,
	[TalkInTime] [int] NULL,
	[TalkOtherTime] [int] NULL,
	[TalkOutTime] [int] NULL,
	[TransferredInCallsTime] [int] NULL,
	[TransferredInCalls] [int] NULL,
	[TransferredOutCalls] [int] NULL,
	[WorkNotReadyTime] [int] NULL,
	[WorkReadyTime] [int] NULL,
	[AutoOutCalls] [int] NULL,
	[AutoOutCallsTime] [int] NULL,
	[AutoOutCallsTalkTime] [int] NULL,
	[AutoOutCallsOnHold] [int] NULL,
	[AutoOutCallsOnHoldTime] [int] NULL,
	[PreviewCalls] [int] NULL,
	[PreviewCallsTime] [int] NULL,
	[PreviewCallsTalkTime] [int] NULL,
	[PreviewCallsOnHold] [int] NULL,
	[PreviewCallsOnHoldTime] [int] NULL,
	[ReserveCalls] [int] NULL,
	[ReserveCallsTime] [int] NULL,
	[ReserveCallsTalkTime] [int] NULL,
	[ReserveCallsOnHold] [int] NULL,
	[ReserveCallsOnHoldTime] [int] NULL,
	[TalkAutoOutTime] [int] NULL,
	[TalkPreviewTime] [int] NULL,
	[TalkReserveTime] [int] NULL,
	[BargeInCalls] [int] NULL,
	[InterceptCalls] [int] NULL,
	[MonitorCalls] [int] NULL,
	[WhisperCalls] [int] NULL,
	[EmergencyAssists] [int] NULL,
	[InterruptedTime] [int] NULL,
	[AbandonHoldOutCalls] [int] NULL,
	[NetConsultativeCalls] [int] NULL,
	[NetConsultativeCallsTime] [int] NULL,
	[NetConferencedOutCalls] [int] NULL,
	[NetConfOutCallsTime] [int] NULL,
	[NetTransferredOutCalls] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[Reserved1] [int] NULL,
	[Reserved2] [int] NULL,
	[Reserved3] [int] NULL,
	[Reserved4] [int] NULL,
	[Reserved5] [real] NULL,
	[ReportingHalfHour] [int] NULL,
	[ReportingInterval] [int] NULL,
	[ConsultOutCalls] [int] NULL,
	[ConsultOutCallsTime] [int] NULL,
 CONSTRAINT [pk_Agent_Skill_Group_Interval] PRIMARY KEY CLUSTERED 
(
	[DateTime] ASC,
	[SkillTargetID] ASC,
	[SkillGroupSkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Agent_Team]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Team](
	[AgentTeamID] [int] NOT NULL,
	[EnterpriseName] [varchar](32) NOT NULL,
	[PeripheralID] [smallint] NOT NULL,
	[DialedNumberID] [int] NULL,
	[Description] [varchar](255) NULL,
	[PriSupervisorSkillTargetID] [int] NULL,
	[ChangeStamp] [int] NOT NULL,
 CONSTRAINT [pk_Agent_Team] PRIMARY KEY CLUSTERED 
(
	[AgentTeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Agent_Team_Member]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Team_Member](
	[AgentTeamID] [int] NOT NULL,
	[SkillTargetID] [int] NOT NULL,
 CONSTRAINT [pk_Agent_Team_Member] PRIMARY KEY CLUSTERED 
(
	[AgentTeamID] ASC,
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Agent_Team_Supervisor]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Supervisor]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Agent_Team_Supervisor](
	[AgentTeamID] [int] NOT NULL,
	[SupervisorSkillTargetID] [int] NOT NULL,
 CONSTRAINT [pk_Agent_Team_Supervisor] PRIMARY KEY CLUSTERED 
(
	[AgentTeamID] ASC,
	[SupervisorSkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Bucket_Intervals]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Bucket_Intervals]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Bucket_Intervals](
	[BucketIntervalID] [int] NOT NULL,
	[EnterpriseName] [varchar](32) NOT NULL,
	[IntervalUpperBound1] [int] NULL,
	[IntervalUpperBound2] [int] NULL,
	[IntervalUpperBound3] [int] NULL,
	[IntervalUpperBound4] [int] NULL,
	[IntervalUpperBound5] [int] NULL,
	[IntervalUpperBound6] [int] NULL,
	[IntervalUpperBound7] [int] NULL,
	[IntervalUpperBound8] [int] NULL,
	[IntervalUpperBound9] [int] NULL,
	[Deleted] [bit] NOT NULL,
	[ChangeStamp] [int] NOT NULL,
 CONSTRAINT [pk_Bucket_Intervals] PRIMARY KEY CLUSTERED 
(
	[BucketIntervalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Call_Type]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Call_Type](
	[CallTypeID] [int] NOT NULL,
	[CustomerDefinitionID] [int] NULL,
	[EnterpriseName] [varchar](32) NOT NULL,
	[Description] [varchar](255) NULL,
	[ServiceLevelThreshold] [int] NULL,
	[ServiceLevelType] [smallint] NULL,
	[Deleted] [bit] NOT NULL,
	[BucketIntervalID] [int] NULL,
	[ChangeStamp] [int] NOT NULL,
 CONSTRAINT [pk_Call_Type] PRIMARY KEY CLUSTERED 
(
	[CallTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Call_Type_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type_Interval]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Call_Type_Interval](
	[DateTime] [datetime] NOT NULL,
	[CallTypeID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[RecoveryKey] [float] NOT NULL,
	[RouterQueueWaitTime] [int] NULL,
	[RouterQueueCalls] [int] NULL,
	[AvgRouterDelayQ] [int] NULL,
	[RouterCallsAbandQ] [int] NULL,
	[RouterQueueCallTypeLimit] [int] NULL,
	[RouterQueueGlobalLimit] [int] NULL,
	[CallsRouted] [int] NULL,
	[ErrorCount] [int] NULL,
	[ICRDefaultRouted] [int] NULL,
	[NetworkDefaultRouted] [int] NULL,
	[ReturnBusy] [int] NULL,
	[ReturnRing] [int] NULL,
	[NetworkAnnouncement] [int] NULL,
	[AnswerWaitTime] [int] NULL,
	[CallsHandled] [int] NULL,
	[CallsOffered] [int] NULL,
	[HandleTime] [int] NULL,
	[ServiceLevelAband] [int] NULL,
	[ServiceLevelCalls] [int] NULL,
	[ServiceLevelCallsOffered] [int] NULL,
	[ServiceLevel] [real] NULL,
	[TalkTime] [int] NULL,
	[OverflowOut] [int] NULL,
	[HoldTime] [int] NULL,
	[IncompleteCalls] [int] NULL,
	[ShortCalls] [int] NULL,
	[DelayQAbandTime] [int] NULL,
	[CallsAnswered] [int] NULL,
	[CallsRoutedNonAgent] [int] NULL,
	[CallsRONA] [int] NULL,
	[ReturnRelease] [int] NULL,
	[CallsQHandled] [int] NULL,
	[VruUnhandledCalls] [int] NULL,
	[VruHandledCalls] [int] NULL,
	[VruAssistedCalls] [int] NULL,
	[VruOptOutUnhandledCalls] [int] NULL,
	[VruScriptedXferredCalls] [int] NULL,
	[VruForcedXferredCalls] [int] NULL,
	[VruOtherCalls] [int] NULL,
	[ServiceLevelType] [int] NULL,
	[BucketIntervalID] [int] NULL,
	[AnsInterval1] [int] NULL,
	[AnsInterval2] [int] NULL,
	[AnsInterval3] [int] NULL,
	[AnsInterval4] [int] NULL,
	[AnsInterval5] [int] NULL,
	[AnsInterval6] [int] NULL,
	[AnsInterval7] [int] NULL,
	[AnsInterval8] [int] NULL,
	[AnsInterval9] [int] NULL,
	[AnsInterval10] [int] NULL,
	[AbandInterval1] [int] NULL,
	[AbandInterval2] [int] NULL,
	[AbandInterval3] [int] NULL,
	[AbandInterval4] [int] NULL,
	[AbandInterval5] [int] NULL,
	[AbandInterval6] [int] NULL,
	[AbandInterval7] [int] NULL,
	[AbandInterval8] [int] NULL,
	[AbandInterval9] [int] NULL,
	[AbandInterval10] [int] NULL,
	[CallsRequeried] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[RouterCallsAbandToAgent] [int] NULL,
	[TotalCallsAband] [int] NULL,
	[DelayAgentAbandTime] [int] NULL,
	[CallDelayAbandTime] [int] NULL,
	[CTDelayAbandTime] [int] NULL,
	[ServiceLevelError] [int] NULL,
	[ServiceLevelRONA] [int] NULL,
	[AgentErrorCount] [int] NULL,
	[VRUTime] [int] NULL,
	[CTVRUTime] [int] NULL,
	[Reserved1] [int] NULL,
	[Reserved2] [int] NULL,
	[Reserved3] [int] NULL,
	[Reserved4] [int] NULL,
	[Reserved5] [real] NULL,
	[CallsOnHold] [int] NULL,
	[MaxHoldTime] [int] NULL,
	[ReportingHalfHour] [int] NULL,
	[ReportingInterval] [int] NULL,
	[MaxCallWaitTime] [int] NULL,
	[MaxCallsQueued] [int] NULL,
	[ReservationCalls] [int] NULL,
 CONSTRAINT [pk_Call_Type_Interval] PRIMARY KEY CLUSTERED 
(
	[DateTime] ASC,
	[CallTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Call_Type_SG_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Call_Type_SG_Interval](
	[DateTime] [datetime] NOT NULL,
	[CallTypeID] [int] NOT NULL,
	[SkillGroupSkillTargetID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[RecoveryKey] [float] NOT NULL,
	[AnswerWaitTime] [int] NULL,
	[AvgRouterDelayQ] [int] NULL,
	[CallDelayAbandTime] [int] NULL,
	[CallsAnswered] [int] NULL,
	[CallsHandled] [int] NULL,
	[CallsReportAgainstOther] [int] NULL,
	[CallsQHandled] [int] NULL,
	[CallsRONA] [int] NULL,
	[CallsRequeried] [int] NULL,
	[CallsRoutedNonAgent] [int] NULL,
	[CallsHandledNotRouted] [int] NULL,
	[DelayAgentAbandTime] [int] NULL,
	[DelayQAbandTime] [int] NULL,
	[HandleTime] [int] NULL,
	[TalkTime] [int] NULL,
	[HoldTime] [int] NULL,
	[IncompleteCalls] [int] NULL,
	[CallsOfferedRouted] [int] NULL,
	[CallsOfferedNotRouted] [int] NULL,
	[RouterCallsAbandQ] [int] NULL,
	[RouterCallsAbandToAgent] [int] NULL,
	[RouterQueueWaitTime] [int] NULL,
	[RouterQueueCalls] [int] NULL,
	[RouterCallsDequeued] [int] NULL,
	[ShortCalls] [int] NULL,
	[AgentErrorCount] [int] NULL,
	[ErrorCount] [int] NULL,
	[ServiceLevelAband] [int] NULL,
	[ServiceLevelCalls] [int] NULL,
	[ServiceLevelCallsOffered] [int] NULL,
	[ServiceLevel] [real] NULL,
	[ServiceLevelError] [int] NULL,
	[ServiceLevelRONA] [int] NULL,
	[ServiceLevelType] [int] NULL,
	[ServiceLevelCallsDequeue] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[CallsOnHold] [int] NULL,
	[RouterCallsAbandDequeued] [int] NULL,
	[MaxHoldTime] [int] NULL,
	[Reserved1] [int] NULL,
	[Reserved2] [int] NULL,
	[Reserved3] [int] NULL,
	[Reserved4] [int] NULL,
	[Reserved5] [real] NULL,
	[OverflowOut] [int] NULL,
	[ReportingHalfHour] [int] NULL,
	[ReportingInterval] [int] NULL,
	[AbandInterval1] [int] NULL,
	[AbandInterval2] [int] NULL,
	[AbandInterval3] [int] NULL,
	[AbandInterval4] [int] NULL,
	[AbandInterval5] [int] NULL,
	[AbandInterval6] [int] NULL,
	[AbandInterval7] [int] NULL,
	[AbandInterval8] [int] NULL,
	[AbandInterval9] [int] NULL,
	[AbandInterval10] [int] NULL,
	[AnsInterval1] [int] NULL,
	[AnsInterval2] [int] NULL,
	[AnsInterval3] [int] NULL,
	[AnsInterval4] [int] NULL,
	[AnsInterval5] [int] NULL,
	[AnsInterval6] [int] NULL,
	[AnsInterval7] [int] NULL,
	[AnsInterval8] [int] NULL,
	[AnsInterval9] [int] NULL,
	[AnsInterval10] [int] NULL,
	[BucketIntervalID] [int] NULL,
	[MaxCallWaitTime] [int] NULL,
	[MaxCallsQueued] [int] NULL,
	[ReservationCalls] [int] NULL,
 CONSTRAINT [pk_Call_Type_SG_Interval] PRIMARY KEY CLUSTERED 
(
	[DateTime] ASC,
	[CallTypeID] ASC,
	[SkillGroupSkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Person]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Person]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Person](
	[PersonID] [int] NOT NULL,
	[FirstName] [varchar](32) NOT NULL,
	[LastName] [varchar](32) NOT NULL,
	[LoginName] [varchar](32) NOT NULL,
	[LoginNameShadow] [varchar](32) NOT NULL,
	[Password] [varchar](32) NULL,
	[PasswordChangeRequired] [smallint] NOT NULL,
	[PasswordLastChangedTime] [datetime] NULL,
	[LoginEnabled] [bit] NOT NULL,
	[Description] [varchar](255) NULL,
	[Deleted] [bit] NOT NULL,
	[ChangeStamp] [int] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Route_Call_Detail]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Route_Call_Detail]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Route_Call_Detail](
	[RecoveryKey] [float] NOT NULL,
	[DialedNumberID] [int] NULL,
	[RouterCallKeyDay] [int] NOT NULL,
	[RouterCallKey] [int] NOT NULL,
	[RouteID] [int] NULL,
	[DateTime] [datetime] NOT NULL,
	[RequestType] [smallint] NOT NULL,
	[RoutingClientID] [smallint] NOT NULL,
	[OriginatorType] [smallint] NULL,
	[RoutingClientCallKey] [int] NULL,
	[Priority] [smallint] NULL,
	[MsgOrigin] [smallint] NULL,
	[Variable1] [varchar](40) NULL,
	[Variable2] [varchar](40) NULL,
	[Variable3] [varchar](40) NULL,
	[Variable4] [varchar](40) NULL,
	[Variable5] [varchar](40) NULL,
	[UserToUser] [varchar](131) NULL,
	[ANI] [varchar](32) NULL,
	[CDPD] [varchar](30) NULL,
	[CED] [varchar](30) NULL,
	[ScriptID] [int] NULL,
	[FinalObjectID] [int] NULL,
	[CallSegmentTime] [int] NULL,
	[NetQTime] [int] NULL,
	[CallTypeID] [int] NULL,
	[RouterErrorCode] [smallint] NULL,
	[RecoveryDay] [int] NOT NULL,
	[TimeZone] [int] NULL,
	[NetworkTargetID] [int] NULL,
	[LabelID] [int] NULL,
	[Originator] [varchar](8) NULL,
	[Variable6] [varchar](40) NULL,
	[Variable7] [varchar](40) NULL,
	[Variable8] [varchar](40) NULL,
	[Variable9] [varchar](40) NULL,
	[Variable10] [varchar](40) NULL,
	[TargetLabelID] [int] NULL,
	[RouterCallKeySequenceNumber] [int] NULL,
	[RouterQueueTime] [int] NULL,
	[VruScripts] [int] NULL,
	[Label] [varchar](32) NULL,
	[TargetLabel] [varchar](32) NULL,
	[DialedNumberString] [varchar](32) NULL,
	[BeganRoutingDateTime] [datetime] NULL,
	[BeganCallTypeDateTime] [datetime] NULL,
	[TargetType] [int] NULL,
	[MRDomainID] [int] NULL,
	[RequeryResult] [int] NULL,
	[VruProgress] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[ECCPayloadID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecoveryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Skill_Group]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Skill_Group](
	[SkillTargetID] [int] NOT NULL,
	[ScheduleID] [int] NULL,
	[PeripheralID] [smallint] NOT NULL,
	[EnterpriseName] [varchar](32) NOT NULL,
	[PeripheralNumber] [int] NOT NULL,
	[PeripheralName] [varchar](32) NOT NULL,
	[AvailableHoldoffDelay] [smallint] NOT NULL,
	[Priority] [smallint] NOT NULL,
	[BaseSkillTargetID] [int] NULL,
	[Extension] [varchar](10) NULL,
	[SubGroupMaskType] [smallint] NOT NULL,
	[SubSkillGroupMask] [varchar](64) NULL,
	[ConfigParam] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
	[Deleted] [bit] NOT NULL,
	[MRDomainID] [int] NOT NULL,
	[IPTA] [bit] NOT NULL,
	[DefaultEntry] [int] NOT NULL,
	[UserDeletable] [bit] NOT NULL,
	[ServiceLevelThreshold] [int] NOT NULL,
	[ServiceLevelType] [smallint] NOT NULL,
	[BucketIntervalID] [int] NULL,
	[ChangeStamp] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table MAXDAT.[Skill_Group_Interval]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Interval]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Skill_Group_Interval](
	[DateTime] [datetime] NOT NULL,
	[SkillTargetID] [int] NOT NULL,
	[TimeZone] [int] NOT NULL,
	[CallbackMessages] [int] NULL,
	[CallbackMessagesTime] [int] NULL,
	[AvgHandledCallsTalkTime] [int] NULL,
	[HoldTime] [int] NULL,
	[HandledCallsTalkTime] [int] NULL,
	[InternalCalls] [int] NULL,
	[InternalCallsTime] [int] NULL,
	[CallsHandled] [int] NULL,
	[SupervAssistCalls] [int] NULL,
	[AvgHandledCallsTime] [int] NULL,
	[SupervAssistCallsTime] [int] NULL,
	[HandledCallsTime] [int] NULL,
	[PercentUtilization] [real] NULL,
	[AgentOutCallsTime] [int] NULL,
	[TalkInTime] [int] NULL,
	[LoggedOnTime] [int] NULL,
	[AgentOutCalls] [int] NULL,
	[TalkOutTime] [int] NULL,
	[TalkOtherTime] [int] NULL,
	[AvailTime] [int] NULL,
	[NotReadyTime] [int] NULL,
	[TransferInCalls] [int] NULL,
	[TalkTime] [int] NULL,
	[TransferInCallsTime] [int] NULL,
	[WorkReadyTime] [int] NULL,
	[TransferOutCalls] [int] NULL,
	[WorkNotReadyTime] [int] NULL,
	[RecoveryDay] [int] NOT NULL,
	[RecoveryKey] [float] NOT NULL,
	[BusyOtherTime] [int] NULL,
	[CallsAnswered] [int] NULL,
	[ReservedStateTime] [int] NULL,
	[AnswerWaitTime] [int] NULL,
	[AbandonRingCalls] [int] NULL,
	[AbandonRingTime] [int] NULL,
	[AbandonHoldCalls] [int] NULL,
	[AgentOutCallsTalkTime] [int] NULL,
	[AgentOutCallsOnHold] [int] NULL,
	[AgentOutCallsOnHoldTime] [int] NULL,
	[AgentTerminatedCalls] [int] NULL,
	[ConsultativeCalls] [int] NULL,
	[ConsultativeCallsTime] [int] NULL,
	[ConferencedInCalls] [int] NULL,
	[ConferencedInCallsTime] [int] NULL,
	[ConferencedOutCalls] [int] NULL,
	[ConferencedOutCallsTime] [int] NULL,
	[IncomingCallsOnHoldTime] [int] NULL,
	[IncomingCallsOnHold] [int] NULL,
	[InternalCallsOnHoldTime] [int] NULL,
	[InternalCallsOnHold] [int] NULL,
	[InternalCallsRcvdTime] [int] NULL,
	[InternalCallsRcvd] [int] NULL,
	[RedirectNoAnsCalls] [int] NULL,
	[RedirectNoAnsCallsTime] [int] NULL,
	[ShortCalls] [int] NULL,
	[RouterCallsAbandQ] [int] NULL,
	[RouterQueueCalls] [int] NULL,
	[AutoOutCalls] [int] NULL,
	[AutoOutCallsTime] [int] NULL,
	[AutoOutCallsTalkTime] [int] NULL,
	[AutoOutCallsOnHold] [int] NULL,
	[AutoOutCallsOnHoldTime] [int] NULL,
	[PreviewCalls] [int] NULL,
	[PreviewCallsTime] [int] NULL,
	[PreviewCallsTalkTime] [int] NULL,
	[PreviewCallsOnHold] [int] NULL,
	[PreviewCallsOnHoldTime] [int] NULL,
	[ReserveCalls] [int] NULL,
	[ReserveCallsTime] [int] NULL,
	[ReserveCallsTalkTime] [int] NULL,
	[ReserveCallsOnHold] [int] NULL,
	[ReserveCallsOnHoldTime] [int] NULL,
	[TalkAutoOutTime] [int] NULL,
	[TalkPreviewTime] [int] NULL,
	[TalkReserveTime] [int] NULL,
	[BargeInCalls] [int] NULL,
	[InterceptCalls] [int] NULL,
	[MonitorCalls] [int] NULL,
	[WhisperCalls] [int] NULL,
	[EmergencyAssists] [int] NULL,
	[CallsOffered] [int] NULL,
	[CallsQueued] [int] NULL,
	[InterruptedTime] [int] NULL,
	[AbandonHoldCallsOut] [int] NULL,
	[NetConsultativeCalls] [int] NULL,
	[NetConsultativeCallsTime] [int] NULL,
	[NetConferencedOutCalls] [int] NULL,
	[NetConfOutCallsTime] [int] NULL,
	[NetTransferOutCalls] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[RouterCallsOffered] [int] NULL,
	[RouterCallsAbandToAgent] [int] NULL,
	[RouterCallsDequeued] [int] NULL,
	[RouterError] [int] NULL,
	[ServiceLevel] [real] NULL,
	[ServiceLevelCalls] [int] NULL,
	[ServiceLevelCallsAband] [int] NULL,
	[ServiceLevelCallsDequeue] [int] NULL,
	[ServiceLevelError] [int] NULL,
	[ServiceLevelRONA] [int] NULL,
	[ServiceLevelCallsOffered] [int] NULL,
	[Reserved1] [int] NULL,
	[Reserved2] [int] NULL,
	[Reserved3] [int] NULL,
	[Reserved4] [int] NULL,
	[Reserved5] [real] NULL,
	[CampaignID] [int] NULL,
	[RouterCallsAbandDequeued] [int] NULL,
	[ReportingHalfHour] [int] NULL,
	[ReportingInterval] [int] NULL,
	[BucketIntervalID] [int] NULL,
	[ConsultOutCalls] [int] NULL,
	[ConsultOutCallsTime] [int] NULL,
	[RouterDelayQAbandTime] [int] NULL,
	[RouterAbandInterval1] [int] NULL,
	[RouterAbandInterval2] [int] NULL,
	[RouterAbandInterval3] [int] NULL,
	[RouterAbandInterval4] [int] NULL,
	[RouterAbandInterval5] [int] NULL,
	[RouterAbandInterval6] [int] NULL,
	[RouterAbandInterval7] [int] NULL,
	[RouterAbandInterval8] [int] NULL,
	[RouterAbandInterval9] [int] NULL,
	[RouterAbandInterval10] [int] NULL,
	[RouterAnsInterval1] [int] NULL,
	[RouterAnsInterval2] [int] NULL,
	[RouterAnsInterval3] [int] NULL,
	[RouterAnsInterval4] [int] NULL,
	[RouterAnsInterval5] [int] NULL,
	[RouterAnsInterval6] [int] NULL,
	[RouterAnsInterval7] [int] NULL,
	[RouterAnsInterval8] [int] NULL,
	[RouterAnsInterval9] [int] NULL,
	[RouterAnsInterval10] [int] NULL,
	[RouterMaxCallsQueued] [int] NULL,
	[RouterMaxCallWaitTime] [int] NULL,
 CONSTRAINT [pk_Skill_Group_Interval] PRIMARY KEY CLUSTERED 
(
	[DateTime] ASC,
	[SkillTargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Skill_Group_Member]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Skill_Group_Member](
	[SkillGroupSkillTargetID] [int] NOT NULL,
	[AgentSkillTargetID] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table MAXDAT.[Termination_Call_Detail]    Script Date: 10/18/2013 2:24:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]') AND type in (N'U'))
BEGIN
CREATE TABLE MAXDAT.[Termination_Call_Detail](
	[RecoveryKey] [float] NOT NULL,
	[MRDomainID] [int] NULL,
	[AgentSkillTargetID] [int] NULL,
	[SkillGroupSkillTargetID] [int] NULL,
	[ServiceSkillTargetID] [int] NULL,
	[PeripheralID] [smallint] NOT NULL,
	[RouteID] [int] NULL,
	[RouterCallKeyDay] [int] NULL,
	[RouterCallKey] [int] NULL,
	[DateTime] [datetime] NOT NULL,
	[PeripheralCallType] [smallint] NULL,
	[DigitsDialed] [varchar](40) NULL,
	[PeripheralCallKey] [int] NULL,
	[CallDisposition] [smallint] NOT NULL,
	[NetworkTime] [int] NULL,
	[Duration] [int] NULL,
	[RingTime] [int] NULL,
	[DelayTime] [int] NULL,
	[TimeToAband] [int] NULL,
	[HoldTime] [int] NULL,
	[TalkTime] [int] NULL,
	[WorkTime] [int] NULL,
	[LocalQTime] [int] NULL,
	[BillRate] [smallint] NULL,
	[CallSegmentTime] [int] NULL,
	[ConferenceTime] [int] NULL,
	[Variable1] [varchar](40) NULL,
	[Variable2] [varchar](40) NULL,
	[Variable3] [varchar](40) NULL,
	[Variable4] [varchar](40) NULL,
	[Variable5] [varchar](40) NULL,
	[UserToUser] [varchar](131) NULL,
	[NewTransaction] [bit] NULL,
	[RecoveryDay] [int] NOT NULL,
	[TimeZone] [int] NULL,
	[NetworkTargetID] [int] NULL,
	[TrunkGroupID] [int] NULL,
	[DNIS] [varchar](32) NULL,
	[InstrumentPortNumber] [int] NULL,
	[AgentPeripheralNumber] [varchar](32) NULL,
	[ICRCallKey] [int] NOT NULL,
	[ICRCallKeyParent] [int] NULL,
	[ICRCallKeyChild] [int] NULL,
	[Variable6] [varchar](40) NULL,
	[Variable7] [varchar](40) NULL,
	[Variable8] [varchar](40) NULL,
	[Variable9] [varchar](40) NULL,
	[Variable10] [varchar](40) NULL,
	[ANI] [varchar](32) NULL,
	[AnsweredWithinServiceLevel] [bit] NULL,
	[Priority] [smallint] NULL,
	[Trunk] [int] NULL,
	[WrapupData] [varchar](40) NULL,
	[SourceAgentPeripheralNumber] [varchar](32) NULL,
	[SourceAgentSkillTargetID] [int] NULL,
	[CallDispositionFlag] [int] NULL,
	[RouterCallKeySequenceNumber] [int] NULL,
	[CED] [varchar](30) NULL,
	[CallTypeID] [int] NULL,
	[BadCallTag] [bit] NULL,
	[ApplicationTaskDisposition] [int] NULL,
	[ApplicationData] [varchar](100) NULL,
	[NetQTime] [int] NULL,
	[DbDateTime] [datetime] NULL,
	[ECCPayloadID] [int] NULL,
	[CallTypeReportingDateTime] [datetime] NULL,
	[RoutedSkillGroupSkillTargetID] [int] NULL,
	[RoutedServiceSkillTargetID] [int] NULL,
	[RoutedAgentSkillTargetID] [int] NULL,
	[Originated] [bit] NULL,
	[CallReferenceID] [varchar](32) NULL,
	[CallGUID] [varchar](32) NULL,
	[LocationParamPKID] [varchar](128) NULL,
	[LocationParamName] [varchar](50) NULL,
	[PstnTrunkGroupID] [varchar](32) NULL,
	[PstnTrunkGroupChannelNumber] [int] NULL,
	[NetworkSkillGroupQTime] [int] NULL,
	[EnterpriseQueueTime] [int] NULL,
	[StartDateTimeUTC] [datetime] NULL,
	[ProtocolID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecoveryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Person] FOREIGN KEY([PersonID])
REFERENCES MAXDAT.[Person] ([PersonID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent] CHECK CONSTRAINT [fk_Agent_Person]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent]  WITH CHECK ADD  CONSTRAINT [fk_Person] FOREIGN KEY([PersonID])
REFERENCES MAXDAT.[Person] ([PersonID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Person]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent]'))
ALTER TABLE MAXDAT.[Agent] CHECK CONSTRAINT [fk_Person]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Interval]'))
ALTER TABLE MAXDAT.[Agent_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Interval_Agent] FOREIGN KEY([SkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Interval]'))
ALTER TABLE MAXDAT.[Agent_Interval] CHECK CONSTRAINT [fk_Agent_Interval_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Logout_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Logout]'))
ALTER TABLE MAXDAT.[Agent_Logout]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Logout_Agent] FOREIGN KEY([SkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Logout_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Logout]'))
ALTER TABLE MAXDAT.[Agent_Logout] CHECK CONSTRAINT [fk_Agent_Logout_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Skill_Group_Interval_Agent] FOREIGN KEY([SkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval] CHECK CONSTRAINT [fk_Agent_Skill_Group_Interval_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Skill_Group_Interval_Skill_Group] FOREIGN KEY([SkillGroupSkillTargetID])
REFERENCES MAXDAT.[Skill_Group] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Agent_Skill_Group_Interval] CHECK CONSTRAINT [fk_Agent_Skill_Group_Interval_Skill_Group]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Supervisor]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team]'))
ALTER TABLE MAXDAT.[Agent_Team]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Team_Supervisor] FOREIGN KEY([PriSupervisorSkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Supervisor]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team]'))
ALTER TABLE MAXDAT.[Agent_Team] CHECK CONSTRAINT [fk_Agent_Team_Supervisor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Team_Member_Agent] FOREIGN KEY([SkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member] CHECK CONSTRAINT [fk_Agent_Team_Member_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent_Team]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member]  WITH CHECK ADD  CONSTRAINT [fk_Agent_Team_Member_Agent_Team] FOREIGN KEY([AgentTeamID])
REFERENCES MAXDAT.[Agent_Team] ([AgentTeamID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Agent_Team_Member_Agent_Team]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Agent_Team_Member]'))
ALTER TABLE MAXDAT.[Agent_Team_Member] CHECK CONSTRAINT [fk_Agent_Team_Member_Agent_Team]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Bucket_Interval]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type]'))
ALTER TABLE MAXDAT.[Call_Type]  WITH CHECK ADD  CONSTRAINT [fk_Call_Type_Bucket_Interval] FOREIGN KEY([BucketIntervalID])
REFERENCES MAXDAT.[Bucket_Intervals] ([BucketIntervalID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Bucket_Interval]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type]'))
ALTER TABLE MAXDAT.[Call_Type] CHECK CONSTRAINT [fk_Call_Type_Bucket_Interval]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Call_Type_Interval_Call_Type] FOREIGN KEY([CallTypeID])
REFERENCES MAXDAT.[Call_Type] ([CallTypeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_Interval] CHECK CONSTRAINT [fk_Call_Type_Interval_Call_Type]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Call_Type_SG_Interval_Call_Type] FOREIGN KEY([CallTypeID])
REFERENCES MAXDAT.[Call_Type] ([CallTypeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval] CHECK CONSTRAINT [fk_Call_Type_SG_Interval_Call_Type]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Call_Type_SG_Interval_Skill_Group] FOREIGN KEY([SkillGroupSkillTargetID])
REFERENCES MAXDAT.[Skill_Group] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Call_Type_SG_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Call_Type_SG_Interval]'))
ALTER TABLE MAXDAT.[Call_Type_SG_Interval] CHECK CONSTRAINT [fk_Call_Type_SG_Interval_Skill_Group]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Route_Call_Detail_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Route_Call_Detail]'))
ALTER TABLE MAXDAT.[Route_Call_Detail]  WITH CHECK ADD  CONSTRAINT [fk_Route_Call_Detail_Call_Type] FOREIGN KEY([CallTypeID])
REFERENCES MAXDAT.[Call_Type] ([CallTypeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Route_Call_Detail_Call_Type]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Route_Call_Detail]'))
ALTER TABLE MAXDAT.[Route_Call_Detail] CHECK CONSTRAINT [fk_Route_Call_Detail_Call_Type]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Skill_Group_Interval]  WITH CHECK ADD  CONSTRAINT [fk_Skill_Group_Interval_Skill_Group] FOREIGN KEY([SkillTargetID])
REFERENCES MAXDAT.[Skill_Group] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Interval_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Interval]'))
ALTER TABLE MAXDAT.[Skill_Group_Interval] CHECK CONSTRAINT [fk_Skill_Group_Interval_Skill_Group]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member]  WITH CHECK ADD  CONSTRAINT [fk_Skill_Group_Member_Agent] FOREIGN KEY([AgentSkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member] CHECK CONSTRAINT [fk_Skill_Group_Member_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member]  WITH CHECK ADD  CONSTRAINT [fk_Skill_Group_Member_Skill_Group] FOREIGN KEY([SkillGroupSkillTargetID])
REFERENCES MAXDAT.[Skill_Group] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Skill_Group_Member_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Skill_Group_Member]'))
ALTER TABLE MAXDAT.[Skill_Group_Member] CHECK CONSTRAINT [fk_Skill_Group_Member_Skill_Group]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail]  WITH CHECK ADD  CONSTRAINT [fk_Termination_Call_Detail_Agent] FOREIGN KEY([AgentSkillTargetID])
REFERENCES MAXDAT.[Agent] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Agent]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail] CHECK CONSTRAINT [fk_Termination_Call_Detail_Agent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail]  WITH CHECK ADD  CONSTRAINT [fk_Termination_Call_Detail_Skill_Group] FOREIGN KEY([SkillGroupSkillTargetID])
REFERENCES MAXDAT.[Skill_Group] ([SkillTargetID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'MAXDAT.[fk_Termination_Call_Detail_Skill_Group]') AND parent_object_id = OBJECT_ID(N'MAXDAT.[Termination_Call_Detail]'))
ALTER TABLE MAXDAT.[Termination_Call_Detail] CHECK CONSTRAINT [fk_Termination_Call_Detail_Skill_Group]
GO
USE [master]
GO
ALTER DATABASE [MAXDAT] SET  READ_WRITE 
GO
/*
IF NOT EXISTS (SELECT * FROM dbo.syslogins where name = 'ebhdsuser')
CREATE LOGIN [ebhdsuser] WITH PASSWORD = 'eb123'

USE [MAXDAT]
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ebhdsuser') 
CREATE USER [ebhdsuser] FOR LOGIN [ebhdsuser]
GO
ALTER USER [ebhduser] WITH DEFAULT_SCHEMA=MAXDAT
GO
EXEC sp_addrolemember 'db_owner', 'ebhdsuser'
*/