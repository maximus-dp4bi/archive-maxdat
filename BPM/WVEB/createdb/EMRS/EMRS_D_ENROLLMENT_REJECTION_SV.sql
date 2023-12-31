CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_REJECTION_SV
AS
  SELECT NULL AS REJECTION_ERROR_REASON_ID ,
    selection_segment_id AS ENROLLMENT_ID ,
    '0' rejection_code
  FROM selection_segment
  WHERE selection_segment_id > 1;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_ENROLLMENT_REJECTION_SV TO EB_MAXDAT_REPORTS;