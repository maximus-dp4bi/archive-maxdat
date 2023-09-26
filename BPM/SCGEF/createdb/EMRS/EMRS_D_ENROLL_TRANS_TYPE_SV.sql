IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_ENROLL_TRANS_TYPE_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_TRANS_TYPE_SV
AS
  SELECT tt.transaction_type_code enrollment_trans_type_code,
         tt.transaction_type enrollment_trans_type	
  FROM maxdat_support.enrollment_transaction_type tt
    
GO