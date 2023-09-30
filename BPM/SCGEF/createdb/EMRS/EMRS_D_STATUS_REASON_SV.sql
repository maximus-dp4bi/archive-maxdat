IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_STATUS_REASON_SV', 'V') IS NOT NULL
DROP VIEW maxdat_support.EMRS_D_STATUS_REASON_SV
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_STATUS_REASON_SV AS
   
select r.reason_id,
	r.description,
	r.reason_code,
	r.display_name,
	r.sort_order
from      enrollment.reason r 

GO