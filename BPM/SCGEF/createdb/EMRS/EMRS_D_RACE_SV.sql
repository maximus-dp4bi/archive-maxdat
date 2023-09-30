IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_RACE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_RACE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_RACE_SV
AS
  SELECT race_type_code race_code,    
    display_name race_description
  FROM organization.race_type
  UNION ALL
  SELECT 'UD' race_code,      
        'Undefined' race_description 

GO