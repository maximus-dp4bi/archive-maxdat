IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CLIENT_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_CLIENT_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_SV
AS
  SELECT CASE WHEN ((0 + Convert(Char(8),getdate(),112) - Convert(Char(8),birth_date,112)) / 10000) <= 19 THEN 'CHILD' ELSE 'ADULT' END adult_or_child
		,null third_party_resources_avail
		,'N' migrant_worker_flag
		,'N' managed_via_gen_rev_flag
		,'N' managed_via_state_fund_flag
		,'N' receiving_tanf_flag
		,'N' receiving_ssi_flag
		,'N' client_reported_shcn
		,'N' plan_reported_shcn
		,null date_of_death_source
		,m.party_id current_client_id
		,COALESCE(et.ethnicity_type_code,'UD') clnt_ethnicity
		,'N' clnt_not_born
		,'N' clnt_hipaa_privacy_ind
		,null sched_auto_assign_date
		,medical_assistance_id clnt_cin
		,null clnt_marital_cd
		,null clnt_status_cd
		,null clnt_expected_dob
		,null clnt_preg_term_date
		,null clnt_preg_term_reas_cd
		,mt.member_type_code client_type_cd
		,COALESCE(lt.language_type_code,'UD') state_language
		,COALESCE(lt.language_type_code,'UD') written_language
		,p.suffix suffix
		,(0 + Convert(Char(8),getdate(),112) - Convert(Char(8),birth_date,112)) / 10000 age
		,p.party_id client_number
		,p.first_name first_name
		,p.middle_name middle_initial
		,p.last_name last_name
		,p.date_of_death date_of_death
		,null coverage_type
		,null transaction_hold
		,null managed_care_candidate
		,COALESCE(rt.race_type_code,'UD') race_code
		,COALESCE(gt.gender_type_code,'UD') sex
		,p.birth_date date_of_birth
		,p.ssn social_security_number
		,m.created_date record_date
		,m.created_by_id record_name
		,m.modified_date modified_date
		,m.modified_by_id modified_name
		,m.created_date date_of_validity_start
		,CAST('12/31/2050' AS DATE) date_of_validity_end
		,p.pregnancy_indicator pregnant_member
		,CASE WHEN ((0 + Convert(Char(8),getdate(),112) - Convert(Char(8),birth_date,112)) / 10000) <= 1 THEN 'Y' ELSE 'N' END newborn
                ,'UD' citizenship_code
  FROM enrollment.member m
    JOIN enrollment.member_type mt ON m.member_type_id = mt.member_type_id  
    JOIN organization.person p ON m.party_id = p.party_id  
    LEFT JOIN organization.ethnicity_type et ON p.ethnicity_type_id = et.ethnicity_type_id
    LEFT JOIN organization.language_type lt ON p.language_type_id = lt.language_type_id
    LEFT JOIN organization.race_type rt ON p.race_type_id = rt.race_type_id
    LEFT JOIN enrollment.gender_type gt ON p.gender_type_id = gt.gender_type_id

GO