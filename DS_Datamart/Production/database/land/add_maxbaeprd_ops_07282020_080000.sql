/*
Created: 11/7/2019
Modified: 12/3/2019
Model: maxbae_maxbaeprd OPS LAYER
Database: MS SQL Server 2016
*/
USE MAXBAE
go
-- Create tables section -------------------------------------------------

-- Table maxbaeprd.OPS_WFM_AGENT_LOCATION

CREATE TABLE [maxbaeprd].[OPS_WFM_AGENT_LOCATION]
(
 [AGENT_WFM_ID] Nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [AGENT_LOCATION_NAME] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ALC_START_DT] Date NULL,
 [ALC_END_DT] Date NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go

-- Table maxbaeprd.OPS_WFM_AGENT_MANAGEMENT_UNIT

CREATE TABLE [maxbaeprd].[OPS_WFM_AGENT_MANAGEMENT_UNIT]
(
 [AGENT_WFM_ID] Nvarchar(40) NOT NULL,
 [MANAGEMENT_UNIT_ID] Int NULL,
 [MANAGEMENT_UNIT_NAME] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [MANAGEMENT_UNIT_TIME_ZONE_NAME] Varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [AMU_START_DT] Date NULL,
 [AMU_END_DT] Date NULL,
 [CREATE_DT] Date NULL,
 [CREATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UPDATE_DT] Date NULL,
 [UPDATED_BY] Varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
go


