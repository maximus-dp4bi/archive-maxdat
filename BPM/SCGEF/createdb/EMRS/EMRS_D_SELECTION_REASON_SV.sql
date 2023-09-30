IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_REASON_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_REASON_SV
AS
  SELECT CASE WHEN reason_code IS NULL OR r.reason_code = ' ' THEN r.description ELSE r.reason_code END selection_reason_code ,
    r.display_name selection_reason 
  FROM enrollment.reason r
    JOIN enrollment.pca_reason pr ON r.reason_id = pr.reason_id
  WHERE r.reason_reference_type_id = 1 
  AND pr.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT 'UD' selection_reason_code,
         'Undefined' selection_reason
	 		

GO 