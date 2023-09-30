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
LEFT JOIN enum_program_type prg ON prg.value = ss.Program_Type_CD
UNION ALL
SELECT DISTINCT s.prior_selection_segment_id,
  'UNK' AS PRIOR_PROGRAM_CODE, 
  'Unknown' AS PRIOR_PROGRAM_NAME, 
  'A' AS ACTIVE_INACTIVE,
  NULL AS END_DATE,
  NULL AS PRIOR_PROGRAM_CATEGORY,
  'Unknown' AS PRIOR_MANAGED_CARE_PROGRAM,
  to_date('01-01-1900 00:00', 'mm-dd-yyyy HH24:MI') AS START_DATE
FROM eb.selection_txn s
WHERE s.prior_selection_segment_id not in (SELECT ss.SELECTION_SEGMENT_ID FROM EB.selection_segment ss)
UNION ALL
SELECT 0 AS PRIOR_SELECTION_SEGMENT_ID,
  'N/A' AS PRIOR_PROGRAM_CODE, 
  'Not Defined' AS PRIOR_PROGRAM_NAME, 
  'A' AS ACTIVE_INACTIVE,
  NULL AS END_DATE,
  NULL AS PRIOR_PROGRAM_CATEGORY,
  'Not Defined' AS PRIOR_MANAGED_CARE_PROGRAM,
to_date('01-01-1900 00:00', 'mm-dd-yyyy HH24:MI') AS START_DATE
FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PRIOR_PROGRAM_SV TO EB_MAXDAT_REPORTS;  