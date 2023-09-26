CREATE OR REPLACE VIEW EMRS_D_PROGRAM_SV
AS
   SELECT pt.value AS program_code ,
    pt.report_label AS program_name ,
    pt.report_label AS program_category,
    CASE
      WHEN pt.effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END AS active_inactive ,
    pt.effective_start_date AS start_date,
    pt.effective_end_date AS end_date 
  FROM &schema_name..enum_program_type pt
  UNION
  SELECT '0' AS program_code ,
    'Not Defined' AS program_name ,
    'Not Defined' AS program_category,
    'A' AS active_inactive , 
    TO_DATE('01/01/1900','MM/DD/YYYY') AS start_date,
    NULL AS end_date 
  FROM DUAL;  

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROGRAM_SV TO MAXDAT_REPORTS; 