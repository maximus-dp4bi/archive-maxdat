CREATE OR REPLACE VIEW D_MW_V2_CURRENT_TEAMS_SV
AS
  SELECT 12345 AS TEAM_SUPERVISOR_STAFF_ID ,
    12345 AS PARENT_TEAM_ID ,
    12345 AS TEAM_ID ,
    'TEAM_NAME' AS TEAM_NAME ,
    'TEAM_DESCRIPTION' AS TEAM_DESCRIPTION
  FROM DUAL;

GRANT SELECT on MAXDAT_LOOKUP.D_MW_V2_CURRENT_TEAMS_SV to EB_MAXDAT_REPORTS ;