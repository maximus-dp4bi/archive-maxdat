CREATE OR REPLACE VIEW EMRS_D_PROVIDER_SPEC_CD_SV
AS
  SELECT 
      ps.value PROVIDER_SPECIALTY_CODE ,
      ps.description PROVIDER_SPECIALTY ,
      ps.effective_start_date AS EFFECTIVE_START_DATE,
      ps.effective_end_date AS EFFECTIVE_END_DATE
    FROM &schema_name..enum_provider_specialty ps
  UNION
  SELECT '0' PROVIDER_SPECIALTY_CODE ,
      'Not Defined' PROVIDER_SPECIALTY ,
      TO_DATE('01/01/1900', 'mm\dd\yyyy') AS EFFECTIVE_START_DATE,
      NULL AS EFFECTIVE_END_DATE
  FROM DUAL;    
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PROVIDER_SPEC_CD_SV TO MAXDAT_REPORTS; 