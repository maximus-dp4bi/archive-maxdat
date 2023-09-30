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
lead (create_ts,1) OVER (PARTITION BY incident_header_id ORDER BY create_ts,INCIDENT_HEADER_STAT_HIST_ID) as end_date
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
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN INCIDENT_STATUS_DT ELSE END_DATE END end_date,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) end age_in_business_days,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) end age_in_calendar_days,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) end age_in_business_days_flow,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) END age_in_calendar_days_flow
FROM get_basic
with read only;

GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_READ_ONLY;

