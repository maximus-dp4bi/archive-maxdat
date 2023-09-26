IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_STATUS_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_STATUS_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_STATUS_SV
AS
  SELECT status_value_code selection_status_code ,
    display_name selection_status_description ,
    1 allow_new_selection_ind     
  FROM enrollment.status_value v
    JOIN enrollment.pca_status_value pv ON v.status_value_id = pv.status_value_id
  WHERE v.status_category_id = 1
  AND pv.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
  UNION ALL
  SELECT 'UD' selection_status_code,
	 'Undefined' selection_status_description,
	 0 allow_new_selection_ind

GO