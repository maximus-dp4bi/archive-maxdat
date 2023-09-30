CREATE OR REPLACE VIEW EMRS_D_PROGRAM_SV
AS
   SELECT NULL source_record_id ,
    value program_code ,
    report_label program_name ,
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END active_inactive ,
    effective_end_date end_date ,
    NULL program_category ,
    value managed_care_program ,
    effective_start_date start_date
  FROM enum_program_type
  UNION
  SELECT NULL source_record_id,
    '0' program_code ,
    'Not Defined' program_name ,
    'A' active_inactive ,
    NULL end_date ,
    NULL program_category ,
    'MEDICAID' managed_care_program ,
    TO_DATE('01/01/1900','MM/DD/YYYY') start_date
  FROM DUAL;  

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROGRAM_SV TO MAXDAT_REPORTS; 