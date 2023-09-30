CREATE OR REPLACE VIEW EMRS_D_CHANGE_REASON_SV
AS
  SELECT 
    'MEDICAID' managed_care_program ,
    NULL source_record_id ,
    edr.value change_reason_code ,
    edr.description change_reason ,
    NULL change_reason_code_plan
  FROM eb.enum_disenrollment_reason edr
  UNION
  SELECT
    'MEDICAID' managed_care_program ,
    NULL source_record_id ,
    '0' change_reason_code ,
    'Not Defined' change_reason ,
    NULL change_reason_code_plan
  FROM DUAL  ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CHANGE_REASON_SV TO MAXDAT_REPORTS; 