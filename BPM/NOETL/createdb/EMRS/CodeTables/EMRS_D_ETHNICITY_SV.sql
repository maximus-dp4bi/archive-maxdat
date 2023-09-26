CREATE OR REPLACE VIEW EMRS_D_ETHNICITY_SV
AS
  SELECT 
    e.VALUE AS CLIENT_ETHNICITY
    ,e.REPORT_LABEL AS ETHNICITY
    ,e.EFFECTIVE_START_DATE AS EFFECTIVE_START_DATE
    ,e.EFFECTIVE_END_DATE AS EFFECTIVE_END_DATE
  FROM eb.ENUM_ETHNICITY e;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ETHNICITY_SV TO MAXDAT_REPORTS;
  
  
