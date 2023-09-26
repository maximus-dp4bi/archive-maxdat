IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_TERMINATION_REASON_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_TERMINATION_REASON_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_TERMINATION_REASON_SV
AS
 SELECT DISTINCT CASE WHEN (r.reason_code = ' ' OR r.reason_code IS NULL) THEN r.description ELSE r.reason_code END  reason_code ,
        r.display_name reason ,
        NULL plan_name
 FROM enrollment.reason r
    JOIN enrollment.status_value_reason_role rr ON r.reason_id = rr.reason_id
    JOIN enrollment.status_value v  ON rr.status_value_id = v.status_value_id
   JOIN enrollment.pca_reason pr    ON r.reason_id = pr.reason_id     
  WHERE r.reason_reference_type_id = 1
  AND v.status_value_code IN('DIS','PDIS','CAN')
  AND pr.process_center_application_id = '35149774-C73A-4A57-9196-23378A2AAB5C'
 UNION ALL
  SELECT 'UD' reason_code,
	 'Undefined' reason,
	 NULL plan_name	

GO