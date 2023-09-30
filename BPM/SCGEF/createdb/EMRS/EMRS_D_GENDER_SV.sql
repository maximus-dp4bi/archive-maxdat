IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_GENDER_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_GENDER_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_GENDER_SV
AS
SELECT gender_type_code sex
       ,description
	   ,display_name report_label
	   ,NULL scope
	   ,NULL created_by
	   ,NULL create_ts
	   ,NULL updated_by
	   ,NULL update_ts
	   ,sort_order order_by_default
	   ,CAST('01/01/1900' AS DATE) effective_start_date
	   ,CAST('12/31/2050' AS DATE) effective_end_date
FROM organization.gender_type
UNION ALL
SELECT 'UD' sex
       ,'Undefined' description
	   ,'Undefined' report_label
	   ,NULL scope
	   ,NULL created_by
	   ,NULL create_ts
	   ,NULL updated_by
	   ,NULL update_ts
	   ,NULL order_by_default
	   ,CAST('01/01/1900' AS DATE) effective_start_date
	   ,CAST('12/31/2050' AS DATE) effective_end_date
GO