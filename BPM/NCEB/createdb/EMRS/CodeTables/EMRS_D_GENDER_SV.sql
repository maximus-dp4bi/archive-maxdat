CREATE OR REPLACE VIEW EMRS_D_GENDER_SV
AS
SELECT value AS SEX,
  description AS DESCRIPTION,
  report_label AS REPORT_LABEL,
  scope AS SCOPE,
  order_by_default AS ORDER_BY_DEFAULT,
  effective_start_date AS EFFECTIVE_START_DATE,
  effective_end_date AS EFFECTIVE_END_DATE,
  create_ts AS CREATE_TS,
  created_by AS CREATED_BY,
  update_ts AS UPDATE_TS,
  updated_by AS UPDATED_BY
FROM &schema_name..ENUM_GENDER ;
  
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_GENDER_SV TO MAXDAT_REPORTS; 
