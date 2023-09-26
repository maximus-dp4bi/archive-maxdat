IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CURRENT_ELIGIBLES_SV', 'V') IS NOT NULL
DROP VIEW maxdat_support.EMRS_D_CURRENT_ELIGIBLES_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW maxdat_support.EMRS_D_CURRENT_ELIGIBLES_SV
AS
	SELECT ce.reporting_year
		  ,ce.reporting_month
		  ,ce.reporting_date
		  ,ce.reporting_year + RIGHT(REPLICATE('0', 2) + ce.reporting_month, 2) AS reporting_d_month
		  ,ce.capture_date
		  ,CAST(CAST(DATEPART(year,ce.capture_date) AS CHAR(4)) 
			+ CASE WHEN LEN(DATEPART(month,ce.capture_date)) = 1 THEN '0' + CAST(DATEPART(month,ce.capture_date)  AS CHAR(1)) 
			ELSE CAST(DATEPART(month,ce.capture_date)  AS CHAR(2)) END AS INT) capture_month
		  ,ce.transaction_type
		  ,ce.medical_assistance_id clnt_cin
		  ,ce.party_id as client_number
		  ,ce.date_of_birth
		  ,ce.coverage_id as selection_segment_id
		  ,COALESCE(CASE WHEN ce.transaction_type IN('FFS','New') THEN 0  --make it FFS for plan
						 ELSE COALESCE(pbe.provider_business_entity_program_id, pben.plan_id, pbep.provider_business_entity_program_id) 
						 END,-1) plan_id
		  ,ce.EnrolledPlan
		  ,ce.EnrolledPlanName
		  ,ce.status_id
		  ,ce.status_created_date as status_date	 
		  ,ce.status_created_date as record_date 
		  ,ce.status_begin_date
		  ,ce.status_end_date
		  ,ce.status_description
		  ,COALESCE(sv.status_value_code,'UD')  selection_status_code
		  ,ce.status_value as current_selection_status_id
		  ,ce.EligibilityStart
		  ,ce.EligibilityEnd
		  ,ce.EffectiveEnrollmentStart as start_date
		  ,ce.EffectiveEnrollmentEnd as end_date
		  ,ce.Assignable as custom_field4
		  ,ce.Program_Code as ce_program_code
		  ,pt.program_type_code program_code
		  ,ce.Payment_Category
		  ,ce.mhn_flag
		  ,ce.mco_flag
		  ,ce.gef_assignable
		  ,ce.FFS_Choice
		  ,ce.FFS_Default
		  ,ce.enrollment_source_type
		  ,COALESCE(s.enrollment_source_type_code,'UD') selection_source_code
		  ,CASE WHEN ce.enrollment_source_type = 'Newborn' THEN 'Y' ELSE 'N' END newborn_flag
		  ,ce.enrollment_source_type_category as custom_field1
		  ,ce.county_description
		  ,ce.address_id
		  ,ce.county_id
		  ,CASE WHEN ce.monthly_tran_type = 'Enrolled' 
				THEN ce.monthly_county_code 
				ELSE COALESCE(ct.county_code,'UD') 
				END county_code
		  ,ce.research_flag
		  ,ce.research_reason
		  ,COALESCE(ce.exclude_flag, 0) as custom_field2
		  ,ce.exclude_reason
		  ,ce.monthly_tran_type 
		  ,ce.monthly_enrollment_reason_code
		  ,REPLACE(ce.monthly_enrolled_plan, 'PCM140', 'PCM120') AS monthly_enrolled_plan
		  ,ce.monthly_enrolled_plan_name
		  ,ce.monthly_discrepancy_flag
		  ,ce.monthly_discrepancy_reason
		  ,ce.monthly_HMO_Eligibility_Start
		  ,ce.monthly_provider_number
		  ,COALESCE(ce.use_monthly_tran_type_flag, 0) AS use_monthly_tran_type_flag
		  ,ce.cur_elig_id
		  ,ce.monthly_county_code
		  ,ce.monthly_county_display_name
		  ,COALESCE(ce.prelim, 1) as custom_field5
		  ,ce.Program_Type_ID
		  ,CASE WHEN ISNULL(ce.exclude_flag,0) = 0
					   AND ISNULL(ce.FFS_Choice,0) = 1
					   AND ce.transaction_type <> 'Enrolled'
					   AND ISNULL(ce.use_monthly_tran_type_flag,0) = 0
				THEN 'FFS_CHOICE'
				WHEN ISNULL(ce.exclude_flag,0) = 0
					   AND ISNULL(ce.FFS_Default,0) = 1
					   AND ISNULL(ce.use_monthly_tran_type_flag,0) = 0
				THEN 'FFS_DEFAULT'
				WHEN ce.use_monthly_tran_type_flag = 1
					   AND ISNULL(ce.monthly_tran_type,0) = 'Enrolled'
				THEN 'Enrolled into Managed Care'
				ELSE 'Undefined'
				END AS CUR_ELIG_TYPE_MCO
		  ,CASE WHEN ISNULL(ce.exclude_flag,0) = 0
					   AND (ISNULL(ce.FFS_Default,0) = 1 OR ISNULL(ce.FFS_Choice,0) = 1)
					   AND ISNULL(ce.use_monthly_tran_type_flag,0) = 0
				THEN 'Prime Eligible/Not Enrolled'
				WHEN ce.use_monthly_tran_type_flag = 1
					   AND ISNULL(ce.monthly_tran_type,0) = 'Enrolled'
				THEN 'Enrolled in Prime'
				ELSE 'Undefined'
				END AS CUR_ELIG_TYPE_PRIME
	  FROM Report.sc_current_eligibles ce
	  JOIN enrollment.pca_program_type ppt ON (ce.program_type_id = ppt.program_type_id AND ppt.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')
      JOIN enrollment.program_type pt ON (ppt.program_type_id = pt.program_type_id)
      LEFT JOIN enrollment.enrollment_source_type s ON (ce.enrollment_source_type = s.description)
	  LEFT JOIN enrollment.pca_enrollment_source_type pst ON (s.enrollment_source_type_id = pst.enrollment_source_type_id
															AND ppt.process_center_application_id = pst.process_center_application_id)  
		--County has an Unknown county that should be used when county_id is not populated													 
      LEFT JOIN organization.county ct ON (COALESCE(ce.county_id, 230) = ct.county_id AND ct.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')	  
      LEFT JOIN enrollment.status_value sv ON (ce.status_value = sv.status_value_id)
	  LEFT JOIN Enrollment.provider_business_entity_program pbep ON (pbep.provider_business_entity_id = ce.EnrolledPlan) 
	  --There is no plan 'PCM140' it needs to be replaced with 'PCM120'
	  LEFT JOIN enrollment.provider_business_entity_program pbe ON (REPLACE(ce.monthly_enrolled_plan, 'PCM140', 'PCM120') = pbe.provider_business_entity_code)
      LEFT JOIN Maxdat_Support.EMRS_D_PLAN_SV pben ON (ce.monthly_enrolled_plan_name = pben.plan_name and pt.program_type_code = pben.plan_service_type) 
  WHERE ce.reporting_date >= CAST(CAST((YEAR(getdate()) - 3) AS varchar) + '-' + CAST(7 AS varchar) + '-' + CAST(1 AS varchar) AS DATE)

GO


