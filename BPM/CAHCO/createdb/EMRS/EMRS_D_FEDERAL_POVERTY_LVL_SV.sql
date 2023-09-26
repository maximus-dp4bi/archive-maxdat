CREATE OR REPLACE VIEW EMRS_D_FEDERAL_POVERTY_LVL_SV
AS
SELECT 'Unknown' fpl_description,
'CA' fpl_locale,
0 fpl_max_dollars,
0 fpl_number_in_family,
1900 fpl_year
FROM dual;

GRANT SELECT ON "EMRS_D_FEDERAL_POVERTY_LVL_SV" TO "MAXDAT_READ_ONLY";

