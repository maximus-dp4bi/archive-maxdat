IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].EMRS_D_CLIENT_ENRL_STATUS_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ENRL_STATUS_SV
AS
SELECT CAST('00000000-0000-0000-0000-000000000000' as uniqueidentifier) client_enroll_status_id
	   ,'UD' current_enrollment_status
	   ,CAST('00000000-0000-0000-0000-000000000000' as uniqueidentifier) client_number
	   ,null record_name
	   ,CAST('01/01/1900' AS DATE) date_of_validity_start
	   ,CAST('12/31/2050' AS DATE) date_of_validity_end
	   ,null modified_date
           ,null modified_name
           ,'Y' current_flag
	   ,null record_date
	   ,'UD' plan_type
	   ,'UD' enrollment_status_code

GO