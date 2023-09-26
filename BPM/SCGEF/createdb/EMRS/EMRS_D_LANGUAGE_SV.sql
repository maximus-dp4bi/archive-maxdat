IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_LANGUAGE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV
AS
SELECT language_type_code language_code
       ,display_name [language]
FROM enrollment.language_type
UNION ALL
SELECT 'UD' language_code
      ,'Undefined' [language]

GO