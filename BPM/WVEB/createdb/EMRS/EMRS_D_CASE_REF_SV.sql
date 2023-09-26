CREATE OR REPLACE VIEW EMRS_D_CASE_REF_SV
AS
  SELECT case_id AS CASE_NUMBER 
  FROM cases ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_CASE_REF_SV TO EB_MAXDAT_REPORTS;