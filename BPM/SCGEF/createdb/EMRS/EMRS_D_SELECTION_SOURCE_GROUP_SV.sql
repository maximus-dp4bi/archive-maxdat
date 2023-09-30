IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_GROUP_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_SOURCE_GROUP_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_GROUP_SV
AS
SELECT DISTINCT
  CASE 
	  WHEN ISNULL(st.enrollment_source_type_code, '') IN ('MMISEligibilityEnd','PCPTransfer','Health Plan Conversion','Outreach','Auto','') 
	  THEN 'MMIS' 
	  ELSE st.enrollment_source_type_code 
  END AS selection_source_group_code,   
  CASE 
	  WHEN ISNULL(st.display_name, '') IN ('MMIS Eligibility End','PCP Transfer','Health Plan Conversion','Outreach','Auto Assign','') 
	  THEN 'MMIS' 
	  ELSE st.display_name 
  END AS selection_source_group  
  FROM enrollment.enrollment_source_type st 
   JOIN enrollment.pca_enrollment_source_type pst ON st.enrollment_source_type_id = pst.enrollment_source_type_id
  WHERE pst.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT 'UD' selection_source_code,
         'Undefined' selection_source;

GO