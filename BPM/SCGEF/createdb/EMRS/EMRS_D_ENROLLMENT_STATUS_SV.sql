IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_STATUS_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].EMRS_D_ENROLLMENT_STATUS_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_STATUS_SV
AS
SELECT 'N' is_mandatory_unassign_ind
	   ,'N' is_aa_pce_ind
	   ,'UD' enrollment_status_code
	   ,'Undefined' enrollment_status_desc 
GO
