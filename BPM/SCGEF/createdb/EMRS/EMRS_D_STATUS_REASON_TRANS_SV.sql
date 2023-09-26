IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_STATUS_REASON_TRANS_SV', 'V') IS NOT NULL
DROP VIEW maxdat_support.EMRS_D_STATUS_REASON_TRANS_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_STATUS_REASON_TRANS_SV AS
   
SELECT enroll_activity_id selection_transaction_id,
	c.coverage_id selection_segment_id,
	c.party_id client_number,
	ea.medical_assistance_id clnt_cin,     	  
	pt.program_type_code program_code,
    COALESCE(ea.prelim, 1) custom_field5,
	ea.reporting_date,
	ea.reporting_year,
	ea.reporting_month,
	ea.transaction_type,
	ea.monthly_tran_type,
	COALESCE(CASE WHEN ea.monthly_tran_type <> 'Disenrolled' THEN COALESCE(ea.status_reason_text, ea.status_reason_code) ELSE null END,'UD') selection_reason_code,
	--The disenrollments cannot use the regular plan logic so it needs to be broken out 			 
	COALESCE(pbe.provider_business_entity_program_id,pbep.provider_business_entity_program_id, pben.plan_id, pbttn.plan_id, -1) disenrolled_plan_id,
	COALESCE(r.reason_id, 1476) reason_id,
	COALESCE(r.description, 'StatusOther') description,
	COALESCE(r.reason_code, 'OT') reason_code,
	COALESCE(r.display_name, 'Other') display_name,
	r.sort_order
FROM      report.sc_enrollment_activity ea 
JOIN enrollment.pca_program_type ppt ON (ea.program_type_id = ppt.program_type_id AND ppt.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C')
JOIN enrollment.program_type pt ON (ppt.program_type_id = pt.program_type_id)
JOIN        enrollment.coverage c on ea.party_id = c.party_id 
JOIN      enrollment.status s on c.current_status_id = s.status_id
--There is no plan 'PCM140' it needs to be replaced with 'PCM120'
LEFT JOIN enrollment.provider_business_entity_program pbe ON (REPLACE(ea.monthly_enrolled_plan, 'PCM140', 'PCM120') = pbe.provider_business_entity_code)
LEFT JOIN maxdat_support.emrs_d_plan_sv pben ON (ea.monthly_enrolled_plan_name = pben.plan_name and pt.program_type_code = pben.plan_service_type) 
LEFT JOIN maxdat_support.emrs_d_plan_sv pbttn ON (ea.monthly_plan_name_transfer_to = pbttn.plan_name and pt.program_type_code = pbttn.plan_service_type)
LEFT JOIN enrollment.provider_business_entity_program pbep ON (ea.enrolledplan = pbep.provider_business_entity_id)
LEFT JOIN (Enrollment.status_reason sr 
			JOIN enrollment.reason r ON sr.reason_id = r.reason_id) ON s.status_id = sr.status_id 

GO
