-- Semantic View

CREATE OR REPLACE VIEW CC_F_AGENT_ACTIVITY_DETAIL_SV AS
SELECT
F_AGENT_ACTIVITY_DETAIL_ID,
D_DATE_ID,
D_AGENT_ID,
ACTIVITY_EVENT_TYPE_ID,
D_PROGRAM_ID,
D_GEOGRAPHY_MASTER_ID,
D_GROUP_ID,
D_PROJECT_ID,
D_SITE_ID,
UTC_ACTIVITY_START_DATETIME ACTIVITY_START_UTC_DT,
UTC_ACTIVITY_END_DATETIME ACTIVITY_END_UTC_DT,
ACTIVITY_START_DATETIME ACTIVITY_START_ET_DT,
ACTIVITY_END_DATETIME ACTIVITY_END_ET_DT,
ACTIVITY_DURATION_SECONDS,
CREATE_DATE,
CREATED_BY,
LAST_UPDATE_DATE,
LAST_UPDATE_BY,
AGENT_LOGIN_ID
FROM CC_F_ACD_AGENT_ACTIVITY_DETAIL;

GRANT SELECT ON CC_F_AGENT_ACTIVITY_DETAIL_SV TO MAXDAT_READ_ONLY; 