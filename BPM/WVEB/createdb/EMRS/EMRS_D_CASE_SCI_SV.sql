CREATE OR REPLACE VIEW EMRS_D_CASE_SCI_SV
AS
  SELECT case_id case_number ,case_cin 
  FROM cases;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CASE_SCI_SV TO EB_MAXDAT_REPORTS;