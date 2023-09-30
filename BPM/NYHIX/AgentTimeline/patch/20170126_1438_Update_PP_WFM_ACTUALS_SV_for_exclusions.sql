CREATE OR REPLACE VIEW MAXDAT.PP_WFM_ACTUALS_SV
AS
select 
RT_ACTUALS_ID
,STAFF_ID
,EVENT_ID
,SOURCE_ID
,TASK_START
,TASK_CATEGORY_ID
,TASK_END
,WORK_ACTIVITY
,ANNOTATION
,CREATE_DATE
,CREATE_STAFF_ID
,MODIFY_DATE
,MODIFY_STAFF_ID
,QUEUE_ID
,EXCLUSION_FLAG
,WORK_SUBACTIVITY
,round(((task_end-task_start) * 24 * 60),2) as HANDLE_TIME
from PP_WFM_ACTUALS a
where not exists (select 1 from dp_scorecard.sc_exclusion_yes_sv b where a.staff_id = b.staff_id and TRUNC(a.task_end) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_SV TO DP_SCORECARD;
GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_SV TO MAXDAT_OLTP_SIU;
GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_SV TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_SV TO MAXDAT_READ_ONLY;
