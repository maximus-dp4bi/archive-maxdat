IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_AID_CATEGORY_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_AID_CATEGORY_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [maxdat_support].[EMRS_D_AID_CATEGORY_SV]
AS
  SELECT CASE WHEN cg.enabled_flag = 1 THEN 'A' ELSE 'I' END active_inactive ,
    CAST('12/31/2050' AS DATE) end_date ,        
    cg.coverage_group_code aid_category_code , 
    CAST('01/01/1900' AS DATE) start_date ,
    cg.display_name aid_category_name    
  FROM enrollment.coverage_group cg JOIN enrollment.pca_coverage_group pcg ON cg.coverage_group_id = pcg.coverage_group_id
  WHERE pcg.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT 'N' active_inactive,
	CAST('12/31/2050' AS DATE) end_date ,  
        'UD' aid_category_code,         
	CAST('01/01/1900' AS DATE) start_date ,   
        'Undefined' aid_category_name	


GO