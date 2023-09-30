
IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_ZIPCODE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].EMRS_D_ZIPCODE_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_ZIPCODE_SV
AS
  SELECT zip_code
         ,zip_city
		 ,zip_county
		 ,zip_state
		 ,covers_multiple_county
  FROM maxdat_support.zipcode
  UNION ALL
  SELECT 'UD' zip_code
         ,'Undefined' zip_city
		 ,'Undefined' zip_county
		 ,'UD' zip_state
		 ,'N' covers_multiple_county
	 		

GO 