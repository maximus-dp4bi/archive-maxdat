CREATE OR REPLACE VIEW EMRS_D_RACE_SV
AS
  SELECT 
    r.value AS RACE_CODE,
    r.description AS RACE_DESCRIPTION
  FROM enum_race r;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_RACE_SV TO MAXDAT_REPORTS; 