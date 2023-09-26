CREATE OR REPLACE VIEW EMRS_D_PRIOR_PROGRAM_SV
 AS
SELECT ss.SELECTION_SEGMENT_ID AS PRIOR_SELECTION_SEGMENT_ID,
  ss.Program_Type_CD AS PRIOR_PROGRAM_CODE,
  prg.Report_Label AS PRIOR_PROGRAM_NAME,
    CASE
      WHEN effective_end_date IS NULL
      THEN 'A'
      ELSE 'I'
    END active_inactive ,
    effective_end_date end_date ,
    NULL prior_program_category ,
    value prior_managed_care_program ,
    effective_start_date start_date
FROM EB.selection_segment ss 
LEFT JOIN enum_program_type prg ON prg.value = ss.Program_Type_CD;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PRIOR_PROGRAM_SV TO MAXDAT_REPORTS;  