IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_PLAN_TYPE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV
AS
 SELECT 'MEDICAL' plan_type,
        'Medical' plan_type_desc
 UNION
 SELECT 'UD'plan_type,
        'Undefined' plan_type_desc
GO