 CREATE OR REPLACE VIEW CC_C_CAMPAIGN_SV
 AS
 SELECT
CAMPAIGN_ID
,CAMPAIGN_NAME
,CAMPAIGN_DESC
,PROGRAM_NAME
,PROJECT_NAME
,PROVINCE_NAME
,DISTRICT_NAME
,REGION_NAME
,STATE_NAME
,COUNTRY_NAME
FROM CC_C_CAMPAIGN;

GRANT SELECT ON CC_C_CAMPAIGN_SV TO MAXDAT_READ_ONLY; 