CREATE OR REPLACE VIEW MAXDAT.D_INCIDENT_STATUS_HISTORY_SV
AS
WITH get_basic AS
(
select
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_HEADER_ID AS INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
CREATE_TS INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
(SELECT max(ishs2.create_ts) FROM INCIDENT_HEADER_STAT_HIST_STG ishs2
    WHERE ishs2.INCIDENT_HEADER_ID = ishs1.INCIDENT_HEADER_ID
    AND ishs2.STATUS_CD IN (SELECT status_cd FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP'))
)  end_date
from
INCIDENT_HEADER_STAT_HIST_STG ishs1
)
select
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
end_date,
bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) age_in_business_days,
trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) age_in_calendar_days,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) end age_in_business_days_flow,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) END age_in_calendar_days_flow
FROM get_basic with read only;

GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO DP_SCORECARD;
