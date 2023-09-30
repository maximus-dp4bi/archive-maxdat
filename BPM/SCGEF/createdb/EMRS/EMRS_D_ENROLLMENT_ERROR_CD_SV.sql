IF OBJECT_ID('MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV', 'V') IS NOT NULL
DROP VIEW [maxdat_support].[EMRS_D_ENROLLMENT_ERROR_CD_SV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_ERROR_CD_SV
AS
 SELECT 
    'UD' enrollment_error_code ,
    'Undefined' enrollment_error_description ,
    0 warning_ind ,
    null denial_reason_ind ,
    0 needs_image_ind ,    
    0 do_not_persist_ind ,
    0 recycle_ind ,
    0 denied_letter_ind ,
    null on_denial_create_task_ind ,
    null correct_for_plan_svc_types ,    
    0 manual_edit_ind
GO

