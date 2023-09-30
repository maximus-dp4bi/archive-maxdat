CREATE OR REPLACE VIEW EMRS_D_CHANGE_REASON_SV
AS
  SELECT NULL change_reason_id ,
    'MEDICAID' managed_care_program ,
    NULL source_record_id ,
    edr.value change_reason_code ,
    edr.description change_reason ,
    NULL change_reason_code_plan
  FROM eb.enum_disenrollment_reason edr;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CHANGE_REASON_SV TO EB_MAXDAT_REPORTS; 