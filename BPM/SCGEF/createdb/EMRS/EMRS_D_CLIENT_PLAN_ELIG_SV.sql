IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CLIENT_PLAN_ELIG_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].EMRS_D_CLIENT_PLAN_ELIG_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_PLAN_ELIG_SV
AS
SELECT CAST('00000000-0000-0000-0000-000000000000' as uniqueidentifier) client_plan_eligibility_id
       ,CAST('00000000-0000-0000-0000-000000000000' as uniqueidentifier) client_number
       ,'UD' eligibility_status_code
       ,'Y' current_flag
       ,null record_name
       ,null record_date
       ,CAST('01/01/1900' AS DATE) date_of_validity_start
       ,CAST('12/31/2050' AS DATE) date_of_validity_end
       ,null modified_date
       ,null modified_name
       ,'UD' current_eligibility_status_cd
       ,'UD' plan_type
       ,'UD' subprogram_code
GO
