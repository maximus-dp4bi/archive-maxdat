CREATE OR REPLACE FORCE VIEW D_PL_LETTER_STATUS_SV
AS
  SELECT report_label LETTER_STATUS
    --D_PL_LETTER_STATUS_SV
  FROM enum_lm_status ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PL_LETTER_STATUS_SV TO EB_MAXDAT_REPORTS ;