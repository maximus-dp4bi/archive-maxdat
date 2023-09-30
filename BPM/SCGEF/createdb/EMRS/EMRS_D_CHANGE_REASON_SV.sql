IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_CHANGE_REASON_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_CHANGE_REASON_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_CHANGE_REASON_SV
AS
  SELECT DISTINCT r.display_name change_reason,
     CASE WHEN COALESCE(r.reason_code, '') = '' THEN r.description ELSE r.reason_code END change_reason_code,    
     NULL change_reason_code_plan,
	 r.reason_id
  FROM enrollment.reason r
    JOIN enrollment.pca_reason pr ON r.reason_id = pr.reason_id 
  WHERE r.reason_reference_type_id = 1
  AND pr.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
 UNION ALL
 SELECT 'Undefined' change_reason,
         'UD' change_reason_code,
		 'UD' as reason_id,	 
		NULL change_reason_code_plan

GO 