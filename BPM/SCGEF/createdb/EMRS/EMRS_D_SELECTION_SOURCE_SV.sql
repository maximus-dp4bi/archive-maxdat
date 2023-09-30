IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_SOURCE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV
AS
  SELECT enrollment_source_type_code selection_source_code ,
    CASE WHEN enrollment_source_type_code IN('Auto','MMIS') THEN 'N' ELSE 'Y' END is_choice_ind ,    
    display_name selection_source,
	CASE 
	  WHEN ISNULL(st.enrollment_source_type_code, '') IN ('MMISEligibilityEnd','PCPTransfer','Health Plan Conversion','Outreach','Auto','') 
	  THEN 'MMIS' 
	  ELSE st.enrollment_source_type_code 
    END AS selection_source_group_code   
  FROM enrollment.enrollment_source_type st 
   JOIN enrollment.pca_enrollment_source_type pst ON st.enrollment_source_type_id = pst.enrollment_source_type_id
  WHERE pst.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT 'UD' selection_source_code,
         'N' is_choice_ind,
         'Undefined' selection_source,
		 'MMIS' AS selection_source_group_code
  UNION ALL
  SELECT 'Health Plan Conversion' selection_source_code,
         'Y' is_choice_ind,
         'Health Plan Conversion' selection_source,
		 'MMIS' AS selection_source_group_code
  UNION ALL
  SELECT 'HealthPlanConversion' selection_source_code,
         'Y' is_choice_ind,
         'Health Plan Conversion' selection_source,
		 'MMIS' AS selection_source_group_code	 		 	 
		 

GO