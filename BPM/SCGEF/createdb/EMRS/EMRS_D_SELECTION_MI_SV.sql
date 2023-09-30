IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_SELECTION_MI_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_MI_SV
AS
 SELECT 0 selection_missing_info_id ,    
    0 selection_transaction_id ,
    'UD' missing_info_type_cd ,
    'Undefined' missing_info_type ,
    NULL enrollment_error_code_id ,
    NULL rejection_error_reason_id ,
    NULL supplemental_info ,
    NULL record_date ,    
    NULL record_name ,
    NULL send_in_letter_ind ,
    'UD' enrollment_error_code ,
    'UD' rejection_code
GO