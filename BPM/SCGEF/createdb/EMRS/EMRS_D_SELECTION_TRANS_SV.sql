IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_TRANS_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_SV AS
   
SELECT  enroll_activity_id selection_transaction_id      	  
	  ,pt.program_type_code program_code
	  ,ea.monthly_tran_type
	  ,ea.transaction_type
	  ,COALESCE(CASE WHEN ea.transaction_type IN('FFS','New') THEN ea.transaction_type 
				ELSE COALESCE(ea.monthly_tran_type,ea.transaction_type) END,'UD') enrollment_trans_type_code
		--added to roll up the FFS trans types to enrolled or transfer
	  ,COALESCE(CASE WHEN ISNULL(exclude_flag ,0) = 0 AND ea.transaction_type IN ('FFS') AND ISNULL(transfer_to_ffs_flag,0) = 0
				THEN 'Enrolled' 
				WHEN ISNULL(exclude_flag ,0) = 0 AND ea.transaction_type IN ('New') AND ea.currently_new_flag = 1 AND ISNULL(transfer_to_ffs_flag,0) = 0
				THEN 'Enrolled'
				WHEN ISNULL(exclude_flag ,0) = 0 AND ea.transaction_type IN ('FFS') AND ISNULL(transfer_to_ffs_flag,0) = 1  
				THEN 'Transfer'
				ELSE COALESCE(ea.monthly_tran_type,ea.transaction_type) 
				END,'UD') AS enrollment_trans_type_group
	  ,COALESCE(ea.enrollment_source_type, '') enrollment_source_type
	  ,COALESCE(s.enrollment_source_type_code, ea.enrollment_source_type,'UD') selection_source_code
	  ,'MEDICAL' plan_type
	  ,COALESCE(CASE WHEN ea.transaction_type ='FFS' AND ea.enrollment_source_type is not null
					AND COALESCE(exclude_flag ,0) = 0 AND COALESCE(transfer_to_ffs_flag,0) = 1 THEN pbep.provider_business_entity_program_id
				WHEN ea.transaction_type IN('FFS','New') AND ea.enrollment_source_type is not null THEN 0
				WHEN ea.monthly_tran_type = 'Transfer' THEN COALESCE(pbtt.provider_business_entity_program_id, pbe.provider_business_entity_program_id) 
				ELSE COALESCE(pbe.provider_business_entity_program_id,pbep.provider_business_entity_program_id, pben.plan_id, pbttn.plan_id) END,-1) plan_id

	  ,CASE WHEN ea.transaction_type ='FFS' AND ea.enrollment_source_type is not null
              AND COALESCE(exclude_flag ,0) = 0 AND COALESCE(transfer_to_ffs_flag,0) = 1 THEN pbep.provider_business_entity_code
			WHEN ea.transaction_type IN('FFS','New') AND ea.enrollment_source_type is not null THEN 'FFS'
			WHEN ea.monthly_tran_type = 'Transfer' THEN COALESCE(ea.monthly_plan_transfer_to, ea.monthly_enrolled_plan) 
			ELSE COALESCE(ea.monthly_enrolled_plan,pbep.provider_business_entity_code) END plan_id_ext	
		--The disenrollments cannot use the regular plan logic so it needs to be broken out 			 
	  ,COALESCE(pbe.provider_business_entity_program_id,pbep.provider_business_entity_program_id, pben.plan_id, pbttn.plan_id, -1) disenrolled_plan_id
	  ,COALESCE(monthly_enrolled_plan,pbep.provider_business_entity_code) disenrolled_plan_id_ext	  		 
	  ,ea.effectiveenrollmentstart start_date
	  ,ea.effectiveenrollmentend end_date
	  ,COALESCE(CASE WHEN monthly_tran_type <> 'Disenrolled' THEN COALESCE(ea.status_reason_code,ea.status_reason_text) ELSE null END,'UD') selection_reason_code
	  --ea.status_reason_code is not reliable, changed to er.display_name as main source
	  ,CASE WHEN COALESCE(ea.monthly_tran_type,ea.transaction_type) IN ('Disenrolled','Transfer') 
			THEN COALESCE(CASE WHEN COALESCE(er.reason_code, '') = '' 
								THEN er.description 
								ELSE er.reason_code END, ea.status_reason_code, RTRIM(LTRIM(ea.status_reason_text)),'UD') 
			ELSE 'UD' END change_reason_code
	  ,ea.status_reason_id	
	  ,null disenroll_reason_cd_2	       
      ,null missing_info_id
      ,null missing_signature_ind
      ,null outreach_session_id
	  ,null benefits_package_cd
	  ,ea.coverage_id selection_segment_id
	  ,ea.party_id client_number
	  ,ea.medical_assistance_id clnt_cin
	  ,ea.status_value current_selection_status_id
	  ,ea.status_created_date status_date
	  ,COALESCE(cg.coverage_group_code,'UD') aid_category_code 
	  ,COALESCE(cvt.coverage_type_code,'UD') subprogram_code 
	  ,COALESCE(ct.county_code,'UD') county_code
	  ,'UD' zip_code
	  ,null client_residence_address_id
	  ,null prior_selection_segment_id
	  ,null prior_selection_start_date
	  ,null prior_selection_end_date
	  ,COALESCE(CASE WHEN ea.monthly_tran_type = 'Transfer' THEN prior_pbe.provider_business_entity_program_id 
	     ELSE prior_pbt.provider_business_entity_program_id END,-1) prior_plan_id 
	  ,CASE WHEN ea.monthly_tran_type = 'Transfer' THEN monthly_plan_transfer_from 
	     ELSE prior_pbt.provider_business_entity_code END prior_plan_id_ext	 
      ,ea.status_created_date record_date 
      ,ea.status_created_by_id record_name
	  ,CONVERT(BIGINT,CONVERT(varchar(10),effectiveenrollmentstart,112)+'000000' ) start_nd
      ,CONVERT(BIGINT,CONVERT(varchar(10),effectiveenrollmentend,112)+'000000' ) end_nd
      ,null prior_choice_reason_cd
      ,null prior_disenroll_reason_cd_1
      ,null prior_disenroll_reason_cd_2
      ,null prior_client_aid_category_cd
      ,null prior_county_cd
      ,null prior_zipcode
      ,null original_start_date
      ,null original_end_date
      ,null selection_generic_field1_date
      ,null selection_generic_field2_date
      ,null selection_generic_field3_num
      ,null selection_generic_field4_num
      ,null selection_generic_field5_txt
      ,null selection_generic_field6_txt
      ,null selection_generic_field7_txt
      ,null selection_generic_field8_txt
      ,null selection_generic_field9_txt
      ,null selection_generic_field10_txt
      ,null age_in_business_days  --do calculation logic
      ,ea.history_age_in_business_days history_age_in_business_days
      ,CASE WHEN enrollment_source_type = 'Newborn' THEN 'Y' ELSE 'N' END newborn_flag
      ,COALESCE(sv.status_value_code,'UD')  selection_status_code
      ,COALESCE(ea.enrollment_source_type_category, 'Unknown') custom_field1
      ,COALESCE(ea.exclude_flag, 0) custom_field2
      ,ea.transfer_to_ffs_flag custom_field3
      ,ea.assignable custom_field4
      ,COALESCE(ea.prelim, 1) custom_field5
	  ,COALESCE(ea.use_monthly_tran_type_flag, 0) AS use_monthly_tran_type_flag
      ,COALESCE(r.region_code,'UD') csda_code	  
	  ,ea.reporting_year
	  ,ea.reporting_month
	  ,ea.reporting_date
	  ,ea.capture_date
	  ,CAST(CAST(DATEPART(year,ea.capture_date) AS CHAR(4)) 
		+ CASE WHEN LEN(DATEPART(month,ea.capture_date)) = 1 THEN '0' + CAST(DATEPART(month,ea.capture_date)  AS CHAR(1)) 
		ELSE CAST(DATEPART(month,ea.capture_date)  AS CHAR(2)) END AS INT) capture_month
	  ,FFS_Choice
	  ,FFS_Default
  FROM report.sc_enrollment_activity ea  
    JOIN enrollment.pca_program_type ppt ON (ea.program_type_id = ppt.program_type_id AND ppt.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')
    JOIN enrollment.program_type pt ON (ppt.program_type_id = pt.program_type_id)
    LEFT JOIN enrollment.enrollment_source_type s ON (ea.enrollment_source_type = s.display_name)
	LEFT JOIN enrollment.pca_enrollment_source_type pst ON (s.enrollment_source_type_id = pst.enrollment_source_type_id
															AND ppt.process_center_application_id = pst.process_center_application_id)  
	--County has an Unknown county that should be used when county_id is not populated
    LEFT JOIN organization.county ct ON (COALESCE(ea.county_id, 230) = ct.county_id AND ct.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')
	LEFT JOIN organization.region_xref x ON (ct.county_id = x.resource_key)
	LEFT JOIN organization.region r ON (x.region_id = r.region_id)
    LEFT JOIN enrollment.status_value sv ON (ea.status_value = sv.status_value_id)
    LEFT JOIN enrollment.provider_location pl ON (ea.pcp = pl.provider_location_id) 
    LEFT JOIN enrollment.provider_location prior_pl ON (prior_pl.provider_location_id = ea.transferredfrompcp)
	--There is no plan 'PCM140' it needs to be replaced with 'PCM120'
    LEFT JOIN enrollment.provider_business_entity_program pbe ON (REPLACE(ea.monthly_enrolled_plan, 'PCM140', 'PCM120') = pbe.provider_business_entity_code)
    LEFT JOIN maxdat_support.emrs_d_plan_sv pben ON (ea.monthly_enrolled_plan_name = pben.plan_name and pt.program_type_code = pben.plan_service_type) 
	LEFT JOIN enrollment.provider_business_entity_program pbtt ON (ea.monthly_plan_transfer_to = pbtt.provider_business_entity_code)
    LEFT JOIN maxdat_support.emrs_d_plan_sv pbttn ON (ea.monthly_plan_name_transfer_to = pbttn.plan_name and pt.program_type_code = pbttn.plan_service_type)
    LEFT JOIN enrollment.provider_business_entity_program pbep ON (ea.enrolledplan = pbep.provider_business_entity_id)
    LEFT JOIN enrollment.provider_business_entity_program prior_pbe ON (ea.monthly_plan_transfer_from = prior_pbe.provider_business_entity_code)
    LEFT JOIN enrollment.provider_business_entity_program prior_pbt ON (ea.transferredfromplan = prior_pbt.provider_business_entity_id)  
    LEFT JOIN enrollment.coverage_type_coverage_group ctcg ON (ea.coverage_group_id = ctcg.coverage_group_id)
    LEFT JOIN enrollment.coverage_group cg ON (ctcg.coverage_group_id = cg.coverage_group_id)
    LEFT JOIN enrollment.coverage_type cvt ON (ctcg.coverage_type_id = cvt.coverage_type_id)
	LEFT JOIN (Enrollment.reason er
				JOIN Enrollment.pca_reason pr ON er.reason_id = pr.reason_id AND pr.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')
		ON CASE WHEN RTRIM(LTRIM(COALESCE(REPLACE(ea.monthly_disenrollment_reason_code, '8V', ''), ''))) ='' THEN '41' ELSE ea.monthly_disenrollment_reason_code END = er.reason_code
  WHERE ea.reporting_date >= CAST(CAST((YEAR(getdate()) - 3) AS varchar) + '-' + CAST(7 AS varchar) + '-' + CAST(1 AS varchar) AS DATE)
  
  --DATEADD(MONTH, -12, (cast(getDate() As Date)))

GO