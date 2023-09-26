IF OBJECT_ID('MAXDAT_SUPPORT.D_HEALTHPLAN_RETENTION_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].D_HEALTHPLAN_RETENTION_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.D_HEALTHPLAN_RETENTION_SV
AS
  SELECT monthofreport reporting_month
        ,date1
	,date2
	,date3
	,planname plan_name
	,retained
	,unretained
	,ProgramName
  FROM Report.tbl_90_Day_New

GO



     
     
      