CREATE OR REPLACE VIEW EMRS_D_SELECTION_SOURCE_SV
AS
  SELECT e.value AS SELECTION_SOURCE_CODE ,
    e.description AS SELECTION_SOURCE ,
    CASE WHEN e.value in ('P','C','W')
         THEN 'Y'
         ELSE 'N'
    END AS IS_CHOICE_IND 
  FROM &schema_name..enum_enrollment_trans_source e
  WHERE e.effective_end_date IS NULL OR e.value = '6'
  UNION
  SELECT '0' AS SELECTION_SOURCE_CODE ,
    'Not Defined' AS SELECTION_SOURCE,
    'N' AS IS_CHOICE_IND      
  FROM DUAL; 
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV TO MAXDAT_REPORTS;
