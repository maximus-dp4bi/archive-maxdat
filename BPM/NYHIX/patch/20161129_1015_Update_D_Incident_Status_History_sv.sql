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
    AND ishs2.STATUS_CD IN ('FOLLOW_UP_REQUIRED',
'SENT_IN_ERROR',
'APPEAL_CLOSED',
'CLOSED',
'WITHDRAWN',
'REFERRAL WITHDRAWN',
'REFERRAL CLOSED',
'INC_CLOSED_DUP',
'INCIDENT_CLOSED',
'CLOSED_IDR_FAIL',
'CLOSED_IDR_SUCCESS',
'APPEAL_CLOSED_ARU_ACTION',
'DIS_DEATH',
'APPEAL_CLOSED_DOH_ACTION_COMP',
'APPEAL_CLOSE_NON_SWORN_CANCEL')
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
CASE WHEN incident_status IN ('Dismissed - Death',
'Appeal Closed - Written Withdrawal',
'Appeal Closed - Non Sworn Cancellation',
'Appeal Closed - ARU Action Completed',
'Appeal Closed - DOH Action Completed',
'Appeal Closed',
'Dismissed',
'Appeal Closed - Failed to Attend Hearing',
'Appeal Closed - Duplicate/Error',
'Awaiting Validity Amendment - Individual',
'Non-Sworn Cancellation',
'Written Withdrawal',
'Pending Withdrawal/Cancellation',
'Reschedule Hearing',
'Returned - Action Required',
'Invalid with Right to Cure',
'Dismissal - Failed to Attend Hearing',
'Adjournment',
'Adjournment - Awaiting Documentation',
'Request to Vacate Dismissal') THEN 0 ELSE bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) end age_in_business_days_flow,
CASE WHEN incident_status IN ('Dismissed - Death',
'Appeal Closed - Written Withdrawal',
'Appeal Closed - Non Sworn Cancellation',
'Appeal Closed - ARU Action Completed',
'Appeal Closed - DOH Action Completed',
'Appeal Closed',
'Dismissed',
'Appeal Closed - Failed to Attend Hearing',
'Appeal Closed - Duplicate/Error',
'Awaiting Validity Amendment - Individual',
'Non-Sworn Cancellation',
'Written Withdrawal',
'Pending Withdrawal/Cancellation',
'Reschedule Hearing',
'Returned - Action Required',
'Invalid with Right to Cure',
'Dismissal - Failed to Attend Hearing',
'Adjournment',
'Adjournment - Awaiting Documentation',
'Request to Vacate Dismissal') THEN 0 ELSE trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) END age_in_calendar_days_flow
FROM get_basic with read only;

GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO DP_SCORECARD;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_OLTP_SIU;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_READ_ONLY;

