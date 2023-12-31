DROP VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV
AS
SELECT e.value AS SELECTION_SOURCE_CODE ,
    e.report_label AS SELECTION_SOURCE ,
    CASE WHEN e.value in ('P','C','W')
         THEN 'Y'
         ELSE 'N'
    END AS IS_CHOICE_IND 
  FROM eb.enum_enrollment_trans_source e
  UNION
  SELECT '0' AS SELECTION_SOURCE_CODE ,
    'State Assigned' AS SELECTION_SOURCE,
    'N' AS IS_CHOICE_IND      
  FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV TO MAXDAT_SUPPORT_READ_ONLY;

