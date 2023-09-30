IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CASE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_CASE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CASE_SV
AS
  SELECT null last_state_updated_by
		,ce.case_id case_number		
		,p.first_name first_name
		,p.middle_name middle_initial
		,p.last_name last_name
		,ce.created_date record_date
		,ce.created_by_id record_name
		,ce.modified_date modified_date
		,ce.modified_id modified_name
		,ce.created_date date_of_validity_start
		,CAST('12/31/2050' AS DATE) date_of_validity_end
		,ce.case_id current_case_id
		,'Y' current_flag
		,ce.case_number case_cin
		,ce.case_number family_number
		,'N' case_educated_ind
		,null case_language_cd
		,null case_how_educated_cd
		,'O' case_status
		,p.ssn case_head_ssn
		,ce.head_of_household_id clnt_client_id
		,null case_spoken_language_cd
  FROM enrollment.case_entity ce
    JOIN organization.person p ON ce.head_of_household_id = p.party_id 

GO